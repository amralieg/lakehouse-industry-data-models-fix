-- Schema for Domain: hazmat | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`hazmat` COMMENT 'Hazardous waste handling, treatment, storage, and disposal operations under RCRA Subtitle C. Manages hazardous waste manifests (cradle-to-grave tracking), TSDF facility operations, waste characterization (TCLP testing), container tracking, EPA ID numbers, waste codes, chain-of-custody, transportation compliance (DOT HMR), BOL documents, emergency response (HAZWOPER), and regulatory reporting. Ensures safe handling of industrial, medical, and special wastes. Integrates with Enviance EHS and SAP EHS modules.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` (
    `hazardous_waste_generator_id` BIGINT COMMENT 'Unique identifier for the hazardous waste generator record. Primary key for the entity.',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Hazardous waste generator is registered with EPA and has an EPA ID. The epa_id_number string is a denormalized copy of data in epa_id_registration. Adding FK to epa_id_registration normalizes this rel',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Generator sites ARE facilities in waste management operations. Links generator regulatory records to facility asset master for permit tracking, inspection scheduling, facility utilization reporting, a',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Generator sites maintain hazard registers identifying site-specific hazards (waste types, storage areas, processes, chemical exposures). Links facility-level risk assessment to generator operations fo',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Generators operate under RCRA permits (40 CFR 262). Permit governs accumulation limits, reporting, and operational requirements. Core regulatory relationship for compliance tracking and inspection pla',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: EPA hazardous waste generator notifications require designated responsible official per 40 CFR 262.12. Tracking employee_id enables signature authority verification, certification tracking, regulatory',
    `tracked_site_id` BIGINT COMMENT 'Foreign key linking to sustainability.tracked_site. Business justification: Hazardous waste generators are sustainability tracking sites for ESG reporting. Corporate sustainability teams track emissions, waste metrics, and compliance by generator location. Standard ESG report',
    `accumulation_start_date_limit_days` STRING COMMENT 'Maximum number of days hazardous waste may be accumulated on-site before shipment, based on generator category. LQG: 90 days; SQG: 180 days (or 270 if >200 miles from TSDF); VSQG: no time limit but quantity limits apply.',
    `biennial_report_required_flag` BOOLEAN COMMENT 'Indicates whether the generator is required to submit biennial hazardous waste reports to EPA. Required for LQGs and some SQGs.',
    `compliance_status` STRING COMMENT 'Current compliance status with RCRA and state hazardous waste regulations. Reflects findings from most recent inspection or enforcement action.. Valid values are `compliant|minor_violation|significant_violation|enforcement_action|consent_decree`',
    `contingency_plan_last_updated_date` DATE COMMENT 'Date when the contingency plan was last reviewed and updated. Plans must be reviewed annually and updated as needed.',
    `contingency_plan_reference` STRING COMMENT 'Reference identifier or document location for the sites hazardous waste contingency plan. Required for LQGs and SQGs.',
    `emergency_contact_name` STRING COMMENT 'Name of the designated emergency response contact for incidents involving hazardous waste at this site.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency phone number for hazardous waste incidents. Must be staffed or monitored continuously.. Valid values are `^+?[0-9]{10,15}$`',
    `enforcement_action_count` STRING COMMENT 'Total number of formal enforcement actions (notices of violation, administrative orders, civil penalties) issued against this generator.',
    `federal_facility_flag` BOOLEAN COMMENT 'Indicates whether the generator is a federal government facility (e.g., military base, federal laboratory). Federal facilities have specific RCRA compliance requirements.',
    `generator_category` STRING COMMENT 'EPA classification of generator based on monthly waste generation volume. LQG (Large Quantity Generator): ≥1,000 kg/month; SQG (Small Quantity Generator): 100-1,000 kg/month; VSQG (Very Small Quantity Generator): <100 kg/month; CESQG (Conditionally Exempt Small Quantity Generator): legacy term for VSQG.. Valid values are `LQG|SQG|VSQG|CESQG`',
    `generator_legal_name` STRING COMMENT 'The official legal name of the hazardous waste generating entity as registered with EPA and state authorities.',
    `generator_status` STRING COMMENT 'Current operational and regulatory status of the hazardous waste generator registration.. Valid values are `active|inactive|suspended|deregistered|pending`',
    `initial_notification_date` DATE COMMENT 'Date when the generator first notified EPA of hazardous waste generation activities and received EPA ID number.',
    `inspection_frequency_months` STRING COMMENT 'Expected frequency of regulatory inspections by EPA or state authorities, in months. Varies by generator category and compliance history.',
    `last_biennial_report_year` STRING COMMENT 'The reporting year of the most recently submitted biennial hazardous waste report (e.g., 2022 for the 2021-2022 reporting period).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection by EPA, state, or local enforcement agency.',
    `last_notification_update_date` DATE COMMENT 'Date of the most recent update to the generators EPA notification information. Generators must notify EPA of changes within 30 days.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the generator site in decimal degrees. Used for spatial analysis and emergency response planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the generator site in decimal degrees. Used for spatial analysis and emergency response planning.',
    `mailing_address` STRING COMMENT 'Mailing address for correspondence and regulatory notifications if different from site address.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code identifying the primary business activity of the generator. Used for regulatory reporting and waste generation profiling.. Valid values are `^[0-9]{6}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for electronic manifest notifications and regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person responsible for hazardous waste management at the generator site.',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for the generator contact. Used for operational coordination and emergency response.. Valid values are `^+?[0-9]{10,15}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person (e.g., Environmental Manager, EHS Coordinator).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this generator record was first created in the system.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this generator record originated (e.g., Enviance EHS, SAP EHS, EPA RCRAInfo).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this generator record was last modified.',
    `sic_code` STRING COMMENT 'Four-digit SIC code for the generators primary business activity. Legacy classification system still used in some regulatory contexts.. Valid values are `^[0-9]{4}$`',
    `site_city` STRING COMMENT 'City where the hazardous waste generation site is located.',
    `site_county` STRING COMMENT 'County where the generator site is located. Required for local enforcement agency (LEA) coordination.',
    `site_state` STRING COMMENT 'Two-letter state code for the generator site location. Used for jurisdictional compliance determination.. Valid values are `^[A-Z]{2}$`',
    `site_street_address` STRING COMMENT 'Physical street address of the hazardous waste generation site. Required for manifest preparation and emergency response.',
    `site_zip_code` STRING COMMENT 'ZIP code for the generator site. Supports 5-digit or 9-digit (ZIP+4) format.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `state_generator_code` STRING COMMENT 'State-specific generator identification number if different from EPA ID. Some states maintain parallel registration systems.',
    `waste_minimization_plan_flag` BOOLEAN COMMENT 'Indicates whether the generator has a documented waste minimization plan in place. Required for LQGs under some state programs.',
    CONSTRAINT pk_hazardous_waste_generator PRIMARY KEY(`hazardous_waste_generator_id`)
) COMMENT 'Master record for each EPA-registered hazardous waste generator (large quantity, small quantity, or very small quantity). Captures EPA ID number, generator category (LQG/SQG/VSQG), site address, RCRA permit status, emergency contact, contingency plan reference, accumulation time limits, and regulatory notification history. Serves as the authoritative identity record for all waste-generating sites managed under RCRA Subtitle C.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`waste_profile` (
    `waste_profile_id` BIGINT COMMENT 'Unique identifier for the waste characterization profile. Primary key for the waste profile entity.',
    `tsdf_facility_id` BIGINT COMMENT 'Reference to the Treatment, Storage, and Disposal Facility authorized to accept this waste profile. Links to facility master data.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Waste profiles require approved vendor tracking for procurement qualification and vendor performance management. Waste Management operations need to link waste characterization to qualified disposal/t',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Waste profiles are approved for customer accounts under master service agreements defining permitted waste streams, pricing basis, approved TSDFs. Profile approval validates contract scope, permitted ',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: Waste profile has un_na_number (string) but no FK to dot_hazmat_classification reference table. Adding FK provides standardized DOT classification lookup including proper shipping name, hazard class, ',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Waste profiles generate specific emissions during handling/storage. EPA GHGRP Subpart HH requires linking hazardous waste streams to emission sources for air permit compliance and Scope 1 emissions qu',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically environmental compliance manager or facility manager) who approved this waste profile.',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Reference to the customer or facility that generates this waste stream. Links to the waste generator profile in the customer domain.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Waste profiles document approved waste characterizations for specific service offerings. Service order fulfillment and pricing validation require linking profiles to catalog offerings. Real business p',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Waste profiles must comply with facility permit conditions. Approved waste streams are constrained by permit scope (waste codes, treatment methods). Required for permit compliance verification and TSD',
    `ppe_issuance_id` BIGINT COMMENT 'Foreign key linking to safety.ppe_issuance. Business justification: Waste profiles specify required PPE (respirators, chemical suits, gloves, face shields) that must be issued to employees handling that waste stream. Links waste hazard characterization to PPE control ',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Waste profile has epa_waste_codes (string, comma-separated) but no FK to waste_code reference table. Adding FK for primary waste code provides standardized waste code lookup and validation. Keep epa_w',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Waste profiles require specific safety programs (HAZWOPER, respiratory protection, confined space) based on waste hazard characteristics. Operations must verify required safety program compliance befo',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Waste profiles characterize specific waste streams. Links regulatory/technical characterization to service catalog waste stream classification. Real business process: proper service routing, pricing d',
    `annual_quantity_estimate_tons` DECIMAL(18,2) COMMENT 'Estimated annual quantity of waste expected to be generated under this profile, measured in tons. Used for capacity planning and permit compliance.',
    `approval_status` STRING COMMENT 'Current approval status of the waste profile. Waste cannot be accepted for treatment or disposal until profile is approved.. Valid values are `draft|pending_review|approved|rejected|suspended|expired`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the waste profile was approved for acceptance.',
    `constituents_of_concern` STRING COMMENT 'List of specific chemical constituents or contaminants present in the waste that drive its hazardous classification (e.g., Lead, Chromium, Toluene).',
    `container_type_approved` STRING COMMENT 'Approved container types for this waste stream (e.g., 55-gallon steel drum, Bulk tanker, Fiber drum, Supersack). Multiple types may be listed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the waste profile record was first created in the system.',
    `dot_hazard_class` STRING COMMENT 'Department of Transportation hazard classification for transportation purposes (e.g., Class 3 Flammable Liquid, Class 6.1 Toxic, Class 8 Corrosive, Class 9 Miscellaneous).',
    `emergency_response_procedure` STRING COMMENT 'Summary of emergency response procedures in case of spill, release, or exposure incident involving this waste material.',
    `epa_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes (D-codes for characteristic, F-codes for non-specific source, K-codes for specific source, P/U-codes for commercial chemical products) assigned to this waste stream.',
    `flash_point_celsius` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors ignite when exposed to an ignition source. Used to determine ignitability characteristic (D001: flash point <60°C).',
    `is_corrosive` BOOLEAN COMMENT 'Indicates whether the waste exhibits the characteristic of corrosivity per EPA D002 criteria (aqueous with pH ≤2 or ≥12.5, or liquid that corrodes steel at rate >6.35mm per year at 55°C).',
    `is_ignitable` BOOLEAN COMMENT 'Indicates whether the waste exhibits the characteristic of ignitability per EPA D001 criteria (liquid with flash point <60°C, non-liquid capable of spontaneous combustion, ignitable compressed gas, or oxidizer).',
    `is_reactive` BOOLEAN COMMENT 'Indicates whether the waste exhibits the characteristic of reactivity per EPA D003 criteria (unstable, reacts violently with water, generates toxic gases, contains cyanide or sulfide, or capable of detonation).',
    `is_toxic` BOOLEAN COMMENT 'Indicates whether the waste exhibits the toxicity characteristic per TCLP testing, with contaminant concentrations exceeding regulatory thresholds (D004-D043).',
    `land_disposal_restricted` BOOLEAN COMMENT 'Indicates whether the waste is subject to Land Disposal Restrictions requiring treatment to meet specific standards before landfill disposal.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this waste profile. Profiles should be reviewed annually or when waste characteristics change.',
    `ldr_treatment_standards` STRING COMMENT 'Specific treatment standards that must be met before land disposal, including concentration limits for hazardous constituents or required treatment technologies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the waste profile record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to this waste profile.',
    `packing_group` STRING COMMENT 'DOT packing group indicating degree of danger: I (great danger), II (medium danger), III (minor danger). Used for transportation classification.. Valid values are `I|II|III`',
    `ph_value` DECIMAL(18,2) COMMENT 'Measured pH level of the waste material. Critical for determining corrosivity characteristic (D002: pH ≤2 or ≥12.5).',
    `physical_state` STRING COMMENT 'Physical form of the waste material at ambient temperature and pressure.. Valid values are `solid|liquid|sludge|gas|semi_solid|powder`',
    `ppe_required` STRING COMMENT 'Personal protective equipment required when handling this waste (e.g., Level B, respirator, chemical-resistant gloves, face shield).',
    `process_generating_waste` STRING COMMENT 'Description of the industrial or commercial process that generates this waste stream (e.g., Metal degreasing operation, Paint booth cleaning).',
    `profile_effective_date` DATE COMMENT 'Date when the waste profile becomes effective and waste shipments under this profile may be accepted.',
    `profile_expiration_date` DATE COMMENT 'Date when the waste profile expires and must be renewed or re-approved. Typically profiles are valid for 1-3 years depending on facility requirements.',
    `profile_name` STRING COMMENT 'Descriptive name of the waste stream or material being profiled (e.g., Industrial Solvent Waste, Lead-Contaminated Soil).',
    `profile_number` STRING COMMENT 'Business identifier for the waste profile, used for external reference and tracking. Typically formatted as WP- followed by numeric sequence.. Valid values are `^WP-[0-9]{6,10}$`',
    `proper_shipping_name` STRING COMMENT 'DOT-approved proper shipping name for the hazardous material as it must appear on shipping papers and manifests (e.g., Waste Flammable Liquid, N.O.S.).',
    `special_handling_instructions` STRING COMMENT 'Any special handling, storage, or safety requirements for this waste stream (e.g., Keep refrigerated, Incompatible with oxidizers, Requires secondary containment).',
    `tclp_results_summary` STRING COMMENT 'Summary of TCLP test results listing detected contaminants and their concentrations in mg/L. Used to determine D-code assignments for toxic characteristics.',
    `tclp_test_date` DATE COMMENT 'Date when the most recent Toxicity Characteristic Leaching Procedure laboratory test was performed to determine if waste exhibits toxicity characteristic.',
    `treatment_method_required` STRING COMMENT 'Approved treatment or disposal method for this waste stream (e.g., Incineration, Stabilization, Landfill Disposal, Fuel Blending).',
    `un_na_number` STRING COMMENT 'Four-digit United Nations or North America identification number assigned to the hazardous material for transportation purposes (e.g., UN1203, NA1993).. Valid values are `^(UN|NA)[0-9]{4}$`',
    `waste_description` STRING COMMENT 'Detailed description of the waste material including source process, composition, contaminants, and any special handling considerations.',
    CONSTRAINT pk_waste_profile PRIMARY KEY(`waste_profile_id`)
) COMMENT 'Waste characterization profile defining the physical and chemical properties of a specific hazardous waste stream. Captures waste code(s) (EPA D/F/K/P/U codes), TCLP test results, physical state, pH, ignitability, corrosivity, reactivity, toxicity characteristics, DOT hazard class, UN/NA number, proper shipping name, and approval status. Each profile is approved before waste is accepted for treatment or disposal. Sourced from SAP EHS and Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`manifest` (
    `manifest_id` BIGINT COMMENT 'Unique identifier for the hazardous waste manifest record. Primary key.',
    `alternate_facility_epa_epa_id_registration_id` BIGINT COMMENT 'EPA ID of an alternate TSDF facility designated by the generator if the primary TSDF cannot accept the waste.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Manifests document waste shipments fulfilling disposal purchase orders. Regulatory compliance and financial reconciliation require linking manifest tracking numbers to procurement commitments for thre',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: Manifest has dot_id_number (string) but no FK to dot_hazmat_classification reference table. Adding FK provides standardized DOT classification lookup. Keep dot_shipping_name, dot_hazard_class, dot_pac',
    `epa_id_registration_id` BIGINT COMMENT 'EPA ID of the first transporter in the chain of custody. Required for all hazardous waste shipments.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Hazardous waste manifests require generator certification signature per 40 CFR 262.23. Tracking the certifying employee enables audit trails, signature authority verification, and regulatory complianc',
    `generator_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Manifest tracks generator EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (generator_epa_id_registration_id) distinguishes this from other EPA ID references on m',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Manifests document shipments under generators permit authority. Required for regulatory traceability, compliance audits, and verifying generator operated within permit conditions during shipment peri',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Transportation and handling incidents during hazmat shipments must reference the manifest for DOT/EPA regulatory reporting, root cause analysis, and liability documentation. Critical for incident inve',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Manifests document hazardous waste shipments that generate billable charges. Regulatory audits require linking manifest tracking numbers to invoices. Essential for compliance verification, dispute res',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Manifest has epa_waste_codes (string, comma-separated) but no FK to waste_code reference table. Adding FK for primary waste code provides standardized waste code lookup. Keep epa_waste_codes string fo',
    `transporter_2_epa_epa_id_registration_id` BIGINT COMMENT 'EPA ID of the second transporter if multiple transporters are involved in the shipment chain.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `tsdf_epa_epa_id_registration_id` BIGINT COMMENT 'EPA ID of the designated TSDF facility that will receive and process the hazardous waste.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Manifest violations (discrepancies, late exception reports, improper signatures) trigger violation notices per 40 CFR 262. Required for enforcement tracking and linking manifest non-compliance to regu',
    `container_count` STRING COMMENT 'Total number of containers (drums, boxes, tanks, etc.) included in this manifest shipment.',
    `container_type` STRING COMMENT 'EPA container type code. Common codes: DM=Metal Drum, DF=Fiber Drum, BA=Burlap/Canvas Bag, DT=Dump Truck, CY=Cylinder, TP=Portable Tank, TT=Cargo Tank, TC=Tank Car, CF=Fiber Box, CM=Metal Box. [ENUM-REF-CANDIDATE: DM|DF|BA|DT|CY|TP|TT|TC|CF|CM|BM|BW|CC|CH|CN|CP|CR|CS|CT|CW|DW|HG|ID|LT|MS|PA|PC|PN|RG|RT|SC|SD|TN|VN|WC — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this manifest record was first created in the system.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies noted by the TSDF, including quantity variances, container damage, or waste type mismatches.',
    `discrepancy_indication` BOOLEAN COMMENT 'Boolean flag indicating whether the TSDF identified any discrepancies between the manifest and the actual shipment received (quantity, type, condition).',
    `dot_hazard_class` STRING COMMENT 'DOT hazard class or division number (e.g., 3 for flammable liquids, 6.1 for toxic substances, 8 for corrosives) per 49 CFR Part 173.',
    `dot_id_number` STRING COMMENT 'Four-digit UN or NA identification number assigned to the hazardous material for transportation (e.g., UN1203 for gasoline).. Valid values are `^UN[0-9]{4}$|^NA[0-9]{4}$`',
    `dot_packing_group` STRING COMMENT 'DOT packing group indicating degree of danger: I=Great Danger, II=Medium Danger, III=Minor Danger.. Valid values are `I|II|III`',
    `dot_shipping_name` STRING COMMENT 'DOT-required proper shipping name from the Hazardous Materials Table (49 CFR 172.101) describing the waste for transportation purposes.',
    `epa_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes (D, F, K, P, U series) identifying the specific waste characteristics or sources. Example: D001,F005,D008.',
    `generator_city` STRING COMMENT 'City where the generator facility is located.',
    `generator_contact_name` STRING COMMENT 'Name of the authorized representative at the generator facility responsible for the manifest.',
    `generator_contact_phone` STRING COMMENT 'Primary phone number for the generator facility contact person.. Valid values are `^+?[0-9]{10,15}$`',
    `generator_emergency_phone` STRING COMMENT '24-hour emergency response phone number for incidents involving this waste shipment (e.g., CHEMTREC, facility emergency line).. Valid values are `^+?[0-9]{10,15}$`',
    `generator_name` STRING COMMENT 'Legal name of the hazardous waste generator facility originating the waste shipment.',
    `generator_signature_date` DATE COMMENT 'Date the generator authorized representative signed the manifest certifying the waste information is accurate.',
    `generator_site_address` STRING COMMENT 'Physical street address of the generator facility where the hazardous waste was produced.',
    `generator_state` STRING COMMENT 'Two-letter US state code for the generator facility location.. Valid values are `^[A-Z]{2}$`',
    `generator_zip_code` STRING COMMENT 'US postal ZIP code for the generator facility (5-digit or ZIP+4 format).. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `import_indication` BOOLEAN COMMENT 'Boolean flag indicating whether this manifest documents an international import of hazardous waste into the United States.',
    `import_port_of_entry` STRING COMMENT 'US port of entry location for international hazardous waste imports.',
    `manifest_status` STRING COMMENT 'Current lifecycle status of the manifest document. Tracks progression from draft through final disposition at TSDF. [ENUM-REF-CANDIDATE: draft|in_transit|received_by_tsdf|completed|corrected|rejected|voided — 7 candidates stripped; promote to reference product]',
    `manifest_type` STRING COMMENT 'Format type of the manifest submission: paper (traditional hard copy), electronic (e-Manifest via RCRAInfo), or hybrid (combination).. Valid values are `paper|electronic|hybrid`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this manifest record was last modified or updated.',
    `quantity_unit` STRING COMMENT 'Unit of measure for total waste quantity. EPA codes: K=Kilograms, P=Pounds, T=Tons (2000 lbs), G=Gallons, L=Liters, M=Metric Tons, N=Cubic Meters, Y=Cubic Yards. [ENUM-REF-CANDIDATE: K|P|T|G|L|M|N|Y — 8 candidates stripped; promote to reference product]',
    `received_date` DATE COMMENT 'Date the TSDF facility received and accepted the hazardous waste shipment. Used to calculate transit time and verify timely delivery.',
    `rejection_indication` BOOLEAN COMMENT 'Boolean flag indicating whether the TSDF rejected all or part of the waste shipment.',
    `rejection_reason` STRING COMMENT 'Explanation of why the TSDF rejected the waste shipment (e.g., waste not matching manifest, facility permit restrictions, safety concerns).',
    `residue_indication` BOOLEAN COMMENT 'Boolean flag indicating whether the containers being shipped contain only residue (less than 3% by weight remaining after emptying).',
    `shipment_date` DATE COMMENT 'Date the hazardous waste shipment left the generator facility. Critical for regulatory compliance timelines and chain-of-custody tracking.',
    `special_handling_instructions` STRING COMMENT 'Additional handling, storage, or safety instructions for transporters and TSDF personnel. May include temperature requirements, incompatibility warnings, or PPE requirements.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Total quantity of hazardous waste on this manifest across all waste streams and containers.',
    `tracking_number` STRING COMMENT 'EPA-issued 12-character unique tracking number for the Uniform Hazardous Waste Manifest (9 digits + 3 letter suffix). Required for cradle-to-grave tracking under RCRA Subtitle C.. Valid values are `^[0-9]{9}[A-Z]{3}$`',
    `transporter_1_name` STRING COMMENT 'Legal name of the first transporter company handling the waste shipment.',
    `transporter_2_name` STRING COMMENT 'Legal name of the second transporter company if applicable.',
    `transporter_signature_date` DATE COMMENT 'Date the transporter signed the manifest acknowledging receipt of the waste shipment from the generator.',
    `tsdf_city` STRING COMMENT 'City where the TSDF facility is located.',
    `tsdf_name` STRING COMMENT 'Legal name of the designated TSDF facility receiving the hazardous waste.',
    `tsdf_signature_date` DATE COMMENT 'Date the TSDF authorized representative signed the manifest certifying receipt of the waste shipment.',
    `tsdf_site_address` STRING COMMENT 'Physical street address of the TSDF facility receiving the waste.',
    `tsdf_state` STRING COMMENT 'Two-letter US state code for the TSDF facility location.. Valid values are `^[A-Z]{2}$`',
    `tsdf_zip_code` STRING COMMENT 'US postal ZIP code for the TSDF facility.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `waste_description` STRING COMMENT 'Detailed description of the hazardous waste contents, composition, and physical state. Required to supplement EPA waste codes.',
    CONSTRAINT pk_manifest PRIMARY KEY(`manifest_id`)
) COMMENT 'Uniform Hazardous Waste Manifest (EPA Form 8700-22) tracking cradle-to-grave movement of hazardous waste from generator to TSDF. Captures manifest number, generator EPA ID, transporter EPA ID(s), designated TSDF EPA ID, waste descriptions, container types and counts, total quantity, DOT shipping information, emergency response phone, special handling instructions, and all required signatures (generator, transporter, TSDF). Supports e-Manifest (EPA RCRAInfo) integration.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`manifest_line` (
    `manifest_line_id` BIGINT COMMENT 'Unique identifier for the manifest line item. Primary key for the manifest line entity.',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: Manifest line has un_na_number (string) but no FK to dot_hazmat_classification reference table. Adding FK provides standardized DOT classification lookup. Keep dot_proper_shipping_name, dot_hazard_cla',
    `manifest_id` BIGINT COMMENT 'Reference to the parent hazardous waste manifest document. Links this line item to the overall manifest header.',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Manifest line has epa_waste_codes (string, comma-separated) but no FK to waste_code reference table. Adding FK for primary waste code provides standardized waste code lookup. Keep epa_waste_codes stri',
    `waste_profile_id` BIGINT COMMENT 'Reference to the approved waste profile document. Waste profiles contain detailed characterization data including TCLP test results, flash point, pH, and other analytical data.',
    `container_count` STRING COMMENT 'Total number of containers of this waste stream on the manifest line. Each container must be of the same type and size.',
    `container_size` DECIMAL(18,2) COMMENT 'Capacity or size of each individual container in the unit of measure specified. For drums, typically 55 gallons; for totes, typically 275-330 gallons.',
    `container_type` STRING COMMENT 'Type of container used to package the hazardous waste. Common types include 55-gallon drums, intermediate bulk containers (totes), portable tanks, compressed gas cylinders, bags, and boxes.. Valid values are `drum|tote|tank|cylinder|bag|box`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this manifest line record was first created in the system. Part of the audit trail for regulatory compliance.',
    `discrepancy_comments` STRING COMMENT 'Detailed explanation of any discrepancy between the manifest description and the waste received. Required when discrepancy_indication is not none.',
    `discrepancy_indication` STRING COMMENT 'Type of discrepancy identified by the receiving facility, if any. Discrepancies must be reported to EPA and the generator within 15 days.. Valid values are `type|quantity|residue|none`',
    `dot_hazard_class` STRING COMMENT 'DOT hazard classification for transportation purposes. Identifies the primary hazard category (e.g., Class 3 Flammable Liquid, Class 6.1 Toxic, Class 8 Corrosive, Class 9 Miscellaneous).',
    `dot_packing_group` STRING COMMENT 'DOT packing group indicating the degree of danger. Group I represents high danger, Group II medium danger, and Group III low danger.. Valid values are `I|II|III`',
    `dot_proper_shipping_name` STRING COMMENT 'Official DOT proper shipping name from the Hazardous Materials Table. Must be used on shipping papers and placards.',
    `epa_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes assigned to this waste stream. Includes F-list (process wastes), K-list (industry-specific), P-list and U-list (discarded commercial chemicals), and D-list (characteristic wastes) codes.',
    `flash_point_fahrenheit` DECIMAL(18,2) COMMENT 'Flash point temperature in degrees Fahrenheit. Wastes with flash point below 140°F are characteristic hazardous wastes (D001) and DOT Class 3 flammable liquids.',
    `generator_comments` STRING COMMENT 'Additional comments or notes from the waste generator regarding this waste stream. May include process information, generation date, or other relevant details.',
    `line_number` STRING COMMENT 'Sequential line number within the manifest document. Determines the ordering of waste streams on the manifest form.',
    `line_status` STRING COMMENT 'Current status of this manifest line item in the cradle-to-grave tracking workflow. Tracks progression from draft through final disposition.. Valid values are `draft|submitted|in_transit|received|discrepancy|rejected`',
    `management_method_code` STRING COMMENT 'Code indicating the intended treatment, storage, or disposal method for this waste stream at the designated TSDF facility.',
    `marine_pollutant_flag` BOOLEAN COMMENT 'Indicates whether the waste is designated as a marine pollutant under DOT regulations. Requires special marking and documentation for water transportation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this manifest line record was last modified. Tracks changes for audit and compliance purposes.',
    `pcb_concentration_ppm` DECIMAL(18,2) COMMENT 'Concentration of PCBs in parts per million if the waste contains PCBs. Wastes with PCB concentrations of 50 ppm or greater are subject to TSCA PCB regulations.',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement of the waste. Wastes with pH ≤2 or ≥12.5 are characteristic corrosive hazardous wastes (D002).',
    `physical_state` STRING COMMENT 'Physical state or form of the hazardous waste. Determines handling, storage, and treatment requirements.. Valid values are `solid|liquid|gas|sludge|semi_solid`',
    `received_date` DATE COMMENT 'Date the waste was received at the designated TSDF facility. Establishes the start of the facilitys custody period.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity received by the designated facility in the specified unit of measure. May differ from total_quantity if discrepancies exist.',
    `reportable_quantity_flag` BOOLEAN COMMENT 'Indicates whether this waste stream meets or exceeds the CERCLA reportable quantity threshold. If true, the letters RQ must appear on the manifest and shipping papers.',
    `special_handling_instructions` STRING COMMENT 'Additional handling, storage, or transportation instructions for this waste stream. May include temperature controls, incompatibility warnings, PPE requirements, or emergency response procedures.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Total quantity of waste for this line item in the specified unit of measure. Calculated as container count multiplied by container size, or measured directly.',
    `un_na_number` STRING COMMENT 'Four-digit UN or NA identification number assigned to the hazardous material for transportation. UN numbers are internationally recognized; NA numbers are North America-specific.. Valid values are `^(UN|NA)[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the waste quantity. Common units include gallons, liters, pounds, kilograms, tons, and cubic yards.. Valid values are `gallons|liters|pounds|kilograms|tons|cubic_yards`',
    `waste_description` STRING COMMENT 'Detailed narrative description of the hazardous waste stream. Includes physical characteristics, chemical composition, and source process information as required by DOT HMR and RCRA.',
    `waste_minimization_code` STRING COMMENT 'Code indicating the waste minimization efforts applied to this waste stream. Required for biennial reporting under RCRA.',
    CONSTRAINT pk_manifest_line PRIMARY KEY(`manifest_line_id`)
) COMMENT 'Individual waste stream line item on a hazardous waste manifest. Captures line number, waste description, EPA waste codes, DOT hazard class, UN/NA number, container type (drum, tote, tank), container count, unit of measure, total quantity (lbs/gallons), physical state, and special handling notes. Each manifest may carry multiple waste streams requiring separate line entries per DOT HMR and RCRA requirements.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` (
    `hazmat_container_id` BIGINT COMMENT 'Unique identifier for the hazardous waste container. Primary key for tracking individual drums, totes, IBCs, lab packs, and roll-offs throughout their lifecycle from generation through disposal.',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Hazmat containers must conform to approved container type specifications from service catalog. Enables container inventory management, service delivery validation, and regulatory compliance with appro',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: Hazmat container has dot_un_number (string) but no FK to dot_hazmat_classification reference table. Adding FK provides standardized DOT classification lookup including proper shipping name, hazard cla',
    `epa_id_registration_id` BIGINT COMMENT 'EPA ID number of the licensed hazardous waste transporter currently responsible for this container during shipment. Required for manifest documentation.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `generator_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Hazmat container tracks generator EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (generator_epa_id_registration_id) distinguishes this from transporter and TSDF',
    `jha_id` BIGINT COMMENT 'Foreign key linking to safety.jha. Business justification: Hazmat containers require approved job hazard analyses for handling, inspection, movement, and emergency response tasks. JHA documents hazards, controls, and PPE requirements specific to container typ',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Hazmat container references manifest by manifest_number string. This should be normalized to FK to manifest. Adding FK provides proper relational link. Remove manifest_number string as it becomes redu',
    `manifest_line_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest_line. Business justification: Containers are listed on specific manifest line items. One container appears on one manifest line. This links the container to the specific line item on the manifest, replacing the INT manifest_line_n',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Hazmat container has epa_waste_codes (string, comma-separated) but no FK to waste_code reference table. Adding FK for primary waste code provides standardized waste code lookup. Keep epa_waste_codes s',
    `service_order_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazmat_service_order. Business justification: Containers are collected via hazmat service orders. This links the container to the service order that picked it up from the generator site. One container is collected in one service order event. This',
    `facility_id` BIGINT COMMENT 'Reference to the physical facility or site where the container is currently stored. Links to facility EPA ID number and permit information.',
    `tsdf_epa_epa_id_registration_id` BIGINT COMMENT 'EPA ID number of the permitted TSDF facility designated to receive and dispose of this container. Must be listed on the hazardous waste manifest.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `waste_profile_id` BIGINT COMMENT 'Reference to the waste profile that characterizes the hazardous waste currently stored in this container. Links to waste codes, TCLP results, and handling requirements.',
    `accumulation_deadline_date` DATE COMMENT 'Regulatory deadline by which the container must be shipped off-site to avoid RCRA violations. Calculated based on generator status and accumulation start date.',
    `accumulation_start_date` DATE COMMENT 'Date when hazardous waste was first placed into this container. Triggers regulatory accumulation time limits (90-day rule for large quantity generators, 180/270-day for small quantity generators).',
    `capacity_gallons` DECIMAL(18,2) COMMENT 'Maximum rated capacity of the container in U.S. gallons. Used to calculate fill levels, determine accumulation limits, and plan transportation logistics.',
    `chain_of_custody_status` STRING COMMENT 'Current custody status in the cradle-to-grave tracking chain. Indicates which party currently has physical possession and legal responsibility for the container.. Valid values are `at_generator|with_transporter|at_tsdf|disposed`',
    `condition` STRING COMMENT 'Assessment of the physical integrity and condition of the container. Critical for safety, regulatory compliance, and determining if container requires overpacking or replacement.. Valid values are `good|fair|damaged|leaking|corroded`',
    `container_status` STRING COMMENT 'Current state of the container in its lifecycle from deployment through final disposal. Drives regulatory compliance timelines (e.g., 90-day accumulation limits) and operational workflows.. Valid values are `empty|accumulating|full|in_transit|at_tsdf|disposed`',
    `container_type` STRING COMMENT 'Classification of the physical container form factor used to store and transport the hazardous waste. Determines handling procedures and equipment requirements.. Valid values are `drum_55_gallon|drum_30_gallon|tote_ibc|lab_pack|roll_off|bulk_tank`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this container record was first created in the system. Used for audit trail and data lineage tracking.',
    `disposal_date` DATE COMMENT 'Date when the waste in this container was finally treated and disposed of at the TSDF. Completes the cradle-to-grave tracking lifecycle.',
    `disposal_method` STRING COMMENT 'Planned or actual method of treatment and disposal for the waste in this container. Determined by waste characteristics, EPA waste codes, and TSDF capabilities.. Valid values are `incineration|landfill|fuel_blending|recycling|stabilization|neutralization`',
    `dot_hazard_class` STRING COMMENT 'DOT hazard class or division number (e.g., 3 for flammable liquids, 8 for corrosives) that classifies the primary hazard of the material for transportation purposes.. Valid values are `^[1-9](.[1-6])?$`',
    `dot_packing_group` STRING COMMENT 'DOT packing group (I, II, or III) indicating the degree of danger: I = high danger, II = medium danger, III = low danger. Determines packaging requirements.. Valid values are `I|II|III`',
    `dot_shipping_name` STRING COMMENT 'DOT-required proper shipping name for the hazardous material in this container as listed in 49 CFR 172.101 Hazardous Materials Table. Required for transportation documentation.',
    `dot_un_number` STRING COMMENT 'Four-digit UN identification number assigned to the hazardous material for international transportation (e.g., UN1203 for gasoline). Required on shipping papers and labels.. Valid values are `^UN[0-9]{4}$`',
    `epa_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes assigned to the waste in this container (e.g., D001, F003). Determines regulatory requirements and disposal methods.. Valid values are `^[DFKPU][0-9]{3}(,[DFKPU][0-9]{3})*$`',
    `fill_level_percent` DECIMAL(18,2) COMMENT 'Current fill level of the container as a percentage of total capacity. Used to determine when container is full and ready for pickup, and to comply with DOT fill requirements.',
    `gross_weight_lbs` DECIMAL(18,2) COMMENT 'Total weight of the container including waste contents in pounds. Critical for transportation compliance, vehicle load planning, and TSDF acceptance.',
    `identification_number` STRING COMMENT 'External business identifier for the container, typically a barcode or RFID tag number used for scanning and tracking in the field. May be printed on container label.. Valid values are `^[A-Z0-9]{8,20}$`',
    `label_affixed_date` DATE COMMENT 'Date when the hazardous waste label was affixed to the container. RCRA requires containers to be labeled upon start of accumulation with waste identity and accumulation start date.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent container inspection for leaks, corrosion, and structural integrity. RCRA requires weekly inspections of containers in accumulation areas.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this container record. Supports audit trail, change tracking, and data quality monitoring.',
    `material_of_construction` STRING COMMENT 'Primary material used in container construction. Must be compatible with waste characteristics to prevent corrosion, leakage, or chemical reaction.. Valid values are `steel|polyethylene|fiberglass|stainless_steel|composite`',
    `net_waste_weight_lbs` DECIMAL(18,2) COMMENT 'Calculated weight of waste contents only (gross weight minus tare weight) in pounds. Used for billing, regulatory reporting, and disposal facility acceptance.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required container inspection. Ensures compliance with weekly inspection requirements for hazardous waste containers.',
    `secondary_containment_required` BOOLEAN COMMENT 'Indicates whether this container must be stored in secondary containment (e.g., spill pallet, containment berm) based on waste characteristics and regulatory requirements.',
    `source_system` STRING COMMENT 'Operational system of record that originated this container record. Typically SAP EHS for container master data or AMCS for container tracking events.. Valid values are `sap_ehs|amcs|enviance|waste_logics`',
    `storage_location_code` STRING COMMENT 'Specific location code within the storage facility (e.g., bay number, rack position, zone identifier) for precise container tracking and inventory management.. Valid values are `^[A-Z0-9]{2,10}$`',
    `storage_location_type` STRING COMMENT 'Classification of the storage area where the container is currently located. Determines applicable regulatory requirements and accumulation time limits.. Valid values are `satellite|ninety_day_area|permitted_storage|tsdf_storage`',
    `tare_weight_lbs` DECIMAL(18,2) COMMENT 'Empty weight of the container in pounds, excluding waste contents. Used to calculate net waste weight for billing, manifest documentation, and transportation compliance.',
    `un_performance_rating` STRING COMMENT 'UN packaging specification code indicating the container has been tested and certified for transporting hazardous materials. Format example: UN1A2/X150/S for a steel drum.. Valid values are `^UN[0-9]{1,2}[A-Z][0-9]{1,2}(/[A-Z])?(/[0-9]{2,4})?$`',
    CONSTRAINT pk_hazmat_container PRIMARY KEY(`hazmat_container_id`)
) COMMENT 'Master record for individual hazardous waste containers (drums, totes, IBCs, lab packs, roll-offs) tracked by CID/RFID. Captures container type, capacity, material of construction, UN performance rating, current waste profile assignment, fill level, tare weight, gross weight, accumulation start date, storage location (satellite, 90-day, permitted storage), container condition, and chain-of-custody status. Integrates with AMCS container tracking and SAP EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` (
    `tsdf_facility_id` BIGINT COMMENT 'Unique identifier for the TSDF facility record. Primary key for the TSDF facility master data.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: TSDF facilities serve specific geographic service areas. Enables service area capacity planning, routing optimization, and territory management. Real business process: determining available TSDF capac',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_audit. Business justification: TSDF facilities undergo periodic safety audits as part of RCRA compliance verification and operational oversight. Links facility safety performance to permit compliance, insurance requirements, and ve',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: TSDF facilities operate under disposal agreements defining accepted waste codes, contracted capacity, pricing. Facility selection for manifest routing requires checking active agreements, permitted wa',
    `emergency_action_plan_id` BIGINT COMMENT 'Foreign key linking to safety.emergency_action_plan. Business justification: TSDF facilities require site-specific emergency action plans per RCRA contingency planning requirements (40 CFR 265 Subpart D). Links facility emergency preparedness to operational safety management f',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: TSDF facilities are major emission sources requiring EPA GHGRP reporting. Treatment/disposal operations (incineration, thermal treatment) generate Scope 1 emissions tracked at facility level for regul',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: TSDF facilities are EPA-registered entities. The epa_id_number string duplicates epa_id_registration data. Adding FK normalizes this relationship and provides a second inbound link to epa_id_registrat',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: TSDF facilities are asset facilities with specialized hazmat permits. Links TSDF regulatory view to facility asset master for depreciation, insurance, maintenance coordination, and capital project tra',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RCRA TSDF permits require designated facility manager per 40 CFR 264.16. Links facility to employee enables certification verification (professional engineer, facility manager training), regulatory co',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: TSDFs operate under RCRA Part B permits (40 CFR 264/265). Permit defines permitted waste codes, treatment/storage/disposal capacity, and operational conditions. Core regulatory relationship for facili',
    `tracked_site_id` BIGINT COMMENT 'Foreign key linking to sustainability.tracked_site. Business justification: TSDF facilities are primary sustainability tracking sites. All corporate ESG reports (CDP, GRI, SASB) include TSDF facility-level metrics for emissions, energy, waste, and water. Fundamental ESG repor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: TSDF facilities are vendors in procurement system. Waste Management operations require linking facility registrations to vendor master data for contract management, payment processing, vendor performa',
    `accepts_bulk_waste` BOOLEAN COMMENT 'Boolean flag indicating whether the facility is equipped and permitted to accept bulk hazardous waste shipments (tanker trucks, rail cars).',
    `accepts_containerized_waste` BOOLEAN COMMENT 'Boolean flag indicating whether the facility accepts containerized hazardous waste (drums, totes, boxes).',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the TSDF facility location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TSDF facility record was first created in the system. Used for audit trail and data lineage tracking.',
    `disposal_capacity_tons` DECIMAL(18,2) COMMENT 'Maximum permitted disposal capacity for hazardous waste at the facility measured in tons. Applicable for landfill and land disposal units.',
    `emergency_coordinator_name` STRING COMMENT 'Full name of the designated emergency coordinator responsible for coordinating emergency response activities at the TSDF facility as required by RCRA.',
    `emergency_coordinator_title` STRING COMMENT 'Job title or position of the designated emergency coordinator at the TSDF facility.',
    `emergency_phone_number` STRING COMMENT '24-hour emergency contact phone number for the TSDF facility as required by RCRA contingency plans. Organizational contact data classified as confidential.',
    `facility_status` STRING COMMENT 'Current operational status of the TSDF facility indicating whether it is authorized to receive and process hazardous waste.. Valid values are `active|inactive|suspended|closed|pending_closure|post_closure`',
    `facility_type` STRING COMMENT 'Classification of the TSDF facility based on permitted operations: treatment, storage, disposal, or combinations thereof. [ENUM-REF-CANDIDATE: treatment_only|storage_only|disposal_only|treatment_storage|treatment_disposal|storage_disposal|treatment_storage_disposal — 7 candidates stripped; promote to reference product]',
    `financial_assurance_amount` DECIMAL(18,2) COMMENT 'Dollar amount of financial assurance maintained by the facility for closure and post-closure care. Business-sensitive financial data.',
    `financial_assurance_expiration_date` DATE COMMENT 'Expiration date of the current financial assurance instrument. Must be renewed before expiration to maintain compliance.',
    `financial_assurance_mechanism` STRING COMMENT 'Type of financial assurance mechanism the facility has established to ensure funds are available for closure and post-closure care as required by RCRA.. Valid values are `trust_fund|surety_bond|letter_of_credit|insurance|financial_test|corporate_guarantee`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection conducted by EPA or authorized state agency at the TSDF facility.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent regulatory inspection indicating compliance status and any violations found.. Valid values are `compliant|minor_violations|major_violations|enforcement_action`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this TSDF facility record was last updated. Used for audit trail and change tracking.',
    `liability_insurance_certificate_number` STRING COMMENT 'Certificate number for the facilitys liability insurance coverage for sudden and non-sudden accidental occurrences as required by RCRA.',
    `liability_insurance_expiration_date` DATE COMMENT 'Expiration date of the facilitys current liability insurance policy. Must maintain continuous coverage per RCRA requirements.',
    `manifest_approval_status` STRING COMMENT 'Approval status indicating whether the facility is authorized to be designated as a receiving facility on hazardous waste manifests. Determines if waste can be shipped to this TSDF.. Valid values are `approved|pending|suspended|revoked|conditional`',
    `notes` STRING COMMENT 'Free-text notes field for capturing additional information about the TSDF facility including special handling requirements, access restrictions, or operational considerations.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the TSDF facility indicating when waste shipments can be received and processed.',
    `permitted_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes (D, F, K, P, U series) that the facility is permitted to accept under its RCRA permit. Determines which waste streams can be sent to this TSDF.',
    `storage_capacity_tons` DECIMAL(18,2) COMMENT 'Maximum permitted storage capacity for hazardous waste at the facility measured in tons. Regulatory limit specified in the RCRA permit.',
    `treatment_methods` STRING COMMENT 'Comma-separated list of treatment method codes (e.g., incineration, stabilization, neutralization, thermal desorption) that the facility is authorized to perform under its RCRA permit.',
    `vendor_rating` STRING COMMENT 'Internal vendor performance rating assigned to the TSDF facility based on compliance history, service quality, and reliability. Used for vendor selection decisions.. Valid values are `preferred|approved|conditional|probation|suspended`',
    CONSTRAINT pk_tsdf_facility PRIMARY KEY(`tsdf_facility_id`)
) COMMENT 'Master record for Treatment, Storage, and Disposal Facilities (TSDFs) authorized to receive hazardous waste. Captures EPA ID number, facility name, address, RCRA permit number and expiration, permitted waste codes, treatment/storage/disposal methods (TSDF type codes), emergency coordinator, insurance certificate status, financial assurance mechanism, and approval status for use as a designated facility on manifests. Sourced from Enviance EHS vendor/facility registry.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` (
    `waste_shipment_id` BIGINT COMMENT 'Unique identifier for the hazardous waste shipment record. Primary key for the waste shipment entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Hazmat shipments require dispatch authorization tracking for chain of custody, DOT compliance verification, and operational accountability. Links shipment to employee enables labor cost allocation, tr',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Waste shipments to TSDF facilities execute under disposal agreements governing tipping fees, permitted waste streams, liability terms. Shipment authorization validates active agreement, applies contra',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Waste shipments execute disposal purchase orders. Operations require linking physical shipment records to procurement commitments for cost allocation, vendor performance tracking, and invoice verifica',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: Waste shipment has dot_placard_codes (string) but no FK to dot_hazmat_classification reference table. Adding FK provides standardized DOT classification lookup for primary placard. Keep dot_placard_co',
    `driver_id` BIGINT COMMENT 'Identifier of the driver assigned to transport this hazardous waste shipment. Driver must hold valid CDL with hazmat endorsement.',
    `epa_id_registration_id` BIGINT COMMENT 'EPA-issued 12-character identification number for the destination TSDF facility. Required for all permitted TSDFs under RCRA.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `fleet_fuel_consumption_id` BIGINT COMMENT 'Foreign key linking to sustainability.fleet_fuel_consumption. Business justification: Each hazmat shipment consumes fuel tracked for Scope 1 emissions. Linking shipments to fuel consumption records enables route-level carbon accounting, optimization analysis, and customer-specific emis',
    `generator_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Waste shipment tracks generator EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (generator_epa_id_registration_id) distinguishes this from TSDF and transporter. ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Shipments occur under generators permit authority. Required for compliance verification that shipment quantities and waste types are within permit limits, and for regulatory reporting and audit trail',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Shipment-related incidents (spills, vehicle accidents, exposure events) require linkage to shipment records for investigation, insurance claims, DOT reporting, and corrective action. Standard practice',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Waste shipments to TSDF facilities incur transportation and disposal costs that must be invoiced. Billing departments need shipment details (weight, distance, handling) to calculate charges. Critical ',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Waste shipment references manifest by manifest_number string. This should be normalized to FK to manifest. Adding FK provides proper relational link. Remove manifest_number string as it becomes redund',
    `observation_id` BIGINT COMMENT 'Foreign key linking to safety.safety_observation. Business justification: Driver safety observations during hazmat shipments (PPE use, placarding, load securement, driving behavior) link to specific shipment records for coaching, compliance verification, and DOT audit trail',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Shipments fulfill specific service offerings. Operations teams need this link for billing, compliance reporting, and SLA tracking. Real business process: shipment billing validation and service level ',
    `service_address_id` BIGINT COMMENT 'Identifier of the originating generator site where the hazardous waste was produced and picked up. Links to the facility that generated the waste.',
    `service_order_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazmat_service_order. Business justification: Waste shipments are the fulfillment of hazmat service orders. One shipment fulfills one service order request. This links the shipment execution to the originating service request, enabling tracking f',
    `transporter_epa_epa_id_registration_id` BIGINT COMMENT 'EPA-issued 12-character identification number for the transporter. Required for all hazardous waste transporters under RCRA.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `transporter_registration_id` BIGINT COMMENT 'Identifier of the hazardous waste transporter company assigned to execute this shipment. Links to the transporter entity responsible for safe transport.',
    `tsdf_facility_id` BIGINT COMMENT 'Identifier of the destination TSDF or transfer facility where the hazardous waste shipment is being transported for treatment, storage, or disposal.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the specific vehicle (truck, trailer) used to transport this hazardous waste shipment. Links to fleet management system.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Waste shipment should link to waste_profile for standardized waste characterization. This provides waste profile details for the shipment. No columns to remove as shipment-specific details (total_weig',
    `actual_arrival_time` TIMESTAMP COMMENT 'Actual timestamp when the vehicle arrived at the destination TSDF facility. Used for chain-of-custody tracking and billing.',
    `actual_departure_time` TIMESTAMP COMMENT 'Actual timestamp when the vehicle departed the generator site with the loaded hazardous waste. Captured via Geotab telematics or driver mobile app.',
    `actual_transit_hours` DECIMAL(18,2) COMMENT 'Actual elapsed time in hours from departure to arrival. Calculated from actual_departure_time and actual_arrival_time for performance tracking.',
    `billing_weight_lbs` DECIMAL(18,2) COMMENT 'Weight in pounds used for billing purposes. May differ from total_weight_lbs if minimum billing weight or rounding rules apply.',
    `bol_number` STRING COMMENT 'Unique Bill of Lading document number issued for this hazardous waste shipment. Required for DOT HMR compliance during transportation.. Valid values are `^BOL-[A-Z0-9]{8,12}$`',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Indicates whether chain-of-custody documentation has been verified and all required signatures obtained from generator, transporter, and TSDF.',
    `container_count` STRING COMMENT 'Total number of hazardous waste containers (drums, totes, boxes) included in this shipment. Used for manifest line item reconciliation.',
    `created_by_user` STRING COMMENT 'Username or employee ID of the system user who created this shipment record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment record was first created in the system. Used for audit trail and data lineage.',
    `dot_placard_codes` STRING COMMENT 'Comma-separated list of DOT placard codes required for this shipment (e.g., Class 3 Flammable Liquid, Class 8 Corrosive). Determines vehicle marking requirements.',
    `dot_placard_required` BOOLEAN COMMENT 'Indicates whether DOT hazmat placards are required on the vehicle for this shipment based on waste classification and quantity thresholds.',
    `driver_cdl_number` STRING COMMENT 'Commercial Driver License number of the driver transporting the hazardous waste. Must include hazmat endorsement for RCRA waste transport.. Valid values are `^[A-Z0-9]{8,15}$`',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency response phone number required on shipping papers for hazardous waste transport. Must be monitored continuously during shipment.. Valid values are `^+?[0-9]{10,15}$`',
    `emergency_response_guide_number` STRING COMMENT 'Three-digit ERG guide number from the DOT Emergency Response Guidebook. Used by first responders in case of spill or accident during transport.. Valid values are `^[0-9]{3}$`',
    `estimated_transit_hours` DECIMAL(18,2) COMMENT 'Estimated travel time in hours from generator site to destination TSDF. Used for route planning and customer communication.',
    `exception_reason` STRING COMMENT 'Description of any exception or discrepancy encountered during shipment (e.g., rejected load, quantity mismatch, container damage, route deviation).',
    `exception_reported_date` DATE COMMENT 'Date when a shipment exception or discrepancy was formally reported to the generator and regulatory authorities. Required within 30 days under RCRA.',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether real-time GPS tracking via Geotab telematics is active for this shipment. Enables live monitoring and geofencing alerts.',
    `last_modified_by_user` STRING COMMENT 'Username or employee ID of the system user who last modified this shipment record. Used for accountability and audit purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment record was last updated. Tracks the most recent change to any field in the record.',
    `route_deviation_detected` BOOLEAN COMMENT 'Flag indicating whether the vehicle deviated from the planned or approved hazmat route during transport. Triggers compliance review.',
    `route_restrictions` STRING COMMENT 'Special routing restrictions or requirements for this hazardous waste shipment (e.g., avoid tunnels, no residential areas, designated hazmat routes only).',
    `scheduled_pickup_time` TIMESTAMP COMMENT 'Planned date and time for pickup of hazardous waste from the generator site. Used for route optimization and customer communication.',
    `shipment_date` DATE COMMENT 'Calendar date when the hazardous waste shipment was scheduled or executed. Used for manifest dating and compliance tracking.',
    `shipment_notes` STRING COMMENT 'Free-text field for additional operational notes, driver observations, or special circumstances related to this shipment.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the hazardous waste shipment. Tracks progression from scheduling through final delivery and manifest closure.. Valid values are `scheduled|dispatched|in_transit|delivered|exception|cancelled`',
    `special_handling_instructions` STRING COMMENT 'Additional handling, loading, or transport instructions specific to this shipment (e.g., keep upright, segregate from oxidizers, HAZWOPER-trained personnel only).',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether this shipment requires temperature-controlled transport due to waste characteristics (e.g., reactive materials, biological hazards).',
    `total_weight_lbs` DECIMAL(18,2) COMMENT 'Total weight of hazardous waste in this shipment measured in pounds. Aggregated from all containers included in the shipment.',
    `vehicle_unit_number` STRING COMMENT 'Fleet unit number or license plate identifier of the vehicle used for this shipment. Used for tracking and compliance reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    CONSTRAINT pk_waste_shipment PRIMARY KEY(`waste_shipment_id`)
) COMMENT 'Operational record of a hazardous waste pickup and transport event from a generator site to a TSDF or transfer facility. Captures shipment date, originating generator site, destination TSDF, assigned transporter, vehicle and driver details, manifest number reference, BOL number, total weight (lbs), container count, DOT placard requirements, route restrictions, actual departure and arrival timestamps, and shipment status (scheduled, in-transit, delivered, exception). Integrates with Locus Dispatch and Geotab telematics.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` (
    `chain_of_custody_id` BIGINT COMMENT 'Unique identifier for the chain of custody record. Primary key for immutable cradle-to-grave tracking of hazardous waste container transfers.',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: Chain of custody has un_identification_number (string) but no FK to dot_hazmat_classification reference table. Adding FK provides standardized DOT classification lookup. Keep dot_shipping_name, dot_ha',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: RCRA regulations require driver identification and signature for chain of custody transfers. Links driver to HAZMAT endorsement verification, DOT physical status, and HOS compliance records. Essential',
    `epa_id_registration_id` BIGINT COMMENT 'EPA identification number of the party accepting custody of the hazardous waste. 12-character format: 2-letter state code + 9 digits.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `hazmat_container_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazmat_container. Business justification: Chain of custody currently links to asset.container (generic container) but should also link to hazmat_container (hazardous waste specific container). This provides hazmat-specific container details i',
    `manifest_id` BIGINT COMMENT 'Reference to the parent hazardous waste manifest document that governs this chain of custody transfer. Links to the EPA uniform hazardous waste manifest.',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Chain of custody has waste_code (string) but no FK to waste_code reference table. Adding FK provides standardized waste code lookup. Keep waste_code string as point-in-time value (may be recorded diff',
    `transferring_party_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Chain of custody tracks transferring party EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (transferring_party_epa_id_registration_id) distinguishes this from re',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: Chain of custody transfers during transportation require vehicle identification for DOT compliance audits, insurance claims, and RCRA enforcement actions. Vehicle tracking is mandatory for establishin',
    `waste_shipment_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_shipment. Business justification: Chain of custody records document transfers during waste shipments. Multiple custody transfer events occur per shipment (generator to transporter, transporter to TSDF, etc.). This links each custody t',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Chain of custody transfers often require employee witness per quality assurance procedures and legal defensibility requirements. Links COC event to employee record enables signature verification, trai',
    `bill_of_lading_number` STRING COMMENT 'Reference number for the DOT bill of lading document accompanying this hazardous waste shipment. Links chain of custody to transportation documentation.',
    `container_count` STRING COMMENT 'Number of hazardous waste containers included in this custody transfer event. Used to verify manifest accuracy and detect discrepancies.',
    `discrepancy_indicator` BOOLEAN COMMENT 'Flag indicating whether a discrepancy was noted during this custody transfer (e.g., container count mismatch, quantity variance, damage observed).',
    `discrepancy_notes` STRING COMMENT 'Detailed notes describing any discrepancy observed during the custody transfer. Required for RCRA exception reporting and CERCLA liability documentation.',
    `discrepancy_type` STRING COMMENT 'Classification of the discrepancy noted during custody transfer, if any. Used for exception handling and regulatory reporting.. Valid values are `quantity_variance|container_count_mismatch|container_damage|labeling_error|documentation_error|none`',
    `dot_hazard_class` STRING COMMENT 'DOT hazard class or division number for the material (e.g., 3 for flammable liquids, 6.1 for toxic substances, 8 for corrosives).',
    `dot_shipping_name` STRING COMMENT 'DOT proper shipping name for the hazardous material as required by Hazardous Materials Regulations (HMR). Used for transportation compliance.',
    `emergency_response_phone` STRING COMMENT '24-hour emergency response phone number for incidents involving this hazardous waste shipment. Required by DOT HMR.',
    `packing_group` STRING COMMENT 'DOT packing group indicating the degree of danger: I (great danger), II (medium danger), III (minor danger).. Valid values are `I|II|III`',
    `quantity_unit` STRING COMMENT 'Unit of measure for the total quantity of hazardous waste transferred (e.g., kilograms, pounds, gallons, liters).. Valid values are `kg|lbs|gallons|liters|cubic_yards|tons`',
    `receiving_party_contact_name` STRING COMMENT 'Full name of the individual representative who physically accepted custody on behalf of the receiving party.',
    `receiving_party_name` STRING COMMENT 'Legal business name of the organization or facility accepting custody of the hazardous waste container.',
    `receiving_party_signature` STRING COMMENT 'Digital signature or signature identifier of the receiving party representative acknowledging acceptance of custody. May be electronic signature hash or physical signature reference.',
    `record_created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this chain of custody record. Supports audit and compliance requirements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this chain of custody record was first created in the database. Used for audit trail and data lineage.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Total quantity of hazardous waste transferred in this custody event, measured in the unit specified by quantity_unit.',
    `transfer_event_type` STRING COMMENT 'Classification of the chain of custody transfer event. Defines the nature of the custody change in the cradle-to-grave lifecycle.. Valid values are `generator_handoff|transporter_receipt|transporter_transfer|tsdf_acceptance|treatment_completion|disposal_confirmation`',
    `transfer_location_address` STRING COMMENT 'Full street address of the location where the custody transfer occurred. Required for DOT and EPA compliance documentation.',
    `transfer_location_city` STRING COMMENT 'City where the custody transfer occurred.',
    `transfer_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the custody transfer location. Supports GPS-based verification and geospatial compliance analysis.',
    `transfer_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the custody transfer location. Supports GPS-based verification and geospatial compliance analysis.',
    `transfer_location_name` STRING COMMENT 'Name of the physical location where the custody transfer occurred (e.g., generator facility, transporter depot, TSDF receiving dock).',
    `transfer_location_postal_code` STRING COMMENT 'ZIP code of the location where the custody transfer occurred.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `transfer_location_state` STRING COMMENT 'Two-letter state code where the custody transfer occurred. Used for state-level regulatory reporting.. Valid values are `^[A-Z]{2}$`',
    `transfer_sequence_number` STRING COMMENT 'Sequential order of this transfer event within the containers complete chain of custody. Starts at 1 for generator handoff and increments with each subsequent transfer.',
    `transfer_timestamp` TIMESTAMP COMMENT 'Exact date and time when physical custody of the hazardous waste container was transferred from the relinquishing party to the receiving party. Critical for CERCLA liability determination.',
    `transferring_party_contact_name` STRING COMMENT 'Full name of the individual representative who physically relinquished custody on behalf of the transferring party.',
    `transferring_party_name` STRING COMMENT 'Legal business name of the organization or facility relinquishing custody of the hazardous waste container.',
    `transferring_party_signature` STRING COMMENT 'Digital signature or signature identifier of the transferring party representative acknowledging relinquishment of custody. May be electronic signature hash or physical signature reference.',
    `un_identification_number` STRING COMMENT 'Four-digit UN number assigned to the hazardous material for international transportation. Format: UN followed by 4 digits.. Valid values are `^UN[0-9]{4}$`',
    `waste_code` STRING COMMENT 'EPA hazardous waste code(s) for the material being transferred. Format: letter (D/F/K/P/U) followed by 3 digits. Multiple codes may be comma-separated.. Valid values are `^[DFKPU][0-9]{3}$`',
    `waste_description` STRING COMMENT 'Detailed description of the hazardous waste material being transferred, including physical state, chemical composition, and any special handling requirements.',
    `witness_signature` STRING COMMENT 'Digital signature or signature identifier of the witness, if present. Provides additional verification for critical transfers.',
    CONSTRAINT pk_chain_of_custody PRIMARY KEY(`chain_of_custody_id`)
) COMMENT 'Immutable chain-of-custody record documenting every transfer of possession for hazardous waste containers from generation through final disposal. Captures transfer event type (generator handoff, transporter receipt, TSDF acceptance, treatment completion, disposal confirmation), transferring party EPA ID, receiving party EPA ID, transfer timestamp, container IDs transferred, witness/signature information, and discrepancy notes. Supports RCRA cradle-to-grave accountability and CERCLA liability documentation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`tclp_test` (
    `tclp_test_id` BIGINT COMMENT 'Unique identifier for the TCLP laboratory test record. Primary key for the test entity.',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: TCLP test tracks generator EPA ID as a string. This should be normalized to FK to epa_id_registration. Adding FK normalizes this relationship. Remove generator_epa_id string as it becomes redundant.',
    `hazmat_container_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazmat_container. Business justification: TCLP tests are performed on samples taken from specific hazardous waste containers. One test is performed on one container sample. This links the test result to the container sampled, replacing the ST',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: TCLP test references manifest by manifest_number string. This should be normalized to FK to manifest. Adding FK provides proper relational link. Remove manifest_number string as it becomes redundant v',
    `original_test_tclp_test_id` BIGINT COMMENT 'Reference to the original TCLP test ID if this is a retest. Null if this is the initial test. Maintains audit trail for retested samples.',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: TCLP test has assigned_waste_codes (string, comma-separated) but no FK to waste_code reference table. Adding FK for primary assigned waste code provides standardized waste code lookup. Keep assigned_w',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: TCLP results are submitted in biennial reports, LDR notifications, and waste characterization reports. Links analytical data to regulatory submissions for compliance verification and audit support.',
    `waste_profile_id` BIGINT COMMENT 'Reference to the waste profile under which this sample was collected and tested. Waste profiles define the expected characteristics and handling requirements for specific waste streams.',
    `analyte_group` STRING COMMENT 'Category of contaminants analyzed in the TCLP test. Common groups include RCRA 8 metals, volatile organic compounds (VOCs), semi-volatile organic compounds (SVOCs), and pesticides.. Valid values are `metals|volatile organics|semi-volatile organics|pesticides|herbicides|full suite`',
    `arsenic_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of arsenic in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 5.0 mg/L per 40 CFR 261.24.',
    `assigned_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes assigned based on TCLP results. D-codes (D004-D043) indicate toxicity characteristic. Empty if waste passes all thresholds.',
    `barium_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of barium in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 100.0 mg/L per 40 CFR 261.24.',
    `benzene_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of benzene in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 0.5 mg/L per 40 CFR 261.24.',
    `cadmium_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of cadmium in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 1.0 mg/L per 40 CFR 261.24.',
    `certifying_chemist_license` STRING COMMENT 'Professional license or certification number of the chemist who certified the test results. Validates professional qualifications.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `certifying_chemist_name` STRING COMMENT 'Name of the certified chemist or laboratory director who reviewed and certified the analytical results. Responsible for data quality and regulatory compliance.',
    `chain_of_custody_number` STRING COMMENT 'Unique tracking number for the chain-of-custody documentation that accompanied the sample from collection through laboratory analysis. Ensures sample integrity and traceability.. Valid values are `^COC-[A-Z0-9]{8,15}$`',
    `chromium_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of total chromium in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 5.0 mg/L per 40 CFR 261.24.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TCLP test record was first created in the Enviance EHS system. Used for audit trail and data lineage tracking.',
    `detection_limit_mg_l` DECIMAL(18,2) COMMENT 'Lowest concentration of analyte that the analytical method can reliably detect. Used to interpret non-detect results and ensure regulatory thresholds can be measured.',
    `extraction_fluid` STRING COMMENT 'Type of extraction fluid used in the TCLP procedure. Fluid #1 (pH 4.93 ± 0.05) or Fluid #2 (pH 2.88 ± 0.05) based on waste alkalinity.. Valid values are `Fluid #1|Fluid #2`',
    `laboratory_certification_number` STRING COMMENT 'State or EPA certification number for the analytical laboratory. Validates that the laboratory is authorized to perform RCRA characterization testing.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `laboratory_name` STRING COMMENT 'Name of the certified analytical laboratory that performed the TCLP test. Must be EPA-certified or state-certified for hazardous waste characterization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this TCLP test record was last updated. Tracks changes to test status, results, or quality control flags.',
    `lead_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of lead in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 5.0 mg/L per 40 CFR 261.24.',
    `mercury_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of mercury in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 0.2 mg/L per 40 CFR 261.24.',
    `overall_pass_fail` STRING COMMENT 'Overall determination of whether the waste exhibits the toxicity characteristic. Pass indicates non-hazardous; fail indicates hazardous waste requiring D-code assignment.. Valid values are `pass|fail`',
    `qa_qc_flag` STRING COMMENT 'Indicates whether the test met all quality assurance and quality control criteria. Qualified results may have data quality limitations but are still reportable.. Valid values are `passed|failed|qualified`',
    `qa_qc_notes` STRING COMMENT 'Free-text notes documenting any quality control issues, deviations from standard method, matrix interferences, or data qualifiers applied to the results.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the test results require regulatory agency review and approval before waste can be accepted for disposal or treatment.',
    `report_date` DATE COMMENT 'Date when the final laboratory analytical report was issued. Used for regulatory reporting timelines and waste profile approval workflows.',
    `report_number` STRING COMMENT 'Unique report number assigned by the laboratory to the analytical report. Used for document tracking and audit trail.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `retest_flag` BOOLEAN COMMENT 'Indicates whether this test is a retest of a previous sample due to quality control failure, sample integrity issues, or regulatory requirement.',
    `sample_collection_date` DATE COMMENT 'Date when the waste sample was physically collected from the waste stream or container for laboratory testing. Critical for chain-of-custody and sample integrity validation.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the waste sample was collected, including time zone. Used for hold time calculations and chain-of-custody verification.',
    `sample_received_date` DATE COMMENT 'Date when the laboratory received the sample for analysis. Used to verify sample hold times and chain-of-custody transfer.',
    `selenium_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of selenium in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 1.0 mg/L per 40 CFR 261.24.',
    `silver_result_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of silver in the TCLP leachate expressed in milligrams per liter. Regulatory threshold is 5.0 mg/L per 40 CFR 261.24.',
    `test_completion_date` DATE COMMENT 'Date when all analytical testing and quality control procedures were completed and results finalized.',
    `test_method` STRING COMMENT 'EPA-approved analytical method used for the TCLP test. Standard method is SW-846 Method 1311 (Toxicity Characteristic Leaching Procedure).. Valid values are `SW-846 Method 1311|EPA Method 1311`',
    `test_start_date` DATE COMMENT 'Date when the TCLP extraction procedure was initiated in the laboratory. Used to verify compliance with sample hold time requirements.',
    `test_status` STRING COMMENT 'Current status of the TCLP test in the laboratory workflow. Tracks progression from sample receipt through final report issuance.. Valid values are `pending|in progress|completed|cancelled|on hold`',
    `waste_matrix_type` STRING COMMENT 'Physical form of the waste sample tested. Determines the specific TCLP extraction procedure to be followed.. Valid values are `solid|liquid|sludge|multi-phase`',
    CONSTRAINT pk_tclp_test PRIMARY KEY(`tclp_test_id`)
) COMMENT 'Toxicity Characteristic Leaching Procedure (TCLP) laboratory test record for waste characterization. Captures sample ID, sample collection date, laboratory name, test method (SW-846), analytes tested (metals, VOCs, SVOCs, pesticides), individual analyte results (mg/L), regulatory threshold values, pass/fail determination per 40 CFR Part 261, QA/QC flags, chain-of-custody for sample, and certifying chemist. Drives waste code assignment and profile approval in Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`treatment_record` (
    `treatment_record_id` BIGINT COMMENT 'Unique identifier for the hazardous waste treatment record. Primary key for tracking individual treatment operations performed at Treatment, Storage, and Disposal Facilities (TSDF) or permitted on-site treatment units under Resource Conservation and Recovery Act (RCRA) Subtitle C regulations.',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Treatment records document services performed under disposal purchase orders. Financial operations require linking treatment documentation to procurement commitments for invoice matching, cost verific',
    `disposal_record_id` BIGINT COMMENT 'Foreign key linking to hazmat.disposal_record. Business justification: Treatment record should link to disposal_record for final disposition tracking. Treatment often precedes disposal in the waste lifecycle. This FK provides traceability from treatment to final disposal',
    `epa_id_registration_id` BIGINT COMMENT 'The EPA identification number of the original hazardous waste generator whose waste is being treated. Maintains cradle-to-grave tracking chain from generation through treatment to final disposal.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_emission. Business justification: Treatment processes (incineration, thermal treatment) generate direct combustion emissions. EPA Subpart CC requires emission tracking per treatment batch for GHGRP reporting. Each treatment event crea',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Treatment process incidents (equipment failure, exposure events, emission exceedances) must link to treatment records for investigation, process safety management, and regulatory reporting. Critical f',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Treatment services (incineration, neutralization, stabilization) are billable. Treatment facilities must invoice for processing hazardous waste based on treatment method, quantity, and complexity. Dir',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Treatment record references manifest by manifest_document_number string. This should be normalized to FK to manifest. Adding FK provides proper relational link. Remove manifest_document_number string ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RCRA treatment operations require certified operator tracking per 40 CFR 264/265. Links treatment batches to employee certification records (HAZWOPER, equipment-specific training), enables labor cost ',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Treatment record has input_waste_codes (string, comma-separated) but no FK to waste_code reference table. Adding FK for primary input waste code provides standardized waste code lookup. Keep input_was',
    `tclp_test_id` BIGINT COMMENT 'Foreign key linking to hazmat.tclp_test. Business justification: Treatment record has tclp_test_performed (boolean) and tclp_test_result (string) but no FK to tclp_test. Adding FK provides traceability to actual TCLP test results. Keep tclp_test_performed and tclp_',
    `transporter_epa_epa_id_registration_id` BIGINT COMMENT 'The EPA identification number of the transporter who delivered the waste to the treatment facility. Part of the manifest chain-of-custody documentation.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `treatment_facility_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Treatment record tracks treatment facility EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (treatment_facility_epa_id_registration_id) distinguishes this from ge',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Treatment operations occur at specific facilities. Links treatment records to facility asset master for capacity utilization analysis, maintenance scheduling (treatment equipment downtime), facility p',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Treatment operations must comply with permit conditions (40 CFR 264 Subpart X). Permit specifies treatment technologies, waste codes, and operating parameters. Required for demonstrating permit compli',
    `storage_unit_id` BIGINT COMMENT 'Internal identifier for the specific treatment unit or equipment used for the operation (e.g., incinerator, neutralization tank, stabilization mixer, fuel blending unit, solvent recovery still). Each unit has unique operating parameters and permit conditions.. Valid values are `^TU-[A-Z0-9]{6,12}$`',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Treatment operations are performed on waste streams characterized by waste profiles. One treatment batch processes waste matching one profile. This links the treatment record to the waste characteriza',
    `bill_of_lading_number` STRING COMMENT 'The Department of Transportation (DOT) Bill of Lading number associated with the shipment of hazardous waste to the treatment facility. Links treatment record to transportation compliance documentation.. Valid values are `^BOL-[A-Z0-9]{10,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this treatment record was first created in the system. Used for audit trail and data lineage tracking.',
    `disposal_method_code` STRING COMMENT 'EPA code indicating the intended final disposal or management method for the treated residual. Values: LANDF=Landfill, INJCT=Underground Injection, SURFI=Surface Impoundment, WSTPL=Waste Pile, RCYCL=Recycling, ENRGY=Energy Recovery, OTHRD=Other Disposal. [ENUM-REF-CANDIDATE: LANDF|INJCT|SURFI|WSTPL|RCYCL|ENRGY|OTHRD — 7 candidates stripped; promote to reference product]',
    `emergency_response_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this treatment operation was performed as part of an emergency response action under CERCLA (Superfund) or RCRA Corrective Action. True=Emergency response treatment, False=Routine permitted treatment.',
    `emission_control_system_code` STRING COMMENT 'Identifier for the air pollution control equipment used during thermal treatment operations (e.g., scrubbers, baghouses, electrostatic precipitators). Required for Clean Air Act (CAA) compliance and RCRA air emission standards.. Valid values are `^ECS-[A-Z0-9]{6,12}$`',
    `input_quantity_unit` STRING COMMENT 'Unit of measure for the input waste quantity. Values: KG=Kilograms, LB=Pounds, GAL=Gallons, L=Liters, TON=US Tons, MT=Metric Tonnes. Must align with manifest and facility reporting units.. Valid values are `KG|LB|GAL|L|TON|MT`',
    `input_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes (D, F, K, P, U series) assigned to the input waste stream. Determines applicable treatment standards and Land Disposal Restrictions (LDR).',
    `input_waste_quantity` DECIMAL(18,2) COMMENT 'The quantity of hazardous waste fed into the treatment unit for this operation, measured in the unit specified by input_quantity_unit. Critical for mass balance calculations and regulatory reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this treatment record was last updated. Supports change tracking and audit compliance.',
    `ldr_compliance_status` STRING COMMENT 'Indicates whether the treated waste meets EPA Land Disposal Restrictions treatment standards and is eligible for land disposal. Values: COMPLIANT=Meets LDR standards, NON_COMPLIANT=Requires additional treatment, EXEMPT=Waste category exempt from LDR, PENDING_ANALYSIS=Awaiting analytical results.. Valid values are `COMPLIANT|NON_COMPLIANT|EXEMPT|PENDING_ANALYSIS`',
    `notes` STRING COMMENT 'Free-text field for recording additional observations, deviations from standard procedures, equipment malfunctions, or other relevant information about the treatment operation. Supports operational troubleshooting and continuous improvement.',
    `operator_certification_number` STRING COMMENT 'Certification number of the trained and certified operator who performed or supervised the treatment operation. RCRA requires personnel training and certification for hazardous waste treatment operations.. Valid values are `^OC-[A-Z0-9]{8,15}$`',
    `output_quantity_unit` STRING COMMENT 'Unit of measure for the output residual quantity. Values: KG=Kilograms, LB=Pounds, GAL=Gallons, L=Liters, TON=US Tons, MT=Metric Tonnes.. Valid values are `KG|LB|GAL|L|TON|MT`',
    `output_residual_quantity` DECIMAL(18,2) COMMENT 'The quantity of treated residual material or byproduct remaining after treatment, measured in the unit specified by output_quantity_unit. Used for mass balance verification and subsequent disposal or recycling decisions.',
    `output_waste_characterization` STRING COMMENT 'Description of the physical and chemical characteristics of the treated residual, including any remaining hazardous waste codes. Determines whether the residual meets Land Disposal Restrictions (LDR) treatment standards or requires further treatment.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Operating pressure in pounds per square inch (PSI) during treatment. Relevant for pressurized treatment technologies such as wet air oxidation or supercritical water oxidation.',
    `quality_assurance_review_status` STRING COMMENT 'Status of the quality assurance review for this treatment record. Values: APPROVED=Record verified and approved by QA, REJECTED=Record failed QA review, PENDING_REVIEW=Awaiting QA review, NOT_REQUIRED=QA review not required for this operation.. Valid values are `APPROVED|REJECTED|PENDING_REVIEW|NOT_REQUIRED`',
    `regulatory_unit_code` STRING COMMENT 'EPA-assigned code identifying the specific treatment unit under the facilitys RCRA Part B permit. Each unit has unique permit conditions, operating parameters, and waste acceptance criteria.. Valid values are `^[A-Z]{2}[0-9]{3}[A-Z]$`',
    `residence_time_minutes` DECIMAL(18,2) COMMENT 'The duration in minutes that the waste remained in the treatment unit. Critical for ensuring adequate contact time for chemical reactions, thermal destruction, or physical separation processes per permit specifications.',
    `source_system` STRING COMMENT 'The operational system from which this treatment record originated. Values: SAP_EHS=SAP Environment Health and Safety module, ENVIANCE=Enviance EHS platform, MANUAL_ENTRY=Manually entered by operator, SCADA=Supervisory Control and Data Acquisition system, LIMS=Laboratory Information Management System.. Valid values are `SAP_EHS|ENVIANCE|MANUAL_ENTRY|SCADA|LIMS`',
    `stack_emission_test_result` STRING COMMENT 'Result of stack emission testing performed during or after the treatment operation to verify compliance with air quality standards. Values: PASS=Emissions within permitted limits, FAIL=Emissions exceed limits, NOT_TESTED=No test performed for this operation.. Valid values are `PASS|FAIL|NOT_TESTED`',
    `tclp_test_performed` BOOLEAN COMMENT 'Boolean flag indicating whether a Toxicity Characteristic Leaching Procedure (TCLP) test was performed on the treated residual to verify that hazardous characteristics have been successfully treated. True=TCLP performed, False=TCLP not performed.',
    `tclp_test_result` STRING COMMENT 'Result of the TCLP test if performed. Values: PASS=Treated waste no longer exhibits toxicity characteristic, FAIL=Waste still exhibits toxicity characteristic, NOT_APPLICABLE=TCLP not required for this waste, PENDING=Test results not yet available.. Valid values are `PASS|FAIL|NOT_APPLICABLE|PENDING`',
    `treatment_batch_number` STRING COMMENT 'Internal batch identifier for grouping multiple treatment records that were processed together or as part of a continuous treatment campaign. Enables batch-level quality control and traceability.. Valid values are `^TB-[0-9]{8}-[A-Z0-9]{4}$`',
    `treatment_cost_usd` DECIMAL(18,2) COMMENT 'The total cost in US dollars incurred for this treatment operation, including labor, energy, consumables, and equipment depreciation. Used for cost accounting and profitability analysis.',
    `treatment_date` DATE COMMENT 'The calendar date on which the hazardous waste treatment operation was performed. Critical for regulatory reporting timelines and Land Disposal Restrictions (LDR) compliance tracking.',
    `treatment_efficiency_percent` DECIMAL(18,2) COMMENT 'The calculated treatment efficiency expressed as a percentage, representing the degree of contaminant removal or destruction achieved. For incinerators, this is the Destruction and Removal Efficiency (DRE) which must meet or exceed 99.99% for most hazardous wastes.',
    `treatment_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the treatment process was completed. Used to calculate total treatment duration and verify process completion per permit requirements.',
    `treatment_ph_level` DECIMAL(18,2) COMMENT 'The pH level maintained during chemical treatment processes such as neutralization or chemical oxidation. Must be within permitted operating ranges to ensure effective treatment and regulatory compliance.',
    `treatment_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the treatment process began. Used to calculate residence time and verify compliance with treatment technology specifications.',
    `treatment_status` STRING COMMENT 'Current status of the treatment operation. Values: COMPLETED=Treatment successfully finished, IN_PROGRESS=Treatment underway, FAILED=Treatment did not meet specifications, ABORTED=Treatment stopped before completion, PENDING_VERIFICATION=Awaiting analytical confirmation of treatment effectiveness.. Valid values are `COMPLETED|IN_PROGRESS|FAILED|ABORTED|PENDING_VERIFICATION`',
    `treatment_technology_code` STRING COMMENT 'EPA-defined code representing the treatment technology applied. Values: INCIN=Incineration, NEUTR=Neutralization, STBLZ=Stabilization, FBLEN=Fuel Blending, SOLVR=Solvent Recovery, CARBN=Carbon Adsorption, WETOX=Wet Air Oxidation, CHOXD=Chemical Oxidation, CMBST=Combustion, DEACT=Deactivation, MACRO=Macroencapsulation, RORGS=Recovery of Organics, RMETL=Recovery of Metals, WTRRX=Water Reaction. [ENUM-REF-CANDIDATE: INCIN|NEUTR|STBLZ|FBLEN|SOLVR|CARBN|WETOX|CHOXD|CMBST|DEACT|MACRO|RORGS|RMETL|WTRRX — 14 candidates stripped; promote to reference product]',
    `treatment_temperature_celsius` DECIMAL(18,2) COMMENT 'Operating temperature of the treatment process in degrees Celsius. Critical parameter for thermal treatment technologies (incineration, combustion) to ensure destruction and removal efficiency (DRE) requirements are met.',
    CONSTRAINT pk_treatment_record PRIMARY KEY(`treatment_record_id`)
) COMMENT 'Record of hazardous waste treatment operations performed at a TSDF or permitted on-site treatment unit. Captures treatment date, treatment unit ID, treatment technology code (incineration, neutralization, stabilization, fuel blending, solvent recovery), input waste stream and quantity, treatment parameters (temperature, pH, residence time), output residual characterization, emission control data, operator certification, and regulatory unit code per RCRA land disposal restrictions (LDR). Sourced from SAP EHS treatment logs.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`disposal_record` (
    `disposal_record_id` BIGINT COMMENT 'Unique identifier for the hazardous waste disposal record. Primary key for tracking final disposal confirmation under RCRA Subtitle C cradle-to-grave requirements.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Disposal certifications require authorized employee signature per RCRA land disposal restrictions (40 CFR 268). Tracking certifying employee enables signature authority verification, audit trails, and',
    `cell_id` BIGINT COMMENT 'Foreign key linking to landfill.cell. Business justification: Hazardous waste disposal records should track which specific landfill cell received the waste for long-term liability tracking and closure planning. Currently disposal_unit_id references hazmat.storag',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Disposal records confirm completion of services ordered via disposal POs. Three-way matching (PO, disposal certificate, invoice) requires linking disposal documentation to procurement commitments for ',
    `epa_id_registration_id` BIGINT COMMENT 'EPA-issued 12-character identification number for the TSDF facility performing the disposal. Required for all permitted hazardous waste treatment, storage, and disposal facilities.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `generator_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Disposal record tracks generator EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (generator_epa_id_registration_id) distinguishes this from TSDF and transporter.',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_emission. Business justification: Landfill disposal generates methane emissions tracked for EPA GHGRP Subpart HH. Each disposal event contributes to facility emission inventory. Required for Scope 1 emissions quantification and carbon',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Disposal operation incidents (container rupture, exposure, equipment failure) require linkage to disposal records for investigation, liability documentation, and regulatory reporting. Links waste char',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Disposal services at TSDF facilities are billable events. Each disposal (by weight, volume, waste code) generates specific charges. Links operational disposal completion to financial billing for reven',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Disposal record references manifest by manifest_number string. This should be normalized to FK to manifest. Adding FK provides proper relational link. Remove manifest_number string as it becomes redun',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Disposal record has waste_code_primary (string) but no FK to waste_code reference table. Adding FK provides standardized waste code lookup. Keep waste_code_primary string as it may differ from manifes',
    `storage_unit_id` BIGINT COMMENT 'Specific disposal unit identifier within the TSDF facility where waste was placed (e.g., landfill cell number, incinerator unit ID, deep well injection well number). Provides precise location tracking.',
    `transporter_epa_epa_id_registration_id` BIGINT COMMENT 'EPA ID number of the transporter who delivered the waste to the TSDF. Documents the transportation link in the chain of custody.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `tsdf_facility_id` BIGINT COMMENT 'Identifier of the permitted TSDF facility where the hazardous waste was ultimately disposed. References the facility authorized under RCRA Subtitle C for final disposal operations.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Disposal operations governed by TSDF permit conditions (40 CFR 264 Subpart N). Permit defines disposal unit capacity, waste codes, and LDR compliance requirements. Core regulatory relationship for dis',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Disposal operations are performed on waste streams characterized by waste profiles. One disposal event handles waste matching one profile. This links the disposal record to the waste characterization ',
    `bill_of_lading_number` STRING COMMENT 'Transportation document number accompanying the hazardous waste shipment. Links disposal record to DOT shipping documentation for compliance verification.',
    `certificate_of_disposal_number` STRING COMMENT 'Unique certificate number issued by the TSDF confirming final disposal of the hazardous waste. Provides legal documentation that waste has been properly disposed per RCRA requirements.',
    `container_count` STRING COMMENT 'Number of containers (drums, totes, boxes) disposed as part of this disposal record. Tracks physical container units received and processed by the TSDF.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies found between manifest documentation and actual waste received. Documents variances for regulatory reporting and resolution.',
    `discrepancy_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether any discrepancies were identified between the manifest and actual waste received (quantity, type, condition). Triggers discrepancy reporting requirements.',
    `disposal_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the disposal process was fully completed and the record was finalized. Marks the official closure of the cradle-to-grave tracking cycle.',
    `disposal_cost_amount` DECIMAL(18,2) COMMENT 'Total cost charged by the TSDF for disposal of this waste shipment. Includes tipping fees, treatment costs, and any surcharges. Used for billing and cost tracking.',
    `disposal_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the disposal cost amount (e.g., USD, CAD, EUR). Supports multi-currency operations for international waste disposal.. Valid values are `^[A-Z]{3}$`',
    `disposal_date` DATE COMMENT 'Date when the hazardous waste was physically disposed at the TSDF facility. Represents the final step in the cradle-to-grave tracking process and closes the manifest lifecycle.',
    `disposal_method_code` STRING COMMENT 'EPA-standardized code identifying the disposal method used (e.g., D80 for landfill, D81 for underground injection, D82 for incineration ash disposal). Defines the ultimate fate of the hazardous waste.. Valid values are `^[A-Z][0-9]{2}$`',
    `disposal_method_description` STRING COMMENT 'Detailed description of the disposal method employed at the TSDF, including specific technology, process, or unit operation used for final waste disposition.',
    `disposal_status` STRING COMMENT 'Current status of the disposal record in the TSDF workflow. Tracks progression from receipt through disposal to final certification and manifest closure.. Valid values are `pending|completed|certified|rejected|under_review`',
    `emergency_response_required` BOOLEAN COMMENT 'Boolean flag indicating whether emergency response procedures were activated during receipt or disposal of this waste. Triggers incident reporting and documentation requirements.',
    `ldr_certification_date` DATE COMMENT 'Date when the TSDF certified LDR compliance for the disposed waste. Documents when treatment standards were verified prior to land disposal.',
    `ldr_compliance_certified` BOOLEAN COMMENT 'Boolean flag indicating whether the TSDF has certified that the waste meets Land Disposal Restriction treatment standards prior to disposal. Required for restricted hazardous wastes under RCRA.',
    `ldr_treatment_method` STRING COMMENT 'Description of the treatment method applied to meet LDR standards before disposal (e.g., stabilization, neutralization, thermal treatment). Required for restricted waste codes.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or observations related to the disposal event. Captures contextual information not covered by structured fields.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this disposal record was first created in the system. Audit trail for record lifecycle tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this disposal record was last modified. Tracks changes and updates throughout the disposal workflow and certification process.',
    `regulatory_report_date` DATE COMMENT 'Date when regulatory reports related to this disposal were submitted to EPA or state environmental agencies. Documents compliance with reporting deadlines.',
    `regulatory_report_submitted` BOOLEAN COMMENT 'Boolean flag indicating whether required regulatory reports (e.g., biennial report, exception report) have been submitted for this disposal event. Tracks compliance reporting obligations.',
    `rejection_reason` STRING COMMENT 'Reason for rejection of the waste shipment by the TSDF, if applicable. Documents why waste was not accepted for disposal (e.g., failed waste profile, prohibited material, damaged containers).',
    `source_system` STRING COMMENT 'Name of the source system that created or manages this disposal record (e.g., Enviance EHS, SAP EHS, TSDF proprietary system). Supports data lineage and integration tracking.',
    `special_handling_instructions` STRING COMMENT 'Any special handling, processing, or disposal instructions required for this waste stream. Documents unique requirements for safe and compliant disposal operations.',
    `tsdf_signature_name` STRING COMMENT 'Name of the authorized TSDF representative who signed and certified the disposal record. Provides accountability for disposal confirmation.',
    `tsdf_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the TSDF representative signed the disposal record, confirming receipt and disposal of the hazardous waste shipment.',
    `tsdf_signature_title` STRING COMMENT 'Job title of the TSDF representative who signed the disposal record (e.g., Facility Manager, Environmental Compliance Officer). Establishes authority of signatory.',
    `waste_code_primary` STRING COMMENT 'Primary EPA hazardous waste code (D, F, K, P, or U list) identifying the principal hazardous characteristic or listing of the disposed waste. Determines regulatory requirements and disposal restrictions.. Valid values are `^[DFKPU][0-9]{3}$`',
    `waste_codes_additional` STRING COMMENT 'Comma-separated list of additional EPA hazardous waste codes applicable to the disposed waste. Captures multiple hazardous characteristics or listings for mixed waste streams.',
    `waste_quantity_lbs` DECIMAL(18,2) COMMENT 'Total quantity of hazardous waste disposed, measured in pounds. Represents the actual weight accepted and disposed by the TSDF facility.',
    `waste_quantity_tons` DECIMAL(18,2) COMMENT 'Total quantity of hazardous waste disposed, measured in tons. Calculated or measured weight for regulatory reporting and capacity tracking purposes.',
    `waste_volume_gallons` DECIMAL(18,2) COMMENT 'Volume of liquid or semi-liquid hazardous waste disposed, measured in gallons. Used for liquid waste streams and deep well injection disposal methods.',
    CONSTRAINT pk_disposal_record PRIMARY KEY(`disposal_record_id`)
) COMMENT 'Final disposal confirmation record documenting the ultimate fate of hazardous waste at a permitted TSDF. Captures disposal date, TSDF facility ID, disposal method (landfill cell, deep well injection, incineration ash disposal), disposal unit ID, waste quantity disposed (lbs/tons), manifest number, certificate of disposal number, land disposal restriction (LDR) compliance certification, and TSDF signature. Closes the cradle-to-grave tracking loop required by RCRA Subtitle C.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`service_order` (
    `service_order_id` BIGINT COMMENT 'Unique identifier for the hazardous waste service order. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Service orders originate from specific service areas. Enables territory-based reporting, franchise compliance tracking, and service area performance analysis. Real business process: franchise agreemen',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: Hazmat service orders require driver assignment for CDL/HAZMAT endorsement verification per DOT 49 CFR 172.704. Critical for regulatory compliance, crew scheduling, and ensuring qualified personnel ha',
    `vehicle_id` BIGINT COMMENT 'Reference to the specialized hazardous waste transport vehicle assigned to the service order.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Hazmat service orders are sold under master service agreements. Order fulfillment validates contract status, applies contracted pricing, enforces volume commitments, verifies permitted waste streams. ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Hazmat service orders assign field crew leadership for on-site waste collection. Tracking crew lead enables labor cost allocation, HAZWOPER certification verification, safety accountability, and perfo',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account requesting the hazardous waste service.',
    `epa_id_registration_id` BIGINT COMMENT 'EPA identification number of the destination treatment, storage, or disposal facility where the hazardous waste will be delivered.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `fleet_fuel_consumption_id` BIGINT COMMENT 'Foreign key linking to sustainability.fleet_fuel_consumption. Business justification: Hazmat service orders require specialized vehicles with tracked fuel consumption. Linking orders to fuel records enables accurate Scope 1 emissions allocation per service type and supports DOT complia',
    `generator_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Hazmat service order tracks generator EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (generator_epa_id_registration_id) distinguishes this from TSDF. Remove gen',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Service orders for hazmat collection require verification that generator operates under valid permit. Pre-service compliance check ensures legal authority to generate and ship waste, protecting servic',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Hazmat service orders generate invoices as part of the revenue cycle. Service delivery (pickup, transport, disposal) must be billed to customers. This links operational service execution to financial ',
    `jha_id` BIGINT COMMENT 'Foreign key linking to safety.jha. Business justification: Hazmat service orders require pre-approved job hazard analyses before crew dispatch. JHA documents task-specific hazards, controls, and PPE requirements for emergency response, drum pickup, or waste h',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Hazmat service order has manifest_number (string) but no FK to manifest. Adding FK provides manifest tracking and traceability. Remove manifest_number string as it can be retrieved via JOIN to manifes',
    `meeting_id` BIGINT COMMENT 'Foreign key linking to safety.safety_meeting. Business justification: Pre-job safety meetings (tailgate meetings) for hazmat service orders document crew briefings on job-specific hazards, controls, and emergency procedures. Links safety communication to specific work o',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Every hazmat service order represents a customer purchasing a specific cataloged offering. Fundamental to order management, pricing, billing, and service delivery tracking. Real business process: orde',
    `org_unit_id` BIGINT COMMENT 'Reference to the hazardous waste handling crew assigned to perform the service.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Hazmat service orders trigger procurement purchase orders for disposal services. Operations require linking customer service requests to procurement commitments for cost tracking, invoice reconciliati',
    `service_address_id` BIGINT COMMENT 'Reference to the physical location where hazardous waste collection or service will be performed.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Hazmat service orders are fulfilled at facilities (customer sites or company facilities). Links service orders to facility asset records for facility utilization tracking, service history analysis, fa',
    `transporter_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.transporter_registration. Business justification: Hazmat service order should link to transporter_registration for transporter details and authorization. This provides transporter EPA ID, DOT authority, insurance details. No columns to remove as serv',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Hazmat service order has waste_description and epa_waste_codes (strings) but no FK to waste_profile. Adding FK provides standardized waste characterization. Keep waste_description and epa_waste_codes ',
    `actual_amount` DECIMAL(18,2) COMMENT 'Final invoiced amount for the hazardous waste service based on actual quantities and services performed.',
    `actual_quantity_uom` STRING COMMENT 'Unit of measure for the actual waste quantity collected: drums, gallons, pounds, tons, cubic yards, liters, or kilograms. [ENUM-REF-CANDIDATE: drums|gallons|pounds|tons|cubic_yards|liters|kilograms — 7 candidates stripped; promote to reference product]',
    `actual_waste_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of hazardous waste collected or treated, as measured by the field crew upon service completion.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the service order was cancelled, including customer request, regulatory hold, or operational constraints.',
    `completed_date` DATE COMMENT 'Date when the hazardous waste service was actually completed in the field.',
    `container_count` STRING COMMENT 'Number of containers to be collected or serviced as part of this order.',
    `container_type` STRING COMMENT 'Type of container used for hazardous waste storage and transport (e.g., 55-gallon drum, 5-gallon pail, lab pack, bulk tank, tote).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hazardous waste service order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the service order pricing (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customer-provided purchase order number for billing and accounts payable reconciliation.',
    `dot_hazard_class` STRING COMMENT 'DOT hazard classification for transportation of the hazardous waste (e.g., Class 3 Flammable Liquid, Class 6.1 Toxic, Class 8 Corrosive).',
    `emergency_response_flag` BOOLEAN COMMENT 'Indicates whether this service order is for an emergency spill response or urgent hazardous waste situation requiring immediate action.',
    `epa_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes (D, F, K, P, U series) applicable to the waste material being serviced.',
    `estimated_quantity_uom` STRING COMMENT 'Unit of measure for the estimated waste quantity: drums, gallons, pounds, tons, cubic yards, liters, or kilograms. [ENUM-REF-CANDIDATE: drums|gallons|pounds|tons|cubic_yards|liters|kilograms — 7 candidates stripped; promote to reference product]',
    `estimated_waste_quantity` DECIMAL(18,2) COMMENT 'Estimated quantity of hazardous waste to be collected or treated, as provided by the customer during order placement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the hazardous waste service order record was last updated in the system.',
    `order_date` DATE COMMENT 'Date when the hazardous waste service order was placed by the customer.',
    `order_number` STRING COMMENT 'Externally-visible business identifier for the hazardous waste service order, used in customer communications and manifests.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the hazardous waste service order. [ENUM-REF-CANDIDATE: quoted|confirmed|scheduled|in_progress|completed|invoiced|cancelled — 7 candidates stripped; promote to reference product]',
    `packing_group` STRING COMMENT 'DOT packing group classification indicating the degree of danger: I (high danger), II (medium danger), III (low danger).. Valid values are `I|II|III`',
    `ppe_requirements` STRING COMMENT 'Required personal protective equipment for field crew performing the hazardous waste service (e.g., Level A, B, C, or D protection; respirator type; chemical-resistant suit).',
    `pricing_basis` STRING COMMENT 'Basis for pricing the hazardous waste service: per drum, per pound, per gallon, per trip, per hour, or flat rate.. Valid values are `per_drum|per_pound|per_gallon|per_trip|per_hour|flat_rate`',
    `proper_shipping_name` STRING COMMENT 'DOT-compliant proper shipping name for the hazardous waste material as it must appear on the Bill of Lading (BOL) and manifest.',
    `quoted_amount` DECIMAL(18,2) COMMENT 'Initial quoted price for the hazardous waste service provided to the customer during order placement.',
    `requested_service_date` DATE COMMENT 'Date requested by the customer for the hazardous waste service to be performed.',
    `safety_briefing_required` BOOLEAN COMMENT 'Indicates whether a site-specific safety briefing is required before performing the hazardous waste service.',
    `scheduled_service_date` DATE COMMENT 'Confirmed date when the hazardous waste service is scheduled to be performed by operations.',
    `service_notes` STRING COMMENT 'Additional notes, instructions, or observations related to the hazardous waste service order, including site access instructions, customer requests, or field crew observations.',
    `service_type` STRING COMMENT 'Type of hazardous waste service being requested: drum pickup, lab pack consolidation, bulk liquid removal, emergency spill response, container exchange, waste characterization profiling, or on-site treatment. [ENUM-REF-CANDIDATE: drum_pickup|lab_pack|bulk_liquid|emergency_response|container_exchange|waste_profiling|on_site_treatment — 7 candidates stripped; promote to reference product]',
    `special_handling_requirements` STRING COMMENT 'Any special handling, packaging, or safety requirements for the hazardous waste service (e.g., temperature control, inert atmosphere, shock-sensitive, reactive precautions).',
    `un_number` STRING COMMENT 'Four-digit UN identification number for the hazardous material being transported, as required by DOT regulations.. Valid values are `^UN[0-9]{4}$`',
    `waste_description` STRING COMMENT 'Detailed description of the hazardous waste material to be collected or treated, including physical state, chemical composition, and source process.',
    CONSTRAINT pk_service_order PRIMARY KEY(`service_order_id`)
) COMMENT 'Service order for hazardous waste collection, packaging, transportation, or treatment services requested by a customer. Captures order date, customer account reference, service type (drum pickup, lab pack, bulk liquid, emergency response), requested service date, site address, estimated waste quantity and type, assigned crew and vehicle, special handling requirements, safety briefing requirements, pricing basis (per drum, per lb, per trip), and order status lifecycle (quoted, confirmed, scheduled, completed, invoiced). Integrates with Salesforce CRM and Oracle Revenue Management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` (
    `epa_id_registration_id` BIGINT COMMENT 'Unique identifier for the EPA identification number registration record.',
    `authorized_state_program` BOOLEAN COMMENT 'Indicates whether the state has an EPA-authorized RCRA program and administers the program in lieu of the federal EPA.',
    `epa_id_number` STRING COMMENT 'The 12-character EPA identification number assigned to the regulated site (format: 2-letter state code + 9 digits). This is the regulatory identity anchor for all RCRA (Resource Conservation and Recovery Act) compliance activities.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `facility_contact_email` STRING COMMENT 'Email address for the facility contact person for regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `facility_contact_name` STRING COMMENT 'Name of the primary contact person for regulatory correspondence and compliance matters at the registered facility.',
    `facility_contact_phone` STRING COMMENT 'Primary phone number for the facility contact person.. Valid values are `^+?[0-9]{10,15}$`',
    `generator_classification` STRING COMMENT 'Generator size classification: LQG (Large Quantity Generator, >1000 kg/month), SQG (Small Quantity Generator, 100-1000 kg/month), VSQG (Very Small Quantity Generator, <100 kg/month), CESQG (Conditionally Exempt Small Quantity Generator, legacy term), or not_applicable for non-generators.. Valid values are `lqg|sqg|vsqg|cesqg|not_applicable`',
    `handler_status` STRING COMMENT 'Current operational status of the EPA ID registration: active (currently operating), inactive (not currently handling hazardous waste), pending (application submitted), withdrawn (voluntarily terminated), or suspended (regulatory action).. Valid values are `active|inactive|pending|withdrawn|suspended`',
    `handler_type` STRING COMMENT 'Primary regulated activity type for this EPA ID: generator (produces hazardous waste), transporter (hauls hazardous waste), TSDF (Treatment Storage and Disposal Facility), or mixed (multiple activities).. Valid values are `generator|transporter|tsdf|mixed`',
    `is_generator` BOOLEAN COMMENT 'Indicates whether this EPA ID is registered as a hazardous waste generator.',
    `is_transporter` BOOLEAN COMMENT 'Indicates whether this EPA ID is registered as a hazardous waste transporter.',
    `is_tsdf` BOOLEAN COMMENT 'Indicates whether this EPA ID is registered as a Treatment, Storage, and Disposal Facility for hazardous waste.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the regulated site in decimal degrees.',
    `location_verification_method` STRING COMMENT 'Method used to verify the geographic coordinates of the site: GPS (field measurement), address_geocoding (automated), survey (professional land survey), or map_interpolation (manual map reading).. Valid values are `gps|address_geocoding|survey|map_interpolation`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the regulated site in decimal degrees.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code representing the primary business activity of the facility.. Valid values are `^[0-9]{6}$`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this EPA ID registration, including special conditions, regulatory variances, or operational context.',
    `notification_effective_date` DATE COMMENT 'Date when the EPA ID registration became effective and the site was authorized to conduct regulated activities.',
    `notification_submission_date` DATE COMMENT 'Date when the RCRA notification form (EPA Form 8700-12) was submitted to the EPA or authorized state agency.',
    `notification_type` STRING COMMENT 'Type of RCRA notification form submission: initial (first-time registration), subsequent (periodic update), amendment (correction to existing registration), or withdrawal (deregistration).. Valid values are `initial|subsequent|amendment|withdrawal`',
    `owner_operator_name` STRING COMMENT 'Legal name of the entity that owns or operates the regulated facility.',
    `owner_operator_type` STRING COMMENT 'Type of entity that owns or operates the facility: private (commercial), public (publicly traded), federal (U.S. government), state (state government), or municipal (local government).. Valid values are `private|public|federal|state|municipal`',
    `rcrainfo_last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful data synchronization with the EPA RCRAInfo system.',
    `rcrainfo_sync_status` STRING COMMENT 'Status of data synchronization with the EPA RCRAInfo national database: synced (up to date), pending (sync in progress), failed (sync error), or not_synced (not yet synchronized).. Valid values are `synced|pending|failed|not_synced`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EPA ID registration record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this EPA ID registration record was last updated in the system.',
    `registration_expiration_date` DATE COMMENT 'Date when the EPA ID registration expires and must be renewed (if applicable based on state requirements).',
    `sic_code` STRING COMMENT 'Four-digit SIC code representing the primary business activity of the facility (legacy classification system).. Valid values are `^[0-9]{4}$`',
    `site_address_line1` STRING COMMENT 'Primary street address of the regulated site.',
    `site_address_line2` STRING COMMENT 'Secondary address information (suite, building, floor) for the regulated site.',
    `site_city` STRING COMMENT 'City where the regulated site is located.',
    `site_country_code` STRING COMMENT 'Three-letter ISO country code for the regulated site location.. Valid values are `^[A-Z]{3}$`',
    `site_county` STRING COMMENT 'County where the regulated site is located.',
    `site_name` STRING COMMENT 'The legal or trade name of the regulated facility or site registered with the EPA.',
    `site_postal_code` STRING COMMENT 'ZIP code or ZIP+4 code for the regulated site address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `site_state_code` STRING COMMENT 'Two-letter state code where the regulated site is located.. Valid values are `^[A-Z]{2}$`',
    `source_system` STRING COMMENT 'System of record where this EPA ID registration was originally captured: Enviance EHS, SAP EHS module, EPA RCRAInfo, or manual entry.. Valid values are `enviance_ehs|sap_ehs|rcrainfo|manual_entry`',
    `state_agency_notification_date` DATE COMMENT 'Date when the state environmental agency was notified of this EPA ID registration.',
    `state_agency_notified` BOOLEAN COMMENT 'Indicates whether the state environmental quality department or local enforcement agency has been notified of this EPA ID registration.',
    `state_id_number` STRING COMMENT 'State-issued identification number for hazardous waste handling (if different from EPA ID and required by state regulations).',
    CONSTRAINT pk_epa_id_registration PRIMARY KEY(`epa_id_registration_id`)
) COMMENT 'EPA Identification Number registration record for each regulated site (generators, transporters, TSDFs). Captures EPA ID number, site name, site address, regulated activity types (generator, transporter, TSDF), RCRA notification form submission date, notification type (initial, subsequent, withdrawal), handler status, large/small/very small quantity generator classification, and state agency notification status. Serves as the regulatory identity anchor for all RCRA compliance activities. Sourced from EPA RCRAInfo and Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` (
    `rcra_biennial_report_id` BIGINT COMMENT 'Unique identifier for the RCRA Biennial Report submission record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RCRA biennial reports require certification by authorized generator representative per 40 CFR 262.41. Tracking certifying employee enables signature authority verification, links to job position autho',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: RCRA biennial report is filed by an EPA-registered facility. The epa_id_number string duplicates epa_id_registration data. Adding FK normalizes this relationship. Remove epa_id_number as it becomes re',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: Biennial reports provide hazardous waste generation and management data for ESG disclosures (GRI 306-3, SASB IF-WM-150a.1). Sustainability teams source hazmat metrics directly from biennial reports fo',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Biennial reports (40 CFR 262.41) ARE regulatory submissions. Links hazmat-specific report content to general submission tracking for deadline management, confirmation numbers, and agency response trac',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Biennial reports are submitted per facility to EPA. Links regulatory reports to facility asset master for compliance tracking, facility performance benchmarking, audit trails, and facility-level waste',
    `amendment_date` DATE COMMENT 'The date on which an amended version of the biennial report was submitted. Nullable if no amendment has been filed.',
    `amendment_reason` STRING COMMENT 'Explanation for why the biennial report was amended after initial submission. Nullable if the report has not been amended. Common reasons include data corrections, additional waste codes discovered, or regulatory agency feedback.',
    `certification_date` DATE COMMENT 'The date on which the authorized representative signed and certified the biennial report, attesting to its accuracy under penalty of law.',
    `certification_title` STRING COMMENT 'Job title of the authorized facility representative who certified the biennial report (e.g., Environmental Manager, Facility Director, Compliance Officer).',
    `comments` STRING COMMENT 'Additional notes, clarifications, or context related to the biennial report submission. May include explanations of unusual waste volumes, operational changes, or regulatory correspondence.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this biennial report record was first created in the system. Audit trail field.',
    `generator_status` STRING COMMENT 'The regulatory classification of the waste generator at the time of reporting. LQG = Large Quantity Generator (≥1000 kg/month), SQG = Small Quantity Generator (100-1000 kg/month), CESQG/VSQG = Conditionally Exempt/Very Small Quantity Generator (<100 kg/month).. Valid values are `LQG|SQG|CESQG|VSQG`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this biennial report record was most recently updated. Audit trail field for tracking changes.',
    `number_of_tsdf_destinations` STRING COMMENT 'The count of distinct off-site TSDF facilities to which hazardous waste was shipped during the reporting year. Each TSDF is identified by its EPA ID number.',
    `number_of_waste_codes_reported` STRING COMMENT 'The count of distinct EPA hazardous waste codes (e.g., D001, F001, K001) reported in this biennial report. Each waste stream is classified by one or more waste codes.',
    `offsite_shipment_flag` BOOLEAN COMMENT 'Indicates whether the facility shipped any hazardous waste off-site to TSDFs during the reporting year. True = off-site shipments occurred, False = all waste managed on-site.',
    `onsite_treatment_flag` BOOLEAN COMMENT 'Indicates whether the facility performed any on-site treatment, storage, or disposal of hazardous waste during the reporting year. True = on-site management occurred, False = all waste shipped off-site.',
    `primary_treatment_method` STRING COMMENT 'The predominant treatment, storage, or disposal method used for hazardous waste during the reporting year. Examples: incineration, stabilization, landfill, fuel blending, recycling, neutralization.',
    `primary_waste_code` STRING COMMENT 'The EPA hazardous waste code representing the largest volume of waste generated during the reporting year. Format: one letter (D=characteristic, F=non-specific source, K=specific source, P/U=acute/toxic) followed by three digits.. Valid values are `^[DFKPU][0-9]{3}$`',
    `primary_waste_description` STRING COMMENT 'Textual description of the primary waste stream corresponding to the primary waste code. Describes the waste source, composition, and hazardous characteristics.',
    `reporting_year` STRING COMMENT 'The even-numbered calendar year for which this biennial report is submitted (e.g., 2022, 2024). Reports are required every two years per RCRA regulations.',
    `source_system` STRING COMMENT 'The operational system from which this biennial report data was sourced. Typically Enviance EHS regulatory reporting module or SAP EHS module.. Valid values are `Enviance EHS|SAP EHS|Manual Entry`',
    `state_agency_code` STRING COMMENT 'Two-letter abbreviation of the state environmental agency to which this biennial report was submitted. Corresponds to the state where the facility is located.. Valid values are `^[A-Z]{2}$`',
    `total_waste_generated_lbs` DECIMAL(18,2) COMMENT 'The total quantity of RCRA hazardous waste generated during the reporting year, measured in pounds. Aggregated across all waste codes managed by the facility.',
    `total_waste_managed_onsite_lbs` DECIMAL(18,2) COMMENT 'The total quantity of hazardous waste treated, stored, or disposed of on-site at the generator facility during the reporting year, measured in pounds.',
    `total_waste_shipped_offsite_lbs` DECIMAL(18,2) COMMENT 'The total quantity of hazardous waste shipped off-site to Treatment, Storage, and Disposal Facilities (TSDFs) during the reporting year, measured in pounds.',
    `waste_minimization_achieved_flag` BOOLEAN COMMENT 'Indicates whether the facility achieved measurable waste minimization or source reduction during the reporting year. True = minimization achieved, False = no reduction.',
    `waste_minimization_activities` STRING COMMENT 'Narrative description of waste minimization, source reduction, and pollution prevention activities undertaken during the reporting year. Required disclosure per RCRA biennial reporting requirements.',
    CONSTRAINT pk_rcra_biennial_report PRIMARY KEY(`rcra_biennial_report_id`)
) COMMENT 'RCRA Biennial Report submission record required of large quantity generators (LQGs) every even-numbered year per 40 CFR Part 262 Subpart D. Captures reporting year, EPA ID, total waste generated by waste code (lbs), waste minimization activities, treatment/disposal methods used, TSDF destinations, on-site management quantities, and submission status (draft, submitted, acknowledged by state agency). Sourced from Enviance EHS regulatory reporting module and SAP EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` (
    `hazwoper_training_id` BIGINT COMMENT 'Unique identifier for the HAZWOPER training record. Primary key.',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: HAZWOPER training hours and compliance rates are ESG safety metrics (GRI 403-5, SASB IF-WM-320a.1). Reported in annual sustainability disclosures as employee health and safety KPIs. Standard ESG socia',
    `previous_training_hazwoper_training_id` BIGINT COMMENT 'Reference to the previous HAZWOPER training record for this employee, establishing training history chain. Used to track initial training and subsequent refresher courses.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who completed the HAZWOPER training. Links to workforce management system.',
    `safety_training_record_id` BIGINT COMMENT 'Foreign key linking to safety.safety_training_record. Business justification: HAZWOPER certifications are specialized safety training records requiring integration with enterprise training management. Links OSHA 1910.120 compliance to broader safety training tracking for report',
    `training_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.training_certification. Business justification: HAZWOPER training records (29 CFR 1910.120) ARE compliance training certifications. Links hazmat-specific training to general certification tracking for expiration management, audit support, and regul',
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: HAZWOPER training fulfills specific regulatory requirements (29 CFR 1910.120, 40 CFR 264.16). Links training completion to requirement definition for gap analysis, compliance verification, and trainin',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: HAZWOPER training is site-specific and references the work sites EPA ID. The epa_id_number string is a denormalized reference. Adding labeled FK (work_site_epa_id_registration_id) normalizes this. Re',
    `assessment_passed` BOOLEAN COMMENT 'Indicates whether the employee passed the HAZWOPER training assessment. True if passed, False if failed.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Final assessment score or percentage achieved by the employee on the HAZWOPER training examination. Minimum passing score typically 70%.',
    `certificate_document_url` STRING COMMENT 'URL or file path to the digital copy of the HAZWOPER training certificate stored in the document management system.',
    `certificate_issued` BOOLEAN COMMENT 'Indicates whether a physical or digital training certificate was issued to the employee. True if issued, False if not issued.',
    `compliance_verification_date` DATE COMMENT 'Date when the Environmental Health and Safety (EHS) department verified that the HAZWOPER training meets all regulatory requirements.',
    `compliance_verified_by` STRING COMMENT 'Name of the EHS compliance officer who verified the HAZWOPER training record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HAZWOPER training record was first created in the system.',
    `fit_test_date` DATE COMMENT 'Date when the employee completed respirator fit testing as required for workers who may use respiratory protection during hazardous waste operations.',
    `fit_test_expiration_date` DATE COMMENT 'Date when the respirator fit test expires. OSHA requires annual fit testing.',
    `instructor_name` STRING COMMENT 'Name of the certified instructor who conducted the HAZWOPER training.',
    `job_role` STRING COMMENT 'Specific job role or position for which the HAZWOPER training was completed (e.g., hazmat technician, site supervisor, emergency responder).',
    `medical_surveillance_clearance_date` DATE COMMENT 'Date when the employee received medical clearance to work with hazardous materials per OSHA 29 CFR 1910.120(f). Medical surveillance is required before assignment to hazardous waste operations.',
    `medical_surveillance_expiration_date` DATE COMMENT 'Date when the medical surveillance clearance expires. OSHA requires annual medical examinations for hazardous waste workers.',
    `modified_by` STRING COMMENT 'Username or employee ID of the user who last modified this HAZWOPER training record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this HAZWOPER training record was last modified in the system.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the HAZWOPER training, including special circumstances, accommodations, or follow-up actions required.',
    `reimbursement_status` STRING COMMENT 'Status of employee reimbursement for training costs, if applicable.. Valid values are `not_applicable|pending|approved|reimbursed|denied`',
    `renewal_notification_sent_date` DATE COMMENT 'Date when the system sent a notification to the employee and supervisor regarding upcoming HAZWOPER training renewal requirement.',
    `supervisor_approval_date` DATE COMMENT 'Date when the employees supervisor approved the HAZWOPER training completion and authorized the employee for hazardous waste work assignments.',
    `training_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the HAZWOPER training, including tuition, materials, travel, and lodging expenses.',
    `training_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `training_delivery_method` STRING COMMENT 'Method by which the HAZWOPER training was delivered. OSHA requires hands-on components for certain training types.. Valid values are `classroom|online|blended|field_exercise|hands_on`',
    `training_location` STRING COMMENT 'Physical location or facility where the HAZWOPER training was conducted.',
    `training_status` STRING COMMENT 'Current status of the HAZWOPER training certification. Determines whether the employee is authorized to work with hazardous materials.. Valid values are `current|expired|pending_renewal|suspended|revoked`',
    `training_topics_covered` STRING COMMENT 'Comma-separated list of specific topics covered in the HAZWOPER training (e.g., hazard recognition, PPE selection, decontamination procedures, emergency response, confined space entry).',
    `training_type` STRING COMMENT 'Type of HAZWOPER training completed per OSHA 29 CFR 1910.120 requirements. 40-hour initial for general site workers, 24-hour initial for occasional site workers, 8-hour annual refresher, supervisor 8-hour, first responder awareness level, or first responder operations level.. Valid values are `40_hour_initial|24_hour_initial|8_hour_refresher|supervisor_8_hour|first_responder_awareness|first_responder_operations`',
    `work_site_assignment` STRING COMMENT 'Treatment, Storage, and Disposal Facility (TSDF) or hazardous waste site where the employee is assigned to work following HAZWOPER training.',
    `created_by` STRING COMMENT 'Username or employee ID of the user who created this HAZWOPER training record in the system.',
    CONSTRAINT pk_hazwoper_training PRIMARY KEY(`hazwoper_training_id`)
) COMMENT 'HAZWOPER (Hazardous Waste Operations and Emergency Response) training record for personnel working with hazardous waste per OSHA 29 CFR 1910.120. Captures employee reference, training type (40-hour initial, 8-hour refresher, supervisor, first responder), training provider, completion date, expiration date, certification number, medical surveillance clearance date, and training status. Ensures only qualified personnel handle hazardous materials. Integrates with Workday HCM training records.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` (
    `emergency_response_incident_id` BIGINT COMMENT 'Unique identifier for the emergency response incident record.',
    `contingency_plan_id` BIGINT COMMENT 'Foreign key linking to hazmat.contingency_plan. Business justification: Emergency response incident should link to contingency_plan for emergency procedures and response protocols. Contingency plan guides emergency response actions. This FK provides traceability to the go',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: Emergency response incident has un_number (string) but no FK to dot_hazmat_classification reference table. Adding FK provides standardized DOT classification lookup. Keep un_number string for operatio',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: DOT requires post-accident drug/alcohol testing for drivers involved in hazmat incidents (49 CFR 382.303). Links incident to driver safety records, HAZMAT training compliance, and qualification files.',
    `emergency_action_plan_id` BIGINT COMMENT 'Foreign key linking to safety.emergency_action_plan. Business justification: Emergency response incidents trigger and validate facility emergency action plans. Links actual emergency events to plan effectiveness for post-incident review, plan updates, and continuous improvemen',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Emergency response incidents occur at EPA-registered sites. The epa_id_number string duplicates epa_id_registration data. Adding FK normalizes this relationship. Remove epa_id_number as it becomes red',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_emission. Business justification: Emergency releases generate unplanned emissions requiring NRC reporting and EPA GHGRP inclusion. Regulatory mandate requires emission quantification for spill events. Critical for Scope 1 inventory co',
    `hazmat_container_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazmat_container. Business justification: Emergency response incidents often involve specific containers (spills, leaks, breaches). This links the incident to the primary container involved, enabling root cause analysis and container integrit',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Emergency response incidents require incident commander assignment per contingency plan requirements (40 CFR 265.52). Links to employee HAZWOPER certification, emergency coordinator training, and enab',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Incidents occur at facilities and impact facility risk profiles, insurance premiums, and safety certifications. Links incidents to facility asset records for insurance claims, facility safety scoring,',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Emergency response incidents that occur during manifested shipments should reference the manifest. This links the incident to the cradle-to-grave tracking document, enabling correlation of incidents w',
    `regulatory_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_corrective_action. Business justification: Incidents require corrective actions per RCRA Corrective Action (40 CFR 264 Subpart F) or CERCLA. Links incident to mandated remediation activities, closure verification, and regulatory oversight of c',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Hazmat emergency responses (spills, releases, exposures) are specialized safety incidents requiring unified incident management, OSHA recordkeeping, and workers compensation integration. Links EPA em',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: Hazmat incidents involving vehicle releases require vehicle identification for DOT incident reporting (49 CFR 171.16), insurance claims, vehicle inspection records, and root cause analysis. Critical f',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Emergency incidents (spills, releases) often trigger violation notices from EPA or state agencies. Required for tracking enforcement actions resulting from incidents and linking incident response to r',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Emergency response incident has waste_code (string) but no FK to waste_code reference table. Adding FK provides standardized waste code lookup and validation. Keep waste_code string for operational fl',
    `waste_shipment_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_shipment. Business justification: Emergency response incidents occur during specific shipment events. This links the incident to the operational shipment record, enabling tracking of which pickup/transport event experienced the incide',
    `cleanup_completion_datetime` TIMESTAMP COMMENT 'Date and time when cleanup and remediation activities were completed and the site was declared safe.',
    `cleanup_contractor_name` STRING COMMENT 'Name of the environmental remediation contractor deployed to the incident site for cleanup and remediation activities.',
    `cleanup_start_datetime` TIMESTAMP COMMENT 'Date and time when formal cleanup and remediation activities commenced at the incident site.',
    `corrective_actions` STRING COMMENT 'Description of corrective and preventive actions implemented to prevent recurrence of similar incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this emergency response incident record was first created in the EHS system.',
    `discovery_datetime` TIMESTAMP COMMENT 'The date and time when the incident was first discovered or reported to management.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the incident location in decimal degrees for precise geospatial tracking and emergency response dispatch.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the incident location in decimal degrees for precise geospatial tracking and emergency response dispatch.',
    `immediate_response_actions` STRING COMMENT 'Description of immediate containment and response actions taken at the time of discovery to mitigate the release.',
    `incident_closure_date` DATE COMMENT 'Date when the incident was formally closed after all response, remediation, and reporting activities were completed.',
    `incident_datetime` TIMESTAMP COMMENT 'The date and time when the hazardous material spill, release, or emergency event occurred.',
    `incident_number` STRING COMMENT 'Externally-known unique incident tracking number assigned by the EHS system for regulatory reporting and internal reference.. Valid values are `^INC-[0-9]{8}$`',
    `incident_severity` STRING COMMENT 'Severity classification of the incident based on release quantity, environmental impact, and public health risk.. Valid values are `minor|moderate|major|catastrophic`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the emergency response incident from initial report through final closure.. Valid values are `reported|under_investigation|response_active|contained|remediation_in_progress|closed`',
    `incident_type` STRING COMMENT 'Classification of the emergency incident type based on the nature of the hazardous material event. [ENUM-REF-CANDIDATE: spill|leak|release|fire|explosion|exposure|transportation_accident — 7 candidates stripped; promote to reference product]',
    `injuries_reported` BOOLEAN COMMENT 'Indicates whether any personnel injuries or exposures occurred as a result of the incident.',
    `injury_count` STRING COMMENT 'Number of personnel who sustained injuries or exposures during the incident.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this emergency response incident record was last updated.',
    `lepc_notification_datetime` TIMESTAMP COMMENT 'Date and time when the Local Emergency Planning Committee was notified of the incident.',
    `lepc_notified` BOOLEAN COMMENT 'Indicates whether the Local Emergency Planning Committee was notified as required under EPCRA Title III.',
    `location_type` STRING COMMENT 'Type of location where the incident occurred, indicating operational context and regulatory jurisdiction.. Valid values are `generator_site|tsdf_facility|in_transit|public_area|waterway`',
    `material_released` STRING COMMENT 'Name or description of the hazardous material(s) that were released during the incident.',
    `nrc_notification_datetime` TIMESTAMP COMMENT 'Date and time when the incident was reported to the National Response Center as required for reportable quantity releases.',
    `nrc_report_number` STRING COMMENT 'Confirmation number issued by the National Response Center upon notification of the incident.. Valid values are `^[0-9]{7,10}$`',
    `regulatory_report_due_date` DATE COMMENT 'Deadline date by which formal regulatory incident reports must be submitted to EPA, state agencies, or other authorities.',
    `regulatory_report_submission_date` DATE COMMENT 'Date when the formal regulatory incident report was submitted to EPA, state, or local authorities.',
    `regulatory_report_submitted` BOOLEAN COMMENT 'Indicates whether the required regulatory incident report has been submitted to the appropriate authorities.',
    `release_pathway` STRING COMMENT 'Environmental pathway through which the hazardous material was released (air, water, soil, etc.).. Valid values are `air|surface_water|groundwater|soil|storm_drain|sewer`',
    `release_quantity` DECIMAL(18,2) COMMENT 'Estimated quantity of hazardous material released during the incident.',
    `release_quantity_unit` STRING COMMENT 'Unit of measure for the release quantity (gallons, pounds, etc.).. Valid values are `gallons|liters|pounds|kilograms|tons|cubic_yards`',
    `remediation_status` STRING COMMENT 'Current status of environmental remediation and cleanup activities at the incident site.. Valid values are `not_started|in_progress|completed|ongoing_monitoring`',
    `root_cause_analysis_completed` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis investigation was completed to identify underlying factors that led to the incident.',
    `site_postal_code` STRING COMMENT 'ZIP code of the incident location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `state_agency_notified` BOOLEAN COMMENT 'Indicates whether the state environmental agency was notified of the incident as required by state regulations.',
    `state_notification_datetime` TIMESTAMP COMMENT 'Date and time when the state environmental agency was notified of the incident.',
    `un_number` STRING COMMENT 'Four-digit United Nations identification number for the hazardous material released, used for international transportation classification.. Valid values are `^UN[0-9]{4}$`',
    `waste_code` STRING COMMENT 'EPA hazardous waste code(s) applicable to the released material under RCRA regulations.. Valid values are `^[DFKPU][0-9]{3}$`',
    CONSTRAINT pk_emergency_response_incident PRIMARY KEY(`emergency_response_incident_id`)
) COMMENT 'Record of hazardous material spill, release, or emergency response incident at a generator site, during transport, or at a TSDF. Captures incident date/time, location (site or GPS coordinates), material(s) released, estimated release quantity, release pathway (air, water, soil), immediate response actions taken, notifications made (NRC, state agency, LEPC), cleanup contractor deployed, remediation status, regulatory reporting deadlines, and final incident closure. Integrates with Enviance EHS incident module and DOT incident reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` (
    `land_disposal_restriction_id` BIGINT COMMENT 'Unique identifier for the land disposal restriction record. Primary key for the LDR notification and certification entity.',
    `disposal_record_id` BIGINT COMMENT 'Foreign key linking to hazmat.disposal_record. Business justification: LDR certifications are required before land disposal can occur. One LDR certification authorizes one disposal event. This links the LDR certification to the disposal record it authorizes, enabling ver',
    `epa_id_registration_id` BIGINT COMMENT 'The EPA identification number of the TSDF receiving the waste for land disposal. 12-character format: 2-letter state code + 9 digits.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `generator_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: LDR notification tracks generator EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (generator_epa_id_registration_id) distinguishes this from TSDF and treatment f',
    `manifest_id` BIGINT COMMENT 'Reference to the hazardous waste manifest that this LDR notification accompanies. Every LDR must be associated with a manifest shipment.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: LDR notifications (40 CFR 268.7) are regulatory submissions. Links LDR compliance documentation to submission tracking for deadline management, confirmation, and audit trails.',
    `treatment_record_id` BIGINT COMMENT 'Foreign key linking to hazmat.treatment_record. Business justification: LDR certifications document that treatment standards were met before land disposal. One LDR certification references one treatment batch that achieved compliance. This links the LDR certification to t',
    `waste_profile_id` BIGINT COMMENT 'Reference to the waste profile that characterizes the waste stream subject to this LDR. Links to waste characterization and TCLP testing results.',
    `analytical_method` STRING COMMENT 'EPA-approved analytical method used to determine constituent concentrations for LDR compliance (e.g., SW-846 methods, TCLP).',
    `analytical_results` STRING COMMENT 'Summary of analytical test results showing constituent concentrations compared to treatment standards, formatted as constituent:value:unit triplets.',
    `certification_date` DATE COMMENT 'Date when the generator certified that the waste meets LDR treatment standards or provided required notification of non-compliance.',
    `certification_statement` STRING COMMENT 'Full text of the generator certification statement required by 40 CFR 268.7, certifying that waste meets treatment standards or identifying prohibited waste codes.',
    `certifying_official_name` STRING COMMENT 'Full name of the authorized representative who signed the LDR certification on behalf of the generator.',
    `certifying_official_signature_date` DATE COMMENT 'Date when the authorized representative signed the LDR certification document.',
    `certifying_official_title` STRING COMMENT 'Job title of the authorized representative who signed the LDR certification (e.g., Environmental Manager, Plant Manager, Authorized Agent).',
    `comments` STRING COMMENT 'Additional comments, notes, or special instructions related to the LDR notification, treatment requirements, or compliance considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LDR record was first created in the system. Audit trail for data governance and compliance tracking.',
    `dilution_prohibition_flag` BOOLEAN COMMENT 'Indicates whether the waste is subject to dilution prohibition under 40 CFR 268.3. True if dilution as substitute for treatment is prohibited.',
    `epa_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes (D, F, K, P, U codes) applicable to this waste stream and subject to LDR treatment standards.',
    `laboratory_certification_number` STRING COMMENT 'State or federal certification number of the laboratory that performed LDR compliance testing.',
    `laboratory_name` STRING COMMENT 'Name of the certified laboratory that performed analytical testing to verify LDR compliance.',
    `ldr_notification_type` STRING COMMENT 'Type of LDR notification: one-time (single shipment), annual (covers multiple shipments of same waste), or waste-specific (unique waste stream).. Valid values are `one_time|annual|waste_specific`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LDR record was last modified. Audit trail for data governance and change tracking.',
    `no_migration_petition_number` STRING COMMENT 'Reference number for approved no-migration petition under 40 CFR 268.6, if applicable, allowing land disposal without meeting treatment standards.',
    `prohibited_waste_codes` STRING COMMENT 'Comma-separated list of waste codes that are prohibited from land disposal without meeting treatment standards. Used when waste does not meet standards.',
    `sample_analysis_date` DATE COMMENT 'Date when the laboratory completed analysis of the waste sample for LDR compliance verification.',
    `sample_collection_date` DATE COMMENT 'Date when the waste sample was collected for LDR compliance testing.',
    `storage_prohibition_flag` BOOLEAN COMMENT 'Indicates whether the waste is subject to storage prohibition under 40 CFR 268.50. True if storage of restricted waste is prohibited except for accumulation purposes.',
    `subcategory` STRING COMMENT 'Specific waste subcategory within the EPA waste code that may have different treatment standards (e.g., high mercury, low mercury, radioactive).',
    `treatment_date` DATE COMMENT 'Date when the waste was treated to meet LDR standards, if applicable. Required when waste_meets_treatment_standards_flag is True.',
    `treatment_facility_name` STRING COMMENT 'Name of the facility where the waste was treated to meet LDR standards, if treatment occurred prior to shipment.',
    `treatment_standard_code` STRING COMMENT 'The specific treatment standard code from 40 CFR Part 268 Subpart D that applies to this waste (e.g., DEACT, RLEAD, STABL, MACRO, CMBST).',
    `treatment_standard_description` STRING COMMENT 'Detailed description of the treatment standard requirements, including specific concentration limits or technology specifications that must be met.',
    `treatment_standard_type` STRING COMMENT 'Type of treatment standard applicable to this waste: concentration-based (specific constituent levels) or technology-based (specific treatment technology required).. Valid values are `concentration_based|technology_based`',
    `tsdf_acknowledgment_date` DATE COMMENT 'Date when the receiving TSDF acknowledged receipt and acceptance of the LDR notification and certification.',
    `uhc_treatment_standards` STRING COMMENT 'Specific concentration limits or treatment requirements for each underlying hazardous constituent listed, formatted as constituent:limit pairs.',
    `underlying_hazardous_constituents` STRING COMMENT 'Comma-separated list of underlying hazardous constituents present in the waste that are subject to treatment standards, even if not the primary waste code.',
    `variance_or_exemption_number` STRING COMMENT 'Reference number for any EPA-granted variance, exemption, or extension from LDR treatment standards applicable to this waste shipment.',
    `waste_category` STRING COMMENT 'EPA waste category classification: wastewater (contains less than 1% total organic carbon and less than 1% total suspended solids) or nonwastewater. Determines applicable treatment standards.. Valid values are `wastewater|nonwastewater`',
    `waste_meets_treatment_standards_flag` BOOLEAN COMMENT 'Indicates whether the waste has been treated to meet applicable LDR treatment standards prior to land disposal. True if waste meets standards, False if waste requires further treatment.',
    CONSTRAINT pk_land_disposal_restriction PRIMARY KEY(`land_disposal_restriction_id`)
) COMMENT 'Land Disposal Restriction (LDR) notification and certification record per 40 CFR Part 268. Captures waste code, treatment standard type (concentration-based or technology-based), applicable treatment standard values, underlying hazardous constituents (UHCs), LDR notification date, generator certification statement, and whether waste meets treatment standards prior to land disposal. Required to accompany every hazardous waste shipment destined for land disposal. Sourced from SAP EHS and Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`waste_code` (
    `waste_code_id` BIGINT COMMENT 'Unique identifier for the waste code record. Primary key.',
    `active_status` BOOLEAN COMMENT 'Indicates whether this waste code is currently active and should be used for new waste classifications. True for codes in current regulatory use. False for obsolete, superseded, or delisted codes that are retained for historical reference only.',
    `acute_hazardous_flag` BOOLEAN COMMENT 'Indicates whether this waste code designates an acutely hazardous waste under RCRA. True for P-listed wastes and certain F-listed wastes that are subject to more stringent quantity thresholds (1 kg vs 100 kg for generator status determination) and management requirements.',
    `container_type_restriction` STRING COMMENT 'Specific container or packaging requirements for this waste code during storage and transportation. May specify DOT-approved containers, compatibility requirements, or prohibited container materials. Critical for safe handling and DOT Hazardous Materials Regulations compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste code record was first created in the system. Used for audit trails and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delisting_petition_eligible_flag` BOOLEAN COMMENT 'Indicates whether generators may petition EPA to delist this waste code for specific waste streams that do not exhibit hazardous characteristics. True for listed wastes (F, K, P, U codes) where site-specific delisting is possible. False for characteristic wastes (D codes) which cannot be delisted.',
    `dot_hazard_class` STRING COMMENT 'DOT hazard class for transportation of this waste under Hazardous Materials Regulations. Classes include: Class 1 (Explosives), Class 2 (Gases), Class 3 (Flammable Liquids), Class 4 (Flammable Solids), Class 5 (Oxidizers), Class 6 (Toxic/Infectious), Class 7 (Radioactive), Class 8 (Corrosives), Class 9 (Miscellaneous). Used for manifest preparation and vehicle placarding.',
    `effective_date` DATE COMMENT 'Date when this waste code became effective under federal or state regulations. Used to determine applicability to historical waste streams and to track regulatory changes over time. Critical for legacy waste management and compliance audits.',
    `generator_accumulation_limit_days` STRING COMMENT 'Maximum number of days a generator may accumulate this waste on-site before shipping to a TSDF. Typically 90 days for large quantity generators, 180 days for small quantity generators, or 270 days with approved extension. Shorter limits (e.g., 1 day) may apply to acutely hazardous wastes.',
    `hazard_basis` STRING COMMENT 'Primary hazard characteristic that qualifies this waste as hazardous under RCRA. Ignitability (D001) covers flammable liquids and oxidizers. Corrosivity (D002) covers acids and bases. Reactivity (D003) covers unstable or explosive materials. Toxicity (D004-D043) covers materials that leach toxic constituents. Listed wastes are hazardous by definition regardless of characteristics. Multiple indicates waste exhibits more than one characteristic.. Valid values are `ignitability|corrosivity|reactivity|toxicity|listed|multiple`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste code record was last updated. Tracks regulatory changes, data corrections, and reference updates. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Additional operational notes, clarifications, or internal guidance for using this waste code. May include common misclassifications to avoid, industry-specific interpretations, or cross-references to related codes. Free-text field for subject matter expert annotations.',
    `prohibited_method_code` STRING COMMENT 'Management method codes that are prohibited for this waste code under Land Disposal Restrictions. Typically references disposal methods that are banned without prior treatment (e.g., landfill disposal, deep well injection). Comma-separated list if multiple methods are prohibited.',
    `recycling_potential_flag` BOOLEAN COMMENT 'Indicates whether this waste code has known recycling or reclamation pathways that may qualify for reduced regulatory requirements under RCRA recycling exemptions. True if legitimate recycling options exist (e.g., solvent recovery, metal reclamation, fuel blending).',
    `regulatory_citation` STRING COMMENT 'Specific section of 40 CFR Part 261 or state regulation that defines this waste code. Provides legal reference for compliance documentation and audit trails. Format typically follows CFR structure (e.g., 40 CFR 261.31 for F-listed wastes).',
    `reportable_quantity_lbs` STRING COMMENT 'CERCLA reportable quantity in pounds. If a spill or release of this waste equals or exceeds this quantity, it must be reported to the National Response Center immediately. Values typically range from 1 lb (most hazardous) to 5,000 lbs. Null if no RQ is assigned.',
    `small_quantity_exclusion_kg` STRING COMMENT 'Quantity threshold in kilograms below which a generator may qualify for reduced regulatory requirements. Typically 100 kg per month for hazardous waste or 1 kg per month for acutely hazardous waste. Used to determine generator category (VSQG, SQG, LQG).',
    `state_code` STRING COMMENT 'Two-letter state abbreviation for state-specific waste codes. Null for federal EPA codes. Used to identify which state jurisdiction defines and enforces this code. Critical for multi-state operations to ensure compliance with local regulations.. Valid values are `^[A-Z]{2}$`',
    `state_specific_flag` BOOLEAN COMMENT 'Indicates whether this waste code is a state-specific designation beyond federal EPA requirements. True when the code is defined by state environmental regulations and may not be recognized in other states. False for federal EPA codes that apply nationwide.',
    `sunset_date` DATE COMMENT 'Date when this waste code was or will be removed from regulatory lists. Null for active codes. Populated when EPA or state agencies delist a waste code or when state-specific codes are superseded. Historical record retention required for audit trails.',
    `tclp_constituent` STRING COMMENT 'Specific toxic constituent measured in TCLP testing for toxicity characteristic wastes. Examples include arsenic, barium, cadmium, chromium, lead, mercury, selenium, silver, benzene, trichloroethylene. Only populated for D-code toxicity characteristic wastes (D004-D043).',
    `tclp_regulatory_level_mg_l` DECIMAL(18,2) COMMENT 'Maximum concentration in milligrams per liter of TCLP extract that triggers hazardous waste classification for toxicity characteristic wastes. Waste exceeding this level must be managed as hazardous. Only applicable to D-code toxicity characteristic wastes.',
    `toxicity_characteristic_flag` BOOLEAN COMMENT 'Indicates whether this waste code is based on Toxicity Characteristic Leaching Procedure (TCLP) test results. True for D004-D043 codes where waste is hazardous if TCLP extract exceeds regulatory levels for specific contaminants. Requires periodic testing to confirm classification.',
    `treatment_standard_code` STRING COMMENT 'Land Disposal Restrictions (LDR) treatment standard code that applies to this waste before land disposal. References 40 CFR Part 268 treatment standards. Specifies required treatment technology or concentration limits (e.g., DEACT for deactivation, IMERC for incineration, specific mg/L or mg/kg limits for TCLP constituents).',
    `treatment_subcategory` STRING COMMENT 'Subcategory designation for wastes with multiple treatment standards based on waste form or concentration. Used when a single waste code has different treatment requirements for wastewater versus non-wastewater forms, or for different concentration ranges.',
    `universal_treatment_standard` STRING COMMENT 'Universal Treatment Standard concentration limits for underlying hazardous constituents. Specifies maximum allowable concentrations (in mg/L for TCLP or mg/kg total) for each constituent before the waste can be land disposed. Multiple constituents may be listed with their respective limits.',
    `waste_code` STRING COMMENT 'EPA or state hazardous waste code identifier. Format follows EPA classification: D-codes (D001-D043 for characteristic wastes), F-codes (F001-F039 for non-specific source wastes), K-codes (K001-K181 for specific source wastes), P-codes (P001-P205 for acutely hazardous commercial chemical products), U-codes (U001-U411 for toxic commercial chemical products). This is the business identifier used across manifests, profiles, and regulatory reports.. Valid values are `^[DFKPU][0-9]{3}[A-Z]?$`',
    `waste_code_type` STRING COMMENT 'Classification category of the waste code. D-listed are characteristic wastes (ignitability, corrosivity, reactivity, toxicity). F-listed are wastes from non-specific sources. K-listed are wastes from specific sources. P-listed are acutely hazardous discarded commercial chemical products. U-listed are toxic discarded commercial chemical products. State-specific codes are additional classifications imposed by state environmental agencies.. Valid values are `D-listed|F-listed|K-listed|P-listed|U-listed|state-specific`',
    `waste_description` STRING COMMENT 'Detailed narrative description of the waste stream or material covered by this code. Includes physical characteristics, chemical composition, source process, and typical examples. Used by generators and TSDFs to match waste streams to appropriate codes.',
    `waste_minimization_code` STRING COMMENT 'Code indicating applicable waste minimization or source reduction strategies for this waste stream. References EPA waste minimization guidance and best management practices. Used in biennial reports and pollution prevention planning.',
    CONSTRAINT pk_waste_code PRIMARY KEY(`waste_code_id`)
) COMMENT 'Reference table of EPA and state hazardous waste codes used to classify hazardous waste streams. Captures waste code (D001–D043, F-listed, K-listed, P-listed, U-listed), waste code description, hazard basis (ignitability, corrosivity, reactivity, toxicity, listed), regulatory citation (40 CFR Part 261 subpart), applicable treatment standards, state-specific code flag, and active status. Used across waste profiles, manifests, and regulatory reports for standardized waste classification.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` (
    `dot_hazmat_classification_id` BIGINT COMMENT 'Unique identifier for the DOT hazardous materials classification record. Primary key.',
    `cargo_aircraft_quantity_limit` STRING COMMENT 'Maximum net quantity per package permitted on cargo-only aircraft. May be expressed as weight (kg), volume (L), or Forbidden if not permitted.',
    `classification_effective_date` DATE COMMENT 'Date when this classification entry became effective in the Hazardous Materials Regulations. Used to track regulatory changes over time.',
    `classification_status` STRING COMMENT 'Current regulatory status of this classification entry. Active = currently in force, Superseded = replaced by newer entry, Withdrawn = no longer valid.. Valid values are `active|superseded|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this classification record was first created in the system. Used for audit trail and data lineage.',
    `erg_guide_number` STRING COMMENT 'Three-digit guide number from the DOT Emergency Response Guidebook that provides first responders with initial action guidance for incidents involving this material.. Valid values are `^[0-9]{3}$`',
    `excepted_quantity_code` STRING COMMENT 'Code (E0-E5) indicating the maximum quantity per inner packaging permitted under excepted quantity provisions, which allow minimal regulatory requirements for very small quantities.. Valid values are `E[0-5]`',
    `exceptions` STRING COMMENT 'Reference to regulatory sections (e.g., 173.###) that provide exceptions or reduced requirements for limited quantities, small quantities, or specific transport modes.',
    `forbidden_cargo_aircraft` BOOLEAN COMMENT 'Indicates whether transport of this material on cargo-only aircraft is prohibited under any circumstances.',
    `forbidden_passenger_aircraft` BOOLEAN COMMENT 'Indicates whether transport of this material on passenger-carrying aircraft is prohibited under any circumstances.',
    `hazard_class` STRING COMMENT 'Primary hazard class or division (1-9) assigned to the material based on its predominant hazard. Examples: 1.1 (explosives), 2.1 (flammable gas), 3 (flammable liquid), 4.1 (flammable solid), 5.1 (oxidizer), 6.1 (toxic), 7 (radioactive), 8 (corrosive), 9 (miscellaneous).. Valid values are `^[1-9](.[1-6])?$`',
    `hazard_division` STRING COMMENT 'Subdivision within a hazard class that further categorizes the material by specific hazard characteristics (e.g., 1.1, 1.2, 2.1, 2.2, 6.1). May be null for classes without divisions.',
    `inhalation_hazard_zone` STRING COMMENT 'For materials that are poisonous by inhalation, the hazard zone (A, B, C, or D) indicating the degree of inhalation toxicity. Zone A is the most toxic.. Valid values are `A|B|C|D`',
    `label_code` STRING COMMENT 'Code(s) identifying the required hazard warning label(s) that must be affixed to packages. Multiple labels may be required for materials with subsidiary hazards. Examples: 3 (flammable liquid), 6.1 (poison), 8 (corrosive).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this classification record was most recently updated. Used for audit trail and change tracking.',
    `limited_quantity_eligible` BOOLEAN COMMENT 'Indicates whether this material is eligible for limited quantity exceptions, which allow reduced packaging, marking, and labeling requirements when transported in small quantities.',
    `limited_quantity_max_net` STRING COMMENT 'Maximum net quantity per inner receptacle or article permitted under limited quantity provisions. Expressed as weight or volume.',
    `marine_pollutant` BOOLEAN COMMENT 'Indicates whether the material is designated as a marine pollutant under DOT and International Maritime Dangerous Goods (IMDG) Code regulations. Requires special marking and handling for water transport.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or special instructions related to this classification entry. May include references to specific regulatory amendments or interpretations.',
    `packaging_authorizations` STRING COMMENT 'Codes referencing the authorized packaging sections (e.g., 173.###) that specify which container types and specifications are approved for this material.',
    `packing_group` STRING COMMENT 'Degree of danger presented by the material during transport. I = high danger, II = medium danger, III = low danger. Used to determine packaging requirements and quantity limits.. Valid values are `I|II|III`',
    `passenger_aircraft_quantity_limit` STRING COMMENT 'Maximum net quantity per package permitted on passenger-carrying aircraft. May be expressed as weight (kg), volume (L), or Forbidden if not permitted.',
    `placard_code` STRING COMMENT 'Code identifying the specific placard design required for the transport vehicle. Examples: FLAMMABLE, CORROSIVE, POISON, OXIDIZER, DANGEROUS.',
    `placard_required` BOOLEAN COMMENT 'Indicates whether placards must be displayed on the transport vehicle for this material when transported in specified quantities.',
    `proper_shipping_name` STRING COMMENT 'The official DOT-approved name used to describe the hazardous material on shipping papers, manifests, and labels. Must match the Hazardous Materials Table entry exactly.',
    `reportable_quantity_lbs` DECIMAL(18,2) COMMENT 'The threshold quantity (in pounds) at or above which a spill or release of this material must be reported to the National Response Center under CERCLA. Null if no RQ applies.',
    `severe_marine_pollutant` BOOLEAN COMMENT 'Indicates whether the material is classified as a severe marine pollutant (PP designation) requiring enhanced environmental protection measures during marine transport.',
    `special_provisions` STRING COMMENT 'Comma-separated list of special provision codes (e.g., B1, IB2, T4, TP1) that impose additional requirements or grant exceptions for packaging, handling, or transport of this material.',
    `subsidiary_hazard_class` STRING COMMENT 'Secondary hazard class(es) for materials that present more than one type of hazard. Multiple subsidiary classes may be listed, separated by commas.',
    `superseded_by_un_na_number` STRING COMMENT 'If this classification has been superseded, the UN/NA number of the replacement classification entry. Null if status is active.. Valid values are `^(UN|NA)[0-9]{4}$`',
    `technical_name_required` BOOLEAN COMMENT 'Indicates whether the technical or chemical name of the hazardous constituent(s) must be entered in parentheses after the proper shipping name on shipping papers.',
    `un_na_number` STRING COMMENT 'Four-digit identification number assigned by the United Nations or North America to hazardous materials for international and domestic transport. Format: UN#### or NA####.. Valid values are `^(UN|NA)[0-9]{4}$`',
    `vessel_stowage_location` STRING COMMENT 'Code indicating where the material must be stowed on a vessel (e.g., A = on deck only, B = under deck, C = on or under deck). Applies to marine transport.',
    `vessel_stowage_other` STRING COMMENT 'Additional stowage requirements or restrictions for marine transport, such as segregation from other materials, ventilation requirements, or temperature controls.',
    CONSTRAINT pk_dot_hazmat_classification PRIMARY KEY(`dot_hazmat_classification_id`)
) COMMENT 'Reference table of DOT Hazardous Materials classifications per 49 CFR Parts 171–180 (HMR). Captures hazard class/division (1–9), UN/NA number, proper shipping name, packing group (I/II/III), label requirements, placard requirements, special provisions, packaging authorizations, quantity limits for passenger/cargo aircraft, and marine pollutant flag. Used to populate manifest shipping descriptions and ensure DOT HMR compliance for all hazardous waste transport.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`storage_unit` (
    `storage_unit_id` BIGINT COMMENT 'Unique identifier for the hazardous waste storage unit. Primary key for the storage unit master record.',
    `facility_id` BIGINT COMMENT 'Reference to the TSDF facility or generator site where this storage unit is located. Links to the facility master record for site-level attributes.',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Reference to the hazardous waste generator that operates this storage unit. Applicable when the unit is at a generator site rather than a TSDF.',
    `lockout_tagout_procedure_id` BIGINT COMMENT 'Foreign key linking to safety.lockout_tagout_procedure. Business justification: Hazmat storage units with mechanical/electrical systems (ventilation, pumps, alarms, temperature control) require LOTO procedures for maintenance and repair. OSHA 1910.147 compliance mandate linking h',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Storage units operate under facility permit with specific conditions (40 CFR 264/265 Subpart I). Permit defines storage capacity, waste codes, and time limits. Required for permit compliance verificat',
    `building_location` STRING COMMENT 'Physical building or structure identifier where the storage unit is located within the facility campus.',
    `closure_certification_number` STRING COMMENT 'Certification number issued by regulatory authority confirming that the storage unit closure was completed in accordance with RCRA requirements.',
    `closure_date` DATE COMMENT 'Date when the storage unit was permanently closed and decommissioned. Applicable for units that have completed RCRA closure procedures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage unit record was first created in the system. Audit trail for data governance.',
    `current_inventory_quantity` DECIMAL(18,2) COMMENT 'Current quantity of hazardous waste stored in the unit at the time of last inventory update. Measured in the unit of measure specified for this storage unit.',
    `emergency_response_zone` STRING COMMENT 'Emergency response zone designation for this storage unit within the facility emergency action plan. Used for HAZWOPER response coordination.',
    `exemption_basis` STRING COMMENT 'Regulatory basis under which this storage unit operates without a full RCRA permit. Identifies the specific exemption category that applies.. Valid values are `satellite_accumulation|90_day_generator|conditionally_exempt|interim_status|none`',
    `fire_suppression_system` STRING COMMENT 'Type of fire suppression system installed to protect the storage unit. Required for certain hazardous waste storage configurations.. Valid values are `sprinkler|foam|co2|dry_chemical|none`',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the storage unit location in decimal degrees format for spatial tracking and emergency response.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the storage unit location in decimal degrees format for spatial tracking and emergency response.',
    `incompatible_waste_codes` STRING COMMENT 'Comma-separated list of EPA waste codes that must not be stored in this unit due to incompatibility concerns. Used to prevent dangerous chemical reactions.',
    `inspection_frequency_days` STRING COMMENT 'Required frequency for routine inspections of the storage unit measured in days. Satellite accumulation areas require weekly inspections; 90-day areas require daily inspections per RCRA.',
    `installation_date` DATE COMMENT 'Date when the storage unit was installed and commissioned for use. Used for tracking unit age and maintenance scheduling.',
    `inventory_unit_of_measure` STRING COMMENT 'Unit of measure used for tracking inventory quantity in this storage unit. Must align with the capacity measurement unit.. Valid values are `gallons|pounds|kilograms|liters|tons|cubic_yards`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent routine inspection performed on this storage unit. Used to track compliance with inspection frequency requirements.',
    `maximum_capacity_gallons` DECIMAL(18,2) COMMENT 'Maximum permitted storage capacity of the unit measured in gallons. Applicable for liquid waste storage tanks and container storage areas. Regulatory limit that must not be exceeded.',
    `maximum_capacity_pounds` DECIMAL(18,2) COMMENT 'Maximum permitted storage capacity of the unit measured in pounds. Applicable for solid waste storage areas and satellite accumulation points. Regulatory limit that must not be exceeded.',
    `maximum_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in Fahrenheit for safe storage of waste in this unit. Applicable when temperature control is required.',
    `minimum_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in Fahrenheit for safe storage of waste in this unit. Applicable when temperature control is required.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage unit record was last modified. Audit trail for tracking changes to unit configuration or status.',
    `next_inspection_due_date` DATE COMMENT 'Calculated date when the next routine inspection is required based on inspection frequency. Used for compliance scheduling and alerts.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or historical information about the storage unit.',
    `permitted_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes that are authorized for storage in this unit. Restricts the types of waste that may be placed in the unit.',
    `ppe_requirements` STRING COMMENT 'Description of personal protective equipment required for personnel working in or inspecting this storage unit. Based on hazard assessment of stored wastes.',
    `room_area_designation` STRING COMMENT 'Specific room number, area code, or zone designation within the building for precise location identification.',
    `secondary_containment_capacity_gallons` DECIMAL(18,2) COMMENT 'Volume capacity of the secondary containment system in gallons. Must meet or exceed 110% of the largest container or 10% of total stored volume per RCRA requirements.',
    `secondary_containment_type` STRING COMMENT 'Type of secondary containment system installed to prevent environmental release in case of primary container failure. Required for most hazardous waste storage units under RCRA.. Valid values are `double_walled_tank|concrete_vault|bermed_area|containment_pallet|spill_containment_system|none`',
    `storage_time_limit_days` STRING COMMENT 'Maximum number of days that hazardous waste may be stored in this unit before shipment is required. Varies by unit type: satellite accumulation has no time limit until 55 gallons accumulated; 90-day areas have 90-day limit.',
    `temperature_control_required` BOOLEAN COMMENT 'Indicates whether this storage unit requires active temperature control to maintain waste stability and prevent hazardous conditions. True for temperature-sensitive wastes.',
    `unit_name` STRING COMMENT 'Human-readable name or designation for the storage unit, used by facility personnel for identification and communication.',
    `unit_number` STRING COMMENT 'Business identifier for the storage unit, used in facility documentation, permits, and operational tracking. Externally visible unit designation.',
    `unit_status` STRING COMMENT 'Current operational status of the storage unit in its lifecycle. Active units are available for waste storage; inactive units are temporarily out of service; closed units have completed closure procedures.. Valid values are `active|inactive|closed|under_inspection|suspended|decommissioned`',
    `unit_type` STRING COMMENT 'Classification of the storage unit based on RCRA regulatory categories. Determines applicable storage time limits, capacity restrictions, and operational requirements. [ENUM-REF-CANDIDATE: satellite_accumulation_area|90_day_accumulation_area|permitted_storage_tank|container_storage_building|drip_pad|containment_building|less_than_90_day_area — 7 candidates stripped; promote to reference product]',
    `ventilation_system_type` STRING COMMENT 'Type of ventilation system installed to control vapor accumulation and maintain air quality in the storage area. Required for volatile hazardous waste storage.. Valid values are `mechanical_exhaust|natural_ventilation|fume_hood|none`',
    CONSTRAINT pk_storage_unit PRIMARY KEY(`storage_unit_id`)
) COMMENT 'Master record for permitted hazardous waste storage units at generator sites or TSDFs. Captures unit ID, unit type (satellite accumulation area, 90-day accumulation area, permitted storage tank, container storage building, drip pad, containment building), physical location, maximum permitted capacity (gallons/lbs), secondary containment type, inspection frequency requirement, permit or exemption basis, current inventory quantity, and unit status (active, closed, under inspection). Supports RCRA storage time limit tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` (
    `storage_unit_inspection_id` BIGINT COMMENT 'Unique identifier for the hazardous waste storage unit inspection record.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Storage unit inspections (40 CFR 264.15, 264.174) ARE compliance inspections. Links hazmat-specific inspection details to general inspection tracking for findings management, corrective actions, and r',
    `employee_id` BIGINT COMMENT 'Reference to the employee record of the inspector who conducted the inspection.',
    `storage_unit_id` BIGINT COMMENT 'Reference to the hazardous waste storage unit or container storage area being inspected.',
    `tsdf_facility_id` BIGINT COMMENT 'Reference to the TSDF facility where the storage unit is located.',
    `aisle_space_adequate` BOOLEAN COMMENT 'Indicates whether aisle space allows unobstructed movement of personnel and emergency equipment for inspection and emergency response, typically requiring minimum 2-foot clearance.',
    `aisle_space_notes` STRING COMMENT 'Details regarding aisle space adequacy, including measurements and any obstructions that impede access or emergency response.',
    `container_closure_compliant` BOOLEAN COMMENT 'Indicates whether all containers are properly closed except when adding or removing waste, as required to prevent emissions and spills.',
    `container_closure_notes` STRING COMMENT 'Observations regarding container closure practices, including any open containers, damaged lids, or improper sealing.',
    `container_condition_notes` STRING COMMENT 'Detailed observations regarding the physical condition of containers, including any signs of damage, corrosion, leakage, or deterioration.',
    `container_condition_pass` BOOLEAN COMMENT 'Indicates whether containers were found to be in good condition without signs of leakage, corrosion, bulging, or structural deterioration.',
    `corrective_action_completed_date` DATE COMMENT 'Actual date when all required corrective actions were completed and verified.',
    `corrective_action_description` STRING COMMENT 'Detailed description of corrective actions required to remediate identified deficiencies and achieve compliance.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which corrective actions must be completed to maintain regulatory compliance.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions are required to address deficiencies identified during the inspection.',
    `corrective_action_verified_by` STRING COMMENT 'Name of the individual who verified completion of corrective actions and confirmed compliance restoration.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection record was first created in the system.',
    `deficiencies_identified_count` STRING COMMENT 'Total number of deficiencies or non-compliance items identified during the inspection.',
    `deficiency_summary` STRING COMMENT 'Consolidated summary of all deficiencies noted during the inspection, including specific checklist items that failed and their severity.',
    `emergency_equipment_available` BOOLEAN COMMENT 'Indicates whether required emergency equipment (spill kits, fire extinguishers, eyewash stations, safety showers, PPE) is present, accessible, and in working order.',
    `emergency_equipment_notes` STRING COMMENT 'Observations regarding the availability, condition, and accessibility of emergency response equipment, including any missing or non-functional items.',
    `facility_manager_name` STRING COMMENT 'Name of the facility manager who reviewed and signed off on the inspection findings.',
    `incompatible_waste_notes` STRING COMMENT 'Details regarding waste segregation practices, including any instances of incompatible materials stored in proximity or inadequate separation measures.',
    `incompatible_waste_separation_compliant` BOOLEAN COMMENT 'Indicates whether incompatible wastes are properly separated to prevent reactions, as required by RCRA for reactive, ignitable, and incompatible materials.',
    `inspection_notes` STRING COMMENT 'General observations, comments, and additional context captured during the inspection that do not fit into specific checklist categories.',
    `inspection_signed_off` BOOLEAN COMMENT 'Indicates whether the inspection has been formally signed off by the inspector and facility manager, confirming review and acceptance of findings.',
    `inspector_certification_expiration_date` DATE COMMENT 'Date when the inspectors certification expires and requires renewal.',
    `inspector_certification_number` STRING COMMENT 'Unique certification or license number for the inspector demonstrating qualification to perform hazardous waste inspections.',
    `inspector_certification_type` STRING COMMENT 'Type of certification held by the inspector, such as HAZWOPER 40-hour, RCRA Inspector, or facility-specific training credentials.',
    `inspector_name` STRING COMMENT 'Full name of the individual who performed the inspection.',
    `labeling_compliant` BOOLEAN COMMENT 'Indicates whether all containers are properly labeled with waste description, hazard class, accumulation start date, and EPA waste codes as required by RCRA.',
    `labeling_deficiency_notes` STRING COMMENT 'Description of any labeling deficiencies found, such as missing labels, illegible text, incorrect waste codes, or missing accumulation start dates.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection record was last modified or updated.',
    `overall_inspection_result` STRING COMMENT 'Summary result of the inspection indicating whether the storage unit meets all regulatory requirements or requires corrective action.. Valid values are `pass|pass_with_minor_deficiencies|fail|corrective_action_required`',
    `secondary_containment_integrity_pass` BOOLEAN COMMENT 'Indicates whether secondary containment systems (berms, dikes, spill pallets) are intact, free of cracks, and capable of containing 110% of the largest container volume.',
    `secondary_containment_notes` STRING COMMENT 'Observations regarding the condition and adequacy of secondary containment, including any cracks, liquid accumulation, or capacity concerns.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was formally signed off and approved.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection, relevant for outdoor storage areas where precipitation or temperature may affect container integrity.',
    CONSTRAINT pk_storage_unit_inspection PRIMARY KEY(`storage_unit_inspection_id`)
) COMMENT 'Periodic inspection record for hazardous waste storage units and container storage areas as required by RCRA regulations (weekly for LQGs, daily for permitted storage). Captures inspection date, inspector name and certification, unit inspected, checklist items (container condition, labeling, secondary containment integrity, aisle space, emergency equipment), deficiencies noted, corrective actions required, and sign-off status. Sourced from Enviance EHS inspection module.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` (
    `transporter_registration_id` BIGINT COMMENT 'Unique identifier for the hazardous waste transporter registration record. Primary key.',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Hazardous waste transporters must be EPA-registered. The epa_id_number string duplicates epa_id_registration data. Adding FK normalizes this relationship and provides a third inbound link to epa_id_re',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Registered hazmat transporters operate under hauling agreements defining routes, rates, insurance requirements, DOT compliance. Transporter assignment validates active agreement, insurance coverage, a',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Registered transporters are vendors for transportation services. Waste Management operations require linking transporter registrations to vendor master data for contract management, payment processing',
    `approval_date` DATE COMMENT 'Date when the transporter was approved for use by Waste Management for hazardous waste transportation services.',
    `approved_for_manifest_use` BOOLEAN COMMENT 'Boolean flag indicating whether this transporter is currently approved for use on hazardous waste manifests. False indicates transporter cannot be selected for new shipments.',
    `authorized_dot_hazard_classes` STRING COMMENT 'Comma-separated list of DOT hazard classes (1-9) that the transporter is authorized to transport based on DOT operating authority and vehicle placarding.',
    `authorized_vehicle_types` STRING COMMENT 'Comma-separated list of vehicle types the transporter is authorized and equipped to operate for hazardous waste transport (e.g., tanker truck, box truck, flatbed, roll-off, vacuum truck).',
    `authorized_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes (D, F, K, P, U series) that the transporter is authorized and equipped to handle based on permits, equipment, and training.',
    `cargo_insurance_carrier` STRING COMMENT 'Name of the insurance company providing cargo insurance coverage for hazardous waste in transit.',
    `cargo_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total cargo insurance coverage amount in USD for hazardous waste shipments in transit.',
    `cargo_insurance_expiration_date` DATE COMMENT 'Date when the current cargo insurance policy expires. Transporter must maintain continuous coverage to remain approved.',
    `cargo_insurance_policy_number` STRING COMMENT 'Policy number for the cargo insurance coverage protecting hazardous waste shipments in transit.',
    `city` STRING COMMENT 'City where the transporter company headquarters or principal place of business is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the transporter company headquarters. Typically USA for domestic transporters.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transporter registration record was first created in the system.',
    `dot_operating_authority_number` STRING COMMENT 'DOT motor carrier operating authority number (MC, FF, or MX number) required for interstate hazardous materials transportation. Format: MC-XXXXXX or FF-XXXXXX.. Valid values are `^(MC|FF|MX)-[0-9]{6,7}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the 24/7 emergency response contact at the transporter company for incident response and HAZWOPER coordination.',
    `emergency_contact_phone` STRING COMMENT '24/7 emergency phone number for incident response and spill coordination. Must be monitored at all times during transport operations.',
    `expiration_date` DATE COMMENT 'Date when the transporter registration expires and must be renewed. Null for indefinite registrations subject to periodic review.',
    `hazmat_employee_training_compliance_status` STRING COMMENT 'Current compliance status of the transporters HAZMAT employee training program per DOT HMR requirements. All drivers and handlers must receive training every 3 years.. Valid values are `compliant|non_compliant|pending_verification|expired`',
    `hazmat_training_last_verified_date` DATE COMMENT 'Date when Waste Management last verified that the transporter maintains compliant HAZMAT employee training records and certifications.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance and performance review conducted for this transporter.',
    `liability_insurance_carrier` STRING COMMENT 'Name of the insurance company providing hazardous waste transporter liability coverage for this transporter.',
    `liability_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total liability insurance coverage amount in USD. Minimum coverage requirements vary by waste type and quantity transported.',
    `liability_insurance_effective_date` DATE COMMENT 'Date when the current liability insurance policy became effective.',
    `liability_insurance_expiration_date` DATE COMMENT 'Date when the current liability insurance policy expires. Transporter must maintain continuous coverage to remain approved.',
    `liability_insurance_policy_number` STRING COMMENT 'Policy number for the transporter liability insurance coverage. Required for RCRA compliance and vendor approval.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transporter registration record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Date when the next periodic compliance and performance review is scheduled for this transporter.',
    `notes` STRING COMMENT 'Free-text notes capturing special handling requirements, restrictions, preferred use cases, or other relevant information about the transporter.',
    `postal_code` STRING COMMENT 'ZIP code or ZIP+4 code for the transporter company headquarters or principal place of business.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_contact_email` STRING COMMENT 'Business email address for the primary contact at the transporter company.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the transporter company for coordination and communication.',
    `primary_contact_phone` STRING COMMENT 'Business phone number for the primary contact at the transporter company.',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary business contact at the transporter company.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the transporter registration. Active transporters are approved for use on manifests. Suspended or revoked transporters cannot be used.. Valid values are `active|inactive|suspended|pending_approval|revoked|expired`',
    `safety_rating` STRING COMMENT 'Current FMCSA safety rating assigned to the motor carrier based on compliance reviews and safety performance. Unsatisfactory rating may disqualify transporter.. Valid values are `satisfactory|conditional|unsatisfactory|not_rated`',
    `state_code` STRING COMMENT 'Two-letter US state code where the transporter company headquarters or principal place of business is located.. Valid values are `^[A-Z]{2}$`',
    `state_transporter_permit_numbers` STRING COMMENT 'Comma-separated list of state-specific hazardous waste transporter permit or license numbers. Some states require additional permits beyond EPA ID.',
    `street_address` STRING COMMENT 'Primary street address of the transporter company headquarters or principal place of business.',
    `transporter_dba_name` STRING COMMENT 'Trade name or doing-business-as name used by the transporter, if different from legal name.',
    `transporter_legal_name` STRING COMMENT 'The full legal business name of the hazardous waste transporter company as registered with EPA and state authorities.',
    `usdot_number` STRING COMMENT 'Unique USDOT identification number assigned by FMCSA for commercial motor vehicle operations. Required for all interstate carriers.. Valid values are `^[0-9]{7,8}$`',
    `vendor_performance_score` DECIMAL(18,2) COMMENT 'Internal performance score (0-100) based on on-time performance, compliance incidents, customer feedback, and service quality metrics.',
    CONSTRAINT pk_transporter_registration PRIMARY KEY(`transporter_registration_id`)
) COMMENT 'Master record for EPA-registered hazardous waste transporters authorized to transport waste on behalf of Waste Management. Captures transporter EPA ID, company name, DOT operating authority number, state transporter permits, insurance certificate details, vehicle types authorized, waste types authorized, HAZMAT employee training compliance status, and approval status for use on manifests. Distinct from the fleet domains vehicle records — this is the regulatory transporter entity identity.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` (
    `contingency_plan_id` BIGINT COMMENT 'Unique identifier for the RCRA contingency plan document record. Primary key for the contingency plan entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RCRA contingency plans must designate emergency coordinator per 40 CFR 265.52. Links plan to employee record enables certification verification (HAZWOPER, emergency response training), contact informa',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Contingency plans are facility-specific and reference the facilitys EPA ID. The facility_epa_id string is a denormalized reference. Adding labeled FK (facility_epa_id_registration_id) normalizes this',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Contingency plans are facility-specific regulatory requirements. Links emergency plans to facility asset master for compliance audits, facility certification tracking, insurance underwriting, and faci',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Contingency plans (40 CFR 264/265 Subpart D) are permit conditions. Links emergency preparedness documentation to permit for compliance verification, inspection support, and demonstrating permit condi',
    `alternate_coordinator_name` STRING COMMENT 'Full name of the alternate or backup emergency coordinator who assumes responsibility when the primary coordinator is unavailable.',
    `alternate_coordinator_phone` STRING COMMENT '24-hour emergency contact phone number for the alternate emergency coordinator.',
    `amendment_reason` STRING COMMENT 'Explanation of why this contingency plan version was created or amended (e.g., facility modification, regulatory change, post-incident update, annual review).',
    `approval_date` DATE COMMENT 'Date on which this contingency plan version was formally approved by the responsible authority.',
    `approved_by_name` STRING COMMENT 'Full name of the individual who formally approved this contingency plan version (typically facility manager or environmental compliance officer).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contingency plan record was first created in the system. Used for audit trail and data lineage.',
    `document_storage_location` STRING COMMENT 'Physical or electronic location where the official contingency plan document is stored and maintained (e.g., file path, document management system reference, physical file cabinet location).',
    `effective_date` DATE COMMENT 'The date on which this contingency plan version became or will become effective and enforceable at the facility. Required for regulatory compliance tracking.',
    `emergency_contractor_name` STRING COMMENT 'Name of the contracted emergency response or cleanup contractor with arrangements to respond to hazardous waste incidents at the facility.',
    `emergency_contractor_phone` STRING COMMENT '24-hour emergency contact phone number for the contracted emergency response or cleanup contractor.',
    `emergency_coordinator_phone` STRING COMMENT '24-hour emergency contact phone number for the primary emergency coordinator. Must be accessible at all times for emergency response.',
    `emergency_coordinator_title` STRING COMMENT 'Job title or position of the primary emergency coordinator (e.g., Environmental Health and Safety Manager, Facility Manager, Operations Director).',
    `emergency_equipment_list` STRING COMMENT 'Comprehensive list of emergency equipment available at the facility, including spill kits, fire extinguishers, decontamination equipment, personal protective equipment (PPE), communication devices, and alarm systems. Required by 40 CFR 265.52.',
    `evacuation_map_reference` STRING COMMENT 'Reference identifier or document location for the facility evacuation map showing routes, exits, assembly points, and emergency equipment locations.',
    `evacuation_routes_description` STRING COMMENT 'Detailed description of primary and alternate evacuation routes from the facility, including assembly points and procedures for accounting for personnel during emergencies.',
    `expiration_date` DATE COMMENT 'The date on which this contingency plan version expires or is scheduled for mandatory review and update. Nullable for plans without fixed expiration.',
    `hazwoper_training_required` BOOLEAN COMMENT 'Boolean flag indicating whether HAZWOPER training (29 CFR 1910.120) is required for personnel involved in emergency response at this facility.',
    `last_review_date` DATE COMMENT 'The most recent date on which the contingency plan was formally reviewed for accuracy and completeness. RCRA requires annual review or review after incidents.',
    `local_emergency_agency_name` STRING COMMENT 'Name of the local emergency response agency or LEPC that has been notified of the facility operations and will respond to emergencies.',
    `local_emergency_agency_phone` STRING COMMENT 'Primary contact phone number for the local emergency response agency or fire department.',
    `local_hospital_distance_miles` DECIMAL(18,2) COMMENT 'Distance in miles from the facility to the designated local hospital. Used for emergency response time estimation.',
    `local_hospital_name` STRING COMMENT 'Name of the nearest hospital or medical facility with arrangements to treat injured personnel from hazardous waste incidents.',
    `local_hospital_phone` STRING COMMENT 'Emergency contact phone number for the designated local hospital or medical facility.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contingency plan record was last modified in the system. Used for audit trail and change tracking.',
    `next_review_due_date` DATE COMMENT 'The scheduled date by which the next formal review of the contingency plan must be completed to maintain regulatory compliance.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this contingency plan that do not fit in other structured fields.',
    `nrc_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether National Response Center notification is required for reportable quantity releases at this facility.',
    `plan_distribution_list` STRING COMMENT 'List of internal and external parties to whom copies of the contingency plan have been distributed, including local emergency responders, state agencies, and facility personnel.',
    `plan_document_number` STRING COMMENT 'Business-assigned unique document control number for the contingency plan. Used for internal tracking and version control.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the contingency plan document. Indicates whether the plan is in draft, under regulatory review, approved and active, or has been superseded by a newer version.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `plan_version` STRING COMMENT 'Version identifier for the contingency plan document (e.g., 1.0, 2.1, 3.0). Tracks revisions and updates over time.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority formally approved this contingency plan, if regulatory approval is required.',
    `regulatory_submission_date` DATE COMMENT 'Date on which this contingency plan was submitted to the regulatory authority (EPA or state agency) if submission is required under the facility permit.',
    `state_agency_name` STRING COMMENT 'Name of the state environmental quality department or agency that must be notified in case of emergencies.',
    `state_agency_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether state environmental agency notification is required for emergencies at this facility under state-specific regulations.',
    `state_agency_phone` STRING COMMENT 'Emergency notification phone number for the state environmental agency.',
    CONSTRAINT pk_contingency_plan PRIMARY KEY(`contingency_plan_id`)
) COMMENT 'RCRA-required contingency plan document record for each generator or TSDF facility. Captures facility EPA ID, plan version, effective date, emergency coordinator name and 24-hour contact, list of emergency equipment (spill kits, fire extinguishers, decontamination equipment), evacuation routes, local emergency response agency (LEPC) notification list, arrangements with local hospitals and contractors, and plan review/update history. Required by 40 CFR 265 Subpart D. Managed in Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` (
    `waste_minimization_activity_id` BIGINT COMMENT 'Unique identifier for the waste minimization activity record.',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_initiative. Business justification: Waste minimization activities are carbon reduction initiatives. Source reduction prevents upstream manufacturing emissions (Scope 3 Category 1). Tracked as sustainability initiatives for SBTi target a',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Reference to the generator site where the waste minimization activity was implemented.',
    `rcra_biennial_report_id` BIGINT COMMENT 'Foreign key linking to hazmat.rcra_biennial_report. Business justification: Waste minimization activity has biennial_report_year (int) but no FK to rcra_biennial_report. Adding FK provides traceability to the specific biennial report where this activity is reported. Remove bi',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Waste minimization activities fulfill RCRA requirements (42 USC 6922(b)) and state program mandates. Links minimization efforts to specific regulatory obligations for biennial reporting, compliance de',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Waste minimization activities target specific waste streams characterized by waste profiles. One activity targets one waste stream. This links the minimization activity to the waste profile it targets',
    `activity_description` STRING COMMENT 'Detailed narrative description of the waste minimization activity, including technical approach and operational changes.',
    `activity_number` STRING COMMENT 'Business identifier for the waste minimization activity, used for tracking and reporting purposes.. Valid values are `^WMA-[0-9]{6,10}$`',
    `activity_status` STRING COMMENT 'Current lifecycle status of the waste minimization activity.. Valid values are `planned|in_progress|implemented|verified|cancelled|suspended`',
    `activity_type` STRING COMMENT 'Classification of the waste minimization activity per RCRA waste minimization program categories.. Valid values are `source_reduction|recycling|treatment_substitution|process_modification|material_substitution|inventory_control`',
    `actual_reduction_percentage` DECIMAL(18,2) COMMENT 'Actual measured percentage reduction in waste generation from baseline after implementation.',
    `actual_reduction_quantity` DECIMAL(18,2) COMMENT 'Actual measured quantity of waste reduction achieved after implementation.',
    `annual_cost_savings` DECIMAL(18,2) COMMENT 'Estimated or actual annual cost savings achieved through waste reduction, including disposal cost avoidance and material savings.',
    `approval_date` DATE COMMENT 'Date when the waste minimization activity was approved for implementation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory or management approval was required before implementing this activity.',
    `approved_by_name` STRING COMMENT 'Name of the person or authority who approved the waste minimization activity.',
    `baseline_generation_quantity` DECIMAL(18,2) COMMENT 'Baseline quantity of hazardous waste generated before implementation of the minimization activity.',
    `baseline_measurement_period_end` DATE COMMENT 'End date of the period used to establish the baseline generation quantity.',
    `baseline_measurement_period_start` DATE COMMENT 'Start date of the period used to establish the baseline generation quantity.',
    `baseline_unit_of_measure` STRING COMMENT 'Unit of measure for the baseline generation quantity.. Valid values are `tons|pounds|kilograms|gallons|liters|cubic_yards`',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether this activity satisfies RCRA waste minimization certification requirements for the biennial report.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the implementation cost.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste minimization activity record was first created in the system.',
    `ghg_reduction_co2e_tons` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions reduction achieved through this waste minimization activity, expressed in CO2 equivalent tons.',
    `implementation_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to implement the waste minimization activity, including capital and operational expenses.',
    `implementation_date` DATE COMMENT 'Date when the waste minimization activity was fully implemented at the generator site.',
    `material_substitution_details` STRING COMMENT 'Details of any hazardous materials substituted with less hazardous or non-hazardous alternatives.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste minimization activity record was last modified in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the waste minimization activity.',
    `payback_period_months` STRING COMMENT 'Calculated payback period in months for the implementation cost based on annual cost savings.',
    `process_modification_details` STRING COMMENT 'Specific details of any process modifications made as part of the waste minimization activity.',
    `projected_reduction_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage reduction in waste generation from baseline after implementing this activity.',
    `projected_reduction_quantity` DECIMAL(18,2) COMMENT 'Estimated quantity of waste reduction expected from implementing this activity.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period for which this waste minimization activity is being reported.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period for which this waste minimization activity is being reported.',
    `responsible_person_name` STRING COMMENT 'Name of the person responsible for implementing and managing the waste minimization activity.',
    `responsible_person_title` STRING COMMENT 'Job title of the person responsible for the waste minimization activity.',
    `sustainability_reporting_flag` BOOLEAN COMMENT 'Indicates whether this activity is included in corporate sustainability reporting and disclosures.',
    `verification_date` DATE COMMENT 'Date when the actual reduction results were verified and documented.',
    `verification_method` STRING COMMENT 'Method used to verify and measure the actual waste reduction achieved.',
    CONSTRAINT pk_waste_minimization_activity PRIMARY KEY(`waste_minimization_activity_id`)
) COMMENT 'Record of source reduction and waste minimization activities implemented at generator sites per RCRA waste minimization program requirements. Captures activity type (source reduction, recycling, treatment substitution), implementation date, target waste stream and waste code, baseline generation quantity, projected reduction quantity, actual reduction achieved, cost savings, and reporting period. Feeds into RCRA Biennial Report waste minimization certification and corporate sustainability reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`exception_report` (
    `exception_report_id` BIGINT COMMENT 'Unique identifier for the RCRA exception report. Primary key.',
    `epa_id_registration_id` BIGINT COMMENT 'The 12-character EPA identification number of the designated TSDF that failed to return the signed manifest copy within the required timeframe.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Exception reports track generator contact for manifest discrepancy resolution per 40 CFR 262.42. Links to employee record enables accurate contact routing, tracks follow-up actions by responsible part',
    `generator_epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Exception report tracks generator EPA ID as a string. This should be normalized to FK to epa_id_registration. Labeled FK (generator_epa_id_registration_id) distinguishes this from TSDF. Remove generat',
    `manifest_id` BIGINT COMMENT 'Reference to the original hazardous waste manifest that triggered this exception report.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Exception reports (40 CFR 262.42) are regulatory submissions required when manifests are not returned. Links exception reporting to submission tracking for deadline compliance and agency acknowledgmen',
    `waste_shipment_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_shipment. Business justification: Exception reports are filed when shipments have discrepancies (manifest not returned, quantity discrepancies, etc.). This links the exception report to the specific shipment that triggered the excepti',
    `certification_date` DATE COMMENT 'The date the exception report was certified and signed by the authorized generator official.',
    `certification_statement` STRING COMMENT 'The regulatory certification statement signed by the generator representative attesting to the accuracy of the exception report.',
    `certifying_official_name` STRING COMMENT 'Name of the authorized generator official who certified and signed the exception report.',
    `certifying_official_title` STRING COMMENT 'Job title of the authorized generator official who certified the exception report.',
    `contact_attempts_count` STRING COMMENT 'Number of documented attempts made by the generator to contact the TSDF regarding the missing signed manifest.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this exception report record was first created in the system.',
    `due_date` DATE COMMENT 'The regulatory deadline by which the generator must file the exception report if the signed manifest is not received.',
    `epa_waste_codes` STRING COMMENT 'Comma-separated list of EPA hazardous waste codes (e.g., D001, F005) applicable to the waste shipment covered by this exception report.',
    `exception_type` STRING COMMENT 'The type of exception being reported: manifest not received within timeframe, unresolved discrepancy, or waste rejection by TSDF.. Valid values are `manifest_not_received|discrepancy_unresolved|rejection_by_tsdf`',
    `expected_return_date` DATE COMMENT 'The date by which the generator expected to receive the signed manifest copy from the TSDF (35 days for domestic, 45 days for international shipments).',
    `follow_up_actions_taken` STRING COMMENT 'Description of the actions taken by the generator to contact the TSDF and attempt to obtain the signed manifest copy before filing the exception report.',
    `generator_contact_email` STRING COMMENT 'Email address of the generator representative who filed the exception report.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `generator_contact_phone` STRING COMMENT 'Phone number of the generator representative who filed the exception report.',
    `generator_name` STRING COMMENT 'Legal name of the hazardous waste generator who filed the exception report.',
    `last_contact_date` DATE COMMENT 'The date of the most recent contact attempt with the TSDF before filing the exception report.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this exception report record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the exception report, follow-up actions, or resolution.',
    `regulatory_action_description` STRING COMMENT 'Description of any enforcement or corrective action taken by the regulatory authority in response to this exception report.',
    `regulatory_action_required` BOOLEAN COMMENT 'Indicates whether the regulatory authority determined that enforcement or corrective action was required based on this exception report.',
    `regulatory_authority` STRING COMMENT 'Indicates whether the exception report was filed with EPA federal program or a state-authorized RCRA program.. Valid values are `epa_federal|state_authorized_program`',
    `resolution_date` DATE COMMENT 'The date the exception was resolved (e.g., signed manifest finally received, regulatory investigation concluded).',
    `resolution_status` STRING COMMENT 'Current status of the exception report resolution process.. Valid values are `open|pending_tsdf_response|manifest_received|regulatory_investigation|closed`',
    `shipment_date` DATE COMMENT 'The date the hazardous waste shipment left the generator site, marking the start of the manifest return timeframe.',
    `shipment_type` STRING COMMENT 'Indicates whether the shipment was domestic (35-day rule) or international (45-day rule) for determining exception report deadline.. Valid values are `domestic|international`',
    `source_system` STRING COMMENT 'The system of record from which this exception report data was sourced (Enviance EHS, SAP EHS, RCRAInfo, or manual entry).. Valid values are `enviance_ehs|sap_ehs|rcrainfo|manual_entry`',
    `state_agency_code` STRING COMMENT 'Two-letter state code of the regulatory agency receiving the exception report, if submitted to a state-authorized program.. Valid values are `^[A-Z]{2}$`',
    `total_quantity` DECIMAL(18,2) COMMENT 'The total quantity of hazardous waste shipped under the manifest for which the exception report is filed.',
    `tsdf_name` STRING COMMENT 'Name of the designated treatment, storage, or disposal facility that was expected to return the signed manifest.',
    `tsdf_response` STRING COMMENT 'Summary of any response received from the TSDF during follow-up contact attempts.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the total waste quantity (e.g., tons, gallons, cubic yards). [ENUM-REF-CANDIDATE: tons|pounds|kilograms|gallons|liters|cubic_yards|cubic_meters — 7 candidates stripped; promote to reference product]',
    `waste_description` STRING COMMENT 'Description of the hazardous waste that was shipped under the manifest for which the exception report is being filed.',
    CONSTRAINT pk_exception_report PRIMARY KEY(`exception_report_id`)
) COMMENT 'RCRA exception report filed when a generator does not receive a signed copy of the manifest from the designated TSDF within 35 days (for domestic shipments) or 45 days (for international). Captures original manifest number, generator EPA ID, shipment date, TSDF name and EPA ID, exception report submission date, submission method (state agency, EPA), follow-up actions taken, and resolution status. Required by 40 CFR 262.42. Sourced from Enviance EHS and SAP EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` (
    `transporter_service_authorization_id` BIGINT COMMENT 'Unique identifier for the transporter service authorization record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to the service area where the transporter is authorized to operate',
    `transporter_registration_id` BIGINT COMMENT 'Foreign key linking to the hazardous waste transporter registration record',
    `authorization_date` DATE COMMENT 'Date when the transporter was authorized to operate in this service area. Used for compliance audit trails.',
    `authorization_status` STRING COMMENT 'Current status of the transporter authorization for this service area. Active authorizations allow the transporter to be selected on manifests for waste originating in this territory.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this authorization record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the authorization expires or was terminated. Null for active authorizations with no defined end date.',
    `effective_start_date` DATE COMMENT 'Date when the authorization becomes effective and the transporter can begin operations in this service area.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this authorization record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this authorization record was last updated.',
    `last_used_date` DATE COMMENT 'Date when this transporter was last used for a shipment originating in this service area. Used for performance tracking and vendor relationship management.',
    `priority_rank` STRING COMMENT 'Preferred selection priority for this transporter in this service area. Lower numbers indicate higher priority. Used for automated transporter assignment on manifests.',
    `rate_schedule_reference` STRING COMMENT 'Reference to the rate schedule or pricing agreement applicable to this transporter in this service area. Rates may vary by geography due to distance, regulatory complexity, or competitive factors.',
    `service_level_agreement` STRING COMMENT 'Reference to the service level agreement governing transporter performance expectations for this service area (response times, pickup windows, documentation requirements).',
    `created_by` STRING COMMENT 'User ID or system identifier that created this authorization record.',
    CONSTRAINT pk_transporter_service_authorization PRIMARY KEY(`transporter_service_authorization_id`)
) COMMENT 'This association product represents the authorization contract between a hazardous waste transporter and a service area. It captures the regulatory and operational authorization for a specific transporter to operate within a specific geographic service territory. Each record links one transporter_registration to one service_area with authorization status, effective dates, service level agreements, and rate schedules that exist only in the context of this transporter-area relationship.. Existence Justification: In waste management operations, a single hazardous waste transporter can be authorized to operate across multiple geographic service areas (different municipalities, counties, or franchise territories), and each service area requires authorization from multiple transporters to ensure operational redundancy, competitive pricing, and service continuity. The business actively manages these authorizations as regulatory compliance artifacts, tracking authorization status, effective dates, service level agreements, and area-specific rate schedules for each transporter-area combination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_alternate_facility_epa_epa_id_registration_id` FOREIGN KEY (`alternate_facility_epa_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_generator_epa_id_registration_id` FOREIGN KEY (`generator_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_transporter_2_epa_epa_id_registration_id` FOREIGN KEY (`transporter_2_epa_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_tsdf_epa_epa_id_registration_id` FOREIGN KEY (`tsdf_epa_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ADD CONSTRAINT `fk_hazmat_manifest_line_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ADD CONSTRAINT `fk_hazmat_manifest_line_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ADD CONSTRAINT `fk_hazmat_manifest_line_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ADD CONSTRAINT `fk_hazmat_manifest_line_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_generator_epa_id_registration_id` FOREIGN KEY (`generator_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_manifest_line_id` FOREIGN KEY (`manifest_line_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest_line`(`manifest_line_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `waste_management_ecm`.`hazmat`.`service_order`(`service_order_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_tsdf_epa_epa_id_registration_id` FOREIGN KEY (`tsdf_epa_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_generator_epa_id_registration_id` FOREIGN KEY (`generator_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `waste_management_ecm`.`hazmat`.`service_order`(`service_order_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_transporter_epa_epa_id_registration_id` FOREIGN KEY (`transporter_epa_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_hazmat_container_id` FOREIGN KEY (`hazmat_container_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazmat_container`(`hazmat_container_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_transferring_party_epa_id_registration_id` FOREIGN KEY (`transferring_party_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_waste_shipment_id` FOREIGN KEY (`waste_shipment_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_shipment`(`waste_shipment_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ADD CONSTRAINT `fk_hazmat_tclp_test_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ADD CONSTRAINT `fk_hazmat_tclp_test_hazmat_container_id` FOREIGN KEY (`hazmat_container_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazmat_container`(`hazmat_container_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ADD CONSTRAINT `fk_hazmat_tclp_test_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ADD CONSTRAINT `fk_hazmat_tclp_test_original_test_tclp_test_id` FOREIGN KEY (`original_test_tclp_test_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tclp_test`(`tclp_test_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ADD CONSTRAINT `fk_hazmat_tclp_test_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ADD CONSTRAINT `fk_hazmat_tclp_test_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_disposal_record_id` FOREIGN KEY (`disposal_record_id`) REFERENCES `waste_management_ecm`.`hazmat`.`disposal_record`(`disposal_record_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_tclp_test_id` FOREIGN KEY (`tclp_test_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tclp_test`(`tclp_test_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_transporter_epa_epa_id_registration_id` FOREIGN KEY (`transporter_epa_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_treatment_facility_epa_id_registration_id` FOREIGN KEY (`treatment_facility_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_storage_unit_id` FOREIGN KEY (`storage_unit_id`) REFERENCES `waste_management_ecm`.`hazmat`.`storage_unit`(`storage_unit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_generator_epa_id_registration_id` FOREIGN KEY (`generator_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_storage_unit_id` FOREIGN KEY (`storage_unit_id`) REFERENCES `waste_management_ecm`.`hazmat`.`storage_unit`(`storage_unit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_transporter_epa_epa_id_registration_id` FOREIGN KEY (`transporter_epa_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_generator_epa_id_registration_id` FOREIGN KEY (`generator_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ADD CONSTRAINT `fk_hazmat_hazwoper_training_previous_training_hazwoper_training_id` FOREIGN KEY (`previous_training_hazwoper_training_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazwoper_training`(`hazwoper_training_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ADD CONSTRAINT `fk_hazmat_hazwoper_training_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_contingency_plan_id` FOREIGN KEY (`contingency_plan_id`) REFERENCES `waste_management_ecm`.`hazmat`.`contingency_plan`(`contingency_plan_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_hazmat_container_id` FOREIGN KEY (`hazmat_container_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazmat_container`(`hazmat_container_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_waste_shipment_id` FOREIGN KEY (`waste_shipment_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_shipment`(`waste_shipment_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ADD CONSTRAINT `fk_hazmat_land_disposal_restriction_disposal_record_id` FOREIGN KEY (`disposal_record_id`) REFERENCES `waste_management_ecm`.`hazmat`.`disposal_record`(`disposal_record_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ADD CONSTRAINT `fk_hazmat_land_disposal_restriction_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ADD CONSTRAINT `fk_hazmat_land_disposal_restriction_generator_epa_id_registration_id` FOREIGN KEY (`generator_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ADD CONSTRAINT `fk_hazmat_land_disposal_restriction_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ADD CONSTRAINT `fk_hazmat_land_disposal_restriction_treatment_record_id` FOREIGN KEY (`treatment_record_id`) REFERENCES `waste_management_ecm`.`hazmat`.`treatment_record`(`treatment_record_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ADD CONSTRAINT `fk_hazmat_land_disposal_restriction_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ADD CONSTRAINT `fk_hazmat_storage_unit_inspection_storage_unit_id` FOREIGN KEY (`storage_unit_id`) REFERENCES `waste_management_ecm`.`hazmat`.`storage_unit`(`storage_unit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ADD CONSTRAINT `fk_hazmat_storage_unit_inspection_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ADD CONSTRAINT `fk_hazmat_transporter_registration_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ADD CONSTRAINT `fk_hazmat_contingency_plan_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ADD CONSTRAINT `fk_hazmat_waste_minimization_activity_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ADD CONSTRAINT `fk_hazmat_waste_minimization_activity_rcra_biennial_report_id` FOREIGN KEY (`rcra_biennial_report_id`) REFERENCES `waste_management_ecm`.`hazmat`.`rcra_biennial_report`(`rcra_biennial_report_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ADD CONSTRAINT `fk_hazmat_waste_minimization_activity_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ADD CONSTRAINT `fk_hazmat_exception_report_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ADD CONSTRAINT `fk_hazmat_exception_report_generator_epa_id_registration_id` FOREIGN KEY (`generator_epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ADD CONSTRAINT `fk_hazmat_exception_report_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ADD CONSTRAINT `fk_hazmat_exception_report_waste_shipment_id` FOREIGN KEY (`waste_shipment_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_shipment`(`waste_shipment_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ADD CONSTRAINT `fk_hazmat_transporter_service_authorization_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`hazmat` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `waste_management_ecm`.`hazmat` SET TAGS ('dbx_domain' = 'hazmat');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Official Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `tracked_site_id` SET TAGS ('dbx_business_glossary_term' = 'Tracked Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `accumulation_start_date_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Accumulation Start Date Time Limit (Days)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `biennial_report_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Biennial Report Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|minor_violation|significant_violation|enforcement_action|consent_decree');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `contingency_plan_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan Last Updated Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `contingency_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan Document Reference');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Contact Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `enforcement_action_count` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `federal_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Facility Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `generator_category` SET TAGS ('dbx_business_glossary_term' = 'Generator Category Classification');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `generator_category` SET TAGS ('dbx_value_regex' = 'LQG|SQG|VSQG|CESQG');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `generator_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Generator Legal Business Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `generator_legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `generator_status` SET TAGS ('dbx_business_glossary_term' = 'Generator Registration Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `generator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deregistered|pending');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `initial_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Initial EPA Notification Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `inspection_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Frequency (Months)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `last_biennial_report_year` SET TAGS ('dbx_business_glossary_term' = 'Last Biennial Report Submission Year');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `last_notification_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Notification Update Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Site Latitude Coordinate');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Site Longitude Coordinate');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `mailing_address` SET TAGS ('dbx_business_glossary_term' = 'Generator Mailing Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `mailing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `mailing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Job Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_city` SET TAGS ('dbx_business_glossary_term' = 'Generator Site City');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_county` SET TAGS ('dbx_business_glossary_term' = 'Generator Site County');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_state` SET TAGS ('dbx_business_glossary_term' = 'Generator Site State Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_street_address` SET TAGS ('dbx_business_glossary_term' = 'Generator Site Street Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Generator Site ZIP Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `site_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `state_generator_code` SET TAGS ('dbx_business_glossary_term' = 'State Generator Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ALTER COLUMN `waste_minimization_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Minimization Plan Exists Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `tsdf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Approved TSDF (Treatment Storage and Disposal Facility) Facility ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Generator ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `ppe_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Ppe Issuance Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Service Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `annual_quantity_estimate_tons` SET TAGS ('dbx_business_glossary_term' = 'Annual Quantity Estimate (Tons)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Approval Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|suspended|expired');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `constituents_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Constituents of Concern');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `container_type_approved` SET TAGS ('dbx_business_glossary_term' = 'Container Type Approved');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'DOT (Department of Transportation) Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `emergency_response_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Procedure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `epa_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `flash_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Celsius)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `is_corrosive` SET TAGS ('dbx_business_glossary_term' = 'Corrosive Waste Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `is_ignitable` SET TAGS ('dbx_business_glossary_term' = 'Ignitable Waste Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `is_reactive` SET TAGS ('dbx_business_glossary_term' = 'Reactive Waste Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `is_toxic` SET TAGS ('dbx_business_glossary_term' = 'Toxic Waste Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `land_disposal_restricted` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restricted (LDR) Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `ldr_treatment_standards` SET TAGS ('dbx_business_glossary_term' = 'LDR (Land Disposal Restrictions) Treatment Standards');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `ldr_treatment_standards` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `ldr_treatment_standards` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profile Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|sludge|gas|semi_solid|powder');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'PPE (Personal Protective Equipment) Required');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `process_generating_waste` SET TAGS ('dbx_business_glossary_term' = 'Process Generating Waste');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `profile_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Effective Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `profile_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `profile_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `profile_number` SET TAGS ('dbx_value_regex' = '^WP-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `tclp_results_summary` SET TAGS ('dbx_business_glossary_term' = 'TCLP (Toxicity Characteristic Leaching Procedure) Results Summary');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `tclp_test_date` SET TAGS ('dbx_business_glossary_term' = 'TCLP (Toxicity Characteristic Leaching Procedure) Test Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `treatment_method_required` SET TAGS ('dbx_business_glossary_term' = 'Treatment Method Required');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `treatment_method_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `treatment_method_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `un_na_number` SET TAGS ('dbx_business_glossary_term' = 'UN/NA (United Nations/North America) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `un_na_number` SET TAGS ('dbx_value_regex' = '^(UN|NA)[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` SET TAGS ('dbx_subdomain' = 'transport_tracking');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `alternate_facility_epa_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Alternate Facility Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `alternate_facility_epa_epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter 1 Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Certifying Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `transporter_2_epa_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter 2 Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `transporter_2_epa_epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_epa_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_epa_epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Total Container Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `discrepancy_indication` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Indication Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_id_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_id_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$|^NA[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_packing_group` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Packing Group');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `dot_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Proper Shipping Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `epa_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Hazardous Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_city` SET TAGS ('dbx_business_glossary_term' = 'Generator City');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Generator Contact Person Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Generator Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_emergency_phone` SET TAGS ('dbx_business_glossary_term' = 'Generator Emergency Response Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_emergency_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_emergency_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_emergency_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_name` SET TAGS ('dbx_business_glossary_term' = 'Generator Facility Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Generator Signature Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_site_address` SET TAGS ('dbx_business_glossary_term' = 'Generator Site Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_state` SET TAGS ('dbx_business_glossary_term' = 'Generator State Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Generator ZIP Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `generator_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `import_indication` SET TAGS ('dbx_business_glossary_term' = 'Import Indication Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `import_port_of_entry` SET TAGS ('dbx_business_glossary_term' = 'Import Port of Entry');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `manifest_status` SET TAGS ('dbx_business_glossary_term' = 'Manifest Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `manifest_type` SET TAGS ('dbx_business_glossary_term' = 'Manifest Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `manifest_type` SET TAGS ('dbx_value_regex' = 'paper|electronic|hybrid');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Receipt Date at Treatment Storage and Disposal Facility (TSDF)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `rejection_indication` SET TAGS ('dbx_business_glossary_term' = 'Rejection Indication Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `residue_indication` SET TAGS ('dbx_business_glossary_term' = 'Residue Indication Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Tracking Number (MTN)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `transporter_1_name` SET TAGS ('dbx_business_glossary_term' = 'Transporter 1 Company Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `transporter_1_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `transporter_2_name` SET TAGS ('dbx_business_glossary_term' = 'Transporter 2 Company Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `transporter_2_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `transporter_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Transporter Signature Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_city` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) City');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Signature Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_site_address` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Site Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_state` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) State Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) ZIP Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `tsdf_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` SET TAGS ('dbx_subdomain' = 'transport_tracking');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `manifest_line_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Line Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `container_size` SET TAGS ('dbx_business_glossary_term' = 'Container Size');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'drum|tote|tank|cylinder|bag|box');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `discrepancy_comments` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Comments');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `discrepancy_indication` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Indication');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `discrepancy_indication` SET TAGS ('dbx_value_regex' = 'type|quantity|residue|none');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `dot_packing_group` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Packing Group');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `dot_packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `dot_proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Proper Shipping Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `epa_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `flash_point_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Fahrenheit)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `generator_comments` SET TAGS ('dbx_business_glossary_term' = 'Generator Comments');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_transit|received|discrepancy|rejected');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `management_method_code` SET TAGS ('dbx_business_glossary_term' = 'Management Method Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `marine_pollutant_flag` SET TAGS ('dbx_business_glossary_term' = 'Marine Pollutant Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `pcb_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Polychlorinated Biphenyl (PCB) Concentration (Parts Per Million)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|sludge|semi_solid');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `reportable_quantity_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable Quantity (RQ) Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `un_na_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations/North America (UN/NA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `un_na_number` SET TAGS ('dbx_value_regex' = '^(UN|NA)[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|liters|pounds|kilograms|tons|cubic_yards');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest_line` ALTER COLUMN `waste_minimization_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Minimization Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` SET TAGS ('dbx_subdomain' = 'storage_operations');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `hazmat_container_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Container Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `generator_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Jha Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `manifest_line_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Service Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Facility Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `tsdf_epa_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `tsdf_epa_epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `accumulation_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Accumulation Deadline Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `accumulation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accumulation Start Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Container Capacity in Gallons');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'at_generator|with_transporter|at_tsdf|disposed');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Container Physical Condition');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'good|fair|damaged|leaking|corroded');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `container_status` SET TAGS ('dbx_business_glossary_term' = 'Container Lifecycle Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `container_status` SET TAGS ('dbx_value_regex' = 'empty|accumulating|full|in_transit|at_tsdf|disposed');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'drum_55_gallon|drum_30_gallon|tote_ibc|lab_pack|roll_off|bulk_tank');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|fuel_blending|recycling|stabilization|neutralization');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `dot_packing_group` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Packing Group');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `dot_packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `dot_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Proper Shipping Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `dot_un_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) United Nations (UN) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `dot_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `epa_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `epa_waste_codes` SET TAGS ('dbx_value_regex' = '^[DFKPU][0-9]{3}(,[DFKPU][0-9]{3})*$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `fill_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Container Fill Level Percentage');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `gross_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Pounds');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `identification_number` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `identification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `label_affixed_date` SET TAGS ('dbx_business_glossary_term' = 'Container Label Affixed Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `material_of_construction` SET TAGS ('dbx_business_glossary_term' = 'Container Material of Construction');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `material_of_construction` SET TAGS ('dbx_value_regex' = 'steel|polyethylene|fiberglass|stainless_steel|composite');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `net_waste_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Net Waste Weight in Pounds');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `secondary_containment_required` SET TAGS ('dbx_business_glossary_term' = 'Secondary Containment Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_ehs|amcs|enviance|waste_logics');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_value_regex' = 'satellite|ninety_day_area|permitted_storage|tsdf_storage');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `tare_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight in Pounds');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `un_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Performance Rating');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ALTER COLUMN `un_performance_rating` SET TAGS ('dbx_value_regex' = '^UN[0-9]{1,2}[A-Z][0-9]{1,2}(/[A-Z])?(/[0-9]{2,4})?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `tsdf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Facility ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emergency_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `tracked_site_id` SET TAGS ('dbx_business_glossary_term' = 'Tracked Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `accepts_bulk_waste` SET TAGS ('dbx_business_glossary_term' = 'Accepts Bulk Waste Indicator');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `accepts_containerized_waste` SET TAGS ('dbx_business_glossary_term' = 'Accepts Containerized Waste Indicator');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Country Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `disposal_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Maximum Disposal Capacity in Tons');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emergency_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Full Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emergency_coordinator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emergency_coordinator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emergency_coordinator_title` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Job Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Emergency Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'TSDF Facility Operational Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_closure|post_closure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'TSDF Facility Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Amount in USD');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `financial_assurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `financial_assurance_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Mechanism Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `financial_assurance_mechanism` SET TAGS ('dbx_value_regex' = 'trust_fund|surety_bond|letter_of_credit|insurance|financial_test|corporate_guarantee');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'compliant|minor_violations|major_violations|enforcement_action');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `liability_insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Certificate Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `liability_insurance_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `liability_insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `manifest_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Manifest Designation Approval Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `manifest_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|suspended|revoked|conditional');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Facility Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Facility Operating Hours');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `permitted_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Permitted Hazardous Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `storage_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Capacity in Tons');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `treatment_methods` SET TAGS ('dbx_business_glossary_term' = 'Permitted Treatment Methods');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `treatment_methods` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `treatment_methods` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `vendor_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Rating');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ALTER COLUMN `vendor_rating` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|suspended');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` SET TAGS ('dbx_subdomain' = 'transport_tracking');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `waste_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Treatment Storage and Disposal Facility (TSDF) Environmental Protection Agency (EPA) ID Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `fleet_fuel_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Fuel Consumption Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `generator_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Site ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Service Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `transporter_epa_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Environmental Protection Agency (EPA) ID Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `transporter_epa_epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `tsdf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Treatment Storage and Disposal Facility (TSDF) ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `actual_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `actual_transit_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Transit Hours');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `billing_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Billing Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^BOL-[A-Z0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Verified');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `dot_placard_codes` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Placard Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `dot_placard_required` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Placard Required');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_business_glossary_term' = 'Driver Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `emergency_response_guide_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Guide (ERG) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `emergency_response_guide_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `estimated_transit_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Hours');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `exception_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Reported Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Enabled');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `route_deviation_detected` SET TAGS ('dbx_business_glossary_term' = 'Route Deviation Detected');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `route_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Route Restrictions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `scheduled_pickup_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Pickup Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `shipment_notes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'scheduled|dispatched|in_transit|delivered|exception|cancelled');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `total_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `vehicle_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Unit Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ALTER COLUMN `vehicle_unit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` SET TAGS ('dbx_subdomain' = 'transport_tracking');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `chain_of_custody_id` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Environmental Protection Agency (EPA) ID Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `hazmat_container_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Manifest ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transferring_party_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transferring Party Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `waste_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Witness Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `discrepancy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Indicator');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'quantity_variance|container_count_mismatch|container_damage|labeling_error|documentation_error|none');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `dot_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Proper Shipping Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `emergency_response_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `emergency_response_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `emergency_response_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|lbs|gallons|liters|cubic_yards|tons');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `receiving_party_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Contact Person Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `receiving_party_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `receiving_party_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `receiving_party_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Legal Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `receiving_party_signature` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Signature');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `receiving_party_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `receiving_party_signature` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_event_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Event Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_event_type` SET TAGS ('dbx_value_regex' = 'generator_handoff|transporter_receipt|transporter_transfer|tsdf_acceptance|treatment_completion|disposal_confirmation');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_address` SET TAGS ('dbx_business_glossary_term' = 'Transfer Location Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_city` SET TAGS ('dbx_business_glossary_term' = 'Transfer Location City');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Transfer Location Latitude');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Transfer Location Longitude');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_name` SET TAGS ('dbx_business_glossary_term' = 'Transfer Location Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Location Postal Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_state` SET TAGS ('dbx_business_glossary_term' = 'Transfer Location State');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_location_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Sequence Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transferring_party_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Transferring Party Contact Person Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transferring_party_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transferring_party_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transferring_party_name` SET TAGS ('dbx_business_glossary_term' = 'Transferring Party Legal Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transferring_party_signature` SET TAGS ('dbx_business_glossary_term' = 'Transferring Party Signature');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transferring_party_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `transferring_party_signature` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `un_identification_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `un_identification_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `waste_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Waste Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `waste_code` SET TAGS ('dbx_value_regex' = '^[DFKPU][0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `witness_signature` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `witness_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ALTER COLUMN `witness_signature` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `tclp_test_id` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Leaching Procedure (TCLP) Test ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `hazmat_container_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `original_test_tclp_test_id` SET TAGS ('dbx_business_glossary_term' = 'Original TCLP Test ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `analyte_group` SET TAGS ('dbx_business_glossary_term' = 'Analyte Group Tested');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `analyte_group` SET TAGS ('dbx_value_regex' = 'metals|volatile organics|semi-volatile organics|pesticides|herbicides|full suite');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `arsenic_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Arsenic Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `assigned_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Assigned RCRA Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `barium_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Barium Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `benzene_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Benzene Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `cadmium_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Cadmium Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `certifying_chemist_license` SET TAGS ('dbx_business_glossary_term' = 'Certifying Chemist License Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `certifying_chemist_license` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `certifying_chemist_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Chemist Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain-of-Custody (COC) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_value_regex' = '^COC-[A-Z0-9]{8,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `chromium_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Chromium Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `detection_limit_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `extraction_fluid` SET TAGS ('dbx_business_glossary_term' = 'TCLP Extraction Fluid Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `extraction_fluid` SET TAGS ('dbx_value_regex' = 'Fluid #1|Fluid #2');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `laboratory_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Certification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `laboratory_certification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `lead_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Lead Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `mercury_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Mercury Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `overall_pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Overall Test Pass/Fail Determination');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `overall_pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `qa_qc_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance/Quality Control (QA/QC) Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `qa_qc_flag` SET TAGS ('dbx_value_regex' = 'passed|failed|qualified');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `qa_qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance/Quality Control (QA/QC) Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Report Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Report Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `sample_collection_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `sample_received_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Receipt Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `selenium_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Selenium Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `silver_result_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Silver Concentration Result (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method Designation');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'SW-846 Method 1311|EPA Method 1311');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'pending|in progress|completed|cancelled|on hold');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `waste_matrix_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Matrix Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ALTER COLUMN `waste_matrix_type` SET TAGS ('dbx_value_regex' = 'solid|liquid|sludge|multi-phase');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_record_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Record Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_record_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `tclp_test_id` SET TAGS ('dbx_business_glossary_term' = 'Tclp Test Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `transporter_epa_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `transporter_epa_epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_facility_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Facility Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_facility_epa_id_registration_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_facility_epa_id_registration_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Facility Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `storage_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Unit Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `storage_unit_id` SET TAGS ('dbx_value_regex' = '^TU-[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `storage_unit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `storage_unit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^BOL-[A-Z0-9]{10,20}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `disposal_method_code` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `emergency_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `emission_control_system_code` SET TAGS ('dbx_business_glossary_term' = 'Emission Control System Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `emission_control_system_code` SET TAGS ('dbx_value_regex' = '^ECS-[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `input_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Input Quantity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `input_quantity_unit` SET TAGS ('dbx_value_regex' = 'KG|LB|GAL|L|TON|MT');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `input_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Input Hazardous Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `input_waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Input Waste Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `ldr_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restrictions (LDR) Compliance Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `ldr_compliance_status` SET TAGS ('dbx_value_regex' = 'COMPLIANT|NON_COMPLIANT|EXEMPT|PENDING_ANALYSIS');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Operation Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `operator_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `operator_certification_number` SET TAGS ('dbx_value_regex' = '^OC-[A-Z0-9]{8,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `output_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Output Quantity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `output_quantity_unit` SET TAGS ('dbx_value_regex' = 'KG|LB|GAL|L|TON|MT');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `output_residual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Output Residual Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `output_waste_characterization` SET TAGS ('dbx_business_glossary_term' = 'Output Waste Characterization');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Treatment Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `quality_assurance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `quality_assurance_review_status` SET TAGS ('dbx_value_regex' = 'APPROVED|REJECTED|PENDING_REVIEW|NOT_REQUIRED');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `regulatory_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Unit Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `regulatory_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{3}[A-Z]$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `residence_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Residence Time in Minutes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_EHS|ENVIANCE|MANUAL_ENTRY|SCADA|LIMS');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `stack_emission_test_result` SET TAGS ('dbx_business_glossary_term' = 'Stack Emission Test Result');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `stack_emission_test_result` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|NOT_TESTED');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `tclp_test_performed` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Leaching Procedure (TCLP) Test Performed');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `tclp_test_result` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Leaching Procedure (TCLP) Test Result');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `tclp_test_result` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|NOT_APPLICABLE|PENDING');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Treatment Batch Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_batch_number` SET TAGS ('dbx_value_regex' = '^TB-[0-9]{8}-[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_batch_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_batch_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Treatment Cost in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_date` SET TAGS ('dbx_business_glossary_term' = 'Treatment Operation Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Treatment Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_efficiency_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_efficiency_percent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Treatment End Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_end_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_end_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_ph_level` SET TAGS ('dbx_business_glossary_term' = 'Treatment pH Level');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_ph_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_ph_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Treatment Start Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_start_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_start_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Treatment Operation Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'COMPLETED|IN_PROGRESS|FAILED|ABORTED|PENDING_VERIFICATION');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technology Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Treatment Temperature in Celsius');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_temperature_celsius` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ALTER COLUMN `treatment_temperature_celsius` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Record Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cell Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Environmental Protection Agency (EPA) Identification (ID) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `generator_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `storage_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Unit Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `transporter_epa_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Environmental Protection Agency (EPA) Identification (ID) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `transporter_epa_epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `tsdf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Tsdf Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `certificate_of_disposal_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Disposal Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `discrepancy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Indicator');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposal Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost Amount');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost Currency');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_method_code` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_method_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_method_description` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_status` SET TAGS ('dbx_business_glossary_term' = 'Disposal Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `disposal_status` SET TAGS ('dbx_value_regex' = 'pending|completed|certified|rejected|under_review');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `emergency_response_required` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Required');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `ldr_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restriction (LDR) Certification Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `ldr_compliance_certified` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restriction (LDR) Compliance Certified');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `ldr_treatment_method` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restriction (LDR) Treatment Method');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `ldr_treatment_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `ldr_treatment_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disposal Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `regulatory_report_submitted` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `tsdf_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Signature Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `tsdf_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Signature Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `tsdf_signature_title` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Signature Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `waste_code_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `waste_code_primary` SET TAGS ('dbx_value_regex' = '^[DFKPU][0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `waste_codes_additional` SET TAGS ('dbx_business_glossary_term' = 'Additional Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `waste_quantity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity in Pounds (lbs)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `waste_quantity_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity in Tons');
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ALTER COLUMN `waste_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Waste Volume in Gallons');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` SET TAGS ('dbx_subdomain' = 'transport_tracking');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Service Order Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Vehicle Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Lead Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `fleet_fuel_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Fuel Consumption Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `generator_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Jha Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Meeting Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Service Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Amount');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `actual_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `actual_waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Waste Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Service Completion Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `emergency_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `epa_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `estimated_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `estimated_waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Waste Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Placement Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Service Order Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'per_drum|per_pound|per_gallon|per_trip|per_hour|flat_rate');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `quoted_amount` SET TAGS ('dbx_business_glossary_term' = 'Quoted Service Amount');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `requested_service_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `safety_briefing_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Briefing Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `scheduled_service_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Service Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `service_notes` SET TAGS ('dbx_business_glossary_term' = 'Service Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Service Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Material Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) ID Registration ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `authorized_state_program` SET TAGS ('dbx_business_glossary_term' = 'Authorized State RCRA (Resource Conservation and Recovery Act) Program');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `epa_id_number` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `epa_id_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `epa_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `epa_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Facility Contact Email Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Contact Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Facility Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `facility_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `generator_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator Classification');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `generator_classification` SET TAGS ('dbx_value_regex' = 'lqg|sqg|vsqg|cesqg|not_applicable');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `handler_status` SET TAGS ('dbx_business_glossary_term' = 'Handler Registration Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `handler_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|withdrawn|suspended');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `handler_type` SET TAGS ('dbx_business_glossary_term' = 'RCRA (Resource Conservation and Recovery Act) Handler Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `handler_type` SET TAGS ('dbx_value_regex' = 'generator|transporter|tsdf|mixed');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `is_generator` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Waste Generator');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `is_transporter` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Waste Transporter');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `is_tsdf` SET TAGS ('dbx_business_glossary_term' = 'Is TSDF (Treatment Storage and Disposal Facility)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Site Latitude');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `location_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Location Verification Method');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `location_verification_method` SET TAGS ('dbx_value_regex' = 'gps|address_geocoding|survey|map_interpolation');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Site Longitude');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'NAICS (North American Industry Classification System) Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `notification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Effective Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `notification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'RCRA (Resource Conservation and Recovery Act) Notification Submission Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'RCRA (Resource Conservation and Recovery Act) Notification Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'initial|subsequent|amendment|withdrawal');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `owner_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Owner or Operator Legal Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `owner_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `owner_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `owner_operator_type` SET TAGS ('dbx_business_glossary_term' = 'Owner or Operator Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `owner_operator_type` SET TAGS ('dbx_value_regex' = 'private|public|federal|state|municipal');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `rcrainfo_last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RCRAInfo Last Synchronization Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `rcrainfo_sync_status` SET TAGS ('dbx_business_glossary_term' = 'RCRAInfo Synchronization Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `rcrainfo_sync_status` SET TAGS ('dbx_value_regex' = 'synced|pending|failed|not_synced');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `registration_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'SIC (Standard Industrial Classification) Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 1');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 2');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_city` SET TAGS ('dbx_business_glossary_term' = 'Site City');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_country_code` SET TAGS ('dbx_business_glossary_term' = 'Site Country Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_county` SET TAGS ('dbx_business_glossary_term' = 'Site County');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Regulated Site Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Site Postal Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_state_code` SET TAGS ('dbx_business_glossary_term' = 'Site State Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `site_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'enviance_ehs|sap_ehs|rcrainfo|manual_entry');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `state_agency_notification_date` SET TAGS ('dbx_business_glossary_term' = 'State Agency Notification Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `state_agency_notified` SET TAGS ('dbx_business_glossary_term' = 'State Environmental Agency Notified');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `state_id_number` SET TAGS ('dbx_business_glossary_term' = 'State Identification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `state_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ALTER COLUMN `state_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `rcra_biennial_report_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Biennial Report ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `certification_title` SET TAGS ('dbx_business_glossary_term' = 'Certification Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `generator_status` SET TAGS ('dbx_business_glossary_term' = 'Generator Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `generator_status` SET TAGS ('dbx_value_regex' = 'LQG|SQG|CESQG|VSQG');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `number_of_tsdf_destinations` SET TAGS ('dbx_business_glossary_term' = 'Number of Treatment Storage and Disposal Facility (TSDF) Destinations');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `number_of_waste_codes_reported` SET TAGS ('dbx_business_glossary_term' = 'Number of Waste Codes Reported');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `offsite_shipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Off-Site Shipment Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `onsite_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Site Treatment Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `onsite_treatment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `onsite_treatment_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `primary_treatment_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Treatment Method');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `primary_treatment_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `primary_treatment_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `primary_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `primary_waste_code` SET TAGS ('dbx_value_regex' = '^[DFKPU][0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `primary_waste_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Waste Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Enviance EHS|SAP EHS|Manual Entry');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `state_agency_code` SET TAGS ('dbx_business_glossary_term' = 'State Agency Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `state_agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `total_waste_generated_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Generated (Pounds)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `total_waste_managed_onsite_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Managed On-Site (Pounds)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `total_waste_shipped_offsite_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Shipped Off-Site (Pounds)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `waste_minimization_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Minimization Achieved Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ALTER COLUMN `waste_minimization_activities` SET TAGS ('dbx_business_glossary_term' = 'Waste Minimization Activities');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `hazwoper_training_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Operations and Emergency Response (HAZWOPER) Training ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `previous_training_hazwoper_training_id` SET TAGS ('dbx_business_glossary_term' = 'Previous HAZWOPER Training ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `safety_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Work Site Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `assessment_passed` SET TAGS ('dbx_business_glossary_term' = 'Assessment Passed Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `compliance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `compliance_verified_by` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified By');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `fit_test_date` SET TAGS ('dbx_business_glossary_term' = 'Respirator Fit Test Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `fit_test_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Respirator Fit Test Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `medical_surveillance_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Surveillance Clearance Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `medical_surveillance_clearance_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `medical_surveillance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Surveillance Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `medical_surveillance_expiration_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|approved|reimbursed|denied');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `renewal_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `supervisor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Approval Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Currency Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|blended|field_exercise|hands_on');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'current|expired|pending_renewal|suspended|revoked');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Training Topics Covered');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'HAZWOPER Training Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = '40_hour_initial|24_hour_initial|8_hour_refresher|supervisor_8_hour|first_responder_awareness|first_responder_operations');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `work_site_assignment` SET TAGS ('dbx_business_glossary_term' = 'Work Site Assignment');
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `emergency_response_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Incident ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `contingency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `emergency_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `hazmat_container_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Commander Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `regulatory_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `waste_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `cleanup_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Completion Date and Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `cleanup_contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Contractor Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `cleanup_contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `cleanup_contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `cleanup_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Start Date and Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `discovery_datetime` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date and Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Latitude');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Longitude');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `immediate_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Immediate Response Actions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Closure Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incident Date and Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|catastrophic');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|response_active|contained|remediation_in_progress|closed');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `injuries_reported` SET TAGS ('dbx_business_glossary_term' = 'Injuries Reported Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `injury_count` SET TAGS ('dbx_business_glossary_term' = 'Injury Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `lepc_notification_datetime` SET TAGS ('dbx_business_glossary_term' = 'LEPC (Local Emergency Planning Committee) Notification Date and Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `lepc_notified` SET TAGS ('dbx_business_glossary_term' = 'LEPC (Local Emergency Planning Committee) Notified Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'generator_site|tsdf_facility|in_transit|public_area|waterway');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `material_released` SET TAGS ('dbx_business_glossary_term' = 'Material Released');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `nrc_notification_datetime` SET TAGS ('dbx_business_glossary_term' = 'NRC (National Response Center) Notification Date and Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `nrc_report_number` SET TAGS ('dbx_business_glossary_term' = 'NRC (National Response Center) Report Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `nrc_report_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,10}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `regulatory_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Due Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `regulatory_report_submitted` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `release_pathway` SET TAGS ('dbx_business_glossary_term' = 'Release Pathway');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `release_pathway` SET TAGS ('dbx_value_regex' = 'air|surface_water|groundwater|soil|storm_drain|sewer');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `release_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `release_quantity_unit` SET TAGS ('dbx_value_regex' = 'gallons|liters|pounds|kilograms|tons|cubic_yards');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|ongoing_monitoring');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `root_cause_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Completed Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Site Postal Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `state_agency_notified` SET TAGS ('dbx_business_glossary_term' = 'State Agency Notified Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `state_notification_datetime` SET TAGS ('dbx_business_glossary_term' = 'State Notification Date and Time');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN (United Nations) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `waste_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ALTER COLUMN `waste_code` SET TAGS ('dbx_value_regex' = '^[DFKPU][0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `land_disposal_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restriction (LDR) ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Environmental Protection Agency (EPA) ID Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `generator_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_record_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_record_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `analytical_results` SET TAGS ('dbx_business_glossary_term' = 'Analytical Results');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Generator Certification Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Generator Certification Statement');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `certifying_official_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Signature Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `certifying_official_title` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restriction (LDR) Comments');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `dilution_prohibition_flag` SET TAGS ('dbx_business_glossary_term' = 'Dilution Prohibition Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `epa_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Hazardous Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `laboratory_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Certification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `ldr_notification_type` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restriction (LDR) Notification Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `ldr_notification_type` SET TAGS ('dbx_value_regex' = 'one_time|annual|waste_specific');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `no_migration_petition_number` SET TAGS ('dbx_business_glossary_term' = 'No-Migration Petition Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `prohibited_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `sample_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Analysis Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `storage_prohibition_flag` SET TAGS ('dbx_business_glossary_term' = 'Storage Prohibition Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Waste Subcategory');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_date` SET TAGS ('dbx_business_glossary_term' = 'Treatment Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Facility Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Standard Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Standard Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_type` SET TAGS ('dbx_business_glossary_term' = 'Land Disposal Restriction (LDR) Treatment Standard Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_type` SET TAGS ('dbx_value_regex' = 'concentration_based|technology_based');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `treatment_standard_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `tsdf_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Acknowledgment Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `uhc_treatment_standards` SET TAGS ('dbx_business_glossary_term' = 'Underlying Hazardous Constituent (UHC) Treatment Standards');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `uhc_treatment_standards` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `uhc_treatment_standards` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `underlying_hazardous_constituents` SET TAGS ('dbx_business_glossary_term' = 'Underlying Hazardous Constituents (UHCs)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `variance_or_exemption_number` SET TAGS ('dbx_business_glossary_term' = 'Variance or Exemption Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'wastewater|nonwastewater');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `waste_meets_treatment_standards_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Meets Treatment Standards Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `waste_meets_treatment_standards_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ALTER COLUMN `waste_meets_treatment_standards_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Code ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `acute_hazardous_flag` SET TAGS ('dbx_business_glossary_term' = 'Acute Hazardous Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `container_type_restriction` SET TAGS ('dbx_business_glossary_term' = 'Container Type Restriction');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `delisting_petition_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Delisting Petition Eligible Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `generator_accumulation_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Generator Accumulation Limit (Days)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `hazard_basis` SET TAGS ('dbx_business_glossary_term' = 'Hazard Basis');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `hazard_basis` SET TAGS ('dbx_value_regex' = 'ignitability|corrosivity|reactivity|toxicity|listed|multiple');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `prohibited_method_code` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Method Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `recycling_potential_flag` SET TAGS ('dbx_business_glossary_term' = 'Recycling Potential Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `reportable_quantity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Reportable Quantity (lbs)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `small_quantity_exclusion_kg` SET TAGS ('dbx_business_glossary_term' = 'Small Quantity Exclusion (kg)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `state_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `tclp_constituent` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Leaching Procedure (TCLP) Constituent');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `tclp_regulatory_level_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Leaching Procedure (TCLP) Regulatory Level (mg/L)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `toxicity_characteristic_flag` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `treatment_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Standard Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `treatment_standard_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `treatment_standard_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `treatment_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Treatment Subcategory');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `treatment_subcategory` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `treatment_subcategory` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `universal_treatment_standard` SET TAGS ('dbx_business_glossary_term' = 'Universal Treatment Standard (UTS)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `universal_treatment_standard` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `universal_treatment_standard` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `waste_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `waste_code` SET TAGS ('dbx_value_regex' = '^[DFKPU][0-9]{3}[A-Z]?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `waste_code_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Code Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `waste_code_type` SET TAGS ('dbx_value_regex' = 'D-listed|F-listed|K-listed|P-listed|U-listed|state-specific');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ALTER COLUMN `waste_minimization_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Minimization Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazardous Materials (HAZMAT) Classification ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `cargo_aircraft_quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Cargo Aircraft Only Quantity Limit');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `classification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Effective Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'active|superseded|withdrawn');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `erg_guide_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Guidebook (ERG) Guide Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `erg_guide_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `excepted_quantity_code` SET TAGS ('dbx_business_glossary_term' = 'Excepted Quantity Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `excepted_quantity_code` SET TAGS ('dbx_value_regex' = 'E[0-5]');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `exceptions` SET TAGS ('dbx_business_glossary_term' = 'Exceptions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `forbidden_cargo_aircraft` SET TAGS ('dbx_business_glossary_term' = 'Forbidden on Cargo Aircraft Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `forbidden_passenger_aircraft` SET TAGS ('dbx_business_glossary_term' = 'Forbidden on Passenger Aircraft Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `hazard_division` SET TAGS ('dbx_business_glossary_term' = 'Hazard Division');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `inhalation_hazard_zone` SET TAGS ('dbx_business_glossary_term' = 'Inhalation Hazard Zone');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `inhalation_hazard_zone` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `label_code` SET TAGS ('dbx_business_glossary_term' = 'Label Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `limited_quantity_eligible` SET TAGS ('dbx_business_glossary_term' = 'Limited Quantity Eligible Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `limited_quantity_max_net` SET TAGS ('dbx_business_glossary_term' = 'Limited Quantity Maximum Net Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `marine_pollutant` SET TAGS ('dbx_business_glossary_term' = 'Marine Pollutant Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `packaging_authorizations` SET TAGS ('dbx_business_glossary_term' = 'Packaging Authorizations');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `passenger_aircraft_quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Passenger Aircraft Quantity Limit');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `placard_code` SET TAGS ('dbx_business_glossary_term' = 'Placard Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `placard_required` SET TAGS ('dbx_business_glossary_term' = 'Placard Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `reportable_quantity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Reportable Quantity (RQ) in Pounds');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `severe_marine_pollutant` SET TAGS ('dbx_business_glossary_term' = 'Severe Marine Pollutant Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `special_provisions` SET TAGS ('dbx_business_glossary_term' = 'Special Provisions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `subsidiary_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Subsidiary Hazard Class');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `superseded_by_un_na_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By UN/NA Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `superseded_by_un_na_number` SET TAGS ('dbx_value_regex' = '^(UN|NA)[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `technical_name_required` SET TAGS ('dbx_business_glossary_term' = 'Technical Name Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `un_na_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations/North America (UN/NA) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `un_na_number` SET TAGS ('dbx_value_regex' = '^(UN|NA)[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `vessel_stowage_location` SET TAGS ('dbx_business_glossary_term' = 'Vessel Stowage Location');
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ALTER COLUMN `vessel_stowage_other` SET TAGS ('dbx_business_glossary_term' = 'Vessel Stowage Other Provisions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` SET TAGS ('dbx_subdomain' = 'storage_operations');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `storage_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Generator ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `lockout_tagout_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Lockout Tagout Procedure Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `building_location` SET TAGS ('dbx_business_glossary_term' = 'Building Location');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `closure_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Closure Certification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `current_inventory_quantity` SET TAGS ('dbx_business_glossary_term' = 'Current Inventory Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `emergency_response_zone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Zone');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `exemption_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exemption Basis');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `exemption_basis` SET TAGS ('dbx_value_regex' = 'satellite_accumulation|90_day_generator|conditionally_exempt|interim_status|none');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_value_regex' = 'sprinkler|foam|co2|dry_chemical|none');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Latitude');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Longitude');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `incompatible_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency (Days)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `inventory_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Inventory Unit of Measure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `inventory_unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|pounds|kilograms|liters|tons|cubic_yards');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `maximum_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity (Gallons)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `maximum_capacity_pounds` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity (Pounds)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `maximum_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Fahrenheit)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `minimum_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Fahrenheit)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `permitted_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Permitted Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'PPE (Personal Protective Equipment) Requirements');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `room_area_designation` SET TAGS ('dbx_business_glossary_term' = 'Room or Area Designation');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `secondary_containment_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Secondary Containment Capacity (Gallons)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `secondary_containment_type` SET TAGS ('dbx_business_glossary_term' = 'Secondary Containment Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `secondary_containment_type` SET TAGS ('dbx_value_regex' = 'double_walled_tank|concrete_vault|bermed_area|containment_pallet|spill_containment_system|none');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `storage_time_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Storage Time Limit (Days)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|under_inspection|suspended|decommissioned');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `ventilation_system_type` SET TAGS ('dbx_business_glossary_term' = 'Ventilation System Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ALTER COLUMN `ventilation_system_type` SET TAGS ('dbx_value_regex' = 'mechanical_exhaust|natural_ventilation|fume_hood|none');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` SET TAGS ('dbx_subdomain' = 'storage_operations');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `storage_unit_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit Inspection ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `storage_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `tsdf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Facility ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `aisle_space_adequate` SET TAGS ('dbx_business_glossary_term' = 'Aisle Space Adequate Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `aisle_space_notes` SET TAGS ('dbx_business_glossary_term' = 'Aisle Space Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `container_closure_compliant` SET TAGS ('dbx_business_glossary_term' = 'Container Closure Compliant Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `container_closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Container Closure Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `container_condition_notes` SET TAGS ('dbx_business_glossary_term' = 'Container Condition Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `container_condition_pass` SET TAGS ('dbx_business_glossary_term' = 'Container Condition Pass Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `corrective_action_verified_by` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Verified By');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `deficiencies_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Identified Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `deficiency_summary` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Summary');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `emergency_equipment_available` SET TAGS ('dbx_business_glossary_term' = 'Emergency Equipment Available Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `emergency_equipment_notes` SET TAGS ('dbx_business_glossary_term' = 'Emergency Equipment Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `facility_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `incompatible_waste_notes` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Waste Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `incompatible_waste_separation_compliant` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Waste Separation Compliant Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `inspection_signed_off` SET TAGS ('dbx_business_glossary_term' = 'Inspection Signed Off Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `inspector_certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `inspector_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `labeling_compliant` SET TAGS ('dbx_business_glossary_term' = 'Labeling Compliant Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `labeling_deficiency_notes` SET TAGS ('dbx_business_glossary_term' = 'Labeling Deficiency Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `overall_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Result');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `overall_inspection_result` SET TAGS ('dbx_value_regex' = 'pass|pass_with_minor_deficiencies|fail|corrective_action_required');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `secondary_containment_integrity_pass` SET TAGS ('dbx_business_glossary_term' = 'Secondary Containment Integrity Pass Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `secondary_containment_notes` SET TAGS ('dbx_business_glossary_term' = 'Secondary Containment Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign Off Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` SET TAGS ('dbx_subdomain' = 'transport_tracking');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Registration ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Approval Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `approved_for_manifest_use` SET TAGS ('dbx_business_glossary_term' = 'Approved for Manifest Use Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `authorized_dot_hazard_classes` SET TAGS ('dbx_business_glossary_term' = 'Authorized Department of Transportation (DOT) Hazard Classes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `authorized_vehicle_types` SET TAGS ('dbx_business_glossary_term' = 'Authorized Vehicle Types');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `authorized_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'Authorized EPA Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `cargo_insurance_carrier` SET TAGS ('dbx_business_glossary_term' = 'Cargo Insurance Carrier Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `cargo_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Cargo Insurance Coverage Amount');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `cargo_insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Cargo Insurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `cargo_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Cargo Insurance Policy Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `cargo_insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Transporter City');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Transporter Country Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `dot_operating_authority_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Operating Authority Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `dot_operating_authority_number` SET TAGS ('dbx_value_regex' = '^(MC|FF|MX)-[0-9]{6,7}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `hazmat_employee_training_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Employee Training Compliance Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `hazmat_employee_training_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_verification|expired');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `hazmat_training_last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Training Last Verified Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `liability_insurance_carrier` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Carrier Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `liability_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Coverage Amount');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `liability_insurance_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Effective Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `liability_insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `liability_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Policy Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `liability_insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Transporter Postal Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Job Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Transporter Registration Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|revoked|expired');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Federal Motor Carrier Safety Administration (FMCSA) Safety Rating');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|conditional|unsatisfactory|not_rated');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'Transporter State Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `state_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `state_transporter_permit_numbers` SET TAGS ('dbx_business_glossary_term' = 'State Transporter Permit Numbers');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Transporter Street Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `transporter_dba_name` SET TAGS ('dbx_business_glossary_term' = 'Transporter Doing Business As (DBA) Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `transporter_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Transporter Legal Company Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `usdot_number` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Transportation (USDOT) Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `usdot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,8}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ALTER COLUMN `vendor_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Score');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `contingency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `alternate_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Alternate Emergency Coordinator Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `alternate_coordinator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `alternate_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Alternate Emergency Coordinator 24-Hour Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `alternate_coordinator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `alternate_coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Contractor Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_contractor_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Contractor Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_contractor_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_contractor_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator 24-Hour Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_coordinator_title` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `emergency_equipment_list` SET TAGS ('dbx_business_glossary_term' = 'Emergency Equipment List');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `evacuation_map_reference` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Map Reference');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `evacuation_routes_description` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Routes Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `hazwoper_training_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Operations and Emergency Response (HAZWOPER) Training Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_emergency_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Local Emergency Planning Committee (LEPC) Agency Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_emergency_agency_phone` SET TAGS ('dbx_business_glossary_term' = 'Local Emergency Agency Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_emergency_agency_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_emergency_agency_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_hospital_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Local Hospital Distance in Miles');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_hospital_name` SET TAGS ('dbx_business_glossary_term' = 'Local Hospital Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_hospital_phone` SET TAGS ('dbx_business_glossary_term' = 'Local Hospital Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_hospital_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `local_hospital_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `nrc_notification_required` SET TAGS ('dbx_business_glossary_term' = 'National Response Center (NRC) Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `plan_distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Plan Distribution List');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `plan_document_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `state_agency_name` SET TAGS ('dbx_business_glossary_term' = 'State Environmental Agency Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `state_agency_notification_required` SET TAGS ('dbx_business_glossary_term' = 'State Agency Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `state_agency_phone` SET TAGS ('dbx_business_glossary_term' = 'State Environmental Agency Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `state_agency_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ALTER COLUMN `state_agency_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `waste_minimization_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Minimization Activity ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `rcra_biennial_report_id` SET TAGS ('dbx_business_glossary_term' = 'Rcra Biennial Report Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `activity_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Minimization Activity Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `activity_number` SET TAGS ('dbx_value_regex' = '^WMA-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|implemented|verified|cancelled|suspended');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Minimization Activity Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'source_reduction|recycling|treatment_substitution|process_modification|material_substitution|inventory_control');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `actual_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Reduction Percentage');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `actual_reduction_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Reduction Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `annual_cost_savings` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost Savings');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `annual_cost_savings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `baseline_generation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Baseline Generation Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `baseline_measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Baseline Measurement Period End Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `baseline_measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Baseline Measurement Period Start Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `baseline_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Baseline Unit of Measure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `baseline_unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons|pounds|kilograms|gallons|liters|cubic_yards');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `ghg_reduction_co2e_tons` SET TAGS ('dbx_business_glossary_term' = 'GHG (Greenhouse Gas) Reduction in CO2e (Carbon Dioxide Equivalent) Tons');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `implementation_cost` SET TAGS ('dbx_business_glossary_term' = 'Implementation Cost');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `implementation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `material_substitution_details` SET TAGS ('dbx_business_glossary_term' = 'Material Substitution Details');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period in Months');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `process_modification_details` SET TAGS ('dbx_business_glossary_term' = 'Process Modification Details');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `projected_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Projected Reduction Percentage');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `projected_reduction_quantity` SET TAGS ('dbx_business_glossary_term' = 'Projected Reduction Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `responsible_person_title` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `sustainability_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Reporting Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `exception_report_id` SET TAGS ('dbx_business_glossary_term' = 'Exception Report ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'TSDF (Treatment Storage and Disposal Facility) EPA ID Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Contact Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `waste_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Certification Statement');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `certifying_official_title` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Title');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `contact_attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Contact Attempts Count');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Report Due Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `epa_waste_codes` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Waste Codes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'manifest_not_received|discrepancy_unresolved|rejection_by_tsdf');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Manifest Return Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `follow_up_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions Taken');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Generator Contact Email Address');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Generator Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `generator_name` SET TAGS ('dbx_business_glossary_term' = 'Generator Legal Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Report Notes');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `regulatory_action_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `regulatory_action_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Required Flag');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'epa_federal|state_authorized_program');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|pending_tsdf_response|manifest_received|regulatory_investigation|closed');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'domestic|international');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'enviance_ehs|sap_ehs|rcrainfo|manual_entry');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `state_agency_code` SET TAGS ('dbx_business_glossary_term' = 'State Agency Code');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `state_agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Quantity');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `tsdf_name` SET TAGS ('dbx_business_glossary_term' = 'TSDF (Treatment Storage and Disposal Facility) Name');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `tsdf_response` SET TAGS ('dbx_business_glossary_term' = 'TSDF (Treatment Storage and Disposal Facility) Response');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Description');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` SET TAGS ('dbx_subdomain' = 'transport_tracking');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` SET TAGS ('dbx_association_edges' = 'hazmat.transporter_registration,service.service_area');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `transporter_service_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Service Authorization ID');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Service Authorization - Service Area Id');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Service Authorization - Transporter Registration Id');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Reference');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
