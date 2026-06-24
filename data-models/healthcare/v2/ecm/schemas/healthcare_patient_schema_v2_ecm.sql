-- Schema for Domain: patient | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`patient` COMMENT 'Master data for all individuals receiving healthcare services. SSOT for patient identity, demographics, MRN (Medical Record Number), MPI (Master Patient Index), insurance coverage, emergency contacts, consent records, SDOH (Social Determinants of Health), patient preferences, and PHI-protected identity information. Referenced by every clinical and financial domain via patient_id FK.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` (
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the MPI record',
    `care_site_id` BIGINT COMMENT 'Primary care site for this patient',
    `surviving_mpi_record_id` BIGINT COMMENT 'Reference to the surviving MPI record if this record was merged',
    `databricks_governance_id` BIGINT COMMENT '',
    `care_gap_id` BIGINT COMMENT 'Open care gap (patient x measure x gap status) tied to this MPI record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MPI record was created',
    `date_of_birth` DATE COMMENT 'Patient date of birth',
    `date_of_death` DATE COMMENT 'Patient date of death if deceased',
    `deceased_flag` BOOLEAN COMMENT 'Indicates if the patient is deceased',
    `digital_health_opt_in` BOOLEAN COMMENT 'Patient opt-in flag for digital health / patient engagement programs.',
    `enterprise_patient_number` STRING COMMENT 'Enterprise-wide unique patient identifier',
    `ethnicity_code` STRING COMMENT 'Patient ethnicity code',
    `first_registration_date` DECIMAL(18,2) COMMENT 'Date of first patient registration in the system',
    `gender_identity` STRING COMMENT 'Patient gender identity',
    `hie_patient_number` STRING COMMENT 'Health Information Exchange patient identifier',
    `identity_confidence_tier` STRING COMMENT 'Confidence level of identity match (high/medium/low)',
    `identity_resolution_status` STRING COMMENT 'Status of identity resolution process',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates if interpreter services are required',
    `is_duplicate_flag` BOOLEAN COMMENT 'Indicates if this is a duplicate record',
    `is_overlay_flag` BOOLEAN COMMENT 'Indicates if this is an overlay record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update to this record',
    `last_verified_date` DATE COMMENT 'Date when identity was last verified',
    `legal_first_name` STRING COMMENT 'Patient legal first name',
    `legal_last_name` STRING COMMENT 'Patient legal last name',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence score for identity match',
    `medicaid_number` STRING COMMENT 'Patient Medicaid identifier',
    `medicare_beneficiary_number` STRING COMMENT 'Patient Medicare Beneficiary Identifier',
    `merge_algorithm` STRING COMMENT 'Algorithm used for identity merge',
    `merge_reason` STRING COMMENT 'Reason for merging this record',
    `merge_timestamp` TIMESTAMP COMMENT 'Timestamp when record was merged',
    `middle_name` STRING COMMENT 'Patient middle name',
    `mpi_record_status` STRING COMMENT 'Status of the MPI record (active/merged/inactive)',
    `mrn` STRING COMMENT 'Medical record number',
    `name_suffix` STRING COMMENT 'Patient name suffix (Jr, Sr, III, etc)',
    `national_health_id_type` STRING COMMENT 'Type of national health identifier',
    `national_health_number` STRING COMMENT 'National health identifier number',
    `npi_crosswalk_count` STRING COMMENT 'Count of NPI crosswalk entries for this patient',
    `patient_class` STRING COMMENT 'Patient classification (inpatient/outpatient/emergency)',
    `patient_risk_score_id` BIGINT COMMENT 'Latest AI patient risk score (readmission/sepsis/fall/deterioration) anchored to this MPI identity.',
    `preferred_name` STRING COMMENT 'Patient preferred name',
    `primary_language_code` STRING COMMENT 'Patient primary language code',
    `race_code` STRING COMMENT 'Patient race code',
    `restricted_access_flag` BOOLEAN COMMENT 'Indicates if access to this record is restricted',
    `sex_at_birth` STRING COMMENT 'Patient sex assigned at birth',
    `source_system_code` STRING COMMENT 'Code of the source system',
    `ssn_last4` STRING COMMENT 'Last 4 digits of Social Security Number',
    `unmerge_reason` STRING COMMENT 'Reason for unmerging this record',
    `unmerge_timestamp` TIMESTAMP COMMENT 'Timestamp when record was unmerged',
    `vip_flag` BOOLEAN COMMENT 'Indicates if patient is a VIP',
    CONSTRAINT pk_mpi_record PRIMARY KEY(`mpi_record_id`)
) COMMENT 'Master Patient Index record serving as the enterprise single-source-of-truth for patient identity across multi-facility health systems, supporting identity resolution, merge/unmerge workflows, and cross-system MRN mapping.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`demographics` (
    `demographics_id` BIGINT COMMENT 'Unique identifier for demographics record',
    `mpi_record_id` BIGINT COMMENT 'Reference to master patient index record',
    `advance_directive_on_file` BOOLEAN COMMENT 'Indicates if advance directive is on file',
    `birth_date` DATE COMMENT 'Patient date of birth',
    `birth_time` TIMESTAMP COMMENT 'Patient time of birth',
    `census_tract` STRING COMMENT 'Census tract code for patient address',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `death_cause_code` STRING COMMENT 'ICD code for cause of death',
    `death_certificate_number` STRING COMMENT 'Death certificate number',
    `death_date` DATE COMMENT 'Date of death',
    `deceased_indicator` BOOLEAN COMMENT 'Indicates if patient is deceased',
    `digital_health_opt_in` BOOLEAN COMMENT 'Patient opt-in flag for digital health / patient engagement programs.',
    `email_address` STRING COMMENT 'Patient email address',
    `enterprise_mrn` STRING COMMENT 'Enterprise medical record number',
    `ethnicity_code` STRING COMMENT 'Patient ethnicity code',
    `gender_identity` STRING COMMENT 'Patient gender identity',
    `home_address_line1` STRING COMMENT 'Home address line 1',
    `home_address_line2` STRING COMMENT 'Home address line 2',
    `home_city` STRING COMMENT 'Home city',
    `home_country_code` STRING COMMENT 'Home country code',
    `home_postal_code` STRING COMMENT 'Home postal code',
    `home_state` STRING COMMENT 'Home state',
    `interpreter_required` BOOLEAN COMMENT 'Indicates if interpreter is required',
    `legal_first_name` STRING COMMENT 'Legal first name',
    `legal_last_name` STRING COMMENT 'Legal last name',
    `mailing_address_line1` STRING COMMENT 'Mailing address line 1',
    `mailing_address_same_as_home` BOOLEAN COMMENT 'Indicates if mailing address is same as home',
    `mailing_city` STRING COMMENT 'Mailing city',
    `mailing_postal_code` STRING COMMENT 'Mailing postal code',
    `mailing_state` STRING COMMENT 'Mailing state',
    `marital_status` STRING COMMENT 'Marital status',
    `middle_name` STRING COMMENT 'Middle name',
    `mrn` STRING COMMENT 'Medical record number',
    `name_suffix` STRING COMMENT 'Name suffix',
    `patient_portal_enrolled` BOOLEAN COMMENT 'Indicates if enrolled in patient portal',
    `preferred_language_code` STRING COMMENT 'Preferred language code',
    `preferred_name` STRING COMMENT 'Preferred name',
    `primary_phone` STRING COMMENT 'Primary phone number',
    `primary_phone_type` STRING COMMENT 'Primary phone type (mobile/home/work)',
    `pronouns` STRING COMMENT 'Preferred pronouns',
    `race_code` STRING COMMENT 'Race code',
    `race_description` STRING COMMENT 'Race description',
    `registration_status` STRING COMMENT 'Registration status',
    `religion_code` STRING COMMENT 'Religion code',
    `rpm_opt_in_flag` BOOLEAN COMMENT 'Indicates the rpm opt in flag for the demographics record.',
    `sdoh_food_insecurity` BOOLEAN COMMENT 'Social determinant: food insecurity flag',
    `sdoh_housing_status` STRING COMMENT 'Social determinant: housing status',
    `secondary_phone` STRING COMMENT 'Secondary phone number',
    `sex_at_birth` STRING COMMENT 'Sex assigned at birth',
    `ssn_last4` STRING COMMENT 'Last 4 digits of SSN',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vip_indicator` BOOLEAN COMMENT 'VIP patient indicator',
    CONSTRAINT pk_demographics PRIMARY KEY(`demographics_id`)
) COMMENT 'Patient demographic information including contact details, addresses, and personal characteristics.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each patient address record in the Master Patient Index (MPI). Primary key for the patient.address data product.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient record in the Master Patient Index (MPI) to whom this address belongs. Links address to the patient master.',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: Patient address links to geographic region for SDOH analytics (area deprivation index, poverty rates, uninsured rates), population health stratification, health equity reporting, and community health ',
    `mpi_record_id` BIGINT COMMENT 'Foreign key to the enterprise MPI record, replacing the denormalized MRN natural key to ensure referential integrity and single-source-of-truth patient identity resolution across multi-facility health systems.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active indicates the address is in use; inactive indicates it has been superseded; undeliverable indicates mail has been returned or the address is not reachable; returned_mail indicates USPS or courier returned correspondence.. Valid values are `active|inactive|undeliverable|returned_mail`',
    `address_type` STRING COMMENT 'Classifies the purpose of the address record. Supported types: home (primary residence), mailing (preferred correspondence), temporary (short-term stay), work (employer location), billing (financial correspondence), guarantor (responsible party address). [ENUM-REF-CANDIDATE: home|mailing|temporary|work|billing|guarantor — promote to reference product if additional types are needed]. Valid values are `home|mailing|temporary|work|billing|guarantor`',
    `area_deprivation_index` DECIMAL(18,2) COMMENT 'National Area Deprivation Index (ADI) score derived from the census tract of this address, ranging from 1 (least deprived) to 100 (most deprived). Used for SDOH risk stratification, population health segmentation, and value-based care program targeting.',
    `census_tract` STRING COMMENT 'U.S. Census Bureau census tract identifier for the address location. Used for SDOH stratification, Area Deprivation Index (ADI) linkage, and population health analytics to identify socioeconomic risk factors.',
    `city` STRING COMMENT 'City or municipality of the patient address. Used for population health outreach, care gap closure, and Social Determinants of Health (SDOH) stratification.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the address (e.g., USA, CAN, MEX). Supports international patient populations and cross-border care coordination.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish name associated with the patient address. Used for SDOH stratification, public health reporting, and county-level population health analytics.',
    `county_fips_code` STRING COMMENT 'Five-digit Federal Information Processing Standards (FIPS) code uniquely identifying the county. Enables linkage to census data, Area Deprivation Index (ADI), and federal SDOH datasets for population health management.. Valid values are `^d{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the source system or the Silver Layer data product. Supports audit trail, data lineage, and HIPAA access logging requirements.',
    `digital_health_opt_in` STRING COMMENT 'Indicates the digital health opt in for the address record.',
    `district` STRING COMMENT 'Administrative district or borough associated with the address. Used in urban markets and international patient populations for sub-county geographic segmentation and population health reporting.',
    `do_not_contact_reason` STRING COMMENT 'Free-text or coded reason why the patient has requested no contact at this address (e.g., patient request, domestic violence protection, deceased, address undeliverable). Supports HIPAA confidential communications compliance and patient preference management.',
    `effective_end_date` DATE COMMENT 'Date on which this address record is no longer active for the patient. Null indicates the address is currently active. Supports historical address tracking and transitions of care documentation.',
    `effective_start_date` DATE COMMENT 'Date from which this address record is considered active and valid for the patient. Supports temporal address management, enabling historical address lookups and point-in-time reporting for care coordination and billing.',
    `geocode_precision` STRING COMMENT 'Precision level of the geocoded coordinates indicating how accurately the latitude/longitude represents the address. Rooftop is highest precision; ungeocoded indicates geocoding has not been performed or failed.. Valid values are `rooftop|range_interpolated|geometric_center|approximate|ungeocoded`',
    `health_service_area` STRING COMMENT 'Dartmouth Atlas Health Service Area (HSA) or facility-defined service area code associated with the address. Used for population health management, market analysis, and care utilization reporting.',
    `housing_type` STRING COMMENT 'Categorizes the patients housing situation at this address. Supports Social Determinants of Health (SDOH) screening, housing instability risk stratification, and population health management programs. Aligned with AHRQ SDOH domain of housing instability.. Valid values are `owned|rented|shelter|transitional|group_home|unhoused`',
    `is_confidential` BOOLEAN COMMENT 'Indicates the address is marked confidential and must not be disclosed to unauthorized parties, including family members. Supports domestic violence protections, sensitive patient situations, and HIPAA confidential communications requirements under 45 CFR §164.522(b).',
    `is_do_not_mail` BOOLEAN COMMENT 'Indicates the patient has requested that no physical mail be sent to this address. Enforced during population health outreach, care gap closure mailings, and marketing communications to honor patient preferences and comply with HIPAA minimum necessary standards.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this address is the patients primary address of record. Only one address per patient should be flagged as primary at any given time. Used by clinical and billing systems to select the default address for correspondence.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees, WGS84) derived from geocoding the address. Supports spatial analytics, drive-time analysis, care access mapping, and population health outreach routing.',
    `line1` STRING COMMENT 'Primary street address line including house/building number and street name. First line of the patients physical or mailing address as captured in Epic or Cerner registration.',
    `line2` STRING COMMENT 'Secondary address line for apartment, suite, unit, floor, or building designator. Supplements address_line1 for multi-unit dwellings.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees, WGS84) derived from geocoding the address. Supports spatial analytics, drive-time analysis, care access mapping, and population health outreach routing.',
    `move_in_date` DATE COMMENT 'Date the patient moved into or began residing at this address, as reported by the patient during registration or updated via patient portal. Supports address tenure analysis and SDOH housing stability assessments.',
    `move_out_date` DATE COMMENT 'Date the patient moved out of or ceased residing at this address, as reported during registration update or returned mail processing. Used to close address records and trigger re-registration workflows.',
    `ncoa_match_code` STRING COMMENT 'USPS NCOA match result code indicating the outcome of the change-of-address lookup (e.g., individual match, family match, business match, no match, moved with no forwarding address). Used to assess address currency and trigger update workflows.',
    `ncoa_update_date` DATE COMMENT 'Date on which this address was last updated via USPS National Change of Address (NCOA) processing. Supports address hygiene programs and ensures outreach mailings reach patients who have relocated.',
    `postal_code` STRING COMMENT 'USPS ZIP or ZIP+4 postal code for the address. Used for geographic routing, population health outreach, and SDOH analysis. Note: Per HIPAA Safe Harbor, full 9-digit ZIP codes for small geographic areas may require de-identification.. Valid values are `^d{5}(-d{4})?$`',
    `preferred_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code representing the patients preferred language for written communications sent to this address (e.g., en, es, zh). Supports culturally competent outreach and CMS language access requirements.. Valid values are `^[a-z]{2,3}$`',
    `quality_integration_flag` BOOLEAN COMMENT 'Flag indicating integration with quality extensions',
    `sdoh_housing_instability_flag` BOOLEAN COMMENT 'Indicates the patient has been identified as experiencing housing instability at this address based on SDOH screening (e.g., PRAPARE, AHC HRSN). Triggers care management interventions and community resource referrals.',
    `sdoh_risk_score` STRING COMMENT '',
    `source_system_address_code` STRING COMMENT 'Native identifier for this address record in the originating operational system (e.g., Epic address record ID, Cerner address sequence number). Supports ETL reconciliation, deduplication, and cross-system traceability.',
    `state_code` STRING COMMENT 'Two-letter USPS state or territory abbreviation (e.g., CA, TX, NY). Used for state-level regulatory reporting, licensure verification, and population health segmentation.. Valid values are `^[A-Z]{2}$`',
    `updated_by` STRING COMMENT 'Username or system identifier of the user or automated process that last modified this address record. Supports HIPAA audit trail requirements and data stewardship accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last modified in the source system or the Silver Layer data product. Supports change data capture (CDC), incremental ETL processing, and audit trail requirements.',
    `urban_rural_classification` STRING COMMENT 'Classifies the address location as urban, suburban, rural, or frontier based on USDA Rural-Urban Commuting Area (RUCA) codes or HRSA definitions. Used for CMS geographic payment adjustments, rural health program eligibility, and access-to-care analytics.. Valid values are `urban|suburban|rural|frontier`',
    `validation_date` DATE COMMENT 'Date on which the address was last validated against USPS or a third-party address verification service. Supports re-validation scheduling and data quality monitoring.',
    `validation_source` STRING COMMENT 'Name of the system or service used to validate the address (e.g., USPS CASS, Melissa Data, SmartyStreets, Epic Address Validation). Supports audit trails for address quality management.',
    `validation_status` STRING COMMENT 'Current USPS or third-party address validation status. Validated indicates the address was confirmed deliverable by USPS CASS certification or equivalent. Corrected indicates the address was standardized during validation. Used to ensure accuracy of outreach mailings and care gap closure communications.. Valid values are `validated|unvalidated|invalid|corrected|pending`',
    `vbc_eligible_flag` BOOLEAN COMMENT 'Flag indicating VBC eligibility for the address record',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Patient address records supporting multiple address types (home, mailing, temporary, work) with full address components, geocoding coordinates, county/census tract for SDOH analysis, address validation status, effective date ranges, and do-not-mail flags. Supports population health outreach, care gap closure, and SDOH stratification. Sourced from Epic and Cerner registration systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` (
    `insurance_coverage_id` BIGINT COMMENT 'Unique surrogate identifier for each insurance coverage record in the patient domain. Primary key for the insurance_coverage data product.',
    `mpi_record_id` BIGINT COMMENT 'The insurance member identification number assigned by the payer to uniquely identify the insured individual. Used in eligibility verification (X12 270/271), claims submission (CMS-1500, UB-04), and Electronic Remittance Advice (ERA) matching.',
    `insurance_mpi_record_id` BIGINT COMMENT 'Reference to the patient whose insurance coverage this record describes. Links to the master patient record via the Master Patient Index (MPI).',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization responsible for adjudicating claims under this coverage. Aligns with the payer master in the reference data domain.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `subscriber_id` BIGINT COMMENT 'The insurance member ID of the primary subscriber (policyholder) when the patient is a dependent. Distinct from member_id when subscriber_relationship is not self. Required for dependent eligibility verification.',
    `benefit_year_end` DATE COMMENT 'The end date of the insurance plans benefit year (plan year). Used to reset deductible and out-of-pocket accumulator tracking and to identify coverage renewal requirements.',
    `benefit_year_start` DATE COMMENT 'The start date of the insurance plans benefit year (plan year). Used to reset deductible and out-of-pocket accumulator tracking. May differ from the coverage effective date for mid-year enrollments.',
    `cob_priority` STRING COMMENT 'Numeric priority order for Coordination of Benefits (COB) when a patient has multiple insurance coverages. 1 = primary payer, 2 = secondary payer, 3 = tertiary payer. Governs claim submission sequencing and payment responsibility allocation.',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'The percentage of covered service costs the patient is responsible for after the deductible is met, expressed as a decimal (e.g., 0.2000 = 20%). Used in patient financial counseling and Revenue Cycle Management (RCM) estimation.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount the patient is required to pay at the time of service for a covered visit or procedure (e.g., $25 primary care, $50 specialist). Used in point-of-service collection and patient financial counseling.',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the insurance coverage record. Drives eligibility verification workflows, claim submission eligibility, and front-end Revenue Cycle Management (RCM) processes. Active = currently valid; Pending = awaiting confirmation; Terminated = coverage ended; Suspended = temporarily inactive.. Valid values are `active|inactive|pending|terminated|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this insurance coverage record was first created in the system. Supports audit trail, data lineage, and HIPAA audit control requirements.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The annual deductible amount the patient must pay out-of-pocket before the insurance plan begins covering costs. Expressed in USD. Used in patient financial counseling, prior authorization, and Revenue Cycle Management (RCM) workflows.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'The year-to-date amount the patient has applied toward their annual deductible. Sourced from real-time eligibility verification (X12 271) responses. Used in patient financial counseling and point-of-service collection.',
    `digital_health_opt_in` STRING COMMENT '',
    `effective_date` DATE COMMENT 'The date on which the insurance coverage becomes effective and claims may be submitted. Used in eligibility verification and coordination of benefits (COB) sequencing. Aligns with X12 271 DTP*356 segment.',
    `eligibility_response_code` STRING COMMENT 'The X12 271 AAA or EB segment response code returned by the payer during eligibility verification, indicating the specific eligibility status or rejection reason (e.g., 1 = Active Coverage, AAA = Rejection). Supports denial prevention and RCM analytics.',
    `eligibility_transaction_number` STRING COMMENT 'The unique transaction control number (TCN) or trace number assigned to the X12 270/271 eligibility verification transaction or FHIR CoverageEligibilityRequest. Enables end-to-end audit trail and transaction reconciliation.',
    `eligibility_verification_method` STRING COMMENT 'The method used to perform the most recent eligibility verification for this coverage. Supports audit trail requirements and verification workflow analytics. EDI_270_271 = X12 batch or real-time transaction; portal = payer web portal; phone = verbal verification; real_time_API = FHIR-based real-time check.. Valid values are `EDI_270_271|portal|phone|manual|real_time_API`',
    `eligibility_verification_status` STRING COMMENT 'The current status of the most recent eligibility verification transaction for this coverage record. Reflects the outcome of X12 270/271 EDI, portal, or phone-based verification. Drives front-end Revenue Cycle Management (RCM) workflows and claim denial prevention.. Valid values are `verified|unverified|pending|failed|not_eligible`',
    `eligibility_verified_by` STRING COMMENT 'The name or system identifier of the staff member, automated process, or clearinghouse that performed the most recent eligibility verification. Supports audit trail and accountability for Revenue Cycle Management (RCM) workflows.',
    `eligibility_verified_timestamp` TIMESTAMP COMMENT 'The date and time when the most recent eligibility verification was completed. Used in the eligibility verification audit trail and to determine whether re-verification is required based on payer-specific or organizational SLA policies.',
    `group_number` STRING COMMENT 'The employer or group plan number assigned by the payer that identifies the specific group policy under which the member is covered. Required for claims submission and eligibility verification.',
    `insurance_card_back_url` STRING COMMENT 'Secure URL or document reference to the scanned or photographed back of the patients insurance card. Stored in a HIPAA-compliant document management system. Contains payer contact information and claims submission instructions.',
    `insurance_card_front_url` STRING COMMENT 'Secure URL or document reference to the scanned or photographed front of the patients insurance card. Stored in a HIPAA-compliant document management system. Used for manual verification and patient registration workflows.',
    `medicaid_state_code` STRING COMMENT 'Two-letter US state code identifying the state Medicaid program under which the patient is enrolled. Null for non-Medicaid plans. Required for Medicaid claim submission and state-specific billing rules.. Valid values are `^[A-Z]{2}$`',
    `medicare_part` STRING COMMENT 'For Medicare coverage, identifies the specific Medicare part: A (Hospital Insurance), B (Medical Insurance), C (Medicare Advantage/HMO), or D (Prescription Drug Coverage). Null for non-Medicare plans. Drives CMS billing rules and claim form selection.. Valid values are `A|B|C|D`',
    `network_status` STRING COMMENT 'Indicates whether the patients coverage is being used within the payers contracted provider network (in-network) or outside it (out-of-network). Affects patient cost-sharing, claim adjudication rates, and denial risk.. Valid values are `in_network|out_of_network|unknown`',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'The maximum annual amount the patient is required to pay out-of-pocket for covered services, after which the plan covers 100% of costs. Used in patient financial counseling and Revenue Cycle Management (RCM) workflows.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'The year-to-date amount the patient has applied toward their annual out-of-pocket maximum. Sourced from real-time eligibility verification (X12 271) responses. Informs point-of-service collection decisions.',
    `payer_electronic_number` STRING COMMENT 'The electronic payer identification number used for submitting X12 EDI transactions (270/271 eligibility, 837 claims). Also known as the EDI payer ID or clearinghouse payer ID. Distinct from the NPI.',
    `plan_name` STRING COMMENT 'The commercial name of the insurance plan as designated by the payer (e.g., Blue Shield PPO Gold, Aetna HMO Select). Used for patient-facing communications and Revenue Cycle Management (RCM) workflows.',
    `plan_type` STRING COMMENT 'Classification of the insurance plan type indicating the network and coverage structure. Drives prior authorization requirements, referral rules, and claim adjudication logic. [ENUM-REF-CANDIDATE: HMO|PPO|POS|EPO|Medicare|Medicaid|self_pay|TRICARE|CHIP|workers_comp|commercial — promote to reference product]',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether the insurance plan requires prior authorization (pre-authorization) before certain services, procedures, or medications are covered. Drives pre-authorization workflows in Order Management and Surgical/Procedural Scheduling.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether the insurance plan requires a referral from a Primary Care Physician (PCP) before the patient can see a specialist. Applicable primarily to Health Maintenance Organization (HMO) and Point of Service (POS) plans.',
    `rx_bin` STRING COMMENT 'The 6-digit Bank Identification Number (BIN) used to route pharmacy claims to the correct Pharmacy Benefit Manager (PBM). Printed on the insurance card and required for real-time pharmacy eligibility and adjudication via NCPDP SCRIPT standard.. Valid values are `^[0-9]{6}$`',
    `rx_group` STRING COMMENT 'The pharmacy benefit group number used to identify the specific pharmacy benefit plan within the Pharmacy Benefit Manager (PBM) system. Printed on the insurance card alongside RxBIN and PCN.',
    `rx_pcn` STRING COMMENT 'The Processor Control Number (PCN) used in conjunction with the RxBIN to route pharmacy claims to the correct sub-processor within the Pharmacy Benefit Manager (PBM). Required for pharmacy eligibility verification.',
    `source_system_record_code` STRING COMMENT 'The native primary key or record identifier for this coverage record in the originating operational system (e.g., Epic coverage record ID, Cerner insurance record ID). Enables traceability from the Silver layer back to the system of record.',
    `subscriber_relationship` STRING COMMENT 'The relationship of the patient (beneficiary) to the primary insurance subscriber. Determines coordination of benefits (COB) rules and claim filing requirements. Self indicates the patient is the primary subscriber.. Valid values are `self|spouse|child|dependent|other`',
    `termination_date` DATE COMMENT 'The date on which the insurance coverage ends or is terminated. Null indicates open-ended active coverage. Used to prevent claim submission for services rendered outside the coverage period. Aligns with X12 271 DTP*357 segment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this insurance coverage record was most recently modified. Supports change tracking, audit trail, and incremental ETL processing in the Databricks Silver layer.',
    CONSTRAINT pk_insurance_coverage PRIMARY KEY(`insurance_coverage_id`)
) COMMENT 'Patient insurance coverage, eligibility, and verification records. Captures payer name, plan name, plan type (HMO, PPO, POS, Medicare, Medicaid, self-pay), member ID, group number, subscriber relationship, coverage effective and termination dates, coordination of benefits (COB) priority, copay/deductible/out-of-pocket amounts, pre-authorization requirements, and real-time/batch eligibility verification transactions (270/271 EDI, portal, phone) with verification status, confirmed coverage details, verification date/time, payer queried, and verification audit trail. SSOT for patient payer eligibility and verification consumed by billing and claims domains. Supports front-end RCM workflows, claim denial prevention, and prior authorization management. Aligned with X12 270/271 transaction standards and HL7 FHIR Coverage resource. Sourced from EHR revenue cycle and eligibility verification modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`guarantor` (
    `guarantor_id` BIGINT COMMENT 'Unique surrogate identifier for the financial guarantor record within the patient accounting system. Primary key for the guarantor entity; referenced by patient account and billing records across the Revenue Cycle Management (RCM) domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue cycle management assigns guarantor accounts to cost centers for departmental revenue attribution in financial statements and management reporting. Healthcare CFOs require guarantor-to-cost-cen',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient record for whom this guarantor is financially responsible. Links the guarantor to the Master Patient Index (MPI) and enables RCM workflows to associate account balances with the correct patient.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `account_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance owed by the guarantor on the patient account in USD. Represents the net self-pay balance after insurance adjudication, contractual adjustments, and payments applied. Core metric for RCM self-pay collection and patient financial counseling.',
    `account_number` STRING COMMENT 'Externally-known patient accounting number assigned to the guarantor account in the EHR revenue cycle or patient accounting system (e.g., Epic Resolute HB guarantor account number). Used by billing staff, financial counselors, and self-pay collection teams to identify and reference the account.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the guarantor account within the Revenue Cycle Management (RCM) workflow. Drives billing, collection, and write-off processes. [ENUM-REF-CANDIDATE: active|inactive|collections|bad_debt|deceased|bankruptcy — promote to reference product if additional statuses are required]. Valid values are `active|inactive|collections|bad_debt|deceased|bankruptcy`',
    `address_line1` STRING COMMENT 'Primary street address line of the guarantors mailing or billing address. Used for billing statement delivery, collection correspondence, and address verification in RCM workflows.',
    `address_line2` STRING COMMENT 'Secondary address line for the guarantor (apartment, suite, unit, floor, PO Box). Supplements address_line1 for complete mailing address used in billing and collection correspondence.',
    `annual_income` DECIMAL(18,2) COMMENT 'Self-reported or verified annual gross income of the guarantor in USD. Used for financial assistance (charity care) eligibility screening, sliding-scale fee determination, and payment plan structuring per CMS and ACA financial assistance requirements.',
    `bad_debt_flag` BOOLEAN COMMENT 'Indicates whether the guarantor account balance has been written off as bad debt in the patient accounting system. Supports financial reporting, bad debt reserve calculations, and RAC audit documentation per GAAP and CMS guidelines.',
    `bankruptcy_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has filed for bankruptcy protection. When True, all collection activities must cease immediately per the automatic stay provisions of the U.S. Bankruptcy Code (11 U.S.C. §362) and the account is flagged for legal review.',
    `city` STRING COMMENT 'City of the guarantors billing or mailing address. Used in billing statement generation, collection correspondence, and geographic analytics for patient financial services.',
    `collection_agency_flag` BOOLEAN COMMENT 'Indicates whether the guarantor account has been referred to an external collection agency for bad debt recovery. When True, direct billing and collection activities by the healthcare organization are suspended per FDCPA requirements.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the guarantors billing or mailing address (e.g., USA, CAN, MEX). Supports international patient billing and cross-border financial correspondence.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the guarantor record was first created in the patient accounting system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Supports audit trail requirements, data lineage, and HIPAA compliance documentation.',
    `date_of_birth` DATE COMMENT 'Date of birth of the guarantor individual in yyyy-MM-dd format. Used for identity verification, eligibility determination for financial assistance programs, and demographic analytics in patient financial services.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the guarantor is deceased. When True, billing and collection workflows are routed to estate billing processes and direct collection outreach is suspended per FDCPA and state probate law requirements.',
    `digital_health_opt_in` STRING COMMENT '',
    `do_not_contact_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has requested cessation of all billing and collection contact. When True, all outreach activities are suppressed in compliance with FDCPA cease-and-desist provisions and HIPAA patient rights.',
    `email_address` STRING COMMENT 'Email address of the guarantor used for electronic billing statements (e-statements), payment portal communications, and financial counseling correspondence. Consent for electronic communication must be documented per HIPAA and CAN-SPAM Act.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employer_name` STRING COMMENT 'Name of the guarantors current employer. Used in financial counseling, self-pay collection assessments, and financial assistance (charity care) eligibility screening to evaluate ability to pay.',
    `employer_phone` STRING COMMENT 'Phone number of the guarantors employer. Used in self-pay collection processes and financial counseling to verify employment status and facilitate payment arrangements.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `employment_status` STRING COMMENT 'Current employment status of the guarantor. Used in financial assistance (charity care) eligibility determination, payment plan structuring, and self-pay collection risk stratification. [ENUM-REF-CANDIDATE: employed_full_time|employed_part_time|self_employed|unemployed|retired|student|disabled — promote to reference product]',
    `estatement_consent_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has consented to receive electronic billing statements (e-statements) via email or patient portal in lieu of paper statements. Supports paperless billing initiatives and reduces statement delivery costs in RCM.',
    `federal_poverty_level_pct` DECIMAL(18,2) COMMENT 'Calculated Federal Poverty Level (FPL) percentage for the guarantors household based on annual income and household size. Determines eligibility tier for financial assistance programs, charity care, and sliding-scale discounts per ACA Section 501(r) and CMS guidelines.',
    `financial_assistance_status` STRING COMMENT 'Current status of the guarantors financial assistance (charity care) application. Drives billing hold, discount application, and collection suspension workflows in the RCM system. Supports ACA Section 501(r) compliance reporting.. Valid values are `not_applied|pending|approved|denied|partial`',
    `financial_assistance_type` STRING COMMENT 'Type of financial assistance program approved or applied for by the guarantor. Determines the discount percentage, payment schedule, and billing workflow applied to the account. [ENUM-REF-CANDIDATE: charity_care|sliding_scale|payment_plan|hardship|medicaid_pending — promote to reference product]. Valid values are `charity_care|sliding_scale|payment_plan|hardship|medicaid_pending`',
    `first_name` STRING COMMENT 'Legal first (given) name of the guarantor individual. Used in billing correspondence, patient financial counseling communications, and self-pay collection outreach. Protected Health Information (PHI) under HIPAA when linked to patient account data.',
    `guarantor_type` STRING COMMENT 'Classification of the guarantor indicating whether the responsible party is the patient themselves, a family member, a legal guardian, an estate, or an organization. Determines billing workflow routing and financial counseling approach. [ENUM-REF-CANDIDATE: self|parent|spouse|legal_guardian|estate|organization — promote to reference product if additional types are required]. Valid values are `self|parent|spouse|legal_guardian|estate|organization`',
    `home_phone` STRING COMMENT 'Home telephone number of the guarantor. Primary contact channel for billing inquiries, financial counseling outreach, and self-pay collection calls. Stored in compliance with HIPAA and Telephone Consumer Protection Act (TCPA) requirements.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `household_size` STRING COMMENT 'Number of individuals in the guarantors household. Used in conjunction with annual income to determine Federal Poverty Level (FPL) percentage for financial assistance (charity care) eligibility and sliding-scale fee calculations.',
    `last_name` STRING COMMENT 'Legal last (family) name of the guarantor individual. Used in billing correspondence, collection letters, and identity verification for patient financial services.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the most recent payment received from the guarantor in USD. Used alongside last_payment_date for payment plan compliance monitoring, collection risk assessment, and RCM reporting.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from the guarantor toward the outstanding account balance. Used in collection aging analysis, payment plan compliance monitoring, and bad debt risk stratification.',
    `last_statement_date` DATE COMMENT 'Date on which the most recent billing statement was generated and sent to the guarantor. Used to track billing cycle compliance, manage statement frequency, and support collection escalation timelines in RCM.',
    `middle_name` STRING COMMENT 'Legal middle name or initial of the guarantor individual. Supports identity verification and disambiguation in patient accounting and self-pay collection workflows.',
    `mobile_phone` STRING COMMENT 'Mobile/cell phone number of the guarantor. Supports SMS billing notifications, payment reminders, and collection outreach. Consent for text messaging must be captured separately per TCPA requirements.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `organization_name` STRING COMMENT 'Legal name of the organization acting as guarantor when the responsible party is a business entity, estate, or institution rather than an individual. Populated when guarantor_type is organization or estate.',
    `payment_plan_amount` DECIMAL(18,2) COMMENT 'Agreed monthly payment amount under the guarantors active payment plan arrangement in USD. Used by RCM billing staff to monitor payment plan compliance and trigger collection escalation if payments are missed.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has an active payment plan arrangement for the outstanding account balance. When True, collection activities are suspended and the account follows the payment plan schedule in the RCM system.',
    `postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code of the guarantors billing or mailing address. Used for billing statement delivery, collection correspondence, and geographic segmentation in patient financial analytics.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `preferred_contact_method` STRING COMMENT 'Guarantors preferred method of contact for billing statements, payment reminders, and financial counseling communications. Drives outreach channel selection in RCM workflows and patient financial services.. Valid values are `home_phone|work_phone|mobile_phone|email|mail`',
    `relationship_to_patient` STRING COMMENT 'Describes the guarantors relationship to the patient as defined in the EHR patient accounting module. Used for financial counseling, billing correspondence, and HIPAA-compliant disclosure of account information. [ENUM-REF-CANDIDATE: self|spouse|parent|child|sibling|grandparent|legal_guardian|other — promote to reference product]',
    `responsibility_pct` DECIMAL(18,2) COMMENT 'Percentage of the total patient account balance for which this guarantor is financially responsible. Supports scenarios where multiple guarantors share responsibility for a single patient account (e.g., divorced parents of a minor patient). Value range: 0.00 to 100.00.',
    `since_date` DATE COMMENT 'Date on which the individual or organization was first established as the financial guarantor for the patient account. Marks the effective start of financial responsibility and is used in RCM aging analysis and financial counseling workflows.',
    `sms_consent_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has provided explicit written consent to receive SMS/text message billing notifications and payment reminders. Required for TCPA compliance before sending automated text messages to the guarantors mobile phone.',
    `ssn_masked` STRING COMMENT 'Masked Social Security Number (SSN) of the guarantor, displaying only the last four digits (format: XXX-XX-NNNN). Used for identity verification in self-pay collections, financial assistance screening, and credit bureau reporting. Full SSN must never be stored in the Silver layer per HIPAA and PCI DSS data minimization requirements.. Valid values are `^XXX-XX-[0-9]{4}$`',
    `state` STRING COMMENT 'Two-letter US state or territory code of the guarantors billing or mailing address (e.g., CA, TX, NY). Used for billing correspondence, state-specific financial assistance program eligibility, and regulatory reporting.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the guarantor record was most recently modified in the patient accounting system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Supports change data capture (CDC), audit trail requirements, and Silver layer incremental load processing.',
    `work_phone` STRING COMMENT 'Work telephone number of the guarantor. Used as an alternate contact channel for billing and collection communications when home phone is unavailable. Stored in compliance with HIPAA and TCPA.. Valid values are `^+?[0-9-() ]{7,20}$`',
    CONSTRAINT pk_guarantor PRIMARY KEY(`guarantor_id`)
) COMMENT 'Financial guarantor record identifying the individual or entity responsible for patient account balances. Captures guarantor name, relationship to patient, address, phone, employer information, SSN (masked), and account responsibility percentage. Supports RCM billing workflows, patient financial counseling, and self-pay collection processes. Sourced from EHR revenue cycle and patient accounting modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` (
    `emergency_contact_id` BIGINT COMMENT 'Unique surrogate identifier for the emergency contact record in the Master Patient Index (MPI) system. Primary key for the emergency_contact data product.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this emergency contact is registered. Links to the patient master record in the Master Patient Index (MPI).',
    `sdoh_referral_id` BIGINT COMMENT '',
    `address_line1` STRING COMMENT 'Primary street address line for the emergency contacts residence. Used for written correspondence, legal notifications, and discharge planning documentation.',
    `address_line2` STRING COMMENT 'Secondary address line for the emergency contact (e.g., apartment number, suite, unit). Supplements address_line1 for complete mailing address resolution.',
    `city` STRING COMMENT 'City of residence for the emergency contact. Used in conjunction with state and postal code for complete address resolution and geographic analytics.',
    `consent_date` DATE COMMENT 'The date on which the patient provided consent to designate this individual as an emergency contact and/or authorized recipient of PHI. Required for HIPAA audit trails and regulatory compliance.',
    `consent_obtained_by` STRING COMMENT 'Name or identifier of the staff member (e.g., registration clerk, nurse) who obtained the patients consent to designate this emergency contact. Supports HIPAA audit trail requirements and accountability in the registration workflow.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the emergency contact record. Active = currently valid and reachable; Inactive = no longer applicable (e.g., relationship ended); Deceased = contact has died; Unverified = contact information has not been confirmed with the patient.. Valid values are `active|inactive|deceased|unverified`',
    `contact_type` STRING COMMENT 'Classification of the contacts role relative to the patient. Determines the scope of authority and notification priority. Values include emergency_contact (general notification), healthcare_proxy (authorized to make medical decisions), legal_guardian (legal authority over patient), authorized_representative (authorized to receive PHI per HIPAA), next_of_kin (biological/legal family), guarantor (financial responsibility). [ENUM-REF-CANDIDATE: emergency_contact|healthcare_proxy|legal_guardian|authorized_representative|next_of_kin|guarantor — promote to reference product]. Valid values are `emergency_contact|healthcare_proxy|legal_guardian|authorized_representative|next_of_kin|guarantor`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the emergency contacts address. Supports international patients and contacts residing outside the United States.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this emergency contact record was first created in the system. Supports audit trail requirements, HIPAA compliance, and data lineage tracking. Stored in ISO 8601 format with timezone offset.',
    `digital_health_opt_in` STRING COMMENT '',
    `effective_end_date` DATE COMMENT 'The date on which this emergency contact designation is no longer valid (e.g., divorce, death of contact, revocation by patient). Null indicates the contact is currently active with no defined end date.',
    `effective_start_date` DATE COMMENT 'The date from which this emergency contact designation is considered valid and active. Supports temporal validity tracking for contact records, particularly when contacts change over time (e.g., new spouse, new guardian).',
    `email_address` STRING COMMENT 'Email address of the emergency contact. Used for non-urgent communications, appointment notifications, and electronic delivery of care summaries or discharge instructions where PHI authorization permits.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Legal given (first) name of the emergency contact individual. Used for identification and communication during care coordination and emergency notification workflows.',
    `healthcare_proxy_flag` BOOLEAN COMMENT 'Indicates whether this contact has been designated as the patients healthcare proxy (durable power of attorney for healthcare decisions). When True, this individual is legally authorized to make medical decisions on behalf of the patient if the patient is incapacitated. Distinct from phi_disclosure_authorized.',
    `home_phone` STRING COMMENT 'Residential landline phone number for the emergency contact. Used as a secondary contact channel when mobile phone is unavailable. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `interpreter_required` BOOLEAN COMMENT 'Indicates whether a professional interpreter is required when communicating with this emergency contact. Supports compliance with Section 1557 of the Affordable Care Act (ACA) language access requirements and TJC communication standards.',
    `last_name` STRING COMMENT 'Legal family (last) name of the emergency contact individual. Used in conjunction with first_name for full identity resolution and communication.',
    `legal_guardian_flag` BOOLEAN COMMENT 'Indicates whether this contact holds legal guardianship over the patient (e.g., parent of a minor, court-appointed guardian for an incapacitated adult). When True, this individual has legal authority over the patients care decisions and access to medical records.',
    `lives_with_patient` BOOLEAN COMMENT 'Indicates whether the emergency contact resides in the same household as the patient. Relevant for discharge planning, home care coordination, and Social Determinants of Health (SDOH) assessments.',
    `middle_name` STRING COMMENT 'Middle name or initial of the emergency contact. Supports full legal name resolution and disambiguation when multiple contacts share the same first and last name.',
    `mobile_phone` STRING COMMENT 'Mobile (cell) phone number for the emergency contact. Preferred channel for urgent notifications and SMS-based communication during emergency and discharge planning workflows. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `notes` STRING COMMENT 'Free-text field for additional clinical or administrative notes about this emergency contact (e.g., Contact is deaf — use text messaging only, Contact travels frequently — try mobile first). Supports nuanced care coordination and communication planning.',
    `notification_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient has explicitly consented to this contact being notified in the event of an emergency, admission, or discharge. Supports EMTALA compliance and HIPAA-compliant notification workflows.',
    `phi_disclosure_authorized` BOOLEAN COMMENT 'Indicates whether the patient has authorized this contact to receive Protected Health Information (PHI) about their care. Critical for HIPAA compliance — clinical staff must verify this flag before disclosing any PHI to the contact. True = authorized; False = not authorized.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the emergency contacts address. Supports mail delivery, geographic segmentation, and Social Determinants of Health (SDOH) analysis.. Valid values are `^d{5}(-d{4})?$`',
    `preferred_contact_method` STRING COMMENT 'The contacts preferred communication channel for receiving notifications and messages. Drives automated notification routing in care coordination and discharge planning workflows.. Valid values are `mobile|home_phone|work_phone|email|text_sms`',
    `preferred_language` STRING COMMENT 'The contacts preferred spoken/written language for communication, expressed as a BCP-47 language tag (e.g., en, es, zh-CN). Used to arrange interpreter services and ensure effective communication during emergency notifications and care coordination.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `preferred_name` STRING COMMENT 'The name the emergency contact prefers to be called, which may differ from their legal name. Supports patient-centered communication and cultural sensitivity in care coordination.',
    `priority_order` STRING COMMENT 'Numeric rank indicating the order in which this contact should be notified in an emergency (1 = first contact, 2 = second, etc.). Supports triage and discharge planning workflows where multiple contacts exist for a single patient.',
    `proxy_document_effective_date` DATE COMMENT 'The date on which the proxy authorization document (e.g., durable power of attorney, healthcare proxy form) became legally effective. Used to validate the currency of the authorization during care decisions.',
    `proxy_document_expiration_date` DATE COMMENT 'The date on which the proxy authorization document expires, if applicable. Null indicates the document is open-ended with no expiration. Clinical staff must verify this date before acting on proxy authority.',
    `proxy_document_type` STRING COMMENT 'Type of legal document on file that establishes this contacts authority as a healthcare proxy or legal guardian. Required for clinical staff to verify decision-making authority before acting on the contacts instructions.. Valid values are `durable_power_of_attorney|healthcare_proxy_form|court_order|advance_directive|none`',
    `relationship_type` STRING COMMENT 'The personal or familial relationship between the emergency contact and the patient (e.g., spouse, parent, sibling). Used for care coordination, discharge planning, and EMTALA compliance. Distinct from contact_type which captures the legal/functional role. [ENUM-REF-CANDIDATE: spouse|parent|child|sibling|domestic_partner|grandparent|aunt_uncle|friend|employer|other — promote to reference product]',
    `source_system_contact_code` STRING COMMENT 'The native identifier assigned to this emergency contact record in the originating source system (e.g., Epic contact ID, Cerner relationship ID). Used for cross-system reconciliation, ETL traceability, and Health Information Exchange (HIE) matching.',
    `state_code` STRING COMMENT 'Two-letter US state or territory code for the emergency contacts address. Follows USPS state abbreviation standards. Used for geographic reporting and jurisdictional compliance.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this emergency contact record was most recently modified. Supports change tracking, audit trail requirements, and incremental data loading in the Silver Layer lakehouse architecture.',
    `verified_by` STRING COMMENT 'Name or identifier of the staff member who last verified the accuracy of this emergency contacts information. Supports accountability and data quality governance in the patient registration process.',
    `verified_date` DATE COMMENT 'The most recent date on which the emergency contacts information was verified with the patient or the contact directly. Supports data quality management and ensures contact information is current for emergency use.',
    `work_phone` STRING COMMENT 'Business or workplace phone number for the emergency contact. Used during daytime hours when the contact may be reached at their place of employment. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `work_phone_extension` STRING COMMENT 'Extension number associated with the contacts work phone. Required for routing calls within large organizations where the contact is employed.. Valid values are `^d{1,6}$`',
    CONSTRAINT pk_emergency_contact PRIMARY KEY(`emergency_contact_id`)
) COMMENT 'Patient emergency contact records capturing contact name, relationship type, priority order, phone numbers (home, mobile, work), address, and authorization level (e.g., authorized to receive PHI, healthcare proxy, legal guardian). Supports EMTALA compliance, care coordination, and discharge planning workflows. Sourced from Epic and Cerner registration modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` (
    `sdoh_assessment_id` BIGINT COMMENT 'Unique surrogate identifier for each Social Determinants of Health (SDOH) assessment record in the patient domain. Primary key for this data product; referenced by downstream clinical, population health, and care management entities.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: SDOH assessments occur at specific care sites; required for CMS quality measure reporting (screening rates by facility), care management program operations, and community health needs assessments tied',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: SDOH screening tools use standardized LOINC codes (e.g., LOINC 96777-8 for housing instability) for interoperability, quality reporting, and CMS/HEDIS measure submission. Enables automated screening t',
    `community_resource_directory_community_resource_id` BIGINT COMMENT 'FK to the community resource directory for linking assessments to available community-based organizations and services.',
    `community_resource_id` BIGINT COMMENT 'FK to the community resource if referral was made',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who was administered this SDOH assessment. Links to the master patient record via the Master Patient Index (MPI). This is the primary party reference for this transaction.',
    `observation_id` BIGINT COMMENT 'The HL7 FHIR Observation resource identifier corresponding to this SDOH assessment record in the source system or Health Information Exchange (HIE). Enables interoperability with FHIR-compliant systems and supports data exchange under the CMS Interoperability and Patient Access Rule.',
    `risk_stratification_id` BIGINT COMMENT 'Risk stratification record derived from this assessment.',
    `sdoh_risk_stratification_id` BIGINT COMMENT 'Risk stratification record derived from this assessment.',
    `sdoh_zcode_mapping_id` BIGINT COMMENT 'FK to the ICD-10 Z-code to SDOH category mapping table for standardized categorization of social determinants.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this SDOH assessment was administered, if applicable. Supports linkage to the Admit-Discharge-Transfer (ADT) encounter context for population health reporting.',
    `administration_method` STRING COMMENT 'Method by which the SDOH screening assessment was administered. clinician_administered indicates face-to-face administration by a care team member; self_administered indicates patient completed independently; telephone indicates phone-based administration; electronic_portal indicates patient portal or kiosk; proxy indicates completed by a caregiver or family member on behalf of the patient.. Valid values are `clinician_administered|self_administered|telephone|electronic_portal|proxy`',
    `assessment_date` DATE COMMENT 'The calendar date on which the SDOH screening assessment was administered to the patient. This is the principal real-world business event date used for population health trending, ACO quality reporting, and CMS SDOH initiative compliance.',
    `assessment_number` STRING COMMENT 'Externally visible business identifier for this SDOH assessment record, typically system-generated by the population health or care management platform (e.g., Epic Healthy Planet, Salesforce Health Cloud). Used for cross-system referencing, audit trails, and patient communication.',
    `assessment_setting` STRING COMMENT 'Clinical or community setting in which the SDOH assessment was conducted. Supports stratification of SDOH findings by care setting for population health management and community health needs assessments (CHNA). [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|telehealth|community|home|pharmacy — 7 candidates stripped; promote to reference product]',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the SDOH assessment record. completed indicates all questions were answered; in_progress indicates partial completion; refused indicates patient declined to participate; not_applicable indicates screening was deemed clinically inappropriate; cancelled indicates the assessment was voided.. Valid values are `completed|in_progress|refused|not_applicable|cancelled`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the SDOH assessment was administered or documented in the system. Provides sub-day precision for workflow analytics, care coordination timing, and audit trail requirements.',
    `care_program_enrolled_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient was enrolled in a care management or population health program as a direct result of this SDOH assessment. Supports ACO quality reporting, HEDIS measure tracking, and population health management program analytics.',
    `consent_date` DATE COMMENT 'Date on which the patient provided informed consent for SDOH screening and data sharing. Required for HIPAA audit trail and regulatory compliance documentation.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient provided informed consent for SDOH screening and data sharing prior to administration of the assessment. Required for HIPAA compliance and data sharing with community-based organizations under the Gravity Project framework.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDOH assessment record was first created in the source system. Serves as the record audit creation timestamp for data lineage, HIPAA audit trail requirements, and Silver Layer ingestion tracking.',
    `digital_health_opt_in` STRING COMMENT '',
    `financial_strain_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient screened positive for financial strain. True indicates a positive screen. Supports financial assistance program referrals, charity care eligibility screening, and population health stratification.',
    `financial_strain_score` STRING COMMENT 'Numeric score for the financial strain SDOH domain, reflecting the patients difficulty meeting basic financial needs including utilities, medical bills, and essential expenses. Aligned with Gravity Project financial insecurity value sets.',
    `food_insecurity_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient screened positive for food insecurity based on validated threshold scoring. True indicates a positive screen requiring intervention or referral. Used for population health stratification and care management prioritization.',
    `food_insecurity_score` STRING COMMENT 'Numeric score for the food insecurity SDOH domain, derived from responses to food security screening questions (e.g., Hunger Vital Sign 2-item screener). Higher scores indicate greater food insecurity risk. Used for ACO quality reporting and community health needs assessment.',
    `housing_instability_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient screened positive for housing instability. True indicates a positive screen. Supports ACO quality reporting, CMS SDOH initiatives, and community health needs assessments.',
    `housing_instability_score` STRING COMMENT 'Numeric score for the housing instability SDOH domain, capturing risk of homelessness, housing insecurity, or inadequate housing conditions. Derived from validated screening questions aligned with Gravity Project value sets.',
    `icd10_z_code` STRING COMMENT 'ICD-10-CM Z-code (Z55-Z65 range) assigned to document the social determinant of health finding for billing, claims, and quality reporting purposes. Examples include Z59.0 (Homelessness), Z59.4 (Lack of adequate food), Z63.0 (Problems in relationship with spouse). Required for CMS SDOH quality measure reporting and value-based care programs.. Valid values are `^Z[0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `identified_needs_summary` STRING COMMENT 'Free-text or structured narrative summarizing the specific social needs identified during this assessment. Documents the patients expressed needs and priorities as captured by the administering clinician or care team member. Supports clinical documentation and care plan development.',
    `interpersonal_safety_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient screened positive for interpersonal safety concerns. True indicates a positive screen. Triggers mandatory reporting workflows and care management escalation per facility policy and applicable state law.',
    `interpersonal_safety_score` STRING COMMENT 'Numeric score for the interpersonal safety SDOH domain, capturing exposure to domestic violence, intimate partner violence, or unsafe living conditions. Derived from validated screening questions per Gravity Project value sets.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Boolean indicator of whether a professional interpreter (in-person or telephonic) was used during the SDOH assessment administration. Supports health equity reporting and Section 1557 ACA language access compliance tracking.',
    `language_of_administration` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the SDOH assessment was administered (e.g., en for English, es for Spanish). Supports health equity reporting, language access compliance, and population health stratification by preferred language.',
    `loinc_panel_code` STRING COMMENT 'LOINC code identifying the specific SDOH screening panel administered (e.g., 93025-5 for PRAPARE, 96777-8 for AHC HRSN). Enables standardized clinical data exchange, EHR interoperability, and alignment with national SDOH coding standards.',
    `overall_risk_level` STRING COMMENT 'Clinician or algorithm-assigned overall SDOH risk stratification level based on the combination of domain scores and positive flags. Drives care management program enrollment, outreach prioritization, and community health worker assignment.. Valid values are `low|moderate|high|critical`',
    `primary_sdoh_referral_id` BIGINT COMMENT 'Primary referral generated from this assessment, linking the assessment into the SDOH referral subdomain.',
    `reassessment_due_date` DATE COMMENT 'Scheduled date for the next SDOH reassessment based on clinical protocol, risk level, or care management program requirements. Drives outreach scheduling and population health management workflows in Epic Healthy Planet and Salesforce Health Cloud.',
    `reassessment_interval_days` STRING COMMENT 'Number of days between this assessment and the scheduled reassessment, as defined by the applicable care management protocol or clinical guideline. Common intervals include 90, 180, or 365 days depending on risk level and program requirements.',
    `referral_closed_date` DATE COMMENT 'Date on which the SDOH referral was closed, either due to successful resource connection, patient declination, or inability to contact. Supports referral loop closure tracking required by CMS SDOH initiatives and ACO quality reporting.',
    `referral_date` DATE COMMENT 'Date on which the referral to a community resource or social service was placed following identification of SDOH needs. Used for care coordination timeliness tracking and ACO quality measure reporting.',
    `referral_disposition` STRING COMMENT 'Outcome disposition indicating whether the patient was referred to community resources or social services based on identified SDOH needs. referred indicates active referral placed; declined_referral indicates patient declined offered resources; no_needs_identified indicates no positive screens; pending indicates referral decision in progress; self_managed indicates patient managing independently.. Valid values are `referred|declined_referral|no_needs_identified|pending|self_managed`',
    `referral_organization` STRING COMMENT 'Name of the community-based organization (CBO), social service agency, or health-related social needs resource to which the patient was referred. Supports community health needs assessment (CHNA) reporting and ACO community partnership tracking.',
    `referral_outcome` STRING COMMENT 'Outcome of the SDOH referral indicating whether the patient was successfully connected to the referred community resource. connected indicates successful resource engagement; not_connected indicates referral was unsuccessful; in_progress indicates outreach ongoing; declined indicates patient declined; unable_to_reach indicates patient could not be contacted.. Valid values are `connected|not_connected|in_progress|declined|unable_to_reach`',
    `screening_tool_code` STRING COMMENT 'Standardized code identifying the validated SDOH screening instrument used for this assessment. Supported tools include: AHC HRSN (Accountable Health Communities Health-Related Social Needs), PRAPARE (Protocol for Responding to and Assessing Patients Assets, Risks, and Experiences), Hunger Vital Sign, WHO WHOQOL, WellCare, iScreen, and Other. [ENUM-REF-CANDIDATE: AHC_HRSN|PRAPARE|HUNGER_VITAL_SIGN|WHOQOL|WELLCARE|ISCREEN|OTHER — promote to reference product]',
    `screening_tool_name` STRING COMMENT 'Human-readable name of the SDOH screening instrument used (e.g., Accountable Health Communities Health-Related Social Needs Screening Tool, PRAPARE, Hunger Vital Sign). Complements the code for display and reporting purposes.',
    `screening_tool_version` STRING COMMENT 'Version number or edition of the screening instrument used (e.g., 2019, v2.0). Important for longitudinal comparability and regulatory reporting as tool versions may change question sets and scoring algorithms.',
    `sdoh_priority_level` STRING COMMENT 'Priority tier (critical/high/medium/low) for SDOH intervention based on risk stratification algorithm output.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `sdoh_risk_score` DECIMAL(18,2) COMMENT 'Composite SDOH risk stratification score derived from screening domains, used for priority-based intervention routing and population health management.',
    `snomed_finding_code` STRING COMMENT 'SNOMED CT (Systematized Nomenclature of Medicine Clinical Terms) code representing the primary social determinant finding identified in this assessment. Supports clinical documentation, problem list coding, and interoperability with FHIR-based systems per Gravity Project value sets.',
    `social_isolation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient screened positive for social isolation. True indicates a positive screen. Supports care management program enrollment and community resource referral.',
    `social_isolation_score` STRING COMMENT 'Numeric score for the social isolation SDOH domain, measuring the patients level of social connectedness and risk of loneliness. Derived from validated screening questions aligned with Gravity Project and WHO WHOQOL social domain.',
    `total_positive_domains` STRING COMMENT 'Count of SDOH domains for which the patient screened positive in this assessment. Ranges from 0 to the total number of domains assessed. Used for risk stratification, care management prioritization, and population health reporting. This is a raw count field, not a derived aggregate metric.',
    `transportation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient screened positive for transportation barriers. True indicates a positive screen requiring care coordination or community resource referral.',
    `transportation_score` STRING COMMENT 'Numeric score for the transportation barrier SDOH domain, reflecting the patients difficulty accessing healthcare services, food, or employment due to lack of reliable transportation. Aligned with Gravity Project transportation value sets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDOH assessment record was last modified in the source system. Supports change data capture (CDC) processing in the Databricks Silver Layer, audit trail compliance, and data quality monitoring.',
    CONSTRAINT pk_sdoh_assessment PRIMARY KEY(`sdoh_assessment_id`)
) COMMENT 'Social Determinants of Health (SDOH) assessment records capturing screening tool used (AHC HRSN, PRAPARE, Hunger Vital Sign, WHO WHOQOL), assessment date, domain scores (food insecurity, housing instability, transportation, interpersonal safety, financial strain, social isolation), identified needs, referral disposition, and reassessment schedule. Supports population health management, ACO quality reporting, CMS SDOH initiatives, and community health needs assessments. Aligned with HL7 FHIR SDOH Clinical Care implementation guide and Gravity Project value sets. Sourced from population health and care management platforms.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`preference` (
    `preference_id` BIGINT COMMENT 'Primary key for preference',
    `care_site_id` BIGINT COMMENT 'Reference to the patients preferred care facility or clinic location for scheduling outpatient appointments and follow-up care. Used in Epic Cadence and Cerner Millennium to default scheduling to the patients preferred location.',
    `clinician_id` BIGINT COMMENT 'Reference to the patients designated Primary Care Physician (PCP). Used for care coordination, referral management, and attribution in value-based care programs such as ACO, HMO, and MIPS. Sourced from Epic EHR registration and Salesforce Health Cloud.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient master record for whom these care and communication preferences are recorded. Links to the patient master identity record.',
    `pharmacy_location_id` BIGINT COMMENT 'Reference to the patients preferred pharmacy for prescription fulfillment. Used by Epic Willow and Cerner PharmNet to route electronic prescriptions (e-prescribing) to the patients designated pharmacy. Supports medication adherence and care coordination.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `advance_directive_on_file` BOOLEAN COMMENT 'Indicates whether the patient has a completed advance directive (e.g., living will, healthcare proxy, POLST) on file with the health system. Triggers clinical alerts in Epic ClinDoc and Cerner PowerChart to ensure care team awareness. Required for CMS Conditions of Participation documentation.',
    `appointment_reminder_opt_in` BOOLEAN COMMENT 'Indicates whether the patient has opted in to receive automated appointment reminders via their preferred communication channel. Drives reminder workflows in Epic Cadence and Cerner Millennium scheduling. Supports no-show reduction and patient access metrics.',
    `care_management_opt_in` BOOLEAN COMMENT 'Indicates whether the patient has consented to enrollment in care management or disease management programs (e.g., chronic disease management, transitional care, ACO care coordination). Drives population health outreach in Epic Healthy Planet and Salesforce Health Cloud.',
    `care_setting_preference` STRING COMMENT 'Patients preferred care delivery setting for non-emergency services. Informs care team routing, scheduling, and population health outreach strategies. ed indicates Emergency Department (ED) preference for urgent needs. Supports health equity and SDOH analysis.. Valid values are `inpatient|outpatient|telehealth|home_health|urgent_care|ed`',
    `communication_channel` STRING COMMENT 'Patients preferred channel for receiving appointment reminders, care instructions, test results, and general health communications. Drives outreach workflows in Epic MyChart, Salesforce Health Cloud, and patient engagement platforms. Supports CAHPS patient experience measurement.. Valid values are `phone|patient_portal|mail|text_sms|email|secure_message`',
    `communication_time_preference` STRING COMMENT 'Patients preferred time of day for receiving outbound communications such as appointment reminders, care management calls, and health coaching outreach. Used by care coordinators and automated outreach systems to optimize contact rates.. Valid values are `morning|afternoon|evening|no_preference`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient preference record was first created in the system. Supports audit trail, data lineage, and HIPAA accounting of disclosures. Stored in ISO 8601 format with timezone offset.',
    `cultural_care_preference` STRING COMMENT 'Free-text or coded description of cultural practices, beliefs, or traditions that should be respected during care delivery. Examples include gender-concordant provider preference, traditional healing practices, or specific cultural rituals. Supports culturally competent care and CLAS Standards compliance.',
    `dietary_preference` STRING COMMENT 'Patients dietary preferences or restrictions relevant to inpatient meal planning and nutritional care (e.g., vegetarian, vegan, halal, kosher, gluten-free, diabetic diet). Sourced from EHR registration and nursing assessment. [ENUM-REF-CANDIDATE: vegetarian|vegan|halal|kosher|gluten_free|diabetic|low_sodium|renal — promote to reference product]',
    `digital_health_opt_in` STRING COMMENT '',
    `do_not_contact` BOOLEAN COMMENT 'Indicates that the patient has requested no outbound contact from the health system for non-clinical communications. When true, suppresses all marketing, outreach, and non-essential communications. Must be honored per HIPAA Right to Restrict and TCPA.',
    `education_material_format` STRING COMMENT 'Patients preferred format for receiving health education materials, discharge instructions, and care plan documents. Drives document generation and delivery in Epic ClinDoc and patient engagement platforms. Supports health literacy and accessibility compliance.. Valid values are `printed|digital|audio|video|pictorial|none`',
    `effective_from` DATE COMMENT 'Date from which this set of patient care and communication preferences is considered active and applicable. Enables temporal tracking of preference changes over time and supports preference versioning.',
    `effective_until` DATE COMMENT 'Date on which this set of patient care and communication preferences expires or is superseded. Null indicates the preferences are open-ended and currently active. Supports preference versioning and historical audit.',
    `gender_concordant_provider` BOOLEAN COMMENT 'Indicates whether the patient has expressed a preference to receive care from a provider of the same gender. Used in scheduling and provider assignment workflows to honor patient preferences and support culturally sensitive care delivery.',
    `health_literacy_level` STRING COMMENT 'Assessment of the patients health literacy level, indicating their ability to understand health information, medication instructions, and care plans. Informs the complexity and format of patient education materials. Supports SDOH analysis and health equity initiatives.. Valid values are `basic|below_average|average|above_average|unknown`',
    `hearing_accommodation` STRING COMMENT 'Specific hearing-related accessibility accommodation required by the patient during clinical encounters and communications. Drives accommodation scheduling and facility preparation. Supports ADA compliance and CLAS Standards.. Valid values are `none|hearing_aid|cochlear_implant|asl_interpreter|captioning|amplified_phone`',
    `interpreter_needed` BOOLEAN COMMENT 'Indicates whether the patient requires professional interpreter services for clinical encounters. When true, triggers interpreter scheduling workflows in Epic Cadence and Cerner Millennium scheduling modules. Supports compliance with Section 1557 of the Affordable Care Act.',
    `interpreter_type` STRING COMMENT 'Specifies the modality of interpreter service preferred or required by the patient. sign_language indicates American Sign Language (ASL) or other signed language interpreter. Informs scheduling and resource allocation in Epic Cadence.. Valid values are `in_person|telephonic|video_remote|sign_language|none`',
    `last_verified_by` STRING COMMENT 'Name or identifier of the staff member, system, or patient who last verified and confirmed the accuracy of the preference record. Supports audit trail and accountability for preference data quality.',
    `last_verified_date` DATE COMMENT 'Date on which the patients preferences were last reviewed and confirmed as current by the patient or a designated representative. Supports preference currency tracking and drives re-verification workflows at registration. Aligns with CMS patient engagement requirements.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the patient has opted in to receive health system marketing communications, wellness newsletters, and promotional health content. Distinct from clinical communications. Governed by HIPAA marketing rules and CAN-SPAM Act.',
    `mobility_accommodation` STRING COMMENT 'Specific mobility-related accessibility accommodation required by the patient for facility navigation, exam room setup, and transport. Informs facility preparation and scheduling in Epic Cadence. Supports ADA compliance.. Valid values are `none|wheelchair|bariatric|stretcher|walker|accessible_parking`',
    `mrn` STRING COMMENT 'Medical Record Number assigned by the facility to uniquely identify the patient within the health system. Used to correlate preferences with clinical and financial records in Epic EHR and Cerner Millennium.',
    `notification_email` STRING COMMENT 'Email address designated by the patient for receiving healthcare notifications, appointment reminders, and portal communications. May differ from the primary contact email on the patient master record. Governed by HIPAA and CAN-SPAM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `notification_phone` STRING COMMENT 'Phone number designated by the patient for receiving healthcare notifications, appointment reminders, and care team calls. Expressed in E.164 international format. Governed by TCPA for automated outreach.. Valid values are `^+?[1-9]d{1,14}$`',
    `organ_donation_status` STRING COMMENT 'Patients registered organ and tissue donation preference. Sourced from state donor registries and patient registration. Required for CMS Conditions of Participation and UNOS reporting. Informs clinical teams during end-of-life care planning.. Valid values are `donor|non_donor|unknown|pending`',
    `portal_enrolled` BOOLEAN COMMENT 'Indicates whether the patient is actively enrolled in the patient portal (e.g., Epic MyChart). Portal enrollment enables secure messaging, online scheduling, test result viewing, and medication refill requests. Tracked for CMS Meaningful Use and patient engagement metrics.',
    `portal_enrollment_date` DATE COMMENT 'Date on which the patient first activated and enrolled in the patient portal. Used to calculate portal engagement duration and for CMS Promoting Interoperability reporting.',
    `preference_status` STRING COMMENT 'Current lifecycle status of the patient preference record. active indicates preferences are current and in use; superseded indicates a newer version exists; pending_review indicates patient-submitted preferences awaiting staff validation.. Valid values are `active|inactive|pending_review|superseded`',
    `preferred_contact_name` STRING COMMENT 'Full name of the patients preferred contact person for care coordination communications, appointment reminders, and non-emergency notifications. May be a family member, caregiver, or healthcare proxy. Distinct from the emergency contact on the patient master record.',
    `preferred_contact_relationship` STRING COMMENT 'Relationship of the preferred contact person to the patient. Used to determine appropriate disclosure scope under HIPAA and to contextualize care coordination communications. [ENUM-REF-CANDIDATE: self|spouse|parent|child|sibling|caregiver|legal_guardian|other — 8 candidates stripped; promote to reference product]',
    `preferred_language` STRING COMMENT 'The patients preferred spoken and written language for receiving healthcare services, clinical instructions, and communications. Expressed as an ISO 639-1 or BCP-47 language code (e.g., en, es, zh-TW). Drives interpreter service requests and multilingual document generation. Required for CLAS Standards compliance and CAHPS survey performance.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `prom_opt_in_flag` BOOLEAN COMMENT 'Patient preference flag indicating consent to receive PROM surveys via the patient portal or RPM app.',
    `religious_preference` STRING COMMENT 'Patients religious or spiritual affiliation relevant to care delivery, chaplaincy services, dietary restrictions, and end-of-life planning. Informs culturally sensitive care and chaplain referrals. Stored as free text or standardized code per facility policy. Supports CAHPS patient experience and health equity initiatives.',
    `research_participation_consent` BOOLEAN COMMENT 'Indicates whether the patient has consented to be contacted for clinical research studies and trials. Drives patient recruitment workflows in research management systems. Supports IRB-compliant research operations and HIPAA Authorization requirements.',
    `rpm_opt_in_flag` BOOLEAN COMMENT 'Patient preference flag indicating consent to participate in Remote Patient Monitoring programs.',
    `sdoh_screening_consent` BOOLEAN COMMENT 'Indicates whether the patient has consented to Social Determinants of Health (SDOH) screening and data collection, including housing, food security, transportation, and social support assessments. Required for NCQA Health Equity Accreditation and CMS SDOH initiatives.',
    `source` STRING COMMENT 'Source channel or system through which the patients preferences were captured or last updated. Supports data provenance, audit, and quality assessment. Values align with operational systems including Epic MyChart portal, Salesforce Health Cloud, and EHR registration workflows. [ENUM-REF-CANDIDATE: patient_portal|registration_staff|care_team|phone|mail|ehr_import|health_cloud — 7 candidates stripped; promote to reference product]',
    `surrogate_decision_maker` BOOLEAN COMMENT 'Indicates whether the patient has designated a surrogate decision maker (healthcare proxy, power of attorney for healthcare) to make medical decisions on their behalf. Triggers documentation workflows in Epic ClinDoc. Required for CMS Conditions of Participation.',
    `telehealth_consent` BOOLEAN COMMENT 'Indicates whether the patient has provided informed consent to receive care via telehealth modalities. Required before scheduling virtual visits in Epic Cadence or Cerner Millennium. Supports compliance with state telehealth consent laws and CMS telehealth billing requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient preference record was most recently modified. Supports change tracking, data freshness monitoring, and HIPAA audit requirements. Stored in ISO 8601 format with timezone offset.',
    `vision_accommodation` STRING COMMENT 'Specific vision-related accessibility accommodation required by the patient for clinical materials, consent forms, and communications. Ensures accessible health information delivery per ADA and Section 508 requirements.. Valid values are `none|large_print|braille|screen_reader|magnification|low_vision_aid`',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Patient care and communication preferences capturing preferred language for care, interpreter needs, preferred communication channel (phone, portal, mail, text), preferred pharmacy, PCP preference, care setting preferences, accessibility needs (hearing, vision, mobility), cultural and religious care preferences, and patient portal enrollment status. Supports patient-centered care delivery, CAHPS survey performance, and health equity initiatives. Sourced from EHR registration and patient engagement platforms.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` (
    `pcp_attribution_id` BIGINT COMMENT 'Unique surrogate identifier for each PCP attribution record in the Master Patient Index (MPI) attribution registry. Serves as the primary key for all downstream joins across population health, HEDIS, and value-based care reporting.',
    `accountable_care_organization_id` BIGINT COMMENT 'Reference to the Accountable Care Organization (ACO) record when the attribution is governed by an ACO participation agreement. Required for CMS Shared Savings Program (MSSP) and Next Generation ACO attribution reporting and shared savings calculations.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: PCP attribution requires tracking the specialty of the attributed provider for network adequacy reporting, panel composition analysis, primary care vs specialist attribution rules, and risk-adjusted q',
    `attribution_panel_id` BIGINT COMMENT 'Reference to the provider panel or patient panel record to which this attribution belongs. A panel represents the defined roster of patients assigned to a PCP or care team for population health management, capacity planning, and value-based care performance measurement.',
    `care_site_id` BIGINT COMMENT 'Reference to the primary care facility or clinic where the attributed PCP practices and where the patient receives primary care services. Used for facility-level population health reporting, capacity planning, and geographic attribution analysis.',
    `care_team_id` BIGINT COMMENT 'Reference to the care team record when attribution is assigned to a multidisciplinary care team rather than a single PCP. Supports Accountable Care Organization (ACO) and Patient-Centered Medical Home (PCMH) attribution models where team-based care is the unit of attribution.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician record for the Primary Care Physician (PCP) or care team lead to whom the patient is attributed. Used to resolve provider demographics, specialty, and panel capacity from the provider domain.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient record in the Master Patient Index (MPI). Links the attribution record to the attributed patients demographic and identity data. Every clinical and financial domain references this identifier.',
    `health_plan_id` BIGINT COMMENT 'Reference to the payer insurance plan record associated with this attribution. Attribution rules and measurement periods vary by plan type (ACO, HMO, PPO, POS). Links to the billing and revenue cycle domain for plan-specific attribution logic.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `aco_contract_number` STRING COMMENT 'CMS-assigned contract number for the Accountable Care Organization (ACO) governing this attribution. Required for CMS Medicare Shared Savings Program (MSSP) reporting, shared savings reconciliation, and regulatory submissions to CMS.. Valid values are `^ACO[0-9]{6}$`',
    `attributed_provider_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the attributed Primary Care Physician (PCP) or care team lead as registered with the National Plan and Provider Enumeration System (NPPES). Required for HEDIS, MIPS, and CMS value-based care reporting submissions.. Valid values are `^[0-9]{10}$`',
    `attribution_confidence_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the statistical confidence level of the attribution assignment. Higher scores indicate stronger evidence of the patient-PCP relationship based on visit frequency, claims history, or enrollment data. Used to prioritize manual review of low-confidence attributions and to weight population health analytics.',
    `attribution_method` STRING COMMENT 'The methodology used to assign the patient to the PCP or care team. Claims-based attribution uses historical utilization patterns; enrollment-based uses payer plan enrollment data; manual is provider-assigned; algorithm-based uses predictive models; hybrid combines multiple methods; empanelment is practice-panel assignment. Drives HEDIS, MIPS, and ACO reporting logic.. Valid values are `claims_based|enrollment_based|manual|algorithm_based|hybrid|empanelment`',
    `attribution_override_reason` STRING COMMENT 'Free-text or coded reason when an attribution assignment has been manually overridden from the algorithm-generated or payer-assigned attribution. Documents the clinical or administrative justification for the override, supporting audit trails and compliance with CMS and NCQA attribution integrity requirements.',
    `attribution_rank` STRING COMMENT 'Ordinal rank (1 = primary) when a patient has multiple concurrent attribution records across different payers or plans. Rank 1 designates the primary PCP attribution used for population health management and HEDIS reporting. Higher ranks indicate secondary or supplemental attributions.',
    `attribution_review_date` DATE COMMENT 'Scheduled or completed date for the next periodic review of this attribution record. Attribution records are reviewed quarterly or annually per payer contract requirements to ensure accuracy of panel rosters and compliance with HEDIS and MIPS reporting periods.',
    `attribution_segment` STRING COMMENT 'Insurance coverage segment of the attributed patient. Determines applicable attribution methodology, quality measure set, and regulatory reporting requirements. Dual eligible patients (Medicare and Medicaid) require special attribution handling per CMS duals coordination rules.. Valid values are `commercial|medicare|medicaid|dual_eligible|uninsured`',
    `attribution_source` STRING COMMENT 'The operational system of record from which this attribution record was sourced. Identifies whether the attribution originated from Epic Healthy Planet, Cerner Millennium, a payer attribution feed, manual entry, HL7 FHIR interface, or a population health management platform. Critical for data lineage and ETL reconciliation.. Valid values are `epic_healthy_planet|cerner_millennium|payer_feed|manual_entry|hl7_fhir|population_health_platform`',
    `attribution_status` STRING COMMENT 'Current lifecycle status of the PCP attribution record. Active indicates a current, valid attribution; pending indicates awaiting confirmation; disputed indicates a payer or provider challenge; terminated indicates the attribution period has ended; under_review indicates compliance or audit review in progress.. Valid values are `active|inactive|pending|terminated|disputed|under_review`',
    `care_management_enrolled` BOOLEAN COMMENT 'Indicates whether the attributed patient is currently enrolled in a care management or disease management program under the attributed PCP or ACO. True = enrolled in care management. Used for population health program tracking and HEDIS care management measure reporting.',
    `consent_on_file` BOOLEAN COMMENT 'Indicates whether the patient has provided documented consent for their health information to be shared with the attributed PCP, care team, and ACO for care coordination and population health management purposes. Required for HIPAA-compliant data sharing under ACO and HIE participation agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PCP attribution record was first created in the Silver Layer lakehouse. Supports data lineage, audit trail requirements, and compliance with HIPAA audit control standards. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_sharing_opt_out` BOOLEAN COMMENT 'Indicates whether the patient has exercised their right to opt out of data sharing with the ACO or population health program under CMS beneficiary notification and opt-out requirements. True = patient has opted out. Patients who opt out must be excluded from ACO attribution and shared data feeds.',
    `digital_health_opt_in` STRING COMMENT '',
    `disenrollment_reason` STRING COMMENT 'Coded reason for the termination of the PCP attribution. Used for panel management analytics, provider turnover reporting, and population health program evaluation. [ENUM-REF-CANDIDATE: provider_change|plan_disenrollment|patient_request|provider_termination|death|moved_out_of_area|other — promote to reference product]',
    `effective_date` DATE COMMENT 'The calendar date on which the PCP attribution becomes effective and the patient is considered part of the attributed providers panel. Used as the start boundary for HEDIS measurement periods, MIPS performance calculations, and ACO shared savings attribution windows.',
    `end_date` DATE COMMENT 'The calendar date on which the PCP attribution terminates. Null indicates an open-ended, currently active attribution. Used to calculate attribution duration, panel turnover, and to exclude patients from measurement periods after disenrollment or provider change.',
    `geographic_region` STRING COMMENT 'Geographic region or service area associated with this attribution record, typically aligned with CMS Hospital Referral Regions (HRR) or payer-defined service areas. Used for population health geographic analysis, regional quality benchmarking, and ACO regional benchmark calculations.',
    `hcc_risk_score` DECIMAL(18,2) COMMENT 'CMS Hierarchical Condition Category (HCC) risk adjustment score for the attributed patient at the time of attribution. Used in Medicare Advantage and ACO shared savings calculations to adjust expected expenditures for patient complexity. Sourced from CMS risk adjustment data or population health platform.',
    `hedis_eligible` BOOLEAN COMMENT 'Indicates whether this attribution record qualifies the patient for inclusion in HEDIS (Healthcare Effectiveness Data and Information Set) measure calculations for the current measurement year. Eligibility is determined by continuous enrollment criteria, plan type, and attribution method per NCQA HEDIS Technical Specifications.',
    `is_primary_attribution` BOOLEAN COMMENT 'Indicates whether this attribution record is the patients primary PCP attribution used as the single source of truth (SSOT) for population health management, HEDIS measurement, and MIPS performance reporting. True = primary attribution; False = secondary or supplemental attribution.',
    `last_visit_date` DATE COMMENT 'Date of the most recent qualifying primary care visit between the patient and the attributed PCP within the attribution lookback period. Used to assess recency of the patient-provider relationship and to support attribution validation and panel management.',
    `lookback_period_months` STRING COMMENT 'The number of months in the historical claims lookback window used to determine claims-based attribution. Standard values are 12 or 24 months per CMS and NCQA attribution methodologies. Stored to support audit and reproducibility of attribution assignments.',
    `measurement_year` STRING COMMENT 'The calendar year for which this attribution record is applicable for quality measurement reporting (HEDIS, MIPS, ACO quality measures). Attribution records are typically finalized at the start of each measurement year and used throughout the performance period.',
    `mips_eligible` BOOLEAN COMMENT 'Indicates whether the attributed provider qualifies for Merit-based Incentive Payment System (MIPS) performance measurement under MACRA for this attribution record. Eligibility is based on provider NPI, patient volume thresholds, and billing thresholds per CMS MIPS eligibility criteria.',
    `mrn` STRING COMMENT 'Facility-assigned Medical Record Number (MRN) for the patient. Used to cross-reference attribution records with the Electronic Health Record (EHR) source system (Epic Healthy Planet / Cerner Millennium) and to validate patient identity during attribution reconciliation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `override_authorized_by` STRING COMMENT 'Name or identifier of the clinical or administrative staff member who authorized a manual attribution override. Required for audit trail integrity and compliance with CMS and NCQA attribution override documentation requirements.',
    `override_date` DATE COMMENT 'Date on which the manual attribution override was authorized and applied. Used in conjunction with override_authorized_by and attribution_override_reason to maintain a complete audit trail of attribution changes.',
    `panel_assignment_date` DATE COMMENT 'Date the patient was formally added to the attributed PCPs patient panel in the practice management or population health system (e.g., Epic Healthy Planet empanelment). May differ from the attribution effective date when payer attribution and practice empanelment are managed separately.',
    `payer_attribution_number` STRING COMMENT 'The external attribution identifier assigned by the payer or managed care organization in their attribution feed. Used to reconcile internal attribution records with payer-issued attribution rosters and to resolve attribution disputes with payers.',
    `payer_name` STRING COMMENT 'Name of the health insurance payer or managed care organization that issued the attribution assignment. Used for payer-specific attribution reconciliation, HEDIS reporting submissions, and value-based contract performance tracking.',
    `plan_type` STRING COMMENT 'The type of health insurance plan governing this attribution relationship. Accountable Care Organization (ACO), Health Maintenance Organization (HMO), Preferred Provider Organization (PPO), Point of Service (POS), Exclusive Provider Organization (EPO), or Patient-Centered Medical Home (PCMH). Determines attribution methodology and performance measurement rules.. Valid values are `ACO|HMO|PPO|POS|EPO|PCMH`',
    `risk_stratification_tier` STRING COMMENT 'Patient risk stratification tier assigned at the time of attribution, based on clinical complexity, chronic condition burden, and Social Determinants of Health (SDOH) factors. Used by the attributed PCP and care team to prioritize outreach, care management intensity, and resource allocation in population health programs.. Valid values are `low|moderate|high|very_high`',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether the patient has documented Social Determinants of Health (SDOH) risk factors (e.g., food insecurity, housing instability, transportation barriers) that require care coordination support from the attributed PCP or care team. True = SDOH risk factors present.',
    `source_feed_date` DATE COMMENT 'Date of the payer attribution feed or population health system extract from which this attribution record was loaded. Used for data currency validation, ETL reconciliation, and to identify stale attribution records that require refresh from the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PCP attribution record was last modified in the Silver Layer lakehouse. Used to detect and process incremental changes during ETL pipeline runs and to support audit trail requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `visit_count_lookback` STRING COMMENT 'Number of qualifying primary care visits with the attributed provider during the claims-based attribution lookback period (typically 24 months). Used to validate and support claims-based attribution assignments and to calculate attribution confidence scores per CMS and NCQA methodologies.',
    CONSTRAINT pk_pcp_attribution PRIMARY KEY(`pcp_attribution_id`)
) COMMENT 'Patient attribution to Primary Care Physician (PCP) or care team records capturing attributed provider NPI, attribution method (claims-based, enrollment-based, manual), attribution panel, attribution effective and end dates, ACO/HMO/PPO plan attribution, and attribution confidence score. SSOT for care team assignment used in population health, HEDIS, MIPS, and value-based care reporting. Sourced from population health management and payer attribution feeds.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` (
    `eligibility_check_id` BIGINT COMMENT 'Unique surrogate identifier for each insurance eligibility verification transaction record in the Silver layer lakehouse.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Eligibility verifications occur at registration/service delivery locations; essential for revenue cycle facility-level reconciliation, payer contract compliance tracking by site, and identifying facil',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Real-time benefit verification during CPOE ordering requires linking eligibility checks to specific orders for prior authorization determination, formulary checking, and coverage validation at order p',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Real-time eligibility verification at registration/scheduling validates patient benefits against specific health plan (not just payer). Deductible, copay, and network status are plan-specific. Removes',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Real-time eligibility verification is performed at imaging order placement for prior authorization requirements and coverage verification. Radiology orders frequently require pre-service authorization',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Eligibility checks verify specific insurance coverage records. Currently eligibility_check links to payer and subscriber separately, but the authoritative coverage record is insurance_coverage. Adding',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose insurance eligibility is being verified. Links to the Master Patient Index (MPI) and serves as the primary party reference for this transaction.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Eligibility verifications are often triggered by specific provider orders or referrals. Tracking the ordering clinician supports prior authorization workflows, audit trails for medical necessity, and ',
    `sdoh_referral_id` BIGINT COMMENT '',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or scheduled appointment that triggered this eligibility verification. Nullable when verification is performed outside of a specific encounter context (e.g., batch eligibility runs).',
    `clearinghouse_name` STRING COMMENT 'The name of the EDI clearinghouse (e.g., Change Healthcare, Availity, Waystar) used to route the 270/271 eligibility transaction between the provider and the payer. Null for direct payer connections.',
    `coinsurance_percent` DECIMAL(18,2) COMMENT 'The percentage of covered service costs the patient is responsible for after the deductible is met, as confirmed in the eligibility response (e.g., 20.00 for a 20% patient coinsurance obligation).',
    `coordination_of_benefits_flag` BOOLEAN COMMENT 'Indicates whether the patient has multiple insurance coverages requiring Coordination of Benefits (COB) processing. True = secondary or tertiary payer exists and COB rules must be applied during claims adjudication.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The fixed copayment amount the patient is required to pay at the time of service for the applicable service type (e.g., office visit, specialist, ED), as confirmed in the eligibility response.',
    `coverage_type` STRING COMMENT 'Indicates the order of coverage for this payer relative to other payers the patient may have. primary = first-pay payer; secondary = pays after primary; tertiary = pays after secondary.. Valid values are `primary|secondary|tertiary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility check record was first created in the source system and ingested into the Silver layer. Supports audit trail and data lineage requirements.',
    `digital_health_opt_in` STRING COMMENT '',
    `family_deductible_amount` DECIMAL(18,2) COMMENT 'The annual family deductible amount for the patients insurance plan as confirmed in the eligibility response. Applicable when the patient is covered under a family plan.',
    `group_number` STRING COMMENT 'The insurance group number associated with the patients coverage plan, as returned in the payers eligibility response. Identifies the employer group or plan sponsor.',
    `individual_deductible_amount` DECIMAL(18,2) COMMENT 'The annual individual deductible amount for the patients insurance plan as confirmed in the eligibility response. Represents the amount the patient must pay out-of-pocket before insurance begins covering costs.',
    `individual_deductible_met_amount` DECIMAL(18,2) COMMENT 'The year-to-date amount of the individual deductible that the patient has already satisfied as of the verification date. Used to calculate remaining patient financial responsibility.',
    `individual_out_of_pocket_max` DECIMAL(18,2) COMMENT 'The annual individual out-of-pocket maximum (OOPM) for the patients plan as confirmed in the eligibility response. Once met, the insurer covers 100% of covered services for the remainder of the benefit year.',
    `individual_out_of_pocket_met` DECIMAL(18,2) COMMENT 'The year-to-date amount applied toward the patients individual out-of-pocket maximum as of the verification date. Used to determine remaining patient financial liability.',
    `is_override` BOOLEAN COMMENT 'Indicates whether the eligibility verification result was manually overridden by a staff member, superseding the automated payer response. True = result was overridden; False = result reflects the original payer response.',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) of the patient as used in the eligibility inquiry submitted to the payer. Captured here as it appeared in the transaction for audit and reconciliation purposes.',
    `network_status` STRING COMMENT 'Indicates whether the rendering provider or facility is in-network or out-of-network with the patients insurance plan, as confirmed in the eligibility response. Affects patient cost-sharing obligations.. Valid values are `in_network|out_of_network|unknown`',
    `override_reason` STRING COMMENT 'Free-text reason documented when a staff member manually overrides the eligibility verification result (e.g., patient confirmed coverage verbally, payer system outage). Supports audit trail for compliance.',
    `prior_auth_number` STRING COMMENT 'The prior authorization number issued by the payer for the specific service, if authorization has already been obtained at the time of eligibility verification. Null if no prior auth exists or is not yet required.',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether the payer requires prior authorization (PA) for the service type being verified. True = prior authorization must be obtained before rendering service to avoid claim denial.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether the patients plan requires a referral from a Primary Care Physician (PCP) before the patient can receive specialist or ancillary services. Common for HMO and POS plan types.',
    `rejection_reason_code` STRING COMMENT 'The ASC X12 AAA reject reason code returned by the payer when the eligibility inquiry could not be processed (e.g., 15 = Required information missing, 72 = Invalid/missing subscriber/insured ID). Null when verification is successful.',
    `rejection_reason_description` STRING COMMENT 'Human-readable description of the rejection reason returned by the payer or clearinghouse when the eligibility inquiry failed. Supports staff workflow resolution and denial prevention.',
    `response_timestamp` TIMESTAMP COMMENT 'The exact date and time when the payer returned the eligibility response (271 transaction or portal/phone response). Used to calculate verification turnaround time for SLA monitoring.',
    `service_date` DATE COMMENT 'The date of service for which eligibility is being verified. May be the date of an upcoming appointment or the date of a completed encounter. Used to confirm coverage was active on the specific date of care.',
    `service_type_code` STRING COMMENT 'The ASC X12 service type code indicating the category of healthcare service for which eligibility was verified (e.g., 30 = Health Benefit Plan Coverage, 98 = Professional Physician Visit, 48 = Hospital Inpatient). Aligns with the 271 EB01 element.',
    `transaction_control_number` STRING COMMENT 'Unique control number assigned to the 270/271 EDI eligibility inquiry and response transaction set. Used for end-to-end transaction tracing and reconciliation with payer acknowledgments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility check record was last modified, such as when a manual override or correction was applied post-verification.',
    `verification_method` STRING COMMENT 'The method used to perform the eligibility verification. edi_270_271 = HIPAA-compliant EDI transaction; portal = payer web portal; phone = telephone inquiry; fax = fax-based verification; real_time_api = real-time API call (e.g., FHIR-based); batch = overnight batch eligibility run.. Valid values are `edi_270_271|portal|phone|fax|real_time_api|batch`',
    `verification_status` STRING COMMENT 'Current lifecycle status of the eligibility verification transaction as returned by the payer. active = patient is currently covered; inactive = coverage lapsed; pending = awaiting payer response; error = transaction failed; partial = incomplete response received; not_found = member not found in payer system.. Valid values are `active|inactive|pending|error|partial|not_found`',
    `verification_timestamp` TIMESTAMP COMMENT 'The exact date and time when the eligibility verification request was initiated and submitted to the payer. Serves as the principal business event timestamp for this transaction.',
    `verification_type` STRING COMMENT 'Indicates whether the eligibility check was performed in real-time at point of service, as part of a scheduled batch run (e.g., night-before appointment verification), or manually initiated by a staff member.. Valid values are `real_time|batch|manual|scheduled`',
    `verified_by_user` STRING COMMENT 'The username or staff identifier of the person who performed or confirmed the eligibility verification, applicable for manual or portal-based verifications. Null for fully automated EDI or batch verifications.',
    CONSTRAINT pk_eligibility_check PRIMARY KEY(`eligibility_check_id`)
) COMMENT 'Real-time and batch insurance eligibility verification transaction records capturing verification date and time, payer queried, verification method (270/271 EDI, portal, phone), eligibility status returned, coverage details confirmed, copay/deductible amounts verified, prior authorization requirements, and verification source system. Supports front-end RCM workflows and reduces claim denials. Sourced from Epic Resolute and Cerner Revenue Cycle eligibility modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`registration_event` (
    `registration_event_id` BIGINT COMMENT 'Unique surrogate identifier for each patient registration lifecycle event record in the Master Patient Index (MPI). Primary key for this product. Role: TRANSACTION_HEADER.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, clinic, outpatient center) where this registration event was initiated. Enables facility-level MPI analytics and cross-facility duplicate detection.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce employee or user who performed or initiated this registration event. Used for accountability, training quality review, and registration error attribution.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: ADT registration events capture plan-specific enrollment context at point of service for billing and eligibility. Business process: admit/transfer/discharge messages include plan details for claims su',
    `insurance_coverage_id` BIGINT COMMENT 'Reference to the patients primary insurance coverage record active at the time of this registration event. Used for eligibility verification, prior authorization, and revenue cycle management.',
    `clinician_id` BIGINT COMMENT 'Reference to the attending clinician assigned to the patient at the time of registration. Corresponds to HL7 PV1-7 Attending Doctor. Used for care team attribution and provider-level registration analytics.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient master record in the Master Patient Index (MPI) for whom this registration event was generated. Links every registration event to the canonical patient identity.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `tertiary_registration_pcp_provider_clinician_id` BIGINT COMMENT 'Reference to the patients designated Primary Care Physician (PCP) at the time of registration. Used for care coordination, referral authorization, and population health management.',
    `admission_type` STRING COMMENT 'Classifies the urgency and nature of the patients admission at registration. Aligns with UB-04 Form Locator 14 and CMS billing requirements. Drives DRG grouping and reimbursement logic.. Valid values are `elective|urgent|emergent|newborn|trauma`',
    `admit_reason` STRING COMMENT 'Free-text or coded description of the chief complaint or reason for the patients registration or admission at this event. Corresponds to HL7 PV2-3 Admit Reason. Supports clinical documentation and triage analytics.',
    `adt_message_type` STRING COMMENT 'The HL7 Admit Discharge Transfer (ADT) message type code that triggered or corresponds to this registration event (e.g., A01, A04, A08, A28, A31, A40). Provides direct traceability to the source HL7 message for interoperability and audit purposes.',
    `advance_directive_flag` BOOLEAN COMMENT 'Indicates whether the patient has an advance directive (e.g., living will, healthcare proxy, DNR order) on file at the time of this registration event. Required by the Patient Self-Determination Act and CMS Conditions of Participation.',
    `completeness_score` DECIMAL(18,2) COMMENT 'A numeric score (0.00–100.00) representing the percentage of required registration data fields that were populated at the time of this event. Used to identify incomplete registrations requiring follow-up and to measure registration quality across facilities and staff.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether the patients general consent for treatment was obtained and documented during this registration event. Required for HIPAA compliance and The Joint Commission accreditation standards.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this registration event record was first created in the data platform. Serves as the record audit creation timestamp for data lineage, SLA monitoring, and ETL reconciliation.',
    `digital_health_opt_in` STRING COMMENT '',
    `discharge_disposition` STRING COMMENT 'The patients discharge disposition code at the time of a discharge-related registration update event (e.g., home, skilled nursing facility, expired, AMA). Corresponds to UB-04 Form Locator 17 and HL7 PV1-36. Null for non-discharge events. [ENUM-REF-CANDIDATE: home|snf|rehab|expired|ama|transfer|hospice|ltac — promote to reference product]',
    `drg_code` STRING COMMENT 'The preliminary Diagnosis-Related Group (DRG) code assigned at registration based on the anticipated principal diagnosis and procedure. Used for prospective payment estimation and case mix index (CMI) tracking. May be updated at discharge.',
    `duplicate_flag` BOOLEAN COMMENT 'Indicates whether this registration event was identified as a potential duplicate patient record in the Master Patient Index (MPI). Triggers MPI duplicate review and merge workflow. Critical for patient safety and data integrity.',
    `eligibility_verification_timestamp` TIMESTAMP COMMENT 'The date and time at which insurance eligibility was electronically verified for this registration event. Used for revenue cycle audit trails and payer dispute resolution.',
    `eligibility_verified_flag` BOOLEAN COMMENT 'Indicates whether the patients insurance eligibility was verified in real-time during this registration event via electronic eligibility transaction (HIPAA 270/271). Supports revenue cycle management and denial prevention.',
    `enterprise_mrn` STRING COMMENT 'The enterprise-wide Medical Record Number assigned by the Master Patient Index (MPI) that persists across all facilities and registration events for a single patient identity. Distinct from facility-level MRN.',
    `event_status` STRING COMMENT 'Current workflow status of the registration event. Completed indicates the event was fully processed and committed to the MPI. Pending indicates the event is awaiting verification or approval. Failed indicates a system or validation error prevented completion.. Valid values are `completed|pending|cancelled|failed|in_progress`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the registration event occurred in the source system. Represents the real-world business event time, not the record audit timestamp. Used for MPI audit trail sequencing and regulatory reporting.',
    `event_type` STRING COMMENT 'Classifies the type of registration lifecycle event: new_registration (first-time patient identity creation), pre_registration (advance registration before arrival), update (demographic or insurance data change), merge (two patient records combined in MPI), unmerge (previously merged records separated). Drives MPI audit trail logic.. Valid values are `new_registration|pre_registration|update|merge|unmerge`',
    `expected_los_days` DECIMAL(18,2) COMMENT 'The anticipated Length of Stay (LOS) in days estimated at the time of registration or admission. Used for bed management, discharge planning, and case management workflows. Supports Average Length of Stay (ALOS) benchmarking.',
    `financial_class` STRING COMMENT 'The patients financial classification at the time of registration, indicating the primary payer category (e.g., Medicare, Medicaid, Commercial, Self-Pay, Charity). Drives revenue cycle routing, eligibility verification, and billing workflows. [ENUM-REF-CANDIDATE: medicare|medicaid|commercial|self_pay|charity|workers_comp|tricare — promote to reference product]',
    `hipaa_notice_delivered_flag` BOOLEAN COMMENT 'Indicates whether the HIPAA Notice of Privacy Practices (NPP) was delivered to the patient during this registration event, as required by the HIPAA Privacy Rule. Supports OCR audit readiness.',
    `identity_verification_method` STRING COMMENT 'The method used to verify the patients identity at the time of registration. Options include government-issued photo ID, insurance card, biometric scan, passport, self-reported (no verification), or none. Critical for fraud prevention, HIPAA compliance, and MPI accuracy.. Valid values are `photo_id|insurance_card|biometric|passport|none|self_reported`',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether the patient requires interpreter services at the time of this registration event. Triggers interpreter scheduling workflows and ensures compliance with Section 1557 of the Affordable Care Act language access requirements.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this registration event record is the current active version in the silver layer. Set to False for records superseded by subsequent updates, merges, or corrections. Supports slowly changing dimension (SCD) pattern for MPI history.',
    `language_preference` STRING COMMENT 'The patients preferred spoken or written language for communication, captured at registration. Drives interpreter services requests and language-concordant care delivery. Stored as ISO 639-1 two-letter language code (e.g., en, es, zh).',
    `mpi_match_score` DECIMAL(18,2) COMMENT 'The probabilistic match score (0.00–100.00) assigned by the MPI algorithm when this registration event was processed, indicating the confidence level of patient identity matching. Scores above threshold trigger auto-merge; scores in range trigger manual review.',
    `mpi_match_status` STRING COMMENT 'The outcome of the MPI identity matching process for this registration event. Indicates whether the patient was identified as a new patient, automatically matched to an existing record, flagged for manual review, automatically merged, or returned no match.. Valid values are `new_patient|auto_matched|manual_review|auto_merged|no_match`',
    `mrn` STRING COMMENT 'The Medical Record Number assigned to the patient at the registering facility at the time of this event. Serves as the facility-level patient identifier within the Electronic Health Record (EHR). May differ across facilities before MPI merge resolution.',
    `patient_class` STRING COMMENT 'The patient classification at the time of this registration event, indicating the intended care setting. Aligns with HL7 PV1-2 Patient Class field. Drives billing, bed management, and regulatory reporting logic.. Valid values are `inpatient|outpatient|emergency|observation|recurring|preadmit`',
    `point_of_care` STRING COMMENT 'The specific unit, department, or care area within the facility where the patient was registered (e.g., Emergency Department, ICU, Outpatient Clinic). Corresponds to HL7 PV1-3 Assigned Patient Location. Used for capacity and throughput analytics.',
    `pre_authorization_number` STRING COMMENT 'The prior authorization number obtained from the payer at the time of registration for planned services. Required for revenue cycle management and claim adjudication. Null if no prior authorization was required or obtained.',
    `prior_mrn` STRING COMMENT 'The Medical Record Number of the patient record that was merged or unmerged in this event. Preserved for MPI audit trail and downstream system reconciliation. Null for non-merge events.',
    `registration_date` DATE COMMENT 'The calendar date on which the patient registration event was initiated. Used for day-level reporting, scheduling, and operational analytics distinct from the precise event timestamp.',
    `registration_source` STRING COMMENT 'The channel or pathway through which the patient registration was initiated. Examples include Emergency Department (ED) walk-in, scheduled appointment, inpatient transfer, online pre-registration portal, referral, or direct admission. Supports operational throughput and access analytics. [ENUM-REF-CANDIDATE: ed_walk_in|scheduled|transfer|online_pre_registration|referral|direct_admit — promote to reference product]. Valid values are `ed_walk_in|scheduled|transfer|online_pre_registration|referral|direct_admit`',
    `restricted_record_flag` BOOLEAN COMMENT 'Indicates whether this patients record has been flagged for restricted access beyond standard role-based controls (e.g., sensitive diagnoses, employee patient, domestic violence victim). Enforces HIPAA minimum necessary and break-the-glass access policies.',
    `source_system_event_code` STRING COMMENT 'The native identifier of this registration event in the originating source system (e.g., Epic ADT event ID, Cerner encounter number). Enables bidirectional traceability between the lakehouse silver layer and the operational EHR system.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this registration event record was last modified in the data platform. Used for change data capture, incremental ETL processing, and audit trail maintenance.',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether the patient has been designated as a VIP (e.g., public figure, employee, board member) requiring enhanced privacy protections and special handling during registration and care delivery. Restricts access to PHI per HIPAA minimum necessary standard.',
    CONSTRAINT pk_registration_event PRIMARY KEY(`registration_event_id`)
) COMMENT 'Patient registration lifecycle event records capturing event type (new registration, pre-registration, update, merge, unmerge), registration date and time, registering facility, registration source (ED walk-in, scheduled, transfer, online pre-registration), registration completeness score, identity verification method (photo ID, insurance card, biometric), and registration staff. Provides the audit trail for patient identity creation and maintenance events within the MPI lifecycle. Distinct from encounter-level ADT events — this product tracks identity/registration events, not clinical visit movements. Sourced from EHR ADT and registration modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` (
    `identity_merge_history_id` BIGINT COMMENT 'Surrogate primary key for each merge/unmerge event record.',
    `mpi_record_id` BIGINT COMMENT 'FK to the surviving (golden) MPI record after the merge event.',
    `care_site_id` BIGINT COMMENT 'FK to the care site where the primary identity record originated.',
    `employee_id` BIGINT COMMENT 'FK to the employee (HIM analyst) who performed or approved the merge action.',
    `prior_merge_event_identity_merge_history_id` BIGINT COMMENT 'Self-referential FK to a prior merge event in the chain, enabling merge history traversal.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `approving_him_analyst_name` STRING COMMENT 'Name of the Health Information Management analyst who approved this merge action.',
    `breach_assessment_required` BOOLEAN COMMENT 'Flag indicating whether this merge/unmerge event requires a HIPAA breach risk assessment due to potential PHI exposure.',
    `breach_assessment_status` STRING COMMENT 'Status of the HIPAA breach assessment (NOT_REQUIRED, PENDING, IN_PROGRESS, COMPLETED_NO_BREACH, COMPLETED_BREACH).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this merge history record was created.',
    `digital_health_opt_in` STRING COMMENT '',
    `duplicate_detection_method` STRING COMMENT 'Method used to detect the duplicate (AUTOMATED_BATCH, REAL_TIME_ALERT, MANUAL_REVIEW, REGISTRATION_FLAG).',
    `effective_date` DATE COMMENT 'Business effective date of the merge action for reporting purposes.',
    `hl7_message_control_number` STRING COMMENT 'HL7 message control ID of the ADT A40/A41 merge message for interface audit trail.',
    `matching_fields_used` STRING COMMENT 'Comma-separated list of demographic fields that matched (e.g., DOB,SSN_LAST4,LAST_NAME,FIRST_NAME).',
    `merge_algorithm` STRING COMMENT 'Name and version of the matching/merge algorithm used for this event.',
    `merge_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000-1.0000) at the time of the merge decision.',
    `merge_event_number` STRING COMMENT 'Business-assigned event tracking number for this merge action.',
    `merge_event_type` STRING COMMENT 'Type of identity event (MERGE, UNMERGE, OVERLAY_CORRECTION, LINK, UNLINK, POSSIBLE_MATCH).',
    `merge_rationale` DECIMAL(18,2) COMMENT 'Free-text rationale documenting why the merge was performed, required for audit compliance.',
    `merge_status` STRING COMMENT 'Current status of this merge event (COMPLETED, REVERSED, PENDING_APPROVAL, FAILED).',
    `merge_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the merge was executed in the MPI system.',
    `merge_trigger_source` STRING COMMENT 'What triggered the merge (BATCH_JOB, REAL_TIME_REGISTRATION, MANUAL_HIM, INTERFACE_ENGINE, ML_MODEL).',
    `mpi_overlay_type` STRING COMMENT 'If this is an overlay correction, the type of overlay (DEMOGRAPHIC_OVERLAY, CLINICAL_OVERLAY, FULL_OVERLAY).',
    `non_surviving_dob_at_merge` DATE COMMENT 'Date of birth on the non-surviving record at the time of merge, preserved for unmerge capability.',
    `non_surviving_enterprise_mrn` STRING COMMENT 'Enterprise MRN of the non-surviving (retired) record at the time of merge.',
    `non_surviving_mrn` STRING COMMENT 'Facility MRN of the non-surviving (retired) record at the time of merge.',
    `non_surviving_patient_name_at_merge` STRING COMMENT 'Full patient name on the non-surviving record at merge time, preserved for audit and unmerge.',
    `patient_safety_impact_flag` BOOLEAN COMMENT 'Flag indicating this merge/unmerge event has potential patient safety implications requiring clinical review.',
    `phi_disclosure_risk_flag` BOOLEAN COMMENT 'Flag indicating potential inappropriate PHI disclosure occurred due to incorrect merge/overlay.',
    `quality_review_flag` BOOLEAN COMMENT 'Flag indicating this event requires quality review by HIM leadership.',
    `quality_review_notes` STRING COMMENT 'Notes from the quality review of this merge event.',
    `records_affected_count` STRING COMMENT 'Number of downstream clinical/financial records affected by this merge event.',
    `reversal_approved_by` STRING COMMENT 'Name/ID of the person who approved the reversal (unmerge) if applicable.',
    `reversal_reason` STRING COMMENT 'Reason for reversing/unmerging this previously merged record.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Timestamp when the merge was reversed (unmerged). NULL if merge stands.',
    `review_priority` STRING COMMENT 'Priority level for manual review (CRITICAL, HIGH, MEDIUM, LOW) based on patient safety risk.',
    `source_system_merge_code` STRING COMMENT 'Source system internal code/ID for this merge transaction.',
    `surviving_dob_at_merge` DATE COMMENT 'Date of birth on the surviving record at the time of merge.',
    `surviving_enterprise_mrn` STRING COMMENT 'Enterprise MRN of the surviving (golden) record.',
    `surviving_mrn` STRING COMMENT 'Facility MRN of the surviving (golden) record.',
    `surviving_patient_name_at_merge` STRING COMMENT 'Full patient name on the surviving record at merge time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this merge history record.',
    CONSTRAINT pk_identity_merge_history PRIMARY KEY(`identity_merge_history_id`)
) COMMENT 'ECM-tier extension providing complete audit trail of all patient identity merge, unmerge, and overlay events. Supports HIPAA breach assessment, patient safety review, and regulatory compliance for identity management. Links to the enterprise MPI record and captures both surviving and non-surviving record details for full reversibility. ECM extension tracking patient identity merge/unmerge events for multi-system identity resolution.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`flag` (
    `flag_id` BIGINT COMMENT 'Unique system-generated identifier for each patient-level clinical or administrative alert flag record. Primary key for the patient flag entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care setting where this flag was created. Supports multi-facility enterprise deployments where flags may be facility-specific or enterprise-wide.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this flag is recorded. Links to the master patient record in the patient domain.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Clinical flags for infectious disease precautions, isolation protocols, and condition-specific alerts reference ICD-10 codes (e.g., A41.9 for sepsis precautions). Supports infection control workflows,',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or staff member who created or initiated this flag. Used for accountability, audit, and follow-up workflows.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical flags use SNOMED CT for precise concepts (fall risk, allergy severity, behavioral health alerts). Enables clinical decision support rules, interoperability via FHIR Flag resource, and granula',
    `tertiary_flag_reviewed_by_provider_clinician_id` BIGINT COMMENT 'Reference to the clinician or staff member who most recently reviewed this flag for continued clinical relevance. Supports accountability and periodic review compliance.',
    `visit_id` BIGINT COMMENT 'Optional reference to the encounter during which this flag was created, if the flag originated in the context of a specific visit. Patient-level flags persist across encounters, but this field captures the originating encounter for traceability.',
    `acknowledgment_count` STRING COMMENT 'Total number of times this flag has been acknowledged by clinical or administrative staff. Supports alert fatigue analysis and compliance monitoring for mandatory acknowledgment flags.',
    `ama_history_flag` BOOLEAN COMMENT 'Indicates whether this flag specifically documents a history of the patient leaving Against Medical Advice (AMA). Supports risk management, care planning, and EMTALA compliance workflows.',
    `flag_code` STRING COMMENT 'Standardized code identifying the specific flag, aligned with the source EHR systems internal code set or a standard terminology (e.g., SNOMED CT concept code for the alert condition). Enables interoperability and cross-system flag reconciliation.',
    `code_system` STRING COMMENT 'Identifies the coding system or terminology used for the flag_code (e.g., SNOMED-CT, ICD-10, LOCAL for facility-defined codes). Supports interoperability and terminology mapping across systems.. Valid values are `SNOMED-CT|ICD-10|LOCAL|HL7|LOINC|CUSTOM`',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification of this flag controlling which roles and users may view it. Restricted and very-restricted flags (e.g., VIP, behavioral, legal hold) are visible only to authorized personnel. Supports HIPAA minimum necessary standard.. Valid values are `normal|restricted|very_restricted|sealed`',
    `flag_description` STRING COMMENT 'Free-text narrative describing the clinical or administrative alert, including relevant context, specific precautions required, or instructions for care team members. Contains Protected Health Information (PHI) and must be handled per HIPAA requirements.',
    `digital_health_opt_in` STRING COMMENT '',
    `display_in_chart` BOOLEAN COMMENT 'Indicates whether this flag should be prominently displayed in the patients electronic health record chart header or banner. Controls EHR display logic for patient safety alerts.',
    `display_in_registration` DOUBLE COMMENT 'Indicates whether this flag should be surfaced during patient registration and ADT workflows. Supports administrative flags such as financial hardship, legal hold, or VIP status at point of registration.',
    `display_in_scheduling` BOOLEAN COMMENT 'Indicates whether this flag should be visible in scheduling and appointment management workflows (e.g., Epic Cadence). Supports pre-visit preparation for flags such as interpreter needed, VIP, or behavioral alerts.',
    `effective_end_date` DATE COMMENT 'The date on which this flag record version is superseded by a newer version. Null indicates the current active version. Supports SCD type 2 history tracking and point-in-time analytics.',
    `effective_start_date` DATE COMMENT 'The date from which this flag record version is considered valid in the silver layer. Supports slowly changing dimension (SCD) type 2 history tracking for flag record changes over time.',
    `expiration_date` DATE COMMENT 'The date on which this flag is scheduled to expire or be automatically inactivated. Null indicates the flag is indefinite and requires manual resolution. Supports time-limited flags such as infectious precautions or temporary behavioral alerts.',
    `fall_risk_assessment_tool` STRING COMMENT 'Identifies the standardized fall risk assessment instrument used to generate the fall_risk_score. Supports comparability of fall risk data across units and facilities.. Valid values are `morse|johns_hopkins|hendrich_ii|humpty_dumpty|none`',
    `fall_risk_score` DECIMAL(18,2) COMMENT 'Numeric fall risk assessment score (e.g., Morse Fall Scale or Johns Hopkins Fall Risk Assessment Tool score) associated with a fall risk flag. Null when flag_subtype is not fall risk. Supports NDNQI fall prevention reporting and The Joint Commission NPSG.09.02.01.',
    `flag_status` STRING COMMENT 'Current lifecycle status of the patient flag. Active flags are displayed in clinical workflows; inactive or resolved flags are retained for historical reference; entered-in-error flags are suppressed from display but preserved for audit.. Valid values are `active|inactive|resolved|entered-in-error`',
    `flag_type` STRING COMMENT 'High-level category of the flag indicating whether it is clinical (e.g., allergy, fall risk), administrative (e.g., VIP, interpreter needed), safety (e.g., infectious precaution, latex allergy), behavioral (e.g., behavioral alert), financial (e.g., financial hardship), or legal (e.g., legal hold). Drives routing and display logic across care settings.. Valid values are `clinical|administrative|safety|behavioral|financial|legal`',
    `flagged_by_role` STRING COMMENT 'The professional role or job function of the individual who created this flag. Provides context for the flags origin and supports role-based analytics on flag creation patterns. [ENUM-REF-CANDIDATE: physician|nurse|pharmacist|social_worker|case_manager|administrative|security|other — 8 candidates stripped; promote to reference product]',
    `flagged_timestamp` TIMESTAMP COMMENT 'The date and time when this flag was first entered into the EHR system. Serves as the record audit creation timestamp and supports chronological ordering of flag history.',
    `infectious_precaution_type` STRING COMMENT 'Specifies the type of infection control precaution required for this patient when the flag_subtype is infectious precaution. Drives isolation protocols, PPE requirements, and room assignment workflows. Null when not applicable.. Valid values are `contact|droplet|airborne|contact_droplet|enhanced_contact|none`',
    `interpreter_language` STRING COMMENT 'The language for which an interpreter is required when the flag_subtype is interpreter needed. Uses ISO 639-1 two-letter language codes (e.g., es for Spanish, zh for Chinese). Supports Title VI compliance and patient communication workflows.',
    `is_enterprise_wide` BOOLEAN COMMENT 'Indicates whether this flag applies across all facilities in the enterprise (True) or is scoped to a specific facility (False). Enterprise-wide flags travel with the patient to any care setting within the health system.',
    `last_acknowledged_timestamp` TIMESTAMP COMMENT 'The most recent date and time this flag was acknowledged by a staff member. Supports compliance monitoring and identification of flags that have not been recently reviewed.',
    `last_reviewed_date` DATE COMMENT 'The date on which this flag was most recently reviewed by a clinician or authorized staff member for continued relevance and accuracy. Supports periodic flag review workflows required by accreditation standards.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this flag record was most recently modified in the source system or the lakehouse. Supports incremental data loading, audit trails, and change detection.',
    `legal_hold_reference` STRING COMMENT 'Reference number or case identifier associated with a legal hold flag. Links the patient flag to the corresponding legal matter or litigation hold managed by the health systems legal department. Null when flag_subtype is not legal hold.',
    `mrn` STRING COMMENT 'Medical Record Number assigned to the patient at the facility. Carried on the flag record to support direct patient identification in clinical workflows without requiring a join to the patient master.',
    `onset_date` DATE COMMENT 'The date on which the condition or circumstance prompting this flag first became clinically or administratively relevant for the patient. Distinct from the date the flag was entered into the system.',
    `phi_flag` BOOLEAN COMMENT 'Indicates whether this flag record contains Protected Health Information (PHI) as defined under HIPAA. Drives data governance, access control, and de-identification workflows in the lakehouse.',
    `requires_acknowledgment` BOOLEAN COMMENT 'Indicates whether clinical or administrative staff must explicitly acknowledge this flag before proceeding with patient care activities. Supports mandatory alert workflows for high-severity flags such as fall risk or infectious precautions.',
    `resolution_reason` STRING COMMENT 'Reason code explaining why the flag was resolved or inactivated. Supports quality review, audit, and analytics on flag lifecycle patterns. [ENUM-REF-CANDIDATE: condition_resolved|entered_in_error|patient_request|clinical_review|expired|superseded|other — 7 candidates stripped; promote to reference product]',
    `resolved_timestamp` TIMESTAMP COMMENT 'The date and time when this flag was resolved, inactivated, or marked as entered-in-error. Null if the flag remains active. Supports lifecycle tracking and compliance reporting.',
    `severity` STRING COMMENT 'Clinical or administrative severity level of the flag indicating urgency and required response. Critical flags require immediate action; informational flags are advisory only. Drives alert prioritization and display prominence in EHR workflows.. Valid values are `critical|high|medium|low|informational`',
    `source_system_flag_code` STRING COMMENT 'The native identifier of this flag record in the originating operational system (e.g., Epic internal flag ID, Cerner alert ID). Supports bidirectional traceability between the lakehouse silver layer and the source EHR system.',
    `subtype` STRING COMMENT 'Granular classification of the flag within its type. Examples include: VIP, fall risk, latex allergy, infectious precaution, AMA history, safety risk, interpreter needed, financial hardship, legal hold, elopement risk, violence risk, do not resuscitate. [ENUM-REF-CANDIDATE: vip|fall_risk|latex_allergy|infectious_precaution|ama_history|safety_risk|interpreter_needed|financial_hardship|legal_hold|elopement_risk|violence_risk|do_not_resuscitate — promote to reference product]',
    CONSTRAINT pk_flag PRIMARY KEY(`flag_id`)
) COMMENT 'Patient-level clinical and administrative alert flags capturing flag type (VIP, behavioral alert, fall risk, latex allergy, infectious precaution, financial hardship, interpreter needed, AMA history, legal hold, safety risk), flag severity, flag description, onset and expiration dates, flagging provider or staff, and active status. Persistent patient-level flags that travel with the patient across encounters — distinct from encounter-specific clinical alerts. Supports safe care delivery, staff safety, and administrative workflows across all care settings. Sourced from EHR clinical alert and patient safety systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`population_segment` (
    `population_segment_id` BIGINT COMMENT 'Unique surrogate identifier for each patient population segmentation and risk stratification record in the Silver Layer lakehouse. Primary key for this entity.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Population health stratification segments patients by attributed provider specialty for quality measure reporting, care gap analysis by specialty, network adequacy assessment, and specialty-specific r',
    `clinician_id` BIGINT COMMENT 'Reference to the primary care physician (PCP) to whom the patient is attributed for population health management, ACO performance measurement, and care gap closure accountability.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Population health and care management programs are budgeted and managed by cost center. Value-based care contract performance reporting requires cost center attribution for care management expenses to',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Risk stratification segments (diabetes_flag, chf_flag, copd_flag) are defined by specific ICD-10 diagnosis codes. Linking the defining diagnosis enables transparent stratification logic, audit trails ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient master record for whom this population segment assignment applies. Links to the patient domain SSOT.',
    `employee_id` BIGINT COMMENT 'Reference to the care manager or care coordinator assigned to this patient based on their population segment and risk tier. Supports care team assignment tracking and workload management in population health programs.',
    `group_id` BIGINT COMMENT 'Reference to the practice or clinic to which the patient is attributed for population health management and ACO performance reporting. Supports panel-level analytics and practice-level care gap reporting.',
    `payer_id` BIGINT COMMENT 'Reference to the primary payer or health plan associated with this population segment record. Determines applicable risk adjustment methodology (CMS HCC for Medicare, ACG for commercial) and ACO/VBP contract applicability.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Risk stratification and population health segments are facility-specific for attributed patient panels, ACO performance reporting by site, and care management resource planning. MSSP and value-based c',
    `aco_attribution_flag` BOOLEAN COMMENT 'Indicates whether the patient is attributed to an Accountable Care Organization (ACO) for the current performance year. Attributed patients are included in ACO quality and financial performance calculations.',
    `aco_code` BIGINT COMMENT 'Reference to the ACO to which the patient is attributed for the current performance year. Used for ACO-level quality reporting, shared savings calculations, and CMS submission.',
    `asthma_flag` BOOLEAN COMMENT 'Indicates whether the patient has an active diagnosis of asthma as identified by the stratification model. Used for chronic disease cohort identification and HEDIS Asthma Medication Ratio measure targeting.',
    `attributed_care_program` STRING COMMENT 'Name or code of the care management or population health program to which the patient is attributed based on their segment assignment (e.g., Complex Care Management, Transitional Care, Diabetes Disease Management, ACO Care Coordination). Drives workflow routing in Epic Healthy Planet.',
    `care_gap_count` STRING COMMENT 'Total number of open care gaps identified for the patient at the time of stratification, based on HEDIS and clinical quality measures. Drives outreach prioritization and care coordinator workload assignment in population health programs.',
    `care_management_enrollment_flag` BOOLEAN COMMENT 'Indicates whether the patient is currently enrolled in a formal care management or disease management program based on their segment assignment. Distinguishes patients receiving active care management from those identified but not yet enrolled.',
    `chf_flag` BOOLEAN COMMENT 'Indicates whether the patient has an active diagnosis of congestive heart failure (CHF) as identified by the stratification model. Used for chronic disease cohort identification, readmission risk stratification, and HEDIS measure targeting.',
    `chronic_condition_count` STRING COMMENT 'Total number of distinct active chronic conditions identified for the patient by the stratification model. Used as a complexity indicator for care management intensity assignment and risk tier determination.',
    `ckd_flag` BOOLEAN COMMENT 'Indicates whether the patient has an active diagnosis of chronic kidney disease (CKD) as identified by the stratification model. Used for chronic disease cohort identification and nephrology care management program targeting.',
    `copd_flag` BOOLEAN COMMENT 'Indicates whether the patient has an active diagnosis of chronic obstructive pulmonary disease (COPD) as identified by the stratification model. Used for chronic disease cohort identification and respiratory disease management program targeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this population segment record was first created in the Silver Layer lakehouse. Supports audit trail, data lineage, and SLA compliance monitoring for population health data pipelines.',
    `depression_flag` BOOLEAN COMMENT 'Indicates whether the patient has an active diagnosis of depression or major depressive disorder as identified by the stratification model. Used for behavioral health integration, HEDIS Depression Screening measure targeting, and care program enrollment.',
    `diabetes_flag` BOOLEAN COMMENT 'Indicates whether the patient has an active diagnosis of diabetes mellitus (Type 1 or Type 2) as identified by the stratification model using ICD-10 codes. Used for chronic disease cohort identification and HEDIS Comprehensive Diabetes Care measure targeting.',
    `digital_health_opt_in` STRING COMMENT '',
    `ed_utilization_risk_flag` BOOLEAN COMMENT 'Indicates whether the patient has been identified as high-risk for avoidable Emergency Department (ED) utilization based on the stratification model. Supports AHRQ Prevention Quality Indicator (PQI) reporting and ED diversion programs.',
    `effective_end_date` DATE COMMENT 'Date on which this population segment assignment was superseded or expired. Null indicates the record is currently active. Supports SCD Type 2 history tracking of segment changes over time.',
    `effective_start_date` DATE COMMENT 'Date from which this population segment assignment is considered valid and active for care management, reporting, and outreach purposes. Supports SCD Type 2 history tracking of segment changes over time.',
    `hcc_condition_count` STRING COMMENT 'Number of distinct CMS HCC categories mapped to the patients active diagnoses. Used for risk adjustment completeness audits, CDI (Clinical Documentation Improvement) gap identification, and RAF (Risk Adjustment Factor) optimization.',
    `hcc_risk_score` DECIMAL(18,2) COMMENT 'CMS Hierarchical Condition Category (HCC) risk adjustment score for the patient, used for Medicare Advantage and ACO financial reconciliation. Reflects predicted cost relative to the average Medicare beneficiary (1.0 = average).',
    `hypertension_flag` BOOLEAN COMMENT 'Indicates whether the patient has an active diagnosis of hypertension as identified by the stratification model. Used for chronic disease cohort identification and HEDIS Controlling High Blood Pressure measure targeting.',
    `measurement_period_end_date` DATE COMMENT 'End date of the measurement or look-back period used by the stratification model to evaluate the patients clinical history, utilization patterns, and chronic condition burden.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the measurement or look-back period used by the stratification model to evaluate the patients clinical history, utilization patterns, and chronic condition burden.',
    `mrn` STRING COMMENT 'Medical Record Number assigned by the facility or health system, used to cross-reference the patients clinical record in the source EHR (Epic Healthy Planet). Supports operational reconciliation and audit.',
    `payer_product_type` STRING COMMENT 'Classification of the patients insurance product type at the time of stratification. Determines applicable risk adjustment model, quality measure set, and care program eligibility. Dual Eligible indicates patients covered by both Medicare and Medicaid.. Valid values are `Medicare|Medicaid|Commercial|Medicare_Advantage|Dual_Eligible|Uninsured`',
    `performance_year` STRING COMMENT 'The calendar year for which this population segment assignment and risk stratification is valid. Used to partition historical stratification records for year-over-year trend analysis and ACO performance reporting.',
    `predicted_utilization_tier` STRING COMMENT 'Predicted healthcare utilization tier for the patient over the next 12 months, derived from the stratification model. Informs care management intensity, proactive outreach scheduling, and resource allocation planning.. Valid values are `very_high|high|moderate|low|very_low`',
    `prior_risk_score` DECIMAL(18,2) COMMENT 'The patients risk score from the immediately preceding stratification cycle. Used to calculate risk score delta and identify patients with significant risk trajectory changes requiring care management intervention.',
    `prior_risk_tier` STRING COMMENT 'The patients risk tier from the immediately preceding stratification cycle. Enables risk tier transition analysis (e.g., rising-risk identification, care management effectiveness measurement) and population health trend reporting.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5`',
    `readmission_risk_flag` BOOLEAN COMMENT 'Indicates whether the patient has been identified as high-risk for 30-day hospital readmission based on the stratification model. Triggers transitional care management (TCM) outreach and care coordination workflows.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric composite risk score assigned to the patient by the stratification model. Higher values indicate greater predicted utilization or clinical risk. Sourced from the model identified in risk_score_source (e.g., CMS HCC, ACG, or proprietary algorithm).',
    `risk_score_percentile` DECIMAL(18,2) COMMENT 'Percentile rank of the patients risk score within the attributed population panel, expressed as a value between 0.00 and 100.00. Enables relative risk comparison across the population for care gap prioritization.',
    `risk_score_source` STRING COMMENT 'Identifies the risk scoring model or algorithm used to generate the patients risk score. CMS HCC (Hierarchical Condition Category) is used for Medicare populations; ACG (Adjusted Clinical Groups) for commercial; proprietary models may be used for internal programs.. Valid values are `CMS_HCC|ACG|proprietary|CDPS|DxCG|ERG`',
    `risk_tier` STRING COMMENT 'Ordinal risk stratification tier assigned to the patient, where Tier 1 represents the highest-risk patients requiring intensive care management and Tier 5 represents the lowest-risk healthy population. Used for ACO performance reporting and care resource allocation.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5`',
    `sdoh_domain_flags` STRING COMMENT 'Pipe-delimited list of specific SDOH domains identified for the patient (e.g., food_insecurity|housing_instability|transportation|social_isolation|financial_strain). Supports targeted community resource referrals and SDOH-informed care planning.',
    `sdoh_risk_flag` BOOLEAN COMMENT 'Indicates whether the patient has been identified as having one or more Social Determinants of Health (SDOH) risk factors (e.g., food insecurity, housing instability, transportation barriers) that may impact care outcomes and utilization.',
    `segment_type` STRING COMMENT 'Categorical classification of the patients population segment as defined by the population health management program. Drives care program assignment, outreach prioritization, and HEDIS measure targeting. [ENUM-REF-CANDIDATE: chronic_disease_cohort|high_risk|rising_risk|healthy|complex_care|palliative — promote to reference product if additional values are needed]. Valid values are `chronic_disease_cohort|high_risk|rising_risk|healthy|complex_care|palliative`',
    `source_system_segment_code` STRING COMMENT 'The native identifier for this population segment record in the source operational system (e.g., Epic Healthy Planet internal segment ID). Supports bidirectional traceability between the lakehouse Silver Layer and the source EHR.',
    `stratification_date` DATE COMMENT 'The most recent date on which the patients risk score and segment assignment were calculated or refreshed by the stratification model. Used to identify stale stratifications requiring recalculation.',
    `stratification_model_version` STRING COMMENT 'Version identifier of the risk stratification model or algorithm used to produce this segment assignment. Critical for reproducibility, model governance, and year-over-year trend analysis in population health reporting.',
    `stratification_status` STRING COMMENT 'Current lifecycle status of this population segment record. Active indicates the current valid assignment; superseded indicates a prior assignment replaced by a newer stratification run; pending_review indicates the record requires clinical validation.. Valid values are `active|inactive|pending_review|superseded`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this population segment record was last modified in the Silver Layer lakehouse. Supports change detection, incremental processing, and audit trail requirements.',
    CONSTRAINT pk_population_segment PRIMARY KEY(`population_segment_id`)
) COMMENT 'Patient population segmentation and risk stratification records capturing segment type (chronic disease cohort, high-risk, rising-risk, healthy), risk tier, risk score source (CMS HCC, ACG, proprietary), attributed care program, chronic condition flags (diabetes, CHF, COPD, CKD), care gap count, last stratification date, and stratification model version. Supports population health management, ACO performance, and HEDIS measure targeting. Sourced from Epic Healthy Planet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` (
    `care_program_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each care program enrollment record. Primary key for this entity. Role: MASTER_AGREEMENT — this entity represents a long-running binding relationship between a patient and a population health care management program.',
    `care_plan_id` BIGINT COMMENT 'Reference to the active care plan associated with this enrollment. Links the enrollment to the patients individualized care plan containing goals, interventions, and care team assignments managed in the clinical domain.',
    `clinician_id` BIGINT COMMENT 'Reference to the Primary Care Physician (PCP) attributed to this patient for the care program. Used for ACO attribution, HEDIS measure attribution, and value-based care performance reporting.',
    `compliance_program_id` BIGINT COMMENT 'Reference to the care management program definition in which the patient is enrolled (e.g., Diabetes Disease Management, CHF Care Coordination, High-Risk Care Management). Links to the program catalog.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient enrolled in the care program. Links to the patient master record as the primary party for this enrollment agreement.',
    `employee_id` BIGINT COMMENT 'Reference to the care manager (nurse, social worker, or care coordinator) assigned to manage this patients enrollment. Used for workload balancing, care manager performance reporting, and care team attribution.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Care management program enrollments are typically site-specific for resource allocation, care manager assignment by facility, and site-level quality/outcome reporting. ACO and value-based contracts re',
    `payer_id` BIGINT COMMENT 'Reference to the patients primary insurance payer associated with this care program enrollment. Used for payer-specific program eligibility validation, value-based contract attribution, and ACO/PCMH performance reporting by payer.',
    `population_segment_id` BIGINT COMMENT 'Foreign key linking to patient.population_segment. Business justification: Care program enrollment is driven by population segmentation and risk stratification. Currently care_program_enrollment has population_segment as a STRING attribute and duplicates many risk/stratifica',
    `sdoh_referral_id` BIGINT COMMENT '',
    `care_gap_count` STRING COMMENT 'Number of open care gaps identified for the patient at the time of enrollment or most recent stratification. Care gaps represent evidence-based preventive or chronic care services that are overdue. Used for HEDIS measure targeting, ACO quality performance, and care manager outreach prioritization.',
    `consent_date` DATE COMMENT 'Date on which the patient provided informed consent to participate in the care management program. Required for CMS CCM billing documentation and HIPAA compliance audit.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether the patient has provided informed consent to participate in the care management program. Required for CMS Chronic Care Management (CCM) billing and HIPAA-compliant care coordination activities involving PHI sharing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this care program enrollment record was first created in the data platform. Supports audit trail, data lineage, and regulatory compliance requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `digital_health_opt_in` STRING COMMENT '',
    `disenrollment_date` DATE COMMENT 'Date on which the patient was disenrolled or exited the care management program. Null if the patient is currently active. Used for program duration calculations, outcomes analysis, and value-based care reporting.',
    `disenrollment_reason` STRING COMMENT 'Reason the patient was disenrolled from the care management program. Used for program quality analysis, retention reporting, and identifying systemic barriers to care program participation. Null if enrollment is active. [ENUM-REF-CANDIDATE: patient_request|program_completion|deceased|lost_to_followup|insurance_change|moved_out_of_area|transferred_to_other_program — 7 candidates stripped; promote to reference product]',
    `enrollment_date` DATE COMMENT 'Date on which the patient was formally enrolled and accepted into the care management program. Represents the effective start of the enrollment agreement. Used for program duration calculations, HEDIS measure attribution, and ACO performance reporting.',
    `enrollment_number` STRING COMMENT 'Externally-known business identifier for this care program enrollment record, assigned by the population health management platform or care management system (e.g., Epic Healthy Planet, Salesforce Health Cloud). Used for cross-system reference and audit tracking.',
    `enrollment_source` STRING COMMENT 'Channel or mechanism through which the patient was identified and enrolled in the care program. Supports program intake analysis, referral source tracking, and population health outreach effectiveness measurement. [ENUM-REF-CANDIDATE: provider_referral|care_manager_outreach|risk_stratification_algorithm|patient_self_referral|payer_referral|ed_discharge|inpatient_discharge — 7 candidates stripped; promote to reference product]',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the patients care program enrollment. active indicates the patient is actively participating; pending indicates enrollment initiated but not yet confirmed; disenrolled indicates the patient has left the program; suspended indicates temporary pause; completed indicates successful program graduation; declined indicates patient refused enrollment.. Valid values are `active|pending|disenrolled|suspended|completed|declined`',
    `last_care_manager_contact_date` DATE COMMENT 'Date of the most recent documented contact between the assigned care manager and the patient. Used to identify patients who are overdue for care manager outreach, monitor care management engagement, and support CMS CCM monthly contact requirements.',
    `last_stratification_date` DATE COMMENT 'Date on which the patients risk stratification was most recently calculated or refreshed. Used to identify patients with stale risk scores requiring re-stratification and to ensure currency of population health segmentation.',
    `next_care_manager_contact_date` DATE COMMENT 'Scheduled date for the next care manager outreach contact with the patient. Used for care manager workload scheduling, proactive outreach management, and ensuring compliance with program contact frequency requirements.',
    `payer_program_name` STRING COMMENT 'Name of the payer-specific care management or value-based care program under which this enrollment is tracked (e.g., Medicare Shared Savings Program, Medicaid Managed Care Disease Management, Commercial ACO). Supports payer-specific performance reporting and contract management.',
    `program_outcome` STRING COMMENT 'Final outcome recorded upon program completion or disenrollment. Captures whether the patient achieved the programs clinical and care management goals. Used for program effectiveness reporting, quality improvement, and value-based care outcome measurement.. Valid values are `goals_met|partial_goals_met|goals_not_met|transferred|deceased|withdrawn`',
    `risk_score_model_version` STRING COMMENT 'Version identifier of the risk stratification model used to calculate the risk score. Critical for reproducibility, model drift monitoring, and regulatory audit of risk-based payment adjustments.',
    `source_system_enrollment_code` STRING COMMENT 'Native identifier for this enrollment record in the originating operational system (e.g., Epic Healthy Planet enrollment ID, Salesforce Health Cloud record ID). Used for cross-system reconciliation, ETL traceability, and back-referencing to the system of record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this care program enrollment record was most recently modified in the data platform. Used for change data capture (CDC), incremental ETL processing, and audit trail compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `value_based_contract_type` STRING COMMENT 'Type of value-based care contract or payment model under which this enrollment is attributed. Determines financial incentive structure, quality measure requirements, and reporting obligations. [ENUM-REF-CANDIDATE: aco_mssp|aco_reach|pcmh|bundled_payment|capitation|shared_savings|pay_for_performance|fee_for_service — promote to reference product]',
    CONSTRAINT pk_care_program_enrollment PRIMARY KEY(`care_program_enrollment_id`)
) COMMENT 'Patient population health segmentation, risk stratification, and care program enrollment records. Captures segment type (chronic disease cohort, high-risk, rising-risk, healthy), risk tier, risk score source (CMS HCC, ACG, proprietary), chronic condition flags (diabetes, CHF, COPD, CKD), care gap count, stratification model version, last stratification date, program name, enrollment and disenrollment dates, program status, assigned care manager, care plan linkage, enrollment source, and program outcomes. SSOT for population health segmentation and care management program participation. Supports ACO performance, PCMH workflows, HEDIS measure targeting, chronic disease management, and value-based care reporting. Sourced from population health management platforms and care management systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` (
    `financial_assistance_id` BIGINT COMMENT 'Unique surrogate identifier for each patient financial assistance application record in the lakehouse Silver layer. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, or outpatient center) where the financial assistance application was submitted and where the associated services were rendered. Used for facility-level community benefit reporting.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Financial assistance write-offs post to specific GL accounts (revenue contra-accounts) for GAAP financial statement preparation. Month-end close process requires mapping charity care adjustments to pr',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who submitted the financial assistance application. Links to the patient master record as the primary party for this transaction.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce employee (financial counselor) who processed or is assigned to this financial assistance application. Used for workload management, quality audits, and staff performance reporting.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Financial assistance often draws from restricted funds (endowments, grants, community benefit funds). Fund accounting requires tracking which fund sources finance charity care write-offs for donor res',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to patient.guarantor. Business justification: Financial assistance applications are submitted by or on behalf of the guarantor (the financially responsible party). Currently financial_assistance links to demographics (patient) but not to guaranto',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Charity care and financial assistance determination requires plan-level benefit analysis to assess coverage gaps and patient liability. Program eligibility depends on specific plan design (deductibles',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Financial assistance applications are often submitted after insurance coverage is exhausted, denied, or determined insufficient. Linking financial_assistance to the specific insurance_coverage record ',
    `sdoh_referral_id` BIGINT COMMENT '',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit that triggered the financial assistance application, if applicable. Used to link assistance to specific episodes of care for Revenue Cycle Management (RCM) reporting.',
    `annual_household_income` DECIMAL(18,2) COMMENT 'Total annual gross income of the patients household as reported and verified during the application process. Sensitive financial data used to calculate Federal Poverty Level (FPL) percentage. Stored in USD.',
    `appeal_date` DATE COMMENT 'Date on which the patient submitted a formal appeal of the financial assistance denial decision. Used to track appeal timelines and compliance with patient rights notification requirements.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether the patient has filed a formal appeal of a denied financial assistance application. Triggers appeal workflow routing in the Revenue Cycle Management (RCM) system.',
    `appeal_outcome` STRING COMMENT 'Result of the formal appeal review for a denied financial assistance application. Determines whether the original denial decision is upheld or reversed.. Valid values are `upheld|overturned|pending|withdrawn`',
    `application_date` DATE COMMENT 'Calendar date on which the patient submitted the financial assistance application. Used as the principal business event date for aging, reporting, and 501(c)(3) community benefit tracking.',
    `application_number` STRING COMMENT 'Externally visible, human-readable application reference number assigned at submission. Used by financial counselors, patients, and payers to track the application through the review lifecycle. Format: FA-YYYY-NNNNNN.. Valid values are `^FA-[0-9]{4}-[0-9]{6}$`',
    `application_source` STRING COMMENT 'Channel or touchpoint through which the financial assistance application was initiated. Used for operational analytics on access patterns and financial counseling resource allocation. [ENUM-REF-CANDIDATE: patient_portal|financial_counselor|social_worker|emergency_department|inpatient_admission|mail|phone|community_partner — promote to reference product]',
    `application_status` STRING COMMENT 'Current lifecycle state of the financial assistance application. Drives workflow routing in financial counseling and Revenue Cycle Management (RCM) modules. [ENUM-REF-CANDIDATE: pending|approved|denied|cancelled|expired|under_review — promote to reference product if additional statuses are needed]. Valid values are `pending|approved|denied|cancelled|expired|under_review`',
    `approval_date` DATE COMMENT 'Calendar date on which the financial assistance application was approved by the financial counselor or review committee. Marks the start of the assistance benefit period.',
    `approved_assistance_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount of financial assistance approved for the patient, where a flat amount rather than a percentage discount is granted. Stored in USD. Applicable for payment plan subsidies or specific hardship grants.',
    `approved_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount approved for the patients outstanding or future balances under the financial assistance program. Expressed as a value between 0.00 and 100.00. Used in Revenue Cycle Management (RCM) to apply adjustments to patient accounts.',
    `balance_eligible_amount` DECIMAL(18,2) COMMENT 'Total patient account balance that is eligible for financial assistance consideration at the time of application. Represents the gross amount subject to discount or write-off. Stored in USD.',
    `collection_hold_flag` BOOLEAN COMMENT 'Indicates whether collections activity on the patients account has been placed on hold pending the outcome of the financial assistance application. Required under IRS 501(r)(6) to prevent extraordinary collection actions during the application review period.',
    `community_benefit_category` STRING COMMENT 'IRS Form 990 Schedule H community benefit category under which this financial assistance record is classified for 501(c)(3) tax-exempt reporting. Drives annual community benefit schedule compilation. [ENUM-REF-CANDIDATE: charity_care|unreimbursed_medicaid|community_health_improvement|subsidized_health_services|research|cash_in_kind — promote to reference product]. Valid values are `charity_care|unreimbursed_medicaid|community_health_improvement|subsidized_health_services|research|cash_in_kind`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial assistance application record was first created in the lakehouse Silver layer. Serves as the audit creation marker for data lineage and compliance tracking.',
    `denial_date` DATE COMMENT 'Calendar date on which the financial assistance application was formally denied. Required for tracking denial rates, appeal timelines, and regulatory compliance with IRS 501(r) notification requirements.',
    `denial_reason` STRING COMMENT 'Coded reason for denial of the financial assistance application. Used for quality review, appeal processing, and regulatory reporting. [ENUM-REF-CANDIDATE: income_exceeds_threshold|incomplete_documentation|duplicate_application|ineligible_service|patient_declined|other — promote to reference product]. Valid values are `income_exceeds_threshold|incomplete_documentation|duplicate_application|ineligible_service|patient_declined|other`',
    `digital_health_opt_in` STRING COMMENT '',
    `effective_start_date` DATE COMMENT 'Date from which the approved financial assistance benefit is valid and applicable to patient account balances. Defines the beginning of the assistance coverage window.',
    `expiration_date` DATE COMMENT 'Date on which the approved financial assistance benefit expires and is no longer applicable. Patients must reapply after this date. Used for renewal workflow triggers in financial counseling.',
    `extraordinary_collection_action_flag` BOOLEAN COMMENT 'Indicates whether any Extraordinary Collection Actions (ECAs) as defined by IRS 501(r)(6) — such as reporting to credit bureaus, filing lawsuits, or placing liens — were initiated against the patient. Must be False during the application review period.',
    `fpl_guideline_year` STRING COMMENT 'Calendar year of the HHS Federal Poverty Level guidelines used to calculate the FPL percentage. Required for audit reproducibility as FPL thresholds change annually.',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Patient household income expressed as a percentage of the current years Federal Poverty Level (FPL) based on household size. Primary eligibility threshold metric used to determine assistance tier and discount level per the facilitys financial assistance policy.',
    `household_size` STRING COMMENT 'Number of individuals in the patients household as declared on the application. Used in conjunction with annual household income to calculate the Federal Poverty Level (FPL) percentage for eligibility determination.',
    `income_verification_method` STRING COMMENT 'Method used to verify the patients household income for eligibility determination. Required for IRS 501(r) compliance documentation and audit purposes. [ENUM-REF-CANDIDATE: self_attestation|tax_return|pay_stub|bank_statement|government_benefit_letter|third_party_database — promote to reference product]. Valid values are `self_attestation|tax_return|pay_stub|bank_statement|government_benefit_letter|third_party_database`',
    `insurance_coverage_verified` BOOLEAN COMMENT 'Indicates whether the patients insurance coverage eligibility was verified prior to processing the financial assistance application. Ensures that assistance is applied only after exhausting third-party payer sources per IRS 501(r) requirements.',
    `medicaid_application_submitted` BOOLEAN COMMENT 'Indicates whether a Medicaid application was submitted on behalf of the patient as part of the financial assistance process. Tracks presumptive eligibility and Medicaid enrollment referral outcomes.',
    `medicaid_screened` BOOLEAN COMMENT 'Indicates whether the patient was screened for Medicaid or other government-sponsored program eligibility before or during the financial assistance application process. Required for IRS 501(r) compliance and CMS uncompensated care reporting.',
    `notes` STRING COMMENT 'Free-text notes entered by the financial counselor documenting special circumstances, patient communications, documentation exceptions, or other contextual information relevant to the application review. Classified as confidential due to potential inclusion of sensitive financial context.',
    `notification_date` DATE COMMENT 'Date on which the written notification of the financial assistance decision was sent to the patient. Required for IRS 501(r) compliance audit trail.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the required written notification of the application decision (approval or denial) was sent to the patient per IRS 501(r) plain language notification requirements.',
    `payment_plan_duration_months` STRING COMMENT 'Total number of months over which the patients balance will be paid under an approved payment plan. Applicable only when program_type is payment_plan. Used for cash flow forecasting in Revenue Cycle Management (RCM).',
    `payment_plan_monthly_amount` DECIMAL(18,2) COMMENT 'Monthly installment amount agreed upon under an approved payment plan financial assistance program. Applicable only when program_type is payment_plan. Stored in USD.',
    `presumptive_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the patient was granted Medicaid Presumptive Eligibility (PE) as part of the financial assistance determination. PE allows temporary Medicaid coverage while the full application is pending.',
    `program_type` STRING COMMENT 'Classification of the financial assistance program under which the patient is applying. Determines eligibility criteria, discount methodology, and regulatory reporting category. [ENUM-REF-CANDIDATE: charity_care|medicaid_presumptive_eligibility|sliding_fee_scale|payment_plan|financial_hardship|hill_burton — promote to reference product]. Valid values are `charity_care|medicaid_presumptive_eligibility|sliding_fee_scale|payment_plan|financial_hardship|hill_burton`',
    `review_completion_date` DATE COMMENT 'Date on which the financial counselor or review committee completed the review of the application, regardless of outcome. Used to measure processing turnaround time and compliance with internal Service Level Agreements (SLAs).',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether Social Determinants of Health (SDOH) factors (e.g., housing instability, food insecurity, transportation barriers) were identified and documented as contributing factors to the patients financial hardship during the application process.',
    `source_system_application_code` STRING COMMENT 'Native application identifier from the originating operational system (e.g., Epic Resolute HB application record ID). Enables bidirectional traceability between the lakehouse Silver layer and the source system for reconciliation and audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this financial assistance application record in the lakehouse Silver layer. Used for incremental load processing, change data capture, and audit trail compliance.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Dollar amount of patient balance written off as charity care or uncompensated care following approval of financial assistance. Reported in 501(c)(3) community benefit schedules and CMS cost reports. Stored in USD.',
    CONSTRAINT pk_financial_assistance PRIMARY KEY(`financial_assistance_id`)
) COMMENT 'Patient financial assistance and charity care application records capturing application date, assistance program type (charity care, Medicaid presumptive eligibility, sliding fee scale, payment plan, financial hardship), application status, income verification method, federal poverty level percentage, approved assistance amount or discount percentage, approval date, and expiration date. Supports RCM financial counseling, 501(c)(3) community benefit reporting, and uncompensated care tracking. Sourced from EHR revenue cycle and financial counseling modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`portal_account` (
    `portal_account_id` BIGINT COMMENT 'Unique surrogate identifier for the patient portal account record. Primary key for the portal_account data product. Role classification: MASTER_AGREEMENT — represents a long-running digital engagement relationship between a patient and the healthcare organizations portal platform.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient master record who owns this portal account. Links the digital engagement account to the patients identity in the Master Patient Index (MPI). Every portal account must be associated with exactly one patient.',
    `patient_rpm_program_enrollment_id` BIGINT COMMENT 'FK to the active RPM program enrollment linked to this portal account, enabling RPM data display in the patient portal.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `account_status` STRING COMMENT 'Current lifecycle status of the patient portal account. Drives access control, engagement workflows, and MIPS Promoting Interoperability reporting. pending_activation indicates account created but not yet activated by patient. locked indicates temporary security lockout. Satisfies MASTER_AGREEMENT LIFECYCLE_STATUS category.. Valid values are `active|inactive|suspended|pending_activation|locked|deactivated`',
    `account_type` STRING COMMENT 'Classification of the portal account indicating whether it is a direct patient account, a proxy account (parent, guardian, caregiver, healthcare POA), or a shared account. Determines applicable access rules and HIPAA authorization requirements. Satisfies MASTER_AGREEMENT CLASSIFICATION_OR_TYPE category.. Valid values are `patient|proxy|shared`',
    `activation_date` DATE COMMENT 'Calendar date on which the patient first activated and verified their portal account. Distinct from created_date — an account may be created by staff but not activated by the patient until later. Key metric for digital front door strategy and patient engagement KPIs.',
    `activation_method` STRING COMMENT 'Method by which the patient portal account was activated. Supports analysis of activation channel effectiveness for digital front door strategy and patient engagement programs.. Valid values are `staff_assisted|self_service|kiosk|mail|email_invite|sms_invite`',
    `app_link_date` DATE COMMENT 'Date on which the patient first linked a third-party digital health application to their portal account. Used for interoperability adoption tracking and CMS Promoting Interoperability reporting.',
    `appointment_scheduling_enabled` BOOLEAN COMMENT 'Indicates whether the patient has been enabled for self-service appointment scheduling through the portal. Supports digital front door strategy, patient access analytics, and operational capacity planning.',
    `created_date` DATE COMMENT 'Calendar date on which the portal account was first created in the portal platform. Used for cohort analysis, onboarding funnel reporting, and MIPS Promoting Interoperability measure denominators. Satisfies MASTER_AGREEMENT EFFECTIVE_FROM category.',
    `created_timestamp` TIMESTAMP COMMENT 'Precise date and time when this portal account record was first created in the lakehouse silver layer. Supports data lineage, audit trail, and ETL processing controls. Satisfies MASTER_AGREEMENT record audit created category.',
    `deactivation_date` DATE COMMENT 'Calendar date on which the portal account was deactivated or terminated. Null for currently active accounts. Used for access revocation auditing and HIPAA compliance reporting. Satisfies MASTER_AGREEMENT EFFECTIVE_UNTIL category.',
    `digital_health_app_linked` BOOLEAN COMMENT 'Indicates whether the patient has linked one or more third-party digital health applications (e.g., Apple Health, Google Fit, wearable device apps) to their portal account via FHIR API. Supports CMS Interoperability Final Rule compliance and patient-generated health data ingestion.',
    `digital_health_opt_in` STRING COMMENT '',
    `identity_verification_method` STRING COMMENT 'Method used to verify the patients identity during portal account setup. Supports NIST identity assurance level classification and HIPAA security rule compliance for user authentication.. Valid values are `in_person|online_proofing|government_id|knowledge_based|staff_verified|none`',
    `identity_verified_date` DATE COMMENT 'Date on which the patients identity was formally verified. Supports audit trail requirements and periodic re-verification workflows per NIST identity assurance standards.',
    `identity_verified_flag` BOOLEAN COMMENT 'Indicates whether the patients identity has been formally verified during portal account setup (e.g., via in-person verification, identity proofing service, or government ID check). Supports NIST identity assurance level requirements and HIPAA access control.',
    `last_login_date` DATE COMMENT 'Most recent calendar date on which the patient successfully authenticated and logged into the portal. Used for patient engagement analytics, dormant account identification, and MIPS Promoting Interoperability active patient measures.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Precise date and time of the most recent successful patient authentication to the portal. Provides granular session tracking for security auditing and HIPAA access log compliance beyond the date-level last_login_date.',
    `linked_app_name` STRING COMMENT 'Name of the primary third-party digital health application linked to the portal account (e.g., Apple Health, Google Fit, Fitbit). Populated when digital_health_app_linked is true. Supports interoperability reporting and app ecosystem analytics.',
    `login_failure_count` STRING COMMENT 'Number of consecutive failed authentication attempts since the last successful login. Used to trigger account lockout policies per HIPAA security rule requirements and NIST password management guidelines.',
    `messaging_opt_in` BOOLEAN COMMENT 'Indicates whether the patient has opted in to receive secure portal messages from care team members. Supports patient engagement workflows, care coordination, and MIPS Promoting Interoperability secure messaging measures.',
    `notification_email` STRING COMMENT 'Email address used for portal notification delivery. May differ from the patients primary contact email on file. Used for account activation links, secure message alerts, appointment reminders, and test result notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `notification_mobile_phone` STRING COMMENT 'Mobile phone number used for SMS-based portal notifications and two-factor authentication. May differ from the patients primary contact phone on file. Subject to TCPA consent requirements.',
    `notification_preference` STRING COMMENT 'Patients preferred channel for receiving portal notifications (e.g., new messages, appointment reminders, test results). Drives outbound communication workflows and patient engagement strategy.. Valid values are `email|sms|push|in_portal|none`',
    `portal_account_number` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to the portal account by the portal platform (e.g., Epic MyChart account number, Cerner HealtheLife account ID). Used for cross-system reconciliation and patient-facing reference. Satisfies MASTER_AGREEMENT BUSINESS_IDENTIFIER category.',
    `portal_platform` STRING COMMENT 'Name of the patient portal platform hosting this account (e.g., Epic MyChart, Cerner HealtheLife). Identifies the source system for digital engagement and determines applicable integration patterns for FHIR-based data exchange.. Valid values are `MyChart|HealtheLife|FollowMyHealth|Healow|PatientFusion|Other`',
    `proxy_access_flag` BOOLEAN COMMENT 'Indicates whether this portal account has been granted proxy access to another patients health record (e.g., parent accessing a minor childs record, adult caregiver accessing an elderly patients record). When true, proxy-specific fields are populated.',
    `proxy_access_level` STRING COMMENT 'Scope of access granted to the proxy account holder. full allows all portal functions including messaging and scheduling; limited restricts to specific record sections; view_only allows read-only access to designated information. Enforces HIPAA minimum necessary standard.. Valid values are `full|limited|view_only`',
    `proxy_authorization_date` DATE COMMENT 'Date on which proxy access was formally authorized and granted. Establishes the start of the proxy access period for audit and compliance purposes.',
    `proxy_date_of_birth` DATE COMMENT 'Date of birth of the proxy account holder. Used for identity verification during proxy access setup and to confirm the proxy is a legal adult where required (e.g., adult caregiver, healthcare POA).',
    `proxy_expiration_date` DATE COMMENT 'Date on which the proxy access authorization expires. Null for indefinite authorizations. System should automatically revoke access on this date. Critical for HIPAA compliance and time-limited proxy arrangements (e.g., temporary caregiver).',
    `proxy_first_name` STRING COMMENT 'First (given) name of the proxy account holder who has been granted access to the patients portal record. Required for identity verification and HIPAA-compliant proxy access management.',
    `proxy_last_name` STRING COMMENT 'Last (family) name of the proxy account holder who has been granted access to the patients portal record. Required for identity verification and HIPAA-compliant proxy access management.',
    `proxy_legal_document_reference` STRING COMMENT 'Reference identifier or URL to the supporting legal documentation (e.g., court order number, POA document ID, scanned document storage path) that authorizes the proxy access. Supports HIPAA audit and legal compliance.',
    `proxy_legal_document_type` STRING COMMENT 'Type of legal documentation supporting the proxy access authorization. Required for healthcare POA and legal guardian proxy relationships. Supports HIPAA compliance and legal defensibility of proxy access grants.. Valid values are `court_order|power_of_attorney|guardianship_decree|parental_consent|advance_directive|other`',
    `proxy_relationship_type` STRING COMMENT 'Type of relationship between the proxy account holder and the patient whose record is being accessed. Determines applicable HIPAA authorization requirements and access scope. Aligned with HL7 FHIR RelatedPerson.relationship value set.. Valid values are `parent|legal_guardian|adult_caregiver|healthcare_poa|spouse|other`',
    `proxy_revocation_date` DATE COMMENT 'Date on which proxy access was explicitly revoked before its natural expiration. Null if access was not revoked early. Supports HIPAA audit trail requirements for access termination events.',
    `proxy_revocation_reason` STRING COMMENT 'Reason code for early revocation of proxy access. Supports compliance auditing and legal documentation requirements. age_of_majority applies when a minor patient reaches adulthood and proxy parental access is automatically terminated.. Valid values are `patient_request|guardian_change|legal_order|deceased|age_of_majority|administrative`',
    `rx_renewal_request_enabled` BOOLEAN COMMENT 'Indicates whether the patient is enabled to submit prescription renewal requests through the portal. Supports pharmacy engagement workflows and MIPS Promoting Interoperability measures for patient-generated health data.',
    `source_system_account_code` STRING COMMENT 'Native account identifier from the originating portal system (e.g., Epic MyChart internal account ID, Cerner HealtheLife user GUID). Enables bidirectional reconciliation between the lakehouse silver layer and the operational system of record.',
    `terms_accepted_date` DATE COMMENT 'Date on which the patient accepted the portal terms of use and privacy notice. Supports HIPAA Notice of Privacy Practices compliance documentation and legal audit trail.',
    `terms_accepted_flag` BOOLEAN COMMENT 'Indicates whether the patient has accepted the portal terms of use and privacy notice. Required for account activation. Supports HIPAA Notice of Privacy Practices acknowledgment tracking.',
    `terms_version` STRING COMMENT 'Version identifier of the portal terms of use and privacy notice that the patient accepted. Enables tracking of re-consent requirements when terms are updated, supporting HIPAA Notice of Privacy Practices compliance.',
    `test_result_notification_enabled` BOOLEAN COMMENT 'Indicates whether the patient has enabled portal notifications for new laboratory or radiology test results. Supports patient engagement, timely result delivery, and 21st Century Cures Act information blocking compliance.',
    `two_factor_auth_enrolled` BOOLEAN COMMENT 'Indicates whether the patient has enrolled in two-factor authentication (2FA) for portal access. Supports HIPAA security rule compliance, NIST identity assurance level requirements, and organizational security policy enforcement.',
    `two_factor_auth_method` STRING COMMENT 'The specific method used for two-factor authentication when enrolled. Supports security posture analysis and patient experience optimization for authentication workflows.. Valid values are `sms|email|authenticator_app|hardware_token|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Precise date and time when this portal account record was last modified in the lakehouse silver layer. Supports change data capture, incremental ETL processing, and audit trail requirements.',
    CONSTRAINT pk_portal_account PRIMARY KEY(`portal_account_id`)
) COMMENT 'Patient portal and digital engagement account record capturing portal platform, account creation date, activation status, last login date, two-factor authentication enrollment, proxy access grants (parent/guardian, adult caregiver, legal guardian, healthcare POA) with proxy identity, access levels (full, limited, view-only), authorization and expiration dates, revocation dates, supporting legal documentation references, messaging opt-in status, appointment self-scheduling enablement, and digital health app linkages. SSOT for patient digital engagement and proxy access management. Supports patient engagement, HIPAA-compliant proxy access, MIPS Promoting Interoperability measures, and digital front door strategy. Aligned with HL7 FHIR RelatedPerson resource for proxy relationships. Sourced from patient portal and proxy management systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` (
    `proxy_access_id` BIGINT COMMENT 'Unique surrogate identifier for each proxy access record in the patient domain. Primary key for the proxy_access data product.',
    `mpi_record_id` BIGINT COMMENT 'Mpi Record Id for proxy access.',
    `demographics_id` BIGINT COMMENT 'Reference to the person record of the authorized proxy representative. Links to the proxys own identity record in the patient or person master.',
    `proxy_patient_demographics_id` BIGINT COMMENT 'FK to patient demographics - PHI',
    `sdoh_referral_id` BIGINT COMMENT '',
    `access_level` STRING COMMENT 'Scope of access granted to the proxy representative within the patient portal and clinical systems. Full access includes all PHI; limited restricts to specific data categories; view-only prevents any actions. [ENUM-REF-CANDIDATE: full|limited|view_only|scheduling_only|messaging_only — promote to reference product]. Valid values are `full|limited|view_only|scheduling_only|messaging_only`',
    `access_status` STRING COMMENT 'Current lifecycle status of the proxy access record. Active indicates the proxy currently has authorized access; expired indicates the authorization period has lapsed; revoked indicates access was explicitly terminated before expiration.. Valid values are `active|expired|revoked|pending|suspended`',
    `age_of_majority_date` DATE COMMENT 'Date on which the patient is expected to reach the age of majority (typically 18th birthday). Used to schedule automatic expiration or review of proxy access for minor patients. Populated only when minor_patient_flag is true.',
    `authorization_date` DATE COMMENT 'Date on which the proxy access was formally authorized and activated. Represents the effective start of the proxys access rights. Aligns with MASTER_AGREEMENT EFFECTIVE_FROM category.',
    `authorization_location` STRING COMMENT 'Facility or location where the proxy authorization was processed (e.g., hospital registration desk, clinic front desk, online portal). Supports operational reporting and audit.',
    `billing_access_flag` BOOLEAN COMMENT 'Indicates whether the proxy is authorized to view billing statements and make payments on behalf of the patient through the patient portal.',
    `consent_obtained_by` STRING COMMENT 'Name or identifier of the staff member or system that captured the patients consent for proxy access. Supports accountability and audit trail for HIPAA compliance.',
    `consent_obtained_method` STRING COMMENT 'Method by which the patients consent for proxy access was obtained. Supports HIPAA consent documentation requirements and audit trail.. Valid values are `in_person|electronic|mail|phone|fax`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this proxy access record was first created in the system. Aligns with MASTER_AGREEMENT RECORD_AUDIT_CREATED category. Supports data lineage and audit trail requirements.',
    `digital_health_opt_in` STRING COMMENT '',
    `expiration_date` DATE COMMENT 'Date on which the proxy access authorization is scheduled to expire. Nullable for open-ended authorizations. System should automatically transition access_status to expired when this date is reached. Aligns with MASTER_AGREEMENT EFFECTIVE_UNTIL category.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent time the proxy accessed the patients record through the portal or clinical system. Used for access monitoring, dormant account detection, and HIPAA audit log reporting.',
    `legal_document_effective_date` DATE COMMENT 'Date on which the supporting legal document became effective. Used to validate that the legal authority was in force at the time of proxy authorization.',
    `legal_document_expiration_date` DATE COMMENT 'Date on which the supporting legal document expires, if applicable. Nullable for permanent legal instruments. Triggers review workflows when approaching expiration.',
    `legal_document_reference` STRING COMMENT 'Reference identifier or document locator for the supporting legal documentation (e.g., court order number, power of attorney document ID, or document management system reference). Enables retrieval of the underlying legal instrument for audit and compliance verification.',
    `legal_document_type` STRING COMMENT 'Type of legal documentation supporting the proxy authorization. Required for legal guardian and healthcare power of attorney proxy types. Drives document verification workflows. [ENUM-REF-CANDIDATE: court_order|power_of_attorney|birth_certificate|adoption_decree|guardianship_order|none_required — promote to reference product]. Valid values are `court_order|power_of_attorney|birth_certificate|adoption_decree|guardianship_order|none_required`',
    `messaging_access_flag` BOOLEAN COMMENT 'Indicates whether the proxy is authorized to send and receive secure messages with the care team on behalf of the patient through the patient portal.',
    `minor_patient_flag` BOOLEAN COMMENT 'Indicates whether the patient is a minor (under 18 years of age) at the time of proxy authorization. Drives specific access rules and automatic expiration logic when the patient reaches the age of majority.',
    `mrn` STRING COMMENT 'Medical Record Number of the patient whose record is subject to proxy access. Carried here for operational lookup and audit without requiring a join to the patient master.',
    `mychart_proxy_account_number` STRING COMMENT 'Epic MyChart system identifier for the proxys portal account. Used to link the proxy access record to the proxys active MyChart login session and access audit logs.',
    `notes` STRING COMMENT 'Free-text notes entered by staff regarding special circumstances, conditions, or instructions associated with this proxy access record. May include details about legal authority limitations or patient-specific access restrictions.',
    `phi_restriction_flag` BOOLEAN COMMENT 'Indicates whether specific PHI restrictions apply to this proxys access (e.g., sensitive categories such as mental health, substance abuse, or reproductive health are excluded from proxy view). When true, restricted_phi_categories should be reviewed.',
    `portal_access_enabled` BOOLEAN COMMENT 'Indicates whether the proxy currently has active access to the patient portal (e.g., Epic MyChart). May be false even when access_status is active if the proxy has not yet activated their portal account.',
    `proxy_date_of_birth` DATE COMMENT 'Date of birth of the proxy representative. Used for identity verification during proxy authorization and to confirm the proxy meets age requirements (e.g., adult caregiver must be 18+).',
    `proxy_email` STRING COMMENT 'Email address of the proxy representative used for MyChart portal login and proxy-related notifications. Serves as the primary digital contact channel for the proxy.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `proxy_first_name` STRING COMMENT 'Legal first name of the authorized proxy representative. Captured at time of authorization to support audit and identity verification independent of the proxys own patient record.',
    `proxy_last_name` STRING COMMENT 'Legal last name of the authorized proxy representative. Captured at time of authorization to support audit and identity verification.',
    `proxy_phone` STRING COMMENT 'Primary phone number of the proxy representative for identity verification and contact purposes during proxy authorization or revocation.',
    `proxy_relationship_type` STRING COMMENT 'Relationship of proxy to patient',
    `proxy_type` STRING COMMENT 'Classification of the proxy relationship type as defined under HIPAA personal representative rules. Determines the legal basis for access. [ENUM-REF-CANDIDATE: parent_guardian|adult_caregiver|legal_guardian|healthcare_power_of_attorney|personal_representative|minor_self — promote to reference product]. Valid values are `parent_guardian|adult_caregiver|legal_guardian|healthcare_power_of_attorney|personal_representative|minor_self`',
    `relationship_to_patient` STRING COMMENT 'Describes the personal or legal relationship of the proxy to the patient. Distinct from proxy_type which captures the legal authorization category; this field captures the familial or social relationship. [ENUM-REF-CANDIDATE: parent|spouse|child|sibling|grandparent|other_family|non_family — promote to reference product]',
    `relationship_type` STRING COMMENT 'Relationship Type for proxy access.',
    `restricted_phi_categories` STRING COMMENT 'Comma-delimited list of PHI categories excluded from this proxys access scope (e.g., mental_health, substance_abuse, reproductive_health, hiv_status). Populated only when phi_restriction_flag is true. Drives data filtering in the patient portal.',
    `revocation_date` DATE COMMENT 'Date on which the proxy access was explicitly revoked prior to the scheduled expiration. Populated only when access_status is revoked. Supports HIPAA audit trail requirements.',
    `revocation_reason` STRING COMMENT 'Reason code explaining why proxy access was revoked. Required when revocation_date is populated. Supports compliance reporting and audit. [ENUM-REF-CANDIDATE: patient_request|proxy_request|legal_order|age_of_majority|death_of_patient|death_of_proxy|administrative — promote to reference product]',
    `revoked_by` STRING COMMENT 'Person who revoked proxy access',
    `rx_refill_access_flag` BOOLEAN COMMENT 'Indicates whether the proxy is authorized to request prescription refills on behalf of the patient through the patient portal. Relevant for caregiver proxies managing chronic condition patients.',
    `scheduling_access_flag` BOOLEAN COMMENT 'Indicates whether the proxy is authorized to schedule, reschedule, or cancel appointments on behalf of the patient through the patient portal.',
    `source_system_proxy_code` STRING COMMENT 'Native identifier for this proxy access record in the originating source system (e.g., Epic MyChart proxy relationship ID). Enables bidirectional traceability between the lakehouse Silver layer and the operational EHR.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this proxy access record was most recently modified. Supports change tracking, audit trail, and incremental ETL processing in the Databricks Silver layer.',
    `verification_date` DATE COMMENT 'Date on which the proxys identity and legal authority were verified by authorized staff. Supports compliance audit trail.',
    `verification_status` STRING COMMENT 'Status of the identity verification process for the proxy representative. Verified indicates the proxys identity and legal authority have been confirmed by staff. Pending indicates verification is in progress.. Valid values are `verified|pending_verification|verification_failed|not_required`',
    `verified_by` STRING COMMENT 'Name or staff identifier of the individual who verified the proxys identity and legal authority. Required for audit and accountability under HIPAA access control requirements.',
    CONSTRAINT pk_proxy_access PRIMARY KEY(`proxy_access_id`)
) COMMENT 'Patient proxy and authorized representative access records capturing proxy type (parent/guardian, adult caregiver, legal guardian, healthcare power of attorney), proxy identity, access level granted (full, limited, view-only), authorization date, expiration date, revocation date, and supporting legal documentation reference. Supports HIPAA-compliant proxy access management in patient portals and clinical settings. Sourced from Epic MyChart proxy management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` (
    `mrn_crosswalk_id` BIGINT COMMENT 'Surrogate primary key for each MRN crosswalk entry.',
    `care_site_id` BIGINT COMMENT 'FK to the facility care site that assigned this particular MRN/identifier to the patient.',
    `mpi_record_id` BIGINT COMMENT 'Mpi Record Id for mrn crosswalk.',
    `payer_id` BIGINT COMMENT 'FK to the insurance payer if this crosswalk entry represents a payer member number.',
    `primary_mrn_mpi_record_id` BIGINT COMMENT 'FK to the enterprise MPI golden record that this identifier maps to. Core linkage for identity resolution.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `active_flag` BOOLEAN COMMENT '',
    `adt_event_type` STRING COMMENT 'HL7 ADT event type (A01, A04, A08, etc.) that triggered creation or update of this crosswalk entry.',
    `adt_message_control_number` STRING COMMENT 'HL7 message control ID for audit trail back to the originating ADT transaction.',
    `assigning_authority` STRING COMMENT 'OID or namespace of the authority that assigned this identifier (e.g., facility OID, payer system).',
    `cerner_euid` STRING COMMENT 'Cerner Enterprise Unique Identifier if the source system is Oracle Health/Cerner.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crosswalk entry was first created.',
    `crosswalk_status` STRING COMMENT 'Status of this crosswalk entry (ACTIVE, INACTIVE, MERGED, PENDING_REVIEW, DEPRECATED).',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data quality score (0.0000-1.0000) reflecting completeness and consistency of this identifier record.',
    `digital_health_opt_in` STRING COMMENT '',
    `effective_end_date` DATE COMMENT 'Date this identifier mapping became inactive (e.g., patient transferred, MRN retired).',
    `effective_start_date` DATE COMMENT 'Date this identifier mapping became active.',
    `enterprise_mrn` STRING COMMENT 'Enterprise-level MRN assigned by the EMPI system, distinct from facility-level MRNs.',
    `epic_empi_number` STRING COMMENT 'Epic Enterprise Master Patient Index number if the source system is Epic.',
    `facility_mrn` STRING COMMENT 'Facility-specific Medical Record Number assigned at the local site level.',
    `fhir_patient_reference` STRING COMMENT 'FHIR Patient resource reference URI for interoperability with FHIR-based systems.',
    `hie_network_name` STRING COMMENT 'Name of the Health Information Exchange network that assigned this patient identifier.',
    `hie_patient_number` STRING COMMENT 'Patient identifier assigned by the HIE network for cross-organization data exchange.',
    `identifier_system_oid` STRING COMMENT 'OID (Object Identifier) of the identifier system namespace per HL7/FHIR standards.',
    `identifier_type` STRING COMMENT 'Type classification of this identifier (MRN, EMPI, HIE, PAYER_MEMBER, SSN, PASSPORT, etc.).',
    `is_active` BOOLEAN COMMENT 'Is Active for mrn crosswalk.',
    `is_golden_record` BOOLEAN COMMENT 'Indicates whether this crosswalk entry represents the designated golden/authoritative record for this patient.',
    `is_primary_identifier` BOOLEAN COMMENT 'Indicates whether this is the primary identifier for the patient at the given facility/system.',
    `is_primary_mrn` BOOLEAN COMMENT '',
    `last_adt_event_date` DATE COMMENT 'Date of the most recent ADT event that referenced this identifier, indicating recency of use.',
    `match_algorithm` STRING COMMENT 'Name/version of the matching algorithm that established this crosswalk linkage.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000-1.0000) of the match that linked this identifier to the MPI record.',
    `match_status` STRING COMMENT 'Status of the identity match (CONFIRMED, PROBABLE, PENDING_REVIEW, REJECTED).',
    `match_type` STRING COMMENT 'Type of matching performed (DETERMINISTIC, PROBABILISTIC, MANUAL, REFERENTIAL).',
    `meditech_patient_number` STRING COMMENT 'MEDITECH system patient number if the source system is MEDITECH.',
    `merge_status` STRING COMMENT 'Merge status of this MRN',
    `mrn_status` STRING COMMENT '',
    `mrn_type` STRING COMMENT 'Type of MRN (facility/enterprise/HIE/payer)',
    `overlay_risk_flag` BOOLEAN COMMENT 'Flag indicating this crosswalk entry has characteristics suggesting potential patient identity overlay risk.',
    `payer_member_number` STRING COMMENT 'Insurance payer member/subscriber number associated with this patient identity.',
    `review_reason` STRING COMMENT 'Reason this crosswalk entry was flagged for manual review (e.g., LOW_CONFIDENCE, DEMOGRAPHIC_MISMATCH).',
    `source_facility_code` STRING COMMENT 'Code identifying the specific facility within the health system that is the source of this identifier.',
    `source_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the last update in the source system for this identifier record.',
    `source_mrn` STRING COMMENT 'Source Mrn for mrn crosswalk.',
    `source_system_code` STRING COMMENT '',
    `source_system_identifier` STRING COMMENT 'The actual identifier value as stored in the source system.',
    `source_system_patient_identifier` STRING COMMENT 'Source system patient identifier - PHI',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this crosswalk entry.',
    `verified_by` STRING COMMENT 'Name or ID of the HIM analyst or system that verified this crosswalk linkage.',
    `verified_date` DATE COMMENT 'Date when this crosswalk entry was manually or systematically verified as correct.',
    `verified_flag` BOOLEAN COMMENT 'Boolean indicating whether this crosswalk linkage has been verified by a human reviewer or automated verification process.',
    CONSTRAINT pk_mrn_crosswalk PRIMARY KEY(`mrn_crosswalk_id`)
) COMMENT 'ECM-tier extension of the MPI providing multi-system Medical Record Number (MRN) crosswalk for identity resolution across facilities, EHR systems, HIEs, and payer networks. Maps every known patient identifier back to the enterprise MPI golden record. Essential for multi-facility health systems performing data integration, analytics, and interoperability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`communication_log` (
    `communication_log_id` BIGINT COMMENT 'Unique identifier for the patient communication event. Primary key.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Care gap outreach campaigns reference specific quality measures identified by LOINC codes (e.g., LOINC 55284-4 for blood pressure screening). Enables HEDIS/MIPS reporting, campaign effectiveness track',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or care site from which the communication originated.',
    `clinician_id` BIGINT COMMENT 'Identifier of the healthcare provider or care team member who initiated or sent the communication.',
    `communication_campaign_id` BIGINT COMMENT 'Identifier of the population health or outreach campaign this communication is part of, enabling campaign effectiveness tracking.',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics - PHI',
    `employee_id` BIGINT COMMENT 'FK to employee who sent communication',
    `follow_up_communication_log_id` BIGINT COMMENT 'Self-referencing FK on communication_log (follow_up_communication_log_id)',
    `message_template_id` BIGINT COMMENT 'Template used for communication',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who is the recipient or subject of this communication.',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer associated with this communication, if the communication is payer-driven (e.g., HEDIS outreach).',
    `sdoh_referral_id` BIGINT COMMENT '',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with this communication, if applicable.',
    `care_gap_code` STRING COMMENT 'Code identifying the specific care gap or quality measure this communication addresses (e.g., HEDIS measure code).',
    `care_gap_description` STRING COMMENT 'Description of the care gap or preventive service the communication is intended to close (e.g., overdue mammogram, diabetic eye exam).',
    `channel` STRING COMMENT 'Channel for communication log.',
    `communication_channel` STRING COMMENT 'Medium or channel through which the communication was delivered (phone call, SMS, email, patient portal message, postal mail, fax, in-person). [ENUM-REF-CANDIDATE: phone_call|sms|email|patient_portal_message|postal_mail|fax|in_person — 7 candidates stripped; promote to reference product]',
    `communication_date` DATE COMMENT 'Date the communication was sent or initiated, used for reporting and tracking outreach timing.',
    `communication_direction` STRING COMMENT 'Direction (inbound/outbound)',
    `communication_number` STRING COMMENT 'Business identifier or tracking number for this communication event, used for reference and audit purposes.',
    `communication_status` STRING COMMENT 'Current lifecycle status of the communication event per HL7 FHIR Communication status value set. [ENUM-REF-CANDIDATE: preparation|in-progress|not-done|on-hold|stopped|completed|entered-in-error|unknown — 8 candidates stripped; promote to reference product]',
    `communication_timestamp` TIMESTAMP COMMENT 'Precise date and time the communication was sent or initiated, supporting detailed audit and sequence analysis.',
    `communication_type` STRING COMMENT 'Category of communication describing the purpose or business function (appointment reminder, care gap notification, preventive screening outreach, billing statement, post-discharge follow-up, population health campaign).. Valid values are `appointment_reminder|care_gap_notification|preventive_screening_outreach|billing_statement|post_discharge_follow_up|population_health_campaign`',
    `consent_date` DATE COMMENT 'Date patient consent was obtained for this type of communication.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicator that patient consent was obtained prior to sending this communication, per HIPAA and organizational policy.',
    `contact_attempt_number` STRING COMMENT 'Attempt number for this contact',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this communication log record was first created in the system.',
    `delivery_confirmation_code` STRING COMMENT 'Delivery confirmation code',
    `delivery_failure_reason` STRING COMMENT 'Reason or error message explaining why the communication delivery failed (invalid contact, opt-out, system error).',
    `delivery_status` STRING COMMENT 'Status indicating whether the communication was successfully delivered to the recipient.. Valid values are `sent|delivered|failed|bounced|undeliverable|pending`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time the communication was confirmed delivered to the recipient system or device.',
    `digital_health_opt_in` STRING COMMENT '',
    `direction` STRING COMMENT 'Direction for communication log.',
    `fhir_communication_reference` STRING COMMENT 'FHIR resource identifier for this communication, enabling interoperability with FHIR-compliant systems.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicator that an interpreter or translation service was used for this communication.',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the language in which the communication was delivered.',
    `message_body` STRING COMMENT 'Full text content of the communication message sent to the patient or recipient.',
    `message_content_summary` STRING COMMENT 'Summary of message content - PHI',
    `mrn` STRING COMMENT 'Medical Record Number of the patient for cross-reference and identity verification.',
    `opt_out_channel` STRING COMMENT 'Specific communication channel the patient opted out of (e.g., SMS, email, phone calls).',
    `opt_out_date` DATE COMMENT 'Date the patient opted out of receiving communications of this type.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicator that the patient has opted out of receiving this type of communication.',
    `patient_response_date` DATE COMMENT 'Date the patient responded to the communication, if applicable.',
    `patient_response_flag` BOOLEAN COMMENT 'Indicator of whether the patient responded to this communication.',
    `patient_response_text` STRING COMMENT 'Text content of the patients response to the communication, captured for follow-up and documentation.',
    `priority` STRING COMMENT 'Priority level of the communication indicating urgency of the message.. Valid values are `routine|urgent|asap|stat`',
    `program_name` STRING COMMENT 'Program associated with communication',
    `recipient_address` STRING COMMENT 'Recipient address/phone/email - PHI',
    `recipient_contact_value` DECIMAL(18,2) COMMENT 'The actual contact value used to reach the recipient (phone number, email address, mailing address, portal account ID).',
    `recipient_name` STRING COMMENT 'Name of the individual who received the communication (patient or proxy).',
    `recipient_type` STRING COMMENT 'Type of recipient receiving the communication (patient, proxy, emergency contact, guarantor, family member).. Valid values are `patient|proxy|emergency_contact|guarantor|family_member`',
    `response_received_flag` BOOLEAN COMMENT 'Response was received',
    `response_timestamp` TIMESTAMP COMMENT 'Timestamp of response',
    `sender_name` STRING COMMENT 'Name of the individual or system that sent the communication, for display and audit purposes.',
    `sender_role` STRING COMMENT 'Role or title of the sender (e.g., care manager, nurse, physician, automated system, billing department).',
    `sent_timestamp` TIMESTAMP COMMENT 'Sent Timestamp for communication log.',
    `source_system_communication_code` STRING COMMENT 'Unique identifier of this communication in the originating source system, used for traceability and reconciliation.',
    `communication_log_status` STRING COMMENT 'Status for communication log.',
    `subject` STRING COMMENT 'Subject for communication log.',
    `subject_line` STRING COMMENT 'Subject or title of the communication message, used for email and portal messages.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this communication log record was last modified or updated.',
    CONSTRAINT pk_communication_log PRIMARY KEY(`communication_log_id`)
) COMMENT 'Patient communication and correspondence history capturing outreach type (appointment reminder, care gap notification, preventive screening outreach, billing statement, post-discharge follow-up, population health campaign), communication channel (phone call, SMS, email, patient portal message, postal mail), communication date, sender, recipient, delivery status, patient response, opt-out preferences, and campaign linkage. Supports patient engagement workflows, care gap closure tracking, CAHPS communication metrics, and population health outreach effectiveness analysis. Aligned with HL7 FHIR Communication resource. Sourced from patient engagement platforms, care management systems, and outreach automation tools.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` (
    `consent_reference_id` BIGINT COMMENT 'Unique identifier for the consent reference record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Foreign key reference to the facility where the consent was obtained or is primarily associated. Enables facility-level consent reporting and compliance tracking.',
    `consent_record_id` BIGINT COMMENT 'FK to consent.record (cross-domain reference)',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics - PHI',
    `employee_id` BIGINT COMMENT 'The user ID of the staff member who verified this consent reference record. Null if not yet verified.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key reference to the patient who has provided consent. Links to the patient domain SSOT.',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider who obtained or witnessed the consent from the patient.',
    `record_id` BIGINT COMMENT 'Foreign key reference to the consent master record in the consent domain SSOT. Enables cross-domain joins to full consent details.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `superseded_consent_reference_id` BIGINT COMMENT 'Self-referencing FK on consent_reference (superseded_consent_reference_id)',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the encounter during which the consent was obtained. Null if consent was obtained outside of a specific encounter context.',
    `audit_trail_flag` BOOLEAN COMMENT 'Indicates whether a detailed audit trail exists for this consent reference in the consent domain SSOT. True if audit trail is available, False otherwise.',
    `consent_date` DATE COMMENT 'Consent Date for consent reference.',
    `consent_effective_date` DATE COMMENT 'The date when the consent becomes effective and enforceable. Denormalized from consent master for quick filtering and reporting.',
    `consent_expiration_date` DATE COMMENT 'The date when the consent expires and is no longer valid. Null if the consent has no expiration. Denormalized from consent master for quick filtering.',
    `consent_method` STRING COMMENT 'The method by which the consent was obtained from the patient (e.g., written signature, verbal acknowledgment, electronic signature via patient portal, implied consent).. Valid values are `written|verbal|electronic|implied`',
    `consent_obtained_date` DATE COMMENT 'The date when the consent was originally obtained from the patient or their authorized representative.',
    `consent_revocation_date` DATE COMMENT 'The date when the patient revoked their consent. Null if the consent has not been revoked.',
    `consent_scope` STRING COMMENT 'Textual description of the scope or boundaries of the consent. Describes what specific activities, data types, or purposes are covered by this consent.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent reference. Indicates whether the consent is currently active, has been revoked by the patient, has expired, is pending approval, or has been superseded by a newer consent.. Valid values are `active|revoked|expired|pending|superseded`',
    `consent_type` STRING COMMENT 'The category of consent being referenced. Indicates the purpose or scope of the consent (e.g., treatment, research participation, marketing communications, PHI disclosure, HIE participation, telehealth services).. Valid values are `treatment|research|marketing|phi_disclosure|hie_participation|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent reference record was first created in the system. Used for audit trail and data lineage.',
    `digital_health_opt_in` STRING COMMENT '',
    `document_reference_number` STRING COMMENT 'Reference identifier to the physical or electronic consent document stored in the document management system. Enables retrieval of the original signed consent form.',
    `enterprise_mrn` STRING COMMENT 'The enterprise-wide Medical Record Number for the patient across all facilities. Denormalized for quick reference.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration Date for consent reference.',
    `guardian_name` STRING COMMENT 'Full name of the legal guardian or authorized representative who provided consent on behalf of the patient. Null if patient provided consent directly.',
    `guardian_relationship` STRING COMMENT 'The relationship of the guardian or authorized representative to the patient (e.g., parent, spouse, healthcare proxy, power of attorney).',
    `hie_participation_flag` BOOLEAN COMMENT 'Indicates whether the patient has consented to participate in Health Information Exchange networks for sharing their medical records across organizations. True if HIE participation is authorized, False otherwise.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the consent process. True if an interpreter was present, False otherwise.',
    `language_of_consent` STRING COMMENT 'The language in which the consent was presented to and obtained from the patient. Important for compliance with language access requirements.',
    `legal_guardian_flag` BOOLEAN COMMENT 'Indicates whether the consent was provided by a legal guardian or authorized representative rather than the patient directly. True if guardian provided consent, False if patient provided consent.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the patient has opted in to receive marketing communications. True if patient opted in, False otherwise.',
    `mrn` STRING COMMENT 'The facility-specific Medical Record Number for the patient. Denormalized for quick reference and cross-system reconciliation.',
    `phi_disclosure_authorized_flag` BOOLEAN COMMENT 'Indicates whether this consent authorizes disclosure of Protected Health Information to third parties. True if PHI disclosure is authorized, False otherwise.',
    `reference_priority` STRING COMMENT 'Priority order of this consent reference when multiple consents of the same type exist for a patient. Lower numbers indicate higher priority. Used for determining which consent applies in conflict scenarios.',
    `research_participation_flag` BOOLEAN COMMENT 'Indicates whether this consent includes authorization for the patient to participate in research studies. True if research participation is authorized, False otherwise.',
    `source_system_reference_code` STRING COMMENT 'The unique identifier for this consent reference record in the source system. Used for data lineage and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent reference record was last updated. Used for audit trail and change tracking.',
    `verification_status` STRING COMMENT 'Indicates whether the consent reference has been verified for accuracy and completeness by authorized staff. Used for quality assurance and compliance auditing.. Valid values are `verified|unverified|pending_verification`',
    `verified_timestamp` TIMESTAMP COMMENT 'The date and time when this consent reference record was verified. Null if not yet verified.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this consent based on regulatory or organizational policy. True if witness was required, False otherwise.',
    CONSTRAINT pk_consent_reference PRIMARY KEY(`consent_reference_id`)
) COMMENT 'Lightweight reference record linking a patient to their consent records in the consent domain SSOT. Captures patient_id and consent_master_id FK for cross-domain joins.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` (
    `quality_measure_evaluation_id` BIGINT COMMENT 'Unique surrogate identifier for each patient-measure evaluation record. Primary key for the association.',
    `clinician_id` BIGINT COMMENT 'Identifier of the primary care provider or care team to whom this patient is attributed for this measure. Used for provider-level quality scorecards and MIPS reporting. May reference a provider master table.',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to the patient demographics record being evaluated against the quality measure',
    `mpi_record_id` BIGINT COMMENT 'Mpi Record Id for quality measure evaluation.',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `measure_id` BIGINT COMMENT 'Measure Id for quality measure evaluation.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `care_gap_closure_date` DATE COMMENT 'Date care gap was closed - PHI',
    `care_gap_flag` BOOLEAN COMMENT 'Care gap identified - PHI',
    `closure_date` DATE COMMENT 'Date on which the quality gap was closed (patient became numerator compliant). Null if gap remains open. Used for tracking gap closure velocity and care management effectiveness.',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp for quality measure evaluation.',
    `data_source` STRING COMMENT 'Source system or data collection method used to determine compliance for this evaluation (e.g., EHR, claims, chart abstraction, patient survey). Important for hybrid measure reporting and data validation.',
    `denominator_eligible` BOOLEAN COMMENT 'Indicates whether the patient meets the denominator eligibility criteria for this measure in this measurement year (e.g., age range, diagnosis, enrollment continuity). Determined by applying measure-specific eligible population logic.',
    `denominator_flag` BOOLEAN COMMENT 'Denominator Flag for quality measure evaluation.',
    `digital_health_opt_in` STRING COMMENT '',
    `due_date` DATE COMMENT 'Target date by which the quality gap should be closed to count toward the measurement year performance (typically end of measurement period or submission deadline). Used for care management prioritization and outreach scheduling.',
    `evaluation_date` TIMESTAMP COMMENT 'Timestamp when this patient-measure evaluation was last calculated or refreshed. Quality measure evaluations are typically run monthly or quarterly to identify new gaps and update compliance status.',
    `exclusion_flag` BOOLEAN COMMENT 'Exclusion Flag for quality measure evaluation.',
    `exclusion_reason` STRING COMMENT 'Reason code or description for why the patient was excluded from the denominator (e.g., hospice enrollment, bilateral mastectomy for breast cancer screening measures, medical contraindication). Null if not excluded.',
    `gap_status` STRING COMMENT 'Current status of the quality gap for this patient-measure combination. OPEN = gap identified, patient eligible but not compliant; CLOSED = gap closed, patient now compliant; IN_PROGRESS = outreach/intervention underway; NOT_APPLICABLE = patient excluded or not eligible.',
    `intervention_code` STRING COMMENT 'Code or identifier for the care management intervention applied to close this gap (e.g., appointment scheduled, prescription sent, patient education provided). Null if no intervention yet.',
    `measurement_period_end_date` DATE COMMENT 'Measurement Period End Date for quality measure evaluation.',
    `measurement_period_start_date` DATE COMMENT 'Measurement Period Start Date for quality measure evaluation.',
    `measurement_year` STRING COMMENT 'Calendar year for which this patient-measure evaluation applies. Critical for HEDIS annual reporting cycles and CMS measurement periods. A patient may be evaluated against the same measure across multiple years.',
    `mrn` STRING COMMENT 'MRN - PHI',
    `notes` STRING COMMENT 'Free-text notes from quality analysts or care managers regarding this patient-measure evaluation (e.g., chart abstraction findings, patient refusal documentation, data quality issues).',
    `numerator_compliant` BOOLEAN COMMENT 'Indicates whether the patient met the numerator criteria (received the required service, achieved the outcome) for this measure. True means the patient is compliant; false indicates a quality gap.',
    `numerator_flag` BOOLEAN COMMENT 'Numerator Flag for quality measure evaluation.',
    `outreach_attempted` BOOLEAN COMMENT 'Indicates whether population health outreach (phone call, letter, patient portal message) has been attempted to close this gap. Used to track care management engagement efforts.',
    `outreach_date` DATE COMMENT 'Date of most recent outreach attempt to the patient regarding this quality gap. Null if no outreach attempted.',
    `performance_rate` DECIMAL(18,2) COMMENT 'Performance rate for this patient',
    `program_type` STRING COMMENT 'Program type (HEDIS/MIPS/VBC/ACO)',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for quality measure evaluation.',
    CONSTRAINT pk_quality_measure_evaluation PRIMARY KEY(`quality_measure_evaluation_id`)
) COMMENT 'This association product represents the evaluation of individual patients against specific quality measures across measurement periods. It captures population health gap management, quality reporting compliance tracking, and patient-level measure performance. Each record links one patient demographics profile to one quality measure with attributes tracking eligibility determination, compliance status, gap identification, and closure activities. This is the operational foundation for HEDIS reporting, CMS eCQM submission, MIPS quality performance, value-based care gap closure workflows, and population health outreach campaigns.. Existence Justification: In healthcare quality management, each patient is evaluated against multiple quality measures (HEDIS, CMS eCQMs, MIPS) across measurement years, and each quality measure is evaluated against thousands of eligible patients. The business actively manages these patient-measure evaluations as operational records, tracking denominator eligibility, numerator compliance, gap identification, outreach attempts, and closure activities. This is the core operational entity for population health gap closure workflows, HEDIS submission, VBP performance improvement, and care management prioritization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` (
    `program_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for the program enrollment record. Primary key for the association.',
    `care_program_id` BIGINT COMMENT 'Care Program Id for program enrollment.',
    `care_site_id` BIGINT COMMENT 'Care Site Id for program enrollment.',
    `clinician_id` BIGINT COMMENT 'Primary provider responsible for the patient within this program, used for quality measure attribution and care coordination.',
    `consent_reference_id` BIGINT COMMENT 'Re-derived business attribute for patient.program_enrollment: consent_reference_id',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to the patient demographics record. Identifies which patient is enrolled in the quality program.',
    `mpi_record_id` BIGINT COMMENT 'Mpi Record Id for program enrollment.',
    `payer_contract_id` BIGINT COMMENT 'Payer contract under which program enrollment is covered or incentivized',
    `payer_id` BIGINT COMMENT 'Payer ID if enrollment is driven by payer attribution',
    `employee_id` BIGINT COMMENT 'Care manager or navigator assigned to support the patient through the program.',
    `program_clinician_id` BIGINT COMMENT 'FK to referring clinician',
    `program_employee_id` BIGINT COMMENT 'Reference to the user or system that created the enrollment record. Supports audit trail and enrollment workflow tracking.',
    `program_enrolled_by_employee_id` BIGINT COMMENT 'Enrolled By Employee Id for program enrollment.',
    `program_override_approved_by_employee_id` BIGINT COMMENT 'Employee who approved the exclusion criteria override',
    `program_payer_id` BIGINT COMMENT 'Payer Id for program enrollment.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to the quality program master record. Identifies which quality program the patient is enrolled in.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `actual_completion_date` DATE COMMENT 'Actual date patient completed or graduated from the program',
    `acuity_level` STRING COMMENT 'Patient acuity or complexity level within the program (e.g., high, medium, low) driving intervention intensity.',
    `auto_disenroll_flag` BOOLEAN COMMENT 'Whether patient is subject to automatic disenrollment rules (e.g., loss of eligibility)',
    `baseline_assessment_date` DATE COMMENT 'Date of baseline health assessment or screening conducted at enrollment',
    `baseline_assessment_score` DECIMAL(18,2) COMMENT 'Baseline clinical or functional status score (e.g., PHQ-9, HbA1c, BMI) captured at enrollment',
    `care_coordination_minutes` DECIMAL(18,2) COMMENT 'Re-derived attribute added during thin-product expansion based on business context for patient.program_enrollment.',
    `care_manager_npi` STRING COMMENT 'NPI of the assigned care manager; supports provider attribution and care coordination reporting.',
    `completion_status` STRING COMMENT 'Completion outcome (completed, graduated, dropped out, transferred, deceased)',
    `consent_date` DATE COMMENT 'Consent Date for program enrollment.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Consent Obtained Flag for program enrollment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was created in the system. Supports audit trail and data lineage tracking.',
    `data_source_system` STRING COMMENT 'Source system from which enrollment record was created or imported',
    `digital_health_opt_in` STRING COMMENT '',
    `disenrollment_date` DATE COMMENT 'Date the patient was disenrolled from the quality program. Null if enrollment is still active. Determines the end of the patients eligibility period for program-specific measures. Used to calculate enrollment duration and program retention metrics.',
    `disenrollment_initiated_by` STRING COMMENT 'Party who initiated disenrollment (patient, provider, payer, system auto-disenroll)',
    `disenrollment_reason` STRING COMMENT 'Reason code or description explaining why the patient was disenrolled from the quality program. Values may include: deceased, transferred_out_of_network, insurance_change, patient_request, no_longer_eligible, program_ended. Supports disenrollment trend analysis and program retention improvement initiatives.',
    `eligibility_basis` STRING COMMENT 'Re-derived business attribute for patient.program_enrollment: eligibility_basis',
    `eligibility_criteria_met` STRING COMMENT 'Comma-separated list of eligibility criteria met at enrollment (e.g., diagnosis, age, risk score threshold)',
    `engagement_level` STRING COMMENT 'Current engagement level classification (high, medium, low, unengaged)',
    `engagement_score` DECIMAL(18,2) COMMENT 'Quantitative measure of patient engagement with program activities (appointments kept, goals met, communications responded to).',
    `enrollment_channel` STRING COMMENT 'Channel through which the patient was enrolled (e.g., EHR referral, outreach call, patient portal, claims-based).',
    `enrollment_consent_date` DATE COMMENT 'Date patient provided consent to participate in the program',
    `enrollment_consent_method` STRING COMMENT 'Method by which consent was obtained (verbal, written, electronic)',
    `enrollment_date` DATE COMMENT 'Enrollment Date for program enrollment.',
    `enrollment_lifecycle_status` STRING COMMENT 'Re-derived business attribute for patient.program_enrollment: enrollment_lifecycle_status',
    `enrollment_method` STRING COMMENT 'Mechanism of enrollment capture (e.g., EHR workflow, portal, phone, in-person, batch import).',
    `enrollment_notes` STRING COMMENT 'Free-text notes about enrollment circumstances, barriers, or special considerations',
    `enrollment_number` STRING COMMENT 'Enrollment tracking number',
    `enrollment_source` STRING COMMENT 'Enrollment Source for program enrollment.',
    `enrollment_status` STRING COMMENT 'Enrollment Status for program enrollment.',
    `exclusion_criteria_override` STRING COMMENT 'Exclusion criteria that were overridden or waived for this enrollment',
    `expected_completion_date` DATE COMMENT 'Expected or target date for program completion or graduation',
    `expected_duration_days` DECIMAL(18,2) COMMENT 'Expected program duration in days based on program design and patient acuity.',
    `goal_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of care plan goals completed as of the last assessment; supports program effectiveness reporting.',
    `graduation_criteria_met_flag` BOOLEAN COMMENT 'Indicates whether the patient met all clinical or engagement criteria for program graduation.',
    `graduation_date` DATE COMMENT 'Date when the patient successfully completed or graduated from the program.',
    `last_contact_date` DATE COMMENT 'Last Contact Date for program enrollment.',
    `last_intervention_type` STRING COMMENT 'Re-derived attribute added during thin-product expansion based on business context for patient.program_enrollment.',
    `last_outreach_date` DATE COMMENT 'Date of most recent outreach attempt to the patient for this program',
    `last_risk_assessment_date` DATE COMMENT 'Date of most recent risk assessment for program stratification',
    `last_status_change_date` DATE COMMENT 'Date of most recent status change',
    `last_status_change_reason` STRING COMMENT 'Reason for most recent status change',
    `mrn` STRING COMMENT 'MRN - PHI',
    `next_contact_date` DATE COMMENT 'Next Contact Date for program enrollment.',
    `next_scheduled_contact_date` DATE COMMENT 'Next planned outreach or follow-up date for the patient within the program.',
    `notes` STRING COMMENT 'Free-text notes or comments about this enrollment',
    `opt_out_date` DATE COMMENT 'Date when the patient opted out of the program.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the patient has opted out of the program after initial enrollment.',
    `outreach_attempt_count` STRING COMMENT 'Number of outreach attempts made to engage patient in the program',
    `outreach_attempts` STRING COMMENT 'Number of outreach attempts made before successful enrollment',
    `outreach_attempts_count` STRING COMMENT 'Total number of outreach attempts made since enrollment',
    `override_reason` STRING COMMENT 'Reason for overriding exclusion criteria',
    `payer_attributed_flag` BOOLEAN COMMENT 'Indicates if patient is attributed to this program by a payer contract',
    `payer_authorization_date` DATE COMMENT 'Date payer authorization was obtained',
    `payer_authorization_number` STRING COMMENT 'Payer authorization or approval number if program requires prior authorization',
    `payer_program_code` STRING COMMENT 'Payer-assigned program code for this enrollment; used in claims submission and payer reporting.',
    `performance_year` STRING COMMENT 'Calendar or fiscal year for which this enrollment record applies. Aligns with the quality programs performance period. Supports year-over-year enrollment tracking and historical program participation analysis.',
    `primary_diagnosis_code` STRING COMMENT 'Primary ICD-10 diagnosis code driving program eligibility; links clinical condition to program enrollment.',
    `priority_level` STRING COMMENT 'Priority level for program services (high, medium, low) based on risk stratification',
    `priority_score` DECIMAL(18,2) COMMENT 'Calculated priority score for outreach and intervention based on risk and engagement factors',
    `program_category` STRING COMMENT 'Program category (wellness/chronic disease/community/research)',
    `program_completion_date` DATE COMMENT 'Date the patient successfully completed all program requirements; null if not yet completed.',
    `program_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost of program services for this patient enrollment',
    `program_enrollment_date` DATE COMMENT 'Date the patient was enrolled into the quality program. Determines eligibility for program-specific measures and performance periods. Sourced from quality program enrollment systems or EHR population health modules.',
    `program_enrollment_status` STRING COMMENT 'Current status of the patients enrollment in the quality program. Values: active (currently enrolled and eligible for measures), inactive (enrollment paused), pending (enrollment initiated but not yet active), disenrolled (enrollment terminated), suspended (temporarily ineligible). Drives inclusion in quality measure denominators and performance calculations.',
    `program_outcome` STRING COMMENT 'Program Outcome for program enrollment.',
    `program_revenue_estimate` DECIMAL(18,2) COMMENT 'Estimated revenue or reimbursement for this program enrollment (e.g., per-member-per-month capitation, bundled payment)',
    `program_tier` STRING COMMENT 'Program intensity tier or level (e.g., high-touch, standard, low-touch, self-service)',
    `program_type` STRING COMMENT 'Program type',
    `projected_graduation_date` DATE COMMENT 'Re-derived business attribute for patient.program_enrollment: projected_graduation_date',
    `re_enrollment_count` STRING COMMENT 'Number of times patient has re-enrolled in this program',
    `readmission_risk_score` DECIMAL(18,2) COMMENT 'Re-derived attribute added during thin-product expansion based on business context for patient.program_enrollment.',
    `referral_date` DATE COMMENT 'Date of referral to program',
    `referral_source` STRING COMMENT 'Source of referral',
    `referral_source_type` STRING COMMENT 'Type of entity that referred the patient (e.g., PCP, specialist, ED, payer, self).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score at time of enrollment; supports predictive analytics and population health stratification.',
    `risk_tier` STRING COMMENT 'Risk stratification tier assigned to the patient within this quality program. Values: low, medium, high, very_high. Used for risk-adjusted outcome calculations, care management prioritization, and program-specific interventions. Risk tier may vary by program based on program-specific risk models (e.g., HCC risk score for VBP, clinical complexity for care management programs).',
    `sdoh_need_count` STRING COMMENT 'Re-derived attribute added during thin-product expansion based on business context for patient.program_enrollment.',
    `target_completion_date` DATE COMMENT 'Expected or target date for program completion or graduation',
    `target_condition_code` STRING COMMENT 'Primary ICD-10 or SNOMED condition code that qualifies the patient for this program.',
    `target_disposition` STRING COMMENT 'Re-derived business attribute for patient.program_enrollment: target_disposition',
    `target_outcome_metric` STRING COMMENT 'Primary outcome metric or goal for this enrollment (e.g., HbA1c reduction, hospital readmission avoidance, medication adherence)',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was last updated. Supports change tracking and data freshness monitoring.',
    `assigned_coordinator_id` BIGINT COMMENT 'care coordinator owning the enrollment',
    CONSTRAINT pk_program_enrollment PRIMARY KEY(`program_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between patients and quality programs. It captures patient participation in CMS Value-Based Purchasing, MIPS, HEDIS, ACO, and other quality improvement programs. Each record links one patient to one quality program with enrollment dates, risk stratification, eligibility status, and program-specific performance tracking. SSOT for quality program membership, risk tier assignment, and patient-level program participation tracking. Supports CMS quality reporting, risk-adjusted outcome calculation, and program-specific patient cohort identification.. Existence Justification: In healthcare quality operations, patients are simultaneously enrolled in multiple quality programs (e.g., a patient may be enrolled in Hospital VBP, HEDIS, ACO REACH, and internal care management programs at the same time). Each quality program tracks many patients for performance measurement, risk stratification, and outcome reporting. The enrollment relationship is actively managed by quality teams who create enrollment records, assign risk tiers, track eligibility periods, and manage disenrollments based on program-specific criteria.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`care_program` (
    `care_program_id` BIGINT COMMENT 'Primary key for care_program',
    `care_site_id` BIGINT COMMENT 'Identifier of the primary healthcare facility where the care program is based and services are delivered.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the clinical department or service line that owns and operates the care program.',
    `parent_care_program_id` BIGINT COMMENT 'Self-referencing FK on care_program (parent_care_program_id)',
    `payer_id` BIGINT COMMENT 'FK to sponsoring payer',
    `sdoh_referral_id` BIGINT COMMENT '',
    `accreditation_date` DATE COMMENT 'Date when the care program received its current accreditation status.',
    `accreditation_expiry_date` DATE COMMENT 'Date when the current accreditation expires and renewal or re-evaluation is required.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the care program by recognized healthcare quality organizations.',
    `accrediting_body` STRING COMMENT 'Name of the organization that has accredited or is reviewing the care program for quality standards compliance.',
    `active_flag` BOOLEAN COMMENT 'Program is currently active',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total annual budget allocated for the care program in USD, covering staffing, supplies, and operational costs.',
    `care_program_type` STRING COMMENT 'Program type (disease management/wellness/care coordination)',
    `clinical_focus` STRING COMMENT 'Primary clinical condition, disease state, or health concern that the program is designed to address.',
    `care_program_code` STRING COMMENT 'Program code',
    `consent_form_version` STRING COMMENT 'Version identifier of the current consent form document used for patient enrollment.',
    `consent_required` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required for enrollment and participation in the care program.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Average cost in USD to deliver the care program services to one enrolled patient for the full program duration.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the care program record was first created in the system.',
    `current_enrollment_count` STRING COMMENT 'Current number of patients actively enrolled in the care program.',
    `care_program_description` STRING COMMENT 'Detailed narrative description of the care program objectives, services provided, and target patient population.',
    `digital_health_opt_in` STRING COMMENT '',
    `duration_weeks` STRING COMMENT 'Standard length of the care program measured in weeks from enrollment to completion. Null for open-ended programs.',
    `effective_end_date` DATE COMMENT 'Date when the care program is scheduled to end or was terminated. Null for ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date when the care program became or will become available for patient enrollment and service delivery.',
    `eligibility_criteria` STRING COMMENT 'Specific clinical, demographic, and administrative requirements that patients must meet to enroll in the program.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of patients that can be actively enrolled in the program at any given time based on resource constraints.',
    `funding_source` STRING COMMENT 'Primary source of financial support for the care program operations and service delivery.',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates whether the care program meets all HIPAA privacy and security requirements for protected health information.',
    `is_active` BOOLEAN COMMENT 'Is Active for care program.',
    `is_evidence_based` BOOLEAN COMMENT 'Indicates whether the care program is based on peer-reviewed clinical evidence and established best practices.',
    `language_support` STRING COMMENT 'Comma-separated list of languages in which program materials and services are available to accommodate diverse patient populations.',
    `last_review_date` DATE COMMENT 'Date when the care program was last reviewed for clinical effectiveness, quality outcomes, and operational performance.',
    `care_program_name` STRING COMMENT 'Program name',
    `next_review_date` DATE COMMENT 'Scheduled date for the next comprehensive review of the care program.',
    `patient_portal_access` BOOLEAN COMMENT 'Indicates whether enrolled patients have access to a dedicated patient portal for program resources and communication.',
    `program_category` STRING COMMENT 'Delivery setting category that defines where and how care is provided to program participants.',
    `program_code` STRING COMMENT 'Unique business identifier code for the care program, used for external reference and integration with clinical systems.',
    `program_coordinator_email` STRING COMMENT 'Email address of the program coordinator for administrative and clinical communication.',
    `program_coordinator_name` STRING COMMENT 'Name of the clinical or administrative staff member responsible for overall program coordination and management.',
    `program_coordinator_phone` STRING COMMENT 'Contact phone number for the program coordinator.',
    `program_duration_months` DECIMAL(18,2) COMMENT 'Expected program duration in months',
    `program_name` STRING COMMENT 'Official name of the care program as recognized by clinical staff and patients.',
    `program_owner` STRING COMMENT 'Program owner/department',
    `program_type` STRING COMMENT 'Classification of the care program by its primary clinical focus and delivery model.',
    `quality_measure_set` STRING COMMENT 'Standardized set of clinical quality measures used to evaluate program effectiveness and patient outcomes.',
    `reimbursement_model` STRING COMMENT 'Payment methodology used to reimburse the healthcare organization for care program services.',
    `requires_physician_referral` BOOLEAN COMMENT 'Indicates whether a physician referral or order is required for patient enrollment in the care program.',
    `requires_prior_authorization` BOOLEAN COMMENT 'Indicates whether insurance prior authorization is required before a patient can enroll in the care program.',
    `care_program_status` STRING COMMENT 'Current lifecycle status of the care program indicating its operational availability for patient enrollment.',
    `target_outcome_metric` STRING COMMENT 'Primary clinical or functional outcome that the care program aims to improve, such as HbA1c reduction or readmission rate.',
    `target_population` STRING COMMENT 'Description of the patient demographic and clinical characteristics that define program eligibility criteria.',
    `telehealth_enabled` BOOLEAN COMMENT 'Indicates whether the care program offers virtual care delivery options via telehealth technology.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the system user who last modified the care program record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the care program record was last modified.',
    CONSTRAINT pk_care_program PRIMARY KEY(`care_program_id`)
) COMMENT 'Master reference table for care_program. Referenced by program_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` (
    `communication_campaign_id` BIGINT COMMENT 'Primary key for communication_campaign',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this campaign record.',
    `communication_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this campaign record.',
    `message_template_id` BIGINT COMMENT 'Reference identifier for the message template used in this campaign.',
    `parent_communication_campaign_id` BIGINT COMMENT 'Self-referencing FK on communication_campaign (parent_communication_campaign_id)',
    `payer_id` BIGINT COMMENT 'FK to sponsoring payer',
    `sdoh_referral_id` BIGINT COMMENT '',
    `active_flag` BOOLEAN COMMENT 'Campaign is currently active',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the campaign completed or was terminated.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the campaign began sending communications.',
    `approved_by_name` STRING COMMENT 'Name of the individual who provided final approval to launch the campaign.',
    `call_to_action` STRING COMMENT 'Specific action or response requested from patients receiving the campaign communication.',
    `campaign_budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for executing this communication campaign, in USD.',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the campaign, used for tracking and reporting purposes.',
    `campaign_description` STRING COMMENT 'Campaign description',
    `campaign_end_date` DATE COMMENT 'Campaign end date',
    `campaign_name` STRING COMMENT 'Human-readable name of the communication campaign.',
    `campaign_objective` STRING COMMENT 'Detailed description of the business goal and intended outcome of the campaign.',
    `campaign_owner_name` STRING COMMENT 'Name of the individual or department responsible for managing this campaign.',
    `campaign_start_date` DATE COMMENT 'Campaign start date',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the communication campaign.',
    `campaign_type` STRING COMMENT 'Classification of the campaign based on its primary purpose and content focus.',
    `channel` STRING COMMENT 'Communication channel (phone/email/SMS/mail)',
    `communication_channel` STRING COMMENT 'Primary delivery channel through which campaign messages are sent to patients.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required before sending communications for this campaign.',
    `cost_per_message` DECIMAL(18,2) COMMENT 'Estimated or actual cost to send a single message through the selected communication channel, in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign record was first created in the system.',
    `digital_health_opt_in` STRING COMMENT '',
    `end_date` DATE COMMENT 'End Date for communication campaign.',
    `exclusion_criteria` STRING COMMENT 'Business rules defining patient populations or conditions that should be excluded from receiving campaign communications.',
    `frequency_type` STRING COMMENT 'Indicates whether the campaign sends messages once, on a recurring schedule, or based on event triggers.',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the campaign has been verified to comply with HIPAA privacy and security requirements.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for the primary language of campaign communications.',
    `measure_code` STRING COMMENT 'Quality measure code targeted by campaign',
    `message_content` STRING COMMENT 'Full text content of the communication message, including personalization placeholders.',
    `message_subject` STRING COMMENT 'Subject line or title of the communication message sent to patients.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign record was last modified.',
    `multi_language_support_flag` BOOLEAN COMMENT 'Indicates whether the campaign supports message delivery in multiple languages based on patient preferences.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context about the campaign for internal reference.',
    `opt_out_allowed_flag` BOOLEAN COMMENT 'Indicates whether patients can opt out of receiving communications from this campaign.',
    `phi_included_flag` BOOLEAN COMMENT 'Indicates whether the campaign messages contain Protected Health Information as defined by HIPAA.',
    `priority_level` STRING COMMENT 'Business priority classification for campaign execution and resource allocation.',
    `recurrence_pattern` STRING COMMENT 'Schedule pattern for recurring campaigns (e.g., daily, weekly, monthly). Applicable only when frequency_type is recurring.',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory or compliance approval was granted for this campaign.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the campaign requires regulatory or compliance review before launch.',
    `reply_to_email_address` STRING COMMENT 'Email address where patient replies to campaign communications should be directed.',
    `scheduled_end_date` DATE COMMENT 'Date when the campaign is scheduled to stop sending communications. Nullable for ongoing campaigns.',
    `scheduled_start_date` DATE COMMENT 'Date when the campaign is scheduled to begin sending communications.',
    `segmentation_criteria` STRING COMMENT 'Business rules and filters used to identify and segment the target patient population for this campaign.',
    `sender_email_address` STRING COMMENT 'Email address used as the sender for email-based campaign communications.',
    `sender_name` STRING COMMENT 'Display name shown as the sender of campaign communications to patients.',
    `sender_phone_number` STRING COMMENT 'Phone number used as the sender for SMS or phone call-based campaign communications.',
    `start_date` DATE COMMENT 'Start Date for communication campaign.',
    `communication_campaign_status` STRING COMMENT 'Status for communication campaign.',
    `target_audience_description` STRING COMMENT 'Description of the patient population or demographic segment targeted by this campaign.',
    `target_patient_count` STRING COMMENT 'Planned number of patients to be reached by this campaign.',
    `target_population` STRING COMMENT 'Target Population for communication campaign.',
    `target_population_criteria` STRING COMMENT 'Criteria defining target population',
    `tracking_url` STRING COMMENT 'Web link included in campaign messages for tracking patient engagement and response rates.',
    `trigger_event_type` STRING COMMENT 'Type of clinical or administrative event that triggers message sending for event-driven campaigns.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for communication campaign.',
    CONSTRAINT pk_communication_campaign PRIMARY KEY(`communication_campaign_id`)
) COMMENT 'Master reference table for communication_campaign. Referenced by campaign_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` (
    `attribution_panel_id` BIGINT COMMENT 'Primary key for attribution_panel',
    `care_site_id` BIGINT COMMENT 'Care Site Id for attribution panel.',
    `care_team_id` BIGINT COMMENT 'Reference to the care team associated with this attribution panel for coordinated care delivery.',
    `clinician_id` BIGINT COMMENT 'Reference to the primary provider or provider group responsible for this attribution panel.',
    `contract_id` BIGINT COMMENT 'Reference to the value-based care contract or payment arrangement governing this attribution panel.',
    `hie_organization_id` BIGINT COMMENT 'Reference to the healthcare organization or accountable care entity that owns or manages this attribution panel.',
    `parent_attribution_panel_id` BIGINT COMMENT 'Self-referencing FK on attribution_panel (parent_attribution_panel_id)',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan associated with this attribution panel for value-based contracts.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `active_flag` BOOLEAN COMMENT 'Panel is currently active',
    `attribution_calculation_date` DATE COMMENT 'Date when the patient attribution assignments were last calculated or refreshed for this panel.',
    `attribution_method` STRING COMMENT 'Methodology used to assign patients to the attribution panel, such as prospective assignment or retrospective claims analysis.',
    `attribution_period` STRING COMMENT 'Time period over which patient attribution is calculated and maintained for this panel.',
    `attribution_priority` STRING COMMENT 'Numeric priority ranking used to resolve conflicts when a patient qualifies for multiple attribution panels.',
    `auto_assignment_enabled` BOOLEAN COMMENT 'Indicates whether patients are automatically assigned to this panel based on utilization rules or require manual assignment.',
    `created_by_user_code` BIGINT COMMENT 'Reference to the user or system account that created this attribution panel record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this attribution panel record was first created in the system.',
    `digital_health_opt_in` STRING COMMENT '',
    `effective_end_date` DATE COMMENT 'Date when the attribution panel ceases to be active. Null for open-ended panels.',
    `effective_start_date` DATE COMMENT 'Date when the attribution panel becomes active and begins attributing patients to providers or care teams.',
    `exclude_emergency_visits` BOOLEAN COMMENT 'Indicates whether emergency department visits are excluded from attribution calculations for this panel.',
    `geographic_service_area` STRING COMMENT 'Geographic region or service area covered by this attribution panel, such as county, state, or ZIP code range.',
    `include_telehealth_encounters` BOOLEAN COMMENT 'Indicates whether telehealth or virtual care encounters are counted toward attribution eligibility for this panel.',
    `is_active` BOOLEAN COMMENT 'Is Active for attribution panel.',
    `lookback_period_months` STRING COMMENT 'Number of months of historical data used to determine patient attribution based on utilization patterns.',
    `max_panel_size` STRING COMMENT 'Maximum panel size',
    `measurement_year` STRING COMMENT 'Measurement Year for attribution panel.',
    `minimum_encounter_threshold` STRING COMMENT 'Minimum number of encounters or visits required for a patient to be attributed to this panel.',
    `modified_by_user_code` BIGINT COMMENT 'Reference to the user or system account that last modified this attribution panel record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this attribution panel record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this attribution panel.',
    `panel_capacity` STRING COMMENT 'Maximum number of patients that can be attributed to this panel based on provider capacity or contractual limits.',
    `panel_code` STRING COMMENT 'Unique business identifier code for the attribution panel, used for external references and system integration.',
    `panel_description` STRING COMMENT 'Detailed textual description of the attribution panel purpose, scope, and business rules for patient assignment.',
    `panel_name` STRING COMMENT 'Human-readable name or title of the attribution panel used for identification and reporting purposes.',
    `panel_size` STRING COMMENT 'Current panel size',
    `panel_type` STRING COMMENT 'Classification of the attribution panel based on care delivery model or payment arrangement.',
    `patient_count` STRING COMMENT 'Total number of patients currently attributed to this panel as of the last calculation date.',
    `quality_program_participation` STRING COMMENT 'Quality measurement or incentive programs this attribution panel participates in, such as MIPS, MSSP, or HEDIS.',
    `risk_adjustment_model` STRING COMMENT 'Risk stratification or adjustment methodology applied to patients in this attribution panel for quality and cost benchmarking.',
    `specialty_type` STRING COMMENT 'Medical specialty or service line focus of the attribution panel, such as cardiology, oncology, or primary care.',
    `attribution_panel_status` STRING COMMENT 'Current lifecycle status of the attribution panel indicating whether it is actively used for patient attribution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for attribution panel.',
    `version_number` STRING COMMENT 'Version number of the attribution panel configuration, incremented with each significant change to attribution rules.',
    CONSTRAINT pk_attribution_panel PRIMARY KEY(`attribution_panel_id`)
) COMMENT 'Master reference table for attribution_panel. Referenced by attribution_panel_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`message_template` (
    `message_template_id` BIGINT COMMENT 'Primary key for message_template',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who originally created this message template record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this message template for production use.',
    `facility_care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility for which this message template is configured and used.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who most recently modified this message template record.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the healthcare department or service line that owns and manages this message template.',
    `parent_message_template_id` BIGINT COMMENT 'Self-referencing FK on message_template (parent_message_template_id)',
    `sdoh_referral_id` BIGINT COMMENT '',
    `active_flag` BOOLEAN COMMENT 'Template is currently active',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this message template was approved for production use.',
    `body` STRING COMMENT 'Body for message template.',
    `callback_phone_number` STRING COMMENT 'Phone number provided in the message template for patients to call back for questions or concerns.',
    `channel` STRING COMMENT 'Channel for message template.',
    `character_limit` STRING COMMENT 'Maximum number of characters allowed for messages using this template, particularly relevant for SMS and push notifications.',
    `communication_channel` STRING COMMENT 'The delivery channel through which this message template is intended to be sent to patients.',
    `consent_type` STRING COMMENT 'The specific type of patient consent required for this message template, if applicable.',
    `contains_phi` BOOLEAN COMMENT 'Indicates whether the message template includes or may include Protected Health Information when rendered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this message template record was first created in the system.',
    `delivery_time_preference` STRING COMMENT 'Preferred time window for delivering messages using this template to optimize patient engagement.',
    `digital_health_opt_in` STRING COMMENT '',
    `effective_end_date` DATE COMMENT 'The date after which this message template is no longer active and should not be used for new communications. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this message template becomes active and available for use in patient communications.',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates whether the message template has been reviewed and approved for HIPAA compliance regarding Protected Health Information (PHI) disclosure.',
    `is_active` BOOLEAN COMMENT 'Is Active for message template.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the message template content.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this message template record was most recently updated.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp when this message template was most recently used to send a message.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of delivery retry attempts allowed for messages using this template.',
    `merge_fields` STRING COMMENT 'Comma-separated list of dynamic merge field placeholders available in this template for personalization (e.g., patient_name, appointment_date, provider_name).',
    `message_body` STRING COMMENT 'The full text content of the message template, including placeholders for dynamic data substitution.',
    `message_subject` STRING COMMENT 'Subject line or title for the message template, used primarily for email and portal communications.',
    `message_type` STRING COMMENT 'Message type (reminder/care gap/billing/clinical)',
    `notes` STRING COMMENT 'Free-text notes and comments about the message template for internal reference and documentation purposes.',
    `opt_out_instructions` STRING COMMENT 'Text instructions provided to patients on how to opt out of receiving future messages of this type.',
    `priority_level` STRING COMMENT 'The urgency classification for messages sent using this template, affecting delivery timing and routing.',
    `reply_to_address` STRING COMMENT 'Email address to which patient replies should be directed when using this message template.',
    `requires_consent` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required before sending messages using this template.',
    `retry_policy` STRING COMMENT 'Policy governing retry attempts if message delivery fails using this template.',
    `sender_name` STRING COMMENT 'The display name that appears as the sender when messages are delivered using this template.',
    `message_template_status` STRING COMMENT 'Current lifecycle status of the message template indicating its availability for use in patient communications.',
    `subject` STRING COMMENT 'Subject for message template.',
    `template_category` STRING COMMENT 'Classification of the message template by its primary communication purpose within patient care workflows.',
    `template_code` STRING COMMENT 'Unique business identifier code for the message template, used for system integration and reference.',
    `template_name` STRING COMMENT 'Human-readable name of the message template for identification and selection purposes.',
    `template_type` STRING COMMENT 'Template Type for message template.',
    `template_version` STRING COMMENT 'Semantic version number of the message template, tracking revisions and updates over time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for message template.',
    `usage_count` BIGINT COMMENT 'Total number of times this message template has been used to send messages to patients.',
    CONSTRAINT pk_message_template PRIMARY KEY(`message_template_id`)
) COMMENT 'Master reference table for message_template. Referenced by message_template_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` (
    `sdoh_referral_id` BIGINT COMMENT 'Surrogate key for the SDOH referral.',
    `care_site_id` BIGINT COMMENT 'Care site where referral originated.',
    `community_resource_id` BIGINT COMMENT 'Community resource the patient was referred to.',
    `demographics_id` BIGINT COMMENT 'Patient referred to the community resource.',
    `mpi_record_id` BIGINT COMMENT 'Patient receiving the referral.',
    `sdoh_assessment_id` BIGINT COMMENT 'Assessment that triggered this referral.',
    `visit_id` BIGINT COMMENT 'Encounter where the referral was generated.',
    `accepted_date` DATE COMMENT 'Date resource accepted the referral.',
    `closed_date` DATE COMMENT 'Date the referral loop was closed.',
    `closed_loop_flag` BOOLEAN COMMENT 'Whether closed-loop confirmation was received.',
    `closure_date` DATE COMMENT '',
    `consent_obtained_flag` BOOLEAN COMMENT 'Whether patient consent to refer was obtained.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `digital_health_opt_in` BOOLEAN COMMENT 'Patient opt-in flag for digital health / patient engagement programs.',
    `disposition` STRING COMMENT 'Final disposition of the referral.',
    `icd10_z_code` STRING COMMENT 'ICD-10 Z-code mapped to the SDOH category.',
    `need_closure_status` STRING COMMENT '',
    `outcome` STRING COMMENT '',
    `outcome_description` STRING COMMENT 'Narrative outcome of the referral.',
    `priority_level` STRING COMMENT '',
    `referral_channel` STRING COMMENT 'Channel used (e-referral, phone, paper).',
    `referral_date` DATE COMMENT 'Date referral was created.',
    `referral_method` STRING COMMENT 'Method used to send the referral (closed-loop platform, fax, phone).',
    `referral_number` STRING COMMENT 'Human-readable referral identifier.',
    `referral_outcome` STRING COMMENT 'Outcome disposition of the referral.',
    `referral_priority` STRING COMMENT 'Priority/urgency of the referral.',
    `referral_status` STRING COMMENT 'Status of referral (open, sent, accepted, declined, closed).',
    `referring_clinician_id` BIGINT COMMENT 'Clinician or CHW who placed the referral.',
    `risk_priority_score` DECIMAL(18,2) COMMENT 'Risk stratification/priority score for need.',
    `sdoh_domain` STRING COMMENT 'SDOH need category (housing, food, transportation, etc.).',
    `sent_date` DATE COMMENT 'Date referral was transmitted to resource.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `z_code` STRING COMMENT 'ICD-10 Z-code associated with the social need.',
    CONSTRAINT pk_sdoh_referral PRIMARY KEY(`sdoh_referral_id`)
) COMMENT 'SDOH referral management linking patient to community resources for identified social needs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`community_resource` (
    `community_resource_id` BIGINT COMMENT 'Surrogate key for the community resource.',
    `geographic_region_id` BIGINT COMMENT 'Service geography of the resource.',
    `accepts_referrals_flag` BOOLEAN COMMENT 'Whether the resource accepts electronic referrals.',
    `active_flag` BOOLEAN COMMENT 'Whether the directory entry is active.',
    `address_line1` STRING COMMENT 'Street address of the resource.',
    `capacity_status` STRING COMMENT 'Current capacity/availability status.',
    `city` STRING COMMENT 'City of the resource.',
    `closed_loop_capable_flag` BOOLEAN COMMENT 'Whether the resource supports closed-loop referrals.',
    `contact_email` STRING COMMENT 'Contact email address.',
    `contact_name` STRING COMMENT 'Resource contact person name.',
    `contact_phone` STRING COMMENT 'Contact phone number.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `digital_health_opt_in` BOOLEAN COMMENT 'Patient opt-in flag for digital health / patient engagement programs.',
    `eligibility_criteria` STRING COMMENT 'Eligibility criteria for the service.',
    `email` STRING COMMENT 'Resource contact email.',
    `hours_of_operation` STRING COMMENT 'Hours of operation.',
    `is_active` BOOLEAN COMMENT 'Whether the resource is currently active.',
    `is_active_flag` BOOLEAN COMMENT '',
    `languages_supported` STRING COMMENT 'Languages supported by the resource.',
    `last_verified_date` DATE COMMENT 'Date the directory entry was last verified.',
    `organization_name` STRING COMMENT '',
    `organization_type` STRING COMMENT 'Type of community organization (CBO, food bank, shelter).',
    `phone` STRING COMMENT 'Resource contact phone.',
    `postal_code` STRING COMMENT 'Postal code of the resource.',
    `resource_name` STRING COMMENT 'Name of the community-based organization.',
    `resource_type` STRING COMMENT 'Type of resource (food bank, shelter, transport).',
    `sdoh_domain` STRING COMMENT 'Primary SDOH domain served.',
    `service_area` STRING COMMENT '',
    `service_category` STRING COMMENT 'Category of service offered.',
    `service_description` STRING COMMENT 'Description of services offered.',
    `state_code` STRING COMMENT 'State of the resource.',
    `taxonomy_code` STRING COMMENT '211/AIRS or other taxonomy code for the service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `website_url` STRING COMMENT 'Resource website URL.',
    CONSTRAINT pk_community_resource PRIMARY KEY(`community_resource_id`)
) COMMENT 'Community resource directory entry for community-based organizations addressing social needs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` (
    `sdoh_need_closure_id` BIGINT COMMENT 'Surrogate key for the need closure record.',
    `clinician_id` BIGINT COMMENT 'Community health worker who worked the need.',
    `chw_intervention_id` BIGINT COMMENT 'CHW intervention contributing to closure.',
    `employee_id` BIGINT COMMENT '',
    `community_resource_id` BIGINT COMMENT 'Resource that addressed the need.',
    `demographics_id` BIGINT COMMENT 'Patient whose need is tracked.',
    `mpi_record_id` BIGINT COMMENT 'Patient whose need is tracked.',
    `sdoh_assessment_id` BIGINT COMMENT 'Originating assessment for the need.',
    `sdoh_referral_id` BIGINT COMMENT 'Referral being closed.',
    `actual_closure_date` DATE COMMENT 'Actual date the need was resolved.',
    `barrier_to_closure` STRING COMMENT 'Barrier preventing closure if unresolved.',
    `closure_method` STRING COMMENT 'Method by which closure was confirmed.',
    `closure_reason` STRING COMMENT 'Reason for closure or non-closure.',
    `closure_status` STRING COMMENT 'Closure status of the need.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `days_to_closure` STRING COMMENT 'Elapsed days from identification to closure.',
    `digital_health_opt_in` BOOLEAN COMMENT 'Patient opt-in flag for digital health / patient engagement programs.',
    `follow_up_due_date` DATE COMMENT 'Next follow-up due date.',
    `icd10_z_code` STRING COMMENT 'ICD-10 Z-code for the SDOH need.',
    `identified_date` DATE COMMENT 'Date the need was identified.',
    `intervention_description` STRING COMMENT 'Description of CHW intervention performed.',
    `need_closed_date` DATE COMMENT '',
    `need_identified_date` DATE COMMENT '',
    `need_resolved_flag` BOOLEAN COMMENT 'Whether the need was resolved.',
    `need_status` STRING COMMENT 'Current status of the need (open, in_progress, resolved, unable_to_resolve).',
    `resolution_date` DATE COMMENT 'Date the need was resolved.',
    `resolved_flag` BOOLEAN COMMENT 'Whether the need was resolved.',
    `sdoh_domain` STRING COMMENT 'SDOH need domain being closed.',
    `target_closure_date` DATE COMMENT 'Target date for resolving the need.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `z_code` STRING COMMENT 'ICD-10 Z-code for the social need.',
    CONSTRAINT pk_sdoh_need_closure PRIMARY KEY(`sdoh_need_closure_id`)
) COMMENT 'Need closure tracking - whether an identified social need (housing/food/etc.) was resolved.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` (
    `patient_coverage_id` BIGINT COMMENT 'Patient Coverage Id for patient coverage.',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics - PHI',
    `insurance_coverage_id` BIGINT COMMENT 'FK to insurance coverage',
    `member_enrollment_id` BIGINT COMMENT 'Member Id for patient coverage.',
    `mpi_record_id` BIGINT COMMENT 'Mpi Record Id for patient coverage.',
    `payer_id` BIGINT COMMENT 'Payer Id for patient coverage.',
    `sdoh_referral_id` BIGINT COMMENT '',
    `coverage_priority` STRING COMMENT 'Coverage priority order (1=primary)',
    `coverage_status` STRING COMMENT 'Coverage Status for patient coverage.',
    `coverage_type` STRING COMMENT 'Coverage Type for patient coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp for patient coverage.',
    `digital_health_opt_in` STRING COMMENT '',
    `effective_date` DATE COMMENT 'Effective Date for patient coverage.',
    `group_number` STRING COMMENT 'Group Number for patient coverage.',
    `is_active` BOOLEAN COMMENT 'Coverage is currently active',
    `last_verified_date` DATE COMMENT 'Date coverage was last verified',
    `merged_with_billing_billing_coverage` STRING COMMENT 'SSOT reconciliation attribute added by vibe cross-domain dedup pass.',
    `plan_name` STRING COMMENT 'Insurance plan name',
    `ssot_canonical_reference` STRING COMMENT 'This table is the canonical coverage SSOT',
    `ssot_reconciliation_status` STRING COMMENT 'Canonical SSOT for patient/member coverage; billing.billing_coverage references this',
    `termination_date` DATE COMMENT 'Termination Date for patient coverage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for patient coverage.',
    CONSTRAINT pk_patient_coverage PRIMARY KEY(`patient_coverage_id`)
) COMMENT 'Patient Coverage product.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` (
    `patient_rpm_device_reading_id` BIGINT COMMENT 'PK',
    `mpi_record_id` BIGINT COMMENT 'FK',
    `patient_rpm_program_enrollment_id` BIGINT COMMENT 'FK',
    `patient_rpm_alert_threshold_id` BIGINT COMMENT 'Foreign key linking to patient.patient_rpm_alert_threshold. Business justification: A device reading carries is_alert_triggered; when an alert fires it crosses a specific per-patient per-measure alert threshold. Linking the reading to the threshold it breached (N:1 — many readings ca',
    `is_alert_triggered` BOOLEAN COMMENT 'Attribute is_alert_triggered',
    `measure_type` STRING COMMENT 'Attribute measure_type',
    `reading_at` TIMESTAMP COMMENT 'Attribute reading_at',
    `reading_value` DECIMAL(18,2) COMMENT 'Attribute reading_value',
    `unit` STRING COMMENT 'Attribute unit',
    CONSTRAINT pk_patient_rpm_device_reading PRIMARY KEY(`patient_rpm_device_reading_id`)
) COMMENT 'Device/sensor readings (HR, glucose, SpO2, weight)';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold` (
    `patient_rpm_alert_threshold_id` BIGINT COMMENT 'PK',
    `mpi_record_id` BIGINT COMMENT 'FK',
    `patient_rpm_program_enrollment_id` BIGINT COMMENT 'FK',
    `high_threshold` DECIMAL(18,2) COMMENT 'Attribute high_threshold',
    `is_active` BOOLEAN COMMENT 'Attribute is_active',
    `low_threshold` DECIMAL(18,2) COMMENT 'Attribute low_threshold',
    `measure_type` STRING COMMENT 'Attribute measure_type',
    CONSTRAINT pk_patient_rpm_alert_threshold PRIMARY KEY(`patient_rpm_alert_threshold_id`)
) COMMENT 'RPM alert threshold definitions per patient per measure';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` (
    `patient_rpm_program_enrollment_id` BIGINT COMMENT 'PK',
    `mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record',
    `device_type` STRING COMMENT 'Attribute device_type',
    `disenrolled_at` TIMESTAMP COMMENT 'Attribute disenrolled_at',
    `enrolled_at` TIMESTAMP COMMENT 'Attribute enrolled_at',
    `enrollment_status` STRING COMMENT 'Attribute enrollment_status',
    `is_active` BOOLEAN COMMENT 'Attribute is_active',
    `program_name` STRING COMMENT 'Attribute program_name',
    CONSTRAINT pk_patient_rpm_program_enrollment PRIMARY KEY(`patient_rpm_program_enrollment_id`)
) COMMENT 'Remote patient monitoring program enrollment tracking';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`patient_portal_engagement_event` (
    `patient_portal_engagement_event_id` BIGINT COMMENT 'PK',
    `mpi_record_id` BIGINT COMMENT 'FK',
    `portal_account_id` BIGINT COMMENT 'FK to patient.portal_account',
    `event_at` TIMESTAMP COMMENT 'Attribute event_at',
    `event_detail` STRING COMMENT 'Attribute event_detail',
    `event_type` STRING COMMENT 'Attribute event_type',
    CONSTRAINT pk_patient_portal_engagement_event PRIMARY KEY(`patient_portal_engagement_event_id`)
) COMMENT 'Patient portal engagement metrics (logins, message reads, self-scheduling)';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` (
    `patient_prom_response_id` BIGINT COMMENT 'PK',
    `mpi_record_id` BIGINT COMMENT 'FK',
    `collected_at` TIMESTAMP COMMENT 'Attribute collected_at',
    `instrument_name` STRING COMMENT 'Attribute instrument_name',
    `question_code` STRING COMMENT 'Attribute question_code',
    `response_value` DECIMAL(18,2) COMMENT 'Attribute response_value',
    `score` DECIMAL(18,2) COMMENT 'Attribute score',
    CONSTRAINT pk_patient_prom_response PRIMARY KEY(`patient_prom_response_id`)
) COMMENT 'Patient-reported outcome measure questionnaire responses';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` (
    `sdoh_risk_stratification_id` BIGINT COMMENT 'Primary key for sdoh_risk_stratification',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or site where the SDOH screening was administered.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: sdoh_risk_stratification has a generic patient_id column that points nowhere. The patient entity within this domain is mpi_record (the enterprise SSOT for identity). An SDOH risk stratification belong',
    `previous_sdoh_risk_stratification_id` BIGINT COMMENT 'Self-referencing FK on sdoh_risk_stratification (previous_sdoh_risk_stratification_id)',
    `assessment_date` DATE COMMENT 'Calendar date on which the social determinants of health screening was administered to the patient.',
    `assessment_method` STRING COMMENT 'Channel or modality through which the SDOH data was collected, distinguishing self-reported responses from clinician-administered screening.',
    `assessment_tool_name` STRING COMMENT 'Name of the standardized screening instrument used to capture social risk (e.g., PRAPARE, AHC-HRSN, Health Leads). Supports comparability and methodological transparency across populations. [ENUM-REF-CANDIDATE: PRAPARE|AHC-HRSN|Health Leads|WellRx|EveryONE Project|Accountable Health Communities|custom — promote to reference product]',
    `care_management_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients social risk tier qualifies them for enrollment in care management or complex care coordination programs.',
    `consent_to_screen_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to the collection and use of their social determinants of health data, supporting privacy compliance.',
    `data_source_system` STRING COMMENT 'Name of the originating source system that captured the screening data (EHR module, community resource platform, HIE feed), supporting provenance and data quality assessment.',
    `domains_screened_positive_count` STRING COMMENT 'Count of distinct social risk domains for which the patient screened positive, providing a quick measure of cumulative social need.',
    `education_barrier_flag` BOOLEAN COMMENT 'Indicates whether the patient reported limited educational attainment or health literacy barriers impacting self-management.',
    `employment_status` STRING COMMENT 'Self-reported employment status of the patient, a contributing social determinant influencing income stability and health risk.',
    `financial_strain_flag` BOOLEAN COMMENT 'Indicates whether the patient reported financial strain affecting their ability to afford basic needs or medical care.',
    `food_insecurity_flag` BOOLEAN COMMENT 'Indicates whether the patient screened positive for food insecurity, informing referrals to nutrition and food assistance programs.',
    `housing_instability_flag` BOOLEAN COMMENT 'Indicates whether the patient screened positive for housing instability or homelessness risk, supporting housing-related social need referrals.',
    `interpersonal_safety_flag` BOOLEAN COMMENT 'Indicates whether the patient screened positive for interpersonal violence or safety concerns, triggering sensitive protective protocols and referrals.',
    `interpreter_needed_flag` BOOLEAN COMMENT 'Indicates whether the patient requires language interpreter services to communicate effectively with care teams.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date by which the patients social risk should be re-screened, supporting periodic re-stratification cadence.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite numeric score summarizing the patients aggregate social risk burden across all assessed domains, used to rank patients for outreach and intervention.',
    `primary_language` STRING COMMENT 'Patients preferred spoken language, used to assess language access barriers and arrange interpreter services. [ENUM-REF-CANDIDATE: english|spanish|chinese|vietnamese|tagalog|arabic|french|other — promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDOH risk stratification record was first captured in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDOH risk stratification record was last modified, supporting change tracking and re-stratification audit.',
    `referral_generated_flag` BOOLEAN COMMENT 'Indicates whether one or more closed-loop community resource referrals were generated as a result of this stratification.',
    `referral_status` STRING COMMENT 'Current status of any social-need referral arising from this assessment, supporting closed-loop referral tracking and follow-up.',
    `risk_tier` STRING COMMENT 'Categorical stratification tier derived from the overall risk score, driving the intensity of care management and resource allocation for the patient.',
    `social_isolation_flag` BOOLEAN COMMENT 'Indicates whether the patient reported social isolation or lack of social support, a risk factor for adverse health outcomes.',
    `stratification_status` STRING COMMENT 'Lifecycle status of this stratification record, indicating whether it is the current active assessment or has been superseded by a more recent screening.',
    `transportation_barrier_flag` BOOLEAN COMMENT 'Indicates whether the patient reported transportation barriers that limit access to care, appointments, or medication pickup.',
    `utility_insecurity_flag` BOOLEAN COMMENT 'Indicates whether the patient reported difficulty paying for utilities (heat, electricity, water), affecting home safety and health.',
    CONSTRAINT pk_sdoh_risk_stratification PRIMARY KEY(`sdoh_risk_stratification_id`)
) COMMENT 'Master reference table for sdoh_risk_stratification. Referenced by sdoh_risk_stratification_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` (
    `sdoh_zcode_mapping_id` BIGINT COMMENT 'Primary key for sdoh_zcode_mapping',
    `superseded_sdoh_zcode_mapping_id` BIGINT COMMENT 'Self-referencing FK on sdoh_zcode_mapping (superseded_sdoh_zcode_mapping_id)',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the Z-code is a valid billable/reportable diagnosis code at the assigned specificity for claims submission.',
    `code_specificity_level` STRING COMMENT 'The hierarchical level of the Z-code indicating coding granularity (3-character category, 4-character subcategory, or full billable code).',
    `data_classification` STRING COMMENT 'Sensitivity classification of the reference record; SDOH Z-code reference mappings are typically internal/public reference data carrying no patient PHI.',
    `default_referral_resource_type` STRING COMMENT 'The default community or social service resource type recommended when this Z-code is assigned. [ENUM-REF-CANDIDATE: food_bank|housing_agency|transportation_service|utility_assistance|employment_service|financial_counseling|legal_aid — promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date on which this Z-code mapping is retired or superseded; null indicates currently active mapping.',
    `effective_start_date` DATE COMMENT 'Date on which this Z-code mapping becomes valid and usable for clinical coding and reporting.',
    `hcpcs_code` STRING COMMENT 'Associated HCPCS G-code or service code used to bill SDOH assessment or intervention services linked to this Z-code (e.g., G0136 social needs screening).',
    `icd10_chapter` STRING COMMENT 'The ICD-10-CM chapter classification under which the Z-code resides (Factors influencing health status and contact with health services).',
    `intervention_recommended_flag` BOOLEAN COMMENT 'Indicates whether identification of this Z-code triggers a recommended care management or community-resource referral intervention.',
    `loinc_code` STRING COMMENT 'LOINC code for the associated SDOH screening observation or panel, enabling interoperability with lab and assessment data.',
    `mapping_confidence_level` STRING COMMENT 'The equivalence/confidence relationship between the source screening concept and the target Z-code, following terminology mapping equivalence semantics.',
    `mapping_source_authority` STRING COMMENT 'The authoritative body or terminology source that defined this SDOH-to-Z-code mapping (e.g., Gravity Project, CMS, internal terminology governance).',
    `mapping_status` STRING COMMENT 'Current lifecycle status of the SDOH Z-code mapping entry governing whether it may be used in production coding workflows.',
    `notes` STRING COMMENT 'Free-text guidance or coding notes explaining usage, exclusions, or special considerations for applying this SDOH Z-code mapping.',
    `reportable_to_payer_flag` BOOLEAN COMMENT 'Indicates whether the Z-code is recognized for SDOH reporting to payers and value-based care programs.',
    `risk_severity_level` STRING COMMENT 'Severity classification indicating the level of health-related social need represented by the Z-code, used for risk stratification and care prioritization.',
    `screening_concept_code` STRING COMMENT 'The code from the source SDOH screening instrument concept that this Z-code is mapped from (e.g., a question or response concept).',
    `screening_instrument_name` STRING COMMENT 'Name of the standardized SDOH screening tool whose findings map to this Z-code (e.g., PRAPARE, AHC-HRSN, Hunger Vital Sign).',
    `sdoh_category_code` STRING COMMENT 'Standardized category code for the social determinant grouping, aligned to the Gravity Project value set terminology.',
    `sdoh_domain` STRING COMMENT 'The high-level SDOH domain category the Z-code maps to. [ENUM-REF-CANDIDATE: food_insecurity|housing_instability|transportation|financial_strain|education|employment|social_isolation|interpersonal_safety|utility_needs — promote to reference product]',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT concept identifier corresponding to the social determinant finding, supporting clinical terminology cross-walking.',
    `terminology_version` STRING COMMENT 'The version or fiscal-year release of the ICD-10-CM code set in which this Z-code mapping is valid (e.g., FY2025).',
    `z_code` STRING COMMENT 'The ICD-10-CM diagnosis Z-code (Z55-Z65 range) representing a social, economic, or environmental determinant of health condition.',
    `z_code_description` STRING COMMENT 'Official ICD-10-CM long description of the Z-code (e.g., Homelessness, unspecified).',
    `z_code_short_description` STRING COMMENT 'Abbreviated ICD-10-CM short description of the Z-code used in claims and clinical displays.',
    CONSTRAINT pk_sdoh_zcode_mapping PRIMARY KEY(`sdoh_zcode_mapping_id`)
) COMMENT 'Master reference table for sdoh_zcode_mapping. Referenced by sdoh_zcode_mapping_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` (
    `chw_intervention_id` BIGINT COMMENT 'Primary key for chw_intervention',
    `employee_id` BIGINT COMMENT 'Identifier of the Community Health Worker (CHW) or community health staff member who performed the intervention.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: chw_intervention has a generic patient_id column with no FK target. A community health worker intervention is delivered to exactly one patient; a patient can receive many interventions — N:1. Linking ',
    `follow_up_chw_intervention_id` BIGINT COMMENT 'Self-referencing FK on chw_intervention (follow_up_chw_intervention_id)',
    `barriers_identified` STRING COMMENT 'Description of barriers to care or health-related social needs identified during the intervention. Protected Health Information (PHI).',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the CHW intervention is billable to a payer or health plan under value-based care or Medicaid CHW reimbursement programs.',
    `consent_record_date` DATE COMMENT 'Date on which patient consent for the intervention and data sharing was documented.',
    `delivery_modality` STRING COMMENT 'Channel or mode through which the CHW intervention was delivered to the patient.',
    `duration_minutes` STRING COMMENT 'Total time in minutes the CHW spent delivering the intervention, used for productivity, billing, and resource utilization analysis.',
    `follow_up_date` DATE COMMENT 'Scheduled date for the next CHW follow-up contact when follow-up is required.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up intervention or contact is required after this encounter.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was used during the intervention.',
    `intervention_category` STRING COMMENT 'High-level domain of the intervention used for population health analytics and program reporting.',
    `intervention_notes` STRING COMMENT 'Free-text notes documenting the CHW interaction, observations, and patient circumstances. Protected Health Information (PHI).',
    `intervention_number` STRING COMMENT 'Externally-known human-readable reference number for the CHW intervention, used by care management staff and reporting systems to locate the encounter.',
    `intervention_status` STRING COMMENT 'Current state of the CHW intervention within its delivery workflow.',
    `intervention_timestamp` TIMESTAMP COMMENT 'The principal real-world timestamp when the CHW intervention actually took place. Distinct from audit timestamps; used for utilization and outcome analytics.',
    `intervention_type` STRING COMMENT 'Categorical classification of the CHW intervention activity. [ENUM-REF-CANDIDATE: home_visit|telephonic_outreach|health_education|care_coordination|resource_navigation|medication_reconciliation|appointment_accompaniment|sdoh_screening — promote to reference product]',
    `location_setting` STRING COMMENT 'Physical or virtual setting where the intervention occurred, relevant for SDOH context and safety protocols.',
    `outcome_status` STRING COMMENT 'Resulting outcome of the intervention against the patients care goal, used for program effectiveness and quality reporting.',
    `patient_consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether documented patient consent was obtained for the CHW intervention and information sharing, per HIPAA requirements.',
    `presenting_concern` STRING COMMENT 'Patient-reported health or social concern that prompted or was addressed during the intervention. Protected Health Information (PHI).',
    `primary_language` STRING COMMENT 'Patients preferred language during the intervention, supporting culturally and linguistically appropriate services (CLAS) and interpreter needs.',
    `procedure_code` STRING COMMENT 'CPT or HCPCS service code associated with the billable CHW intervention (e.g., HCPCS codes for community health services).',
    `program_name` STRING COMMENT 'Name of the population health, care management, or community outreach program under which the intervention was performed (e.g., chronic disease management, maternal health).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this intervention record was first captured in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this intervention record was last modified.',
    `referral_made_flag` BOOLEAN COMMENT 'Indicates whether a referral to another service, provider, or community organization was generated during this intervention.',
    `referral_source` STRING COMMENT 'Source that referred the patient for the CHW intervention. [ENUM-REF-CANDIDATE: primary_care|emergency_department|inpatient_discharge|health_plan|self_referral|community_partner|school|other — promote to reference product]',
    `resources_provided` STRING COMMENT 'Community resources, services, or referrals provided to the patient during the intervention (e.g., food bank, transportation voucher).',
    `risk_level` STRING COMMENT 'Risk stratification level of the patient at the time of the intervention, used for prioritization and care management.',
    `scheduled_date` DATE COMMENT 'Date on which the CHW intervention was planned to occur, supporting outreach scheduling and capacity planning.',
    `sdoh_domain` STRING COMMENT 'Primary Social Determinants of Health (SDOH) domain addressed in the intervention. [ENUM-REF-CANDIDATE: housing|food_security|transportation|financial_strain|employment|education|social_isolation|safety — promote to reference product]',
    `service_address` STRING COMMENT 'Address where an in-person CHW intervention (e.g., home visit) was delivered. Contains patient location PHI under HIPAA.',
    CONSTRAINT pk_chw_intervention PRIMARY KEY(`chw_intervention_id`)
) COMMENT 'Master reference table for chw_intervention. Referenced by chw_intervention_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ADD CONSTRAINT `fk_patient_mpi_record_surviving_mpi_record_id` FOREIGN KEY (`surviving_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ADD CONSTRAINT `fk_patient_demographics_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ADD CONSTRAINT `fk_patient_address_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ADD CONSTRAINT `fk_patient_address_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ADD CONSTRAINT `fk_patient_address_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_insurance_mpi_record_id` FOREIGN KEY (`insurance_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ADD CONSTRAINT `fk_patient_guarantor_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ADD CONSTRAINT `fk_patient_guarantor_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ADD CONSTRAINT `fk_patient_emergency_contact_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ADD CONSTRAINT `fk_patient_emergency_contact_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_community_resource_directory_community_resource_id` FOREIGN KEY (`community_resource_directory_community_resource_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_risk_stratification_id` FOREIGN KEY (`risk_stratification_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification`(`sdoh_risk_stratification_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_sdoh_risk_stratification_id` FOREIGN KEY (`sdoh_risk_stratification_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification`(`sdoh_risk_stratification_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_sdoh_zcode_mapping_id` FOREIGN KEY (`sdoh_zcode_mapping_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping`(`sdoh_zcode_mapping_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_attribution_panel_id` FOREIGN KEY (`attribution_panel_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`attribution_panel`(`attribution_panel_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_prior_merge_event_identity_merge_history_id` FOREIGN KEY (`prior_merge_event_identity_merge_history_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`identity_merge_history`(`identity_merge_history_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_population_segment_id` FOREIGN KEY (`population_segment_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`population_segment`(`population_segment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ADD CONSTRAINT `fk_patient_portal_account_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ADD CONSTRAINT `fk_patient_portal_account_patient_rpm_program_enrollment_id` FOREIGN KEY (`patient_rpm_program_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment`(`patient_rpm_program_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ADD CONSTRAINT `fk_patient_portal_account_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ADD CONSTRAINT `fk_patient_proxy_access_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ADD CONSTRAINT `fk_patient_proxy_access_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ADD CONSTRAINT `fk_patient_proxy_access_proxy_patient_demographics_id` FOREIGN KEY (`proxy_patient_demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ADD CONSTRAINT `fk_patient_proxy_access_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_primary_mrn_mpi_record_id` FOREIGN KEY (`primary_mrn_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_communication_campaign_id` FOREIGN KEY (`communication_campaign_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`communication_campaign`(`communication_campaign_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_follow_up_communication_log_id` FOREIGN KEY (`follow_up_communication_log_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`communication_log`(`communication_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_message_template_id` FOREIGN KEY (`message_template_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`message_template`(`message_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_superseded_consent_reference_id` FOREIGN KEY (`superseded_consent_reference_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_parent_care_program_id` FOREIGN KEY (`parent_care_program_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_message_template_id` FOREIGN KEY (`message_template_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`message_template`(`message_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_parent_communication_campaign_id` FOREIGN KEY (`parent_communication_campaign_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`communication_campaign`(`communication_campaign_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_parent_attribution_panel_id` FOREIGN KEY (`parent_attribution_panel_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`attribution_panel`(`attribution_panel_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_parent_message_template_id` FOREIGN KEY (`parent_message_template_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`message_template`(`message_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_chw_intervention_id` FOREIGN KEY (`chw_intervention_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`chw_intervention`(`chw_intervention_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` ADD CONSTRAINT `fk_patient_patient_rpm_device_reading_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` ADD CONSTRAINT `fk_patient_patient_rpm_device_reading_patient_rpm_program_enrollment_id` FOREIGN KEY (`patient_rpm_program_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment`(`patient_rpm_program_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` ADD CONSTRAINT `fk_patient_patient_rpm_device_reading_patient_rpm_alert_threshold_id` FOREIGN KEY (`patient_rpm_alert_threshold_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold`(`patient_rpm_alert_threshold_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold` ADD CONSTRAINT `fk_patient_patient_rpm_alert_threshold_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold` ADD CONSTRAINT `fk_patient_patient_rpm_alert_threshold_patient_rpm_program_enrollment_id` FOREIGN KEY (`patient_rpm_program_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment`(`patient_rpm_program_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` ADD CONSTRAINT `fk_patient_patient_rpm_program_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_portal_engagement_event` ADD CONSTRAINT `fk_patient_patient_portal_engagement_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_portal_engagement_event` ADD CONSTRAINT `fk_patient_patient_portal_engagement_event_portal_account_id` FOREIGN KEY (`portal_account_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`portal_account`(`portal_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` ADD CONSTRAINT `fk_patient_patient_prom_response_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ADD CONSTRAINT `fk_patient_sdoh_risk_stratification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ADD CONSTRAINT `fk_patient_sdoh_risk_stratification_previous_sdoh_risk_stratification_id` FOREIGN KEY (`previous_sdoh_risk_stratification_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification`(`sdoh_risk_stratification_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ADD CONSTRAINT `fk_patient_sdoh_zcode_mapping_superseded_sdoh_zcode_mapping_id` FOREIGN KEY (`superseded_sdoh_zcode_mapping_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping`(`sdoh_zcode_mapping_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ADD CONSTRAINT `fk_patient_chw_intervention_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ADD CONSTRAINT `fk_patient_chw_intervention_follow_up_chw_intervention_id` FOREIGN KEY (`follow_up_chw_intervention_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`chw_intervention`(`chw_intervention_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`patient` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`patient` SET TAGS ('pii_domain' = 'patient');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('pii_identity_resolution' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('pii_ssot' = 'patient_identity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('pii_role' = 'ssot_patient_identity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `surviving_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Surviving MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `care_gap_id` SET TAGS ('pii_business_glossary_term' = 'AI/ML Inference Linkage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `care_gap_id` SET TAGS ('pii_domain' = 'clinical_ai');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `care_gap_id` SET TAGS ('pii_layer' = 'ai_ml_inference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('pii_business_glossary_term' = 'Date of Death');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `deceased_flag` SET TAGS ('pii_business_glossary_term' = 'Deceased Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('pii_business_glossary_term' = 'Enterprise Patient Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_business_glossary_term' = 'Ethnicity Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `first_registration_date` SET TAGS ('pii_business_glossary_term' = 'First Registration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `first_registration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('pii_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('pii_business_glossary_term' = 'HIE Patient Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_confidence_tier` SET TAGS ('pii_business_glossary_term' = 'Identity Confidence Tier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_resolution_status` SET TAGS ('pii_business_glossary_term' = 'Identity Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `is_duplicate_flag` SET TAGS ('pii_business_glossary_term' = 'Is Duplicate');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `is_overlay_flag` SET TAGS ('pii_business_glossary_term' = 'Is Overlay');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('pii_business_glossary_term' = 'Legal First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('pii_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `match_confidence_score` SET TAGS ('pii_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicaid_number` SET TAGS ('pii_business_glossary_term' = 'Medicaid Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicaid_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_business_glossary_term' = 'Medicare Beneficiary Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `merge_algorithm` SET TAGS ('pii_business_glossary_term' = 'Merge Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `merge_reason` SET TAGS ('pii_business_glossary_term' = 'Merge Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `merge_timestamp` SET TAGS ('pii_business_glossary_term' = 'Merge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_status` SET TAGS ('pii_business_glossary_term' = 'MPI Record Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('pii_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('pii_business_glossary_term' = 'National Health ID Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('pii_business_glossary_term' = 'National Health Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('pii_business_glossary_term' = 'NPI Crosswalk Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_class` SET TAGS ('pii_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_class` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_class` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_business_glossary_term' = 'AI/ML Inference Linkage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_domain' = 'clinical_ai');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_layer' = 'ai_ml_inference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('pii_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `primary_language_code` SET TAGS ('pii_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('pii_business_glossary_term' = 'Race Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `restricted_access_flag` SET TAGS ('pii_business_glossary_term' = 'Restricted Access');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_business_glossary_term' = 'Sex at Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('pii_business_glossary_term' = 'SSN Last 4');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `unmerge_reason` SET TAGS ('pii_business_glossary_term' = 'Unmerge Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `unmerge_timestamp` SET TAGS ('pii_business_glossary_term' = 'Unmerge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `vip_flag` SET TAGS ('pii_business_glossary_term' = 'VIP Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `advance_directive_on_file` SET TAGS ('pii_business_glossary_term' = 'Advance Directive On File');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('pii_business_glossary_term' = 'Birth Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_time` SET TAGS ('pii_business_glossary_term' = 'Birth Time');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_time` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_time` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_time` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `census_tract` SET TAGS ('pii_business_glossary_term' = 'Census Tract');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('pii_business_glossary_term' = 'Death Cause Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Death Certificate Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('pii_business_glossary_term' = 'Death Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `deceased_indicator` SET TAGS ('pii_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_business_glossary_term' = 'Enterprise MRN');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_business_glossary_term' = 'Ethnicity Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('pii_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('pii_business_glossary_term' = 'Home Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('pii_business_glossary_term' = 'Home Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('pii_business_glossary_term' = 'Home City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_country_code` SET TAGS ('pii_business_glossary_term' = 'Home Country Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('pii_business_glossary_term' = 'Home Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('pii_business_glossary_term' = 'Home State');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `interpreter_required` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('pii_business_glossary_term' = 'Legal First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('pii_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Same As Home');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('pii_business_glossary_term' = 'Mailing City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('pii_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('pii_business_glossary_term' = 'Mailing State');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('pii_business_glossary_term' = 'Marital Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'MRN');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('pii_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `patient_portal_enrolled` SET TAGS ('pii_business_glossary_term' = 'Patient Portal Enrolled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `patient_portal_enrolled` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `patient_portal_enrolled` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_language_code` SET TAGS ('pii_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('pii_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Phone');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('pii_business_glossary_term' = 'Primary Phone Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `pronouns` SET TAGS ('pii_business_glossary_term' = 'Pronouns');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `pronouns` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('pii_business_glossary_term' = 'Race Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_description` SET TAGS ('pii_business_glossary_term' = 'Race Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_description` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `registration_status` SET TAGS ('pii_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `religion_code` SET TAGS ('pii_business_glossary_term' = 'Religion Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `religion_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('pii_business_glossary_term' = 'SDOH Food Insecurity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_housing_status` SET TAGS ('pii_business_glossary_term' = 'SDOH Housing Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `secondary_phone` SET TAGS ('pii_business_glossary_term' = 'Secondary Phone');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `secondary_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `secondary_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `secondary_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_business_glossary_term' = 'Sex at Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('pii_business_glossary_term' = 'SSN Last 4');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `vip_indicator` SET TAGS ('pii_business_glossary_term' = 'VIP Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` SET TAGS ('pii_'mvm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` SET TAGS ('pii_'tier' = 'ecm]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('pii_business_glossary_term' = 'Address ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_business_glossary_term' = 'Geographic Region Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Master Patient Index Record');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_referral_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('pii_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('pii_value_regex' = 'active|inactive|undeliverable|returned_mail');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('pii_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('pii_value_regex' = 'home|mailing|temporary|work|billing|guarantor');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `area_deprivation_index` SET TAGS ('pii_business_glossary_term' = 'Area Deprivation Index (ADI)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `area_deprivation_index` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('pii_business_glossary_term' = 'Census Tract');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('pii_business_glossary_term' = 'County');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('pii_business_glossary_term' = 'County Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('pii_value_regex' = '^d{5}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `district` SET TAGS ('pii_business_glossary_term' = 'District');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `district` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `do_not_contact_reason` SET TAGS ('pii_business_glossary_term' = 'Do Not Contact Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `do_not_contact_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `do_not_contact_reason` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Address Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Address Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('pii_business_glossary_term' = 'Geocode Precision Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('pii_value_regex' = 'rooftop|range_interpolated|geometric_center|approximate|ungeocoded');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('pii_business_glossary_term' = 'Health Service Area (HSA)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `housing_type` SET TAGS ('pii_business_glossary_term' = 'Housing Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `housing_type` SET TAGS ('pii_value_regex' = 'owned|rented|shelter|transitional|group_home|unhoused');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `housing_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Confidential Address Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `is_do_not_mail` SET TAGS ('pii_business_glossary_term' = 'Do Not Mail Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Primary Address Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `move_in_date` SET TAGS ('pii_business_glossary_term' = 'Move-In Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `move_out_date` SET TAGS ('pii_business_glossary_term' = 'Move-Out Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `ncoa_match_code` SET TAGS ('pii_business_glossary_term' = 'National Change of Address (NCOA) Match Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `ncoa_update_date` SET TAGS ('pii_business_glossary_term' = 'National Change of Address (NCOA) Update Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code (ZIP Code)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('pii_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('pii_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Housing Instability Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('pii_sensitivity' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_risk_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_risk_score` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('pii_business_glossary_term' = 'Source System Address ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `urban_rural_classification` SET TAGS ('pii_business_glossary_term' = 'Urban Rural Classification');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `urban_rural_classification` SET TAGS ('pii_value_regex' = 'urban|suburban|rural|frontier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `validation_date` SET TAGS ('pii_business_glossary_term' = 'Address Validation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `validation_source` SET TAGS ('pii_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `validation_status` SET TAGS ('pii_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `validation_status` SET TAGS ('pii_value_regex' = 'validated|unvalidated|invalid|corrected|pending');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` SET TAGS ('pii_subdomain' = 'coverage_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_mpi_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `benefit_year_end` SET TAGS ('pii_business_glossary_term' = 'Benefit Year End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `benefit_year_start` SET TAGS ('pii_business_glossary_term' = 'Benefit Year Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `cob_priority` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Priority');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Rate');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `copay_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_met_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_met_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_response_code` SET TAGS ('pii_business_glossary_term' = 'Eligibility Response Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Eligibility Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verification_method` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verification_method` SET TAGS ('pii_value_regex' = 'EDI_270_271|portal|phone|manual|real_time_API');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verification_status` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending|failed|not_eligible');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verified_by` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verified By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `group_number` SET TAGS ('pii_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `group_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_back_url` SET TAGS ('pii_business_glossary_term' = 'Insurance Card Back Image URL');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_back_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_back_url` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_back_url` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_front_url` SET TAGS ('pii_business_glossary_term' = 'Insurance Card Front Image URL');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_front_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_front_url` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_front_url` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('pii_business_glossary_term' = 'Medicaid State Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicare_part` SET TAGS ('pii_business_glossary_term' = 'Medicare Part');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicare_part` SET TAGS ('pii_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `network_status` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|unknown');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_max` SET TAGS ('pii_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_max` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('pii_business_glossary_term' = 'Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `payer_electronic_number` SET TAGS ('pii_business_glossary_term' = 'Payer Electronic ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `plan_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `plan_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `prior_auth_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `referral_required` SET TAGS ('pii_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_bin` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Identification (RxBIN) Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_bin` SET TAGS ('pii_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_bin` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_group` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Group Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_group` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_pcn` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Processor Control Number (PCN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_pcn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_value_regex' = 'self|spouse|child|dependent|other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_balance` SET TAGS ('pii_business_glossary_term' = 'Guarantor Account Balance');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_balance` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_balance` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Guarantor Account Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Guarantor Account Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_status` SET TAGS ('pii_value_regex' = 'active|inactive|collections|bad_debt|deceased|bankruptcy');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Guarantor Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Guarantor Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('pii_business_glossary_term' = 'Guarantor Annual Income');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bad_debt_flag` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('pii_business_glossary_term' = 'Guarantor Bankruptcy Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Guarantor City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `collection_agency_flag` SET TAGS ('pii_business_glossary_term' = 'Collection Agency Referral Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Guarantor Country Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Guarantor Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `deceased_flag` SET TAGS ('pii_business_glossary_term' = 'Guarantor Deceased Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `deceased_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `do_not_contact_flag` SET TAGS ('pii_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `do_not_contact_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `do_not_contact_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Guarantor Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('pii_business_glossary_term' = 'Guarantor Employer Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('pii_business_glossary_term' = 'Guarantor Employer Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('pii_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employment_status` SET TAGS ('pii_business_glossary_term' = 'Guarantor Employment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('pii_business_glossary_term' = 'Electronic Statement (E-Statement) Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `federal_poverty_level_pct` SET TAGS ('pii_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `federal_poverty_level_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `federal_poverty_level_pct` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_status` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_status` SET TAGS ('pii_value_regex' = 'not_applied|pending|approved|denied|partial');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_type` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_type` SET TAGS ('pii_value_regex' = 'charity_care|sliding_scale|payment_plan|hardship|medicaid_pending');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'Guarantor First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('pii_business_glossary_term' = 'Guarantor Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('pii_value_regex' = 'self|parent|spouse|legal_guardian|estate|organization');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('pii_business_glossary_term' = 'Guarantor Home Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('pii_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `household_size` SET TAGS ('pii_business_glossary_term' = 'Guarantor Household Size');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Guarantor Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_statement_date` SET TAGS ('pii_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Guarantor Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('pii_business_glossary_term' = 'Guarantor Mobile Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('pii_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('pii_business_glossary_term' = 'Guarantor Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `payment_plan_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Monthly Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `payment_plan_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `payment_plan_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `payment_plan_flag` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Guarantor Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_value_regex' = 'home_phone|work_phone|mobile_phone|email|mail');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `relationship_to_patient` SET TAGS ('pii_business_glossary_term' = 'Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `relationship_to_patient` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `relationship_to_patient` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `responsibility_pct` SET TAGS ('pii_business_glossary_term' = 'Account Responsibility Percentage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `responsibility_pct` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `since_date` SET TAGS ('pii_business_glossary_term' = 'Guarantor Since Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `sms_consent_flag` SET TAGS ('pii_business_glossary_term' = 'SMS Text Message Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `sms_consent_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `sms_consent_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('pii_business_glossary_term' = 'Social Security Number (SSN) Masked');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('pii_value_regex' = '^XXX-XX-[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'Guarantor State');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('pii_business_glossary_term' = 'Guarantor Work Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('pii_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `emergency_contact_id` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `emergency_contact_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `emergency_contact_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `emergency_contact_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Contact Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Contact Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Contact City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Patient Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_obtained_by` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_obtained_by` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_obtained_by` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_status` SET TAGS ('pii_business_glossary_term' = 'Contact Record Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_status` SET TAGS ('pii_value_regex' = 'active|inactive|deceased|unverified');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_type` SET TAGS ('pii_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_type` SET TAGS ('pii_value_regex' = 'emergency_contact|healthcare_proxy|legal_guardian|authorized_representative|next_of_kin|guarantor');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Contact Country Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Contact Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Contact Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('pii_business_glossary_term' = 'Healthcare Proxy Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Home Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('pii_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `interpreter_required` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `legal_guardian_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Guardian Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `legal_guardian_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `legal_guardian_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `lives_with_patient` SET TAGS ('pii_business_glossary_term' = 'Lives With Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `lives_with_patient` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `lives_with_patient` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `notification_consent_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `notification_consent_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `notification_consent_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `phi_disclosure_authorized` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Disclosure Authorization');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Contact Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_value_regex' = 'mobile|home_phone|work_phone|email|text_sms');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_language` SET TAGS ('pii_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('pii_business_glossary_term' = 'Contact Preferred Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `priority_order` SET TAGS ('pii_business_glossary_term' = 'Contact Priority Order');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_effective_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Authorization Document Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_effective_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_effective_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Authorization Document Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_expiration_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_expiration_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_type` SET TAGS ('pii_business_glossary_term' = 'Proxy Authorization Document Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_type` SET TAGS ('pii_value_regex' = 'durable_power_of_attorney|healthcare_proxy_form|court_order|advance_directive|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `relationship_type` SET TAGS ('pii_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `source_system_contact_code` SET TAGS ('pii_business_glossary_term' = 'Source System Contact ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `source_system_contact_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `source_system_contact_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'Contact State Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Contact Information Verified By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `verified_date` SET TAGS ('pii_business_glossary_term' = 'Contact Information Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Work Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('pii_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('pii_business_glossary_term' = 'Contact Work Phone Extension');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('pii_value_regex' = '^d{1,6}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` SET TAGS ('pii_subdomain' = 'social_determinants');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Assessment Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Assessment Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `community_resource_directory_community_resource_id` SET TAGS ('pii_business_glossary_term' = 'Community Resource Directory Reference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `community_resource_id` SET TAGS ('pii_business_glossary_term' = 'Community Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_business_glossary_term' = 'HL7 FHIR Observation Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `sdoh_zcode_mapping_id` SET TAGS ('pii_business_glossary_term' = 'SDOH Z-Code Mapping Reference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `administration_method` SET TAGS ('pii_business_glossary_term' = 'SDOH Assessment Administration Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `administration_method` SET TAGS ('pii_value_regex' = 'clinician_administered|self_administered|telephone|electronic_portal|proxy');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `administration_method` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'SDOH Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_number` SET TAGS ('pii_business_glossary_term' = 'SDOH Assessment Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_setting` SET TAGS ('pii_business_glossary_term' = 'SDOH Assessment Setting');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'SDOH Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'completed|in_progress|refused|not_applicable|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('pii_business_glossary_term' = 'SDOH Assessment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `care_program_enrolled_flag` SET TAGS ('pii_business_glossary_term' = 'Care Management Program Enrolled Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Patient Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `consent_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `consent_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `financial_strain_flag` SET TAGS ('pii_business_glossary_term' = 'Financial Strain Positive Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `financial_strain_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `financial_strain_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `financial_strain_score` SET TAGS ('pii_business_glossary_term' = 'Financial Strain Domain Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `financial_strain_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `financial_strain_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `food_insecurity_flag` SET TAGS ('pii_business_glossary_term' = 'Food Insecurity Positive Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `food_insecurity_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `food_insecurity_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `food_insecurity_score` SET TAGS ('pii_business_glossary_term' = 'Food Insecurity Domain Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `food_insecurity_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `food_insecurity_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `housing_instability_flag` SET TAGS ('pii_business_glossary_term' = 'Housing Instability Positive Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `housing_instability_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `housing_instability_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `housing_instability_score` SET TAGS ('pii_business_glossary_term' = 'Housing Instability Domain Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `housing_instability_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `housing_instability_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `icd10_z_code` SET TAGS ('pii_business_glossary_term' = 'ICD-10 Z-Code for Social Determinants');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `icd10_z_code` SET TAGS ('pii_value_regex' = '^Z[0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `icd10_z_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `identified_needs_summary` SET TAGS ('pii_business_glossary_term' = 'Identified SDOH Needs Summary');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `identified_needs_summary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `identified_needs_summary` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('pii_business_glossary_term' = 'Interpersonal Safety Positive Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `interpersonal_safety_score` SET TAGS ('pii_business_glossary_term' = 'Interpersonal Safety Domain Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `interpersonal_safety_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `interpersonal_safety_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `interpreter_used_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `language_of_administration` SET TAGS ('pii_business_glossary_term' = 'Language of Administration');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `language_of_administration` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `loinc_panel_code` SET TAGS ('pii_business_glossary_term' = 'Logical Observation Identifiers Names and Codes (LOINC) Panel Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `loinc_panel_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `overall_risk_level` SET TAGS ('pii_business_glossary_term' = 'Overall SDOH Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `overall_risk_level` SET TAGS ('pii_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `overall_risk_level` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `overall_risk_level` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `reassessment_due_date` SET TAGS ('pii_business_glossary_term' = 'SDOH Reassessment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `reassessment_interval_days` SET TAGS ('pii_business_glossary_term' = 'SDOH Reassessment Interval Days');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_closed_date` SET TAGS ('pii_business_glossary_term' = 'SDOH Referral Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_date` SET TAGS ('pii_business_glossary_term' = 'SDOH Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_disposition` SET TAGS ('pii_business_glossary_term' = 'SDOH Referral Disposition');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_disposition` SET TAGS ('pii_value_regex' = 'referred|declined_referral|no_needs_identified|pending|self_managed');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_organization` SET TAGS ('pii_business_glossary_term' = 'SDOH Referral Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_outcome` SET TAGS ('pii_business_glossary_term' = 'SDOH Referral Outcome');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_outcome` SET TAGS ('pii_value_regex' = 'connected|not_connected|in_progress|declined|unable_to_reach');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `screening_tool_code` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Tool Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Tool Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `screening_tool_version` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Tool Version');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `sdoh_priority_level` SET TAGS ('pii_business_glossary_term' = 'SDOH Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `sdoh_risk_score` SET TAGS ('pii_business_glossary_term' = 'SDOH Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `snomed_finding_code` SET TAGS ('pii_business_glossary_term' = 'SNOMED CT Social Determinant Finding Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `snomed_finding_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `social_isolation_flag` SET TAGS ('pii_business_glossary_term' = 'Social Isolation Positive Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `social_isolation_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `social_isolation_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `social_isolation_score` SET TAGS ('pii_business_glossary_term' = 'Social Isolation Domain Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `social_isolation_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `social_isolation_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `total_positive_domains` SET TAGS ('pii_business_glossary_term' = 'Total Positive SDOH Domains Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `total_positive_domains` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `total_positive_domains` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `transportation_flag` SET TAGS ('pii_business_glossary_term' = 'Transportation Barrier Positive Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `transportation_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `transportation_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `transportation_score` SET TAGS ('pii_business_glossary_term' = 'Transportation Barrier Domain Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `transportation_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `transportation_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preference_id` SET TAGS ('pii_business_glossary_term' = 'Preference Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Primary Care Physician (PCP) ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `pharmacy_location_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Pharmacy ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `advance_directive_on_file` SET TAGS ('pii_business_glossary_term' = 'Advance Directive on File');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `advance_directive_on_file` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `advance_directive_on_file` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `appointment_reminder_opt_in` SET TAGS ('pii_business_glossary_term' = 'Appointment Reminder Opt-In');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `care_management_opt_in` SET TAGS ('pii_business_glossary_term' = 'Care Management Program Opt-In');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `care_management_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `care_management_opt_in` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_business_glossary_term' = 'Preferred Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|telehealth|home_health|urgent_care|ed');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `communication_channel` SET TAGS ('pii_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `communication_channel` SET TAGS ('pii_value_regex' = 'phone|patient_portal|mail|text_sms|email|secure_message');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `communication_channel` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `communication_channel` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `communication_time_preference` SET TAGS ('pii_business_glossary_term' = 'Preferred Communication Time of Day');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `communication_time_preference` SET TAGS ('pii_value_regex' = 'morning|afternoon|evening|no_preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `cultural_care_preference` SET TAGS ('pii_business_glossary_term' = 'Cultural Care Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `cultural_care_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `cultural_care_preference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `dietary_preference` SET TAGS ('pii_business_glossary_term' = 'Dietary Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `dietary_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `dietary_preference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `do_not_contact` SET TAGS ('pii_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `do_not_contact` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `do_not_contact` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `do_not_contact` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `do_not_contact` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `education_material_format` SET TAGS ('pii_business_glossary_term' = 'Preferred Patient Education Material Format');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `education_material_format` SET TAGS ('pii_value_regex' = 'printed|digital|audio|video|pictorial|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `education_material_format` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `education_material_format` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Preference Effective From Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Preference Effective Until Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `gender_concordant_provider` SET TAGS ('pii_business_glossary_term' = 'Gender-Concordant Provider Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `gender_concordant_provider` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `gender_concordant_provider` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `gender_concordant_provider` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `gender_concordant_provider` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `health_literacy_level` SET TAGS ('pii_business_glossary_term' = 'Health Literacy Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `health_literacy_level` SET TAGS ('pii_value_regex' = 'basic|below_average|average|above_average|unknown');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `health_literacy_level` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `health_literacy_level` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `health_literacy_level` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `health_literacy_level` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `hearing_accommodation` SET TAGS ('pii_business_glossary_term' = 'Hearing Accessibility Accommodation');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `hearing_accommodation` SET TAGS ('pii_value_regex' = 'none|hearing_aid|cochlear_implant|asl_interpreter|captioning|amplified_phone');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `hearing_accommodation` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `hearing_accommodation` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `interpreter_needed` SET TAGS ('pii_business_glossary_term' = 'Interpreter Services Needed');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `interpreter_needed` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `interpreter_needed` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `interpreter_type` SET TAGS ('pii_business_glossary_term' = 'Interpreter Service Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `interpreter_type` SET TAGS ('pii_value_regex' = 'in_person|telephonic|video_remote|sign_language|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `interpreter_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `interpreter_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `last_verified_by` SET TAGS ('pii_business_glossary_term' = 'Preference Last Verified By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Preference Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('pii_business_glossary_term' = 'Marketing Communications Opt-In');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mobility_accommodation` SET TAGS ('pii_business_glossary_term' = 'Mobility Accessibility Accommodation');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mobility_accommodation` SET TAGS ('pii_value_regex' = 'none|wheelchair|bariatric|stretcher|walker|accessible_parking');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mobility_accommodation` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mobility_accommodation` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_email` SET TAGS ('pii_business_glossary_term' = 'Notification Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_phone` SET TAGS ('pii_business_glossary_term' = 'Notification Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_phone` SET TAGS ('pii_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `notification_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `organ_donation_status` SET TAGS ('pii_business_glossary_term' = 'Organ Donation Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `organ_donation_status` SET TAGS ('pii_value_regex' = 'donor|non_donor|unknown|pending');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `organ_donation_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `organ_donation_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `portal_enrolled` SET TAGS ('pii_business_glossary_term' = 'Patient Portal Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `portal_enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Patient Portal Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preference_status` SET TAGS ('pii_business_glossary_term' = 'Preference Record Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preference_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending_review|superseded');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_name` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Person Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_relationship` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Relationship');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_relationship` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_relationship` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_language` SET TAGS ('pii_business_glossary_term' = 'Preferred Language for Care');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_language` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `preferred_language` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `prom_opt_in_flag` SET TAGS ('pii_business_glossary_term' = 'Prom Opt In Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `religious_preference` SET TAGS ('pii_business_glossary_term' = 'Religious or Spiritual Care Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `religious_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `religious_preference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `research_participation_consent` SET TAGS ('pii_business_glossary_term' = 'Research Participation Consent');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `research_participation_consent` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `research_participation_consent` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `research_participation_consent` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `research_participation_consent` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `rpm_opt_in_flag` SET TAGS ('pii_business_glossary_term' = 'Rpm Opt In Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `sdoh_screening_consent` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Screening Consent');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `sdoh_screening_consent` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `sdoh_screening_consent` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `sdoh_screening_consent` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `sdoh_screening_consent` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Preference Capture Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `surrogate_decision_maker` SET TAGS ('pii_business_glossary_term' = 'Surrogate Decision Maker Designated');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `surrogate_decision_maker` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `surrogate_decision_maker` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `telehealth_consent` SET TAGS ('pii_business_glossary_term' = 'Telehealth Consent');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `telehealth_consent` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `telehealth_consent` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `telehealth_consent` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `telehealth_consent` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `vision_accommodation` SET TAGS ('pii_business_glossary_term' = 'Vision Accessibility Accommodation');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `vision_accommodation` SET TAGS ('pii_value_regex' = 'none|large_print|braille|screen_reader|magnification|low_vision_aid');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `vision_accommodation` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ALTER COLUMN `vision_accommodation` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `pcp_attribution_id` SET TAGS ('pii_business_glossary_term' = 'Primary Care Physician (PCP) Attribution ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `accountable_care_organization_id` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Attributed Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_panel_id` SET TAGS ('pii_business_glossary_term' = 'Attribution Panel ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `care_team_id` SET TAGS ('pii_business_glossary_term' = 'Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Attributed Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Payer Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `aco_contract_number` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `aco_contract_number` SET TAGS ('pii_value_regex' = '^ACO[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Attributed Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_confidence_score` SET TAGS ('pii_business_glossary_term' = 'Attribution Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_method` SET TAGS ('pii_business_glossary_term' = 'Attribution Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_method` SET TAGS ('pii_value_regex' = 'claims_based|enrollment_based|manual|algorithm_based|hybrid|empanelment');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_override_reason` SET TAGS ('pii_business_glossary_term' = 'Attribution Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_rank` SET TAGS ('pii_business_glossary_term' = 'Attribution Rank');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_review_date` SET TAGS ('pii_business_glossary_term' = 'Attribution Review Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_segment` SET TAGS ('pii_business_glossary_term' = 'Attribution Segment');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_segment` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|dual_eligible|uninsured');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_source` SET TAGS ('pii_business_glossary_term' = 'Attribution Source System');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_source` SET TAGS ('pii_value_regex' = 'epic_healthy_planet|cerner_millennium|payer_feed|manual_entry|hl7_fhir|population_health_platform');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_status` SET TAGS ('pii_business_glossary_term' = 'Attribution Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated|disputed|under_review');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `care_management_enrolled` SET TAGS ('pii_business_glossary_term' = 'Care Management Enrollment Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `consent_on_file` SET TAGS ('pii_business_glossary_term' = 'Patient Consent on File Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `consent_on_file` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `consent_on_file` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `data_sharing_opt_out` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Opt-Out Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `disenrollment_reason` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Attribution Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Attribution End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `geographic_region` SET TAGS ('pii_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `hcc_risk_score` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `hedis_eligible` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `is_primary_attribution` SET TAGS ('pii_business_glossary_term' = 'Is Primary Attribution Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `last_visit_date` SET TAGS ('pii_business_glossary_term' = 'Last PCP Visit Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `lookback_period_months` SET TAGS ('pii_business_glossary_term' = 'Attribution Lookback Period (Months)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Attribution Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mips_eligible` SET TAGS ('pii_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mrn` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `override_authorized_by` SET TAGS ('pii_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `override_date` SET TAGS ('pii_business_glossary_term' = 'Attribution Override Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `panel_assignment_date` SET TAGS ('pii_business_glossary_term' = 'Panel Assignment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `payer_attribution_number` SET TAGS ('pii_business_glossary_term' = 'Payer Attribution ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `payer_name` SET TAGS ('pii_business_glossary_term' = 'Payer Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `payer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `payer_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Health Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'ACO|HMO|PPO|POS|EPO|PCMH');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `risk_stratification_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Stratification Tier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `risk_stratification_tier` SET TAGS ('pii_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `sdoh_flag` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `sdoh_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `source_feed_date` SET TAGS ('pii_business_glossary_term' = 'Source Feed Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `visit_count_lookback` SET TAGS ('pii_business_glossary_term' = 'Visit Count Lookback');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` SET TAGS ('pii_subdomain' = 'coverage_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `eligibility_check_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility Check ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility Check Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coinsurance_percent` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coinsurance_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coinsurance_percent` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coinsurance_percent` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coinsurance_percent` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coordination_of_benefits_flag` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `copay_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `family_deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Family Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `family_deductible_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `group_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Group Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Individual Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_deductible_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_deductible_met_amount` SET TAGS ('pii_business_glossary_term' = 'Individual Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_deductible_met_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_out_of_pocket_max` SET TAGS ('pii_business_glossary_term' = 'Individual Out-of-Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_out_of_pocket_max` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_out_of_pocket_met` SET TAGS ('pii_business_glossary_term' = 'Individual Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_out_of_pocket_met` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `is_override` SET TAGS ('pii_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `network_status` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|unknown');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `override_reason` SET TAGS ('pii_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `prior_auth_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `prior_auth_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `referral_required` SET TAGS ('pii_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `rejection_reason_description` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `service_type_code` SET TAGS ('pii_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `transaction_control_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Control Number (TCN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_method` SET TAGS ('pii_value_regex' = 'edi_270_271|portal|phone|fax|real_time_api|batch');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|error|partial|not_found');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_type` SET TAGS ('pii_business_glossary_term' = 'Verification Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_type` SET TAGS ('pii_value_regex' = 'real_time|batch|manual|scheduled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verified_by_user` SET TAGS ('pii_business_glossary_term' = 'Verified By User');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_event_id` SET TAGS ('pii_business_glossary_term' = 'Registration Event ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Registering Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Registration Staff ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Primary Insurance Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `tertiary_registration_pcp_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Primary Care Physician (PCP) Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `admission_type` SET TAGS ('pii_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `admission_type` SET TAGS ('pii_value_regex' = 'elective|urgent|emergent|newborn|trauma');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `admit_reason` SET TAGS ('pii_business_glossary_term' = 'Admission Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `adt_message_type` SET TAGS ('pii_business_glossary_term' = 'Admit Discharge Transfer (ADT) Message Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `advance_directive_flag` SET TAGS ('pii_business_glossary_term' = 'Advance Directive on File Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `completeness_score` SET TAGS ('pii_business_glossary_term' = 'Registration Completeness Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `discharge_disposition` SET TAGS ('pii_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `drg_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `duplicate_flag` SET TAGS ('pii_business_glossary_term' = 'Duplicate Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `eligibility_verification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `eligibility_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Insurance Eligibility Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_business_glossary_term' = 'Enterprise Medical Record Number (Enterprise MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_status` SET TAGS ('pii_business_glossary_term' = 'Registration Event Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_status` SET TAGS ('pii_value_regex' = 'completed|pending|cancelled|failed|in_progress');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Registration Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Registration Event Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_type` SET TAGS ('pii_value_regex' = 'new_registration|pre_registration|update|merge|unmerge');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `expected_los_days` SET TAGS ('pii_business_glossary_term' = 'Expected Length of Stay (LOS) Days');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `financial_class` SET TAGS ('pii_business_glossary_term' = 'Financial Class');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `financial_class` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `hipaa_notice_delivered_flag` SET TAGS ('pii_business_glossary_term' = 'HIPAA Notice of Privacy Practices Delivered Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `identity_verification_method` SET TAGS ('pii_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `identity_verification_method` SET TAGS ('pii_value_regex' = 'photo_id|insurance_card|biometric|passport|none|self_reported');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Patient Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_match_score` SET TAGS ('pii_business_glossary_term' = 'Master Patient Index (MPI) Match Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_match_status` SET TAGS ('pii_business_glossary_term' = 'Master Patient Index (MPI) Match Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_match_status` SET TAGS ('pii_value_regex' = 'new_patient|auto_matched|manual_review|auto_merged|no_match');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `patient_class` SET TAGS ('pii_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `patient_class` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|emergency|observation|recurring|preadmit');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `patient_class` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `patient_class` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `point_of_care` SET TAGS ('pii_business_glossary_term' = 'Point of Care');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `pre_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Pre-Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('pii_business_glossary_term' = 'Prior Medical Record Number (Prior MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_date` SET TAGS ('pii_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_source` SET TAGS ('pii_business_glossary_term' = 'Registration Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_source` SET TAGS ('pii_value_regex' = 'ed_walk_in|scheduled|transfer|online_pre_registration|referral|direct_admit');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_source` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `restricted_record_flag` SET TAGS ('pii_business_glossary_term' = 'Restricted Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `restricted_record_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `source_system_event_code` SET TAGS ('pii_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `vip_flag` SET TAGS ('pii_business_glossary_term' = 'VIP Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `vip_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` SET TAGS ('pii_identity_resolution' = 'audit_trail');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` SET TAGS ('pii_hipaa' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` SET TAGS ('pii_patient_safety' = 'critical');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` SET TAGS ('pii_role' = 'identity_resolution');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `identity_merge_history_id` SET TAGS ('pii_business_glossary_term' = 'Identity Merge History ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Surviving MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Primary Identity Care Site');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Merge Performed By Employee');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `prior_merge_event_identity_merge_history_id` SET TAGS ('pii_business_glossary_term' = 'Prior Merge Event');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `approving_him_analyst_name` SET TAGS ('pii_business_glossary_term' = 'Approving HIM Analyst');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `approving_him_analyst_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `approving_him_analyst_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `breach_assessment_required` SET TAGS ('pii_business_glossary_term' = 'Breach Assessment Required');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `breach_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Breach Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `duplicate_detection_method` SET TAGS ('pii_business_glossary_term' = 'Duplicate Detection Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `hl7_message_control_number` SET TAGS ('pii_business_glossary_term' = 'HL7 Message Control Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `matching_fields_used` SET TAGS ('pii_business_glossary_term' = 'Matching Fields Used');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_algorithm` SET TAGS ('pii_business_glossary_term' = 'Merge Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_confidence_score` SET TAGS ('pii_business_glossary_term' = 'Merge Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_event_number` SET TAGS ('pii_business_glossary_term' = 'Merge Event Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_event_type` SET TAGS ('pii_business_glossary_term' = 'Merge Event Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_rationale` SET TAGS ('pii_business_glossary_term' = 'Merge Rationale');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_rationale` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_status` SET TAGS ('pii_business_glossary_term' = 'Merge Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_timestamp` SET TAGS ('pii_business_glossary_term' = 'Merge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_trigger_source` SET TAGS ('pii_business_glossary_term' = 'Merge Trigger Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `mpi_overlay_type` SET TAGS ('pii_business_glossary_term' = 'MPI Overlay Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_dob_at_merge` SET TAGS ('pii_business_glossary_term' = 'Non-Surviving DOB at Merge');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_dob_at_merge` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_dob_at_merge` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_dob_at_merge` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_enterprise_mrn` SET TAGS ('pii_business_glossary_term' = 'Non-Surviving Enterprise MRN');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_enterprise_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_enterprise_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_enterprise_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_mrn` SET TAGS ('pii_business_glossary_term' = 'Non-Surviving MRN');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_patient_name_at_merge` SET TAGS ('pii_business_glossary_term' = 'Non-Surviving Patient Name at Merge');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_patient_name_at_merge` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_patient_name_at_merge` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_patient_name_at_merge` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `phi_disclosure_risk_flag` SET TAGS ('pii_business_glossary_term' = 'PHI Disclosure Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `quality_review_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `quality_review_notes` SET TAGS ('pii_business_glossary_term' = 'Quality Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `records_affected_count` SET TAGS ('pii_business_glossary_term' = 'Records Affected Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `reversal_approved_by` SET TAGS ('pii_business_glossary_term' = 'Reversal Approved By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `reversal_approved_by` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `reversal_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `review_priority` SET TAGS ('pii_business_glossary_term' = 'Review Priority');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `source_system_merge_code` SET TAGS ('pii_business_glossary_term' = 'Source System Merge Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_dob_at_merge` SET TAGS ('pii_business_glossary_term' = 'Surviving DOB at Merge');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_dob_at_merge` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_dob_at_merge` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_dob_at_merge` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_enterprise_mrn` SET TAGS ('pii_business_glossary_term' = 'Surviving Enterprise MRN');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_enterprise_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_enterprise_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_enterprise_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_mrn` SET TAGS ('pii_business_glossary_term' = 'Surviving MRN');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_patient_name_at_merge` SET TAGS ('pii_business_glossary_term' = 'Surviving Patient Name at Merge');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_patient_name_at_merge` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_patient_name_at_merge` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_patient_name_at_merge` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_id` SET TAGS ('pii_business_glossary_term' = 'Patient Flag ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Flagged By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_sensitivity' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `tertiary_flag_reviewed_by_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Reviewed By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `acknowledgment_count` SET TAGS ('pii_business_glossary_term' = 'Flag Acknowledgment Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `ama_history_flag` SET TAGS ('pii_business_glossary_term' = 'Against Medical Advice (AMA) History Flag Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_code` SET TAGS ('pii_business_glossary_term' = 'Flag Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `code_system` SET TAGS ('pii_business_glossary_term' = 'Flag Code System');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `code_system` SET TAGS ('pii_value_regex' = 'SNOMED-CT|ICD-10|LOCAL|HL7|LOINC|CUSTOM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Flag Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'normal|restricted|very_restricted|sealed');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_description` SET TAGS ('pii_business_glossary_term' = 'Flag Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `display_in_chart` SET TAGS ('pii_business_glossary_term' = 'Display in Chart Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `display_in_registration` SET TAGS ('pii_business_glossary_term' = 'Display in Registration Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `display_in_scheduling` SET TAGS ('pii_business_glossary_term' = 'Display in Scheduling Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Flag Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `fall_risk_assessment_tool` SET TAGS ('pii_business_glossary_term' = 'Fall Risk Assessment Tool');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `fall_risk_assessment_tool` SET TAGS ('pii_value_regex' = 'morse|johns_hopkins|hendrich_ii|humpty_dumpty|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `fall_risk_assessment_tool` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `fall_risk_score` SET TAGS ('pii_business_glossary_term' = 'Fall Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_status` SET TAGS ('pii_business_glossary_term' = 'Flag Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_status` SET TAGS ('pii_value_regex' = 'active|inactive|resolved|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_type` SET TAGS ('pii_business_glossary_term' = 'Flag Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flag_type` SET TAGS ('pii_value_regex' = 'clinical|administrative|safety|behavioral|financial|legal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flagged_by_role` SET TAGS ('pii_business_glossary_term' = 'Flagged By Role');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `flagged_timestamp` SET TAGS ('pii_business_glossary_term' = 'Flag Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `infectious_precaution_type` SET TAGS ('pii_business_glossary_term' = 'Infectious Precaution Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `infectious_precaution_type` SET TAGS ('pii_value_regex' = 'contact|droplet|airborne|contact_droplet|enhanced_contact|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `interpreter_language` SET TAGS ('pii_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `interpreter_language` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `is_enterprise_wide` SET TAGS ('pii_business_glossary_term' = 'Enterprise-Wide Flag Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `last_acknowledged_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Acknowledged Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Flag Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `legal_hold_reference` SET TAGS ('pii_business_glossary_term' = 'Legal Hold Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `legal_hold_reference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `onset_date` SET TAGS ('pii_business_glossary_term' = 'Flag Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `phi_flag` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Flag Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `requires_acknowledgment` SET TAGS ('pii_business_glossary_term' = 'Requires Acknowledgment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `resolution_reason` SET TAGS ('pii_business_glossary_term' = 'Flag Resolution Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `resolved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Flag Resolved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Flag Severity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `severity` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `source_system_flag_code` SET TAGS ('pii_business_glossary_term' = 'Source System Flag ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ALTER COLUMN `subtype` SET TAGS ('pii_business_glossary_term' = 'Flag Subtype');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `population_segment_id` SET TAGS ('pii_business_glossary_term' = 'Population Segment ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Attributed Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Attributed Primary Care Physician (PCP) ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Defining Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Care Manager ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Attributed Practice ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Segment Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `aco_attribution_flag` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Attribution Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `aco_code` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `asthma_flag` SET TAGS ('pii_business_glossary_term' = 'Asthma Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `attributed_care_program` SET TAGS ('pii_business_glossary_term' = 'Attributed Care Program');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `care_gap_count` SET TAGS ('pii_business_glossary_term' = 'Care Gap Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `care_management_enrollment_flag` SET TAGS ('pii_business_glossary_term' = 'Care Management Enrollment Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `chf_flag` SET TAGS ('pii_business_glossary_term' = 'Congestive Heart Failure (CHF) Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `chronic_condition_count` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `chronic_condition_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `ckd_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Kidney Disease (CKD) Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `copd_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Obstructive Pulmonary Disease (COPD) Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `depression_flag` SET TAGS ('pii_business_glossary_term' = 'Depression Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `diabetes_flag` SET TAGS ('pii_business_glossary_term' = 'Diabetes Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `ed_utilization_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Department (ED) Utilization Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `hcc_condition_count` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Condition Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `hcc_condition_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `hcc_risk_score` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `hypertension_flag` SET TAGS ('pii_business_glossary_term' = 'Hypertension Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `measurement_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `measurement_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `payer_product_type` SET TAGS ('pii_business_glossary_term' = 'Payer Product Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `payer_product_type` SET TAGS ('pii_value_regex' = 'Medicare|Medicaid|Commercial|Medicare_Advantage|Dual_Eligible|Uninsured');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `predicted_utilization_tier` SET TAGS ('pii_business_glossary_term' = 'Predicted Utilization Tier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `predicted_utilization_tier` SET TAGS ('pii_value_regex' = 'very_high|high|moderate|low|very_low');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `prior_risk_score` SET TAGS ('pii_business_glossary_term' = 'Prior Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `prior_risk_tier` SET TAGS ('pii_business_glossary_term' = 'Prior Risk Tier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `prior_risk_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `readmission_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_percentile` SET TAGS ('pii_business_glossary_term' = 'Risk Score Percentile');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_percentile` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_source` SET TAGS ('pii_business_glossary_term' = 'Risk Score Source Model');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_source` SET TAGS ('pii_value_regex' = 'CMS_HCC|ACG|proprietary|CDPS|DxCG|ERG');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `sdoh_domain_flags` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Domain Flags');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `sdoh_domain_flags` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `sdoh_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `sdoh_risk_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `segment_type` SET TAGS ('pii_business_glossary_term' = 'Population Segment Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `segment_type` SET TAGS ('pii_value_regex' = 'chronic_disease_cohort|high_risk|rising_risk|healthy|complex_care|palliative');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `source_system_segment_code` SET TAGS ('pii_business_glossary_term' = 'Source System Segment ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `stratification_date` SET TAGS ('pii_business_glossary_term' = 'Last Stratification Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `stratification_model_version` SET TAGS ('pii_business_glossary_term' = 'Stratification Model Version');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `stratification_status` SET TAGS ('pii_business_glossary_term' = 'Stratification Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `stratification_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending_review|superseded');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `care_program_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Care Program Enrollment ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Primary Care Physician (PCP) ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Care Program ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Care Manager ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `population_segment_id` SET TAGS ('pii_business_glossary_term' = 'Population Segment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `care_gap_count` SET TAGS ('pii_business_glossary_term' = 'Care Gap Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `consent_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `consent_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `disenrollment_reason` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('pii_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_value_regex' = 'active|pending|disenrolled|suspended|completed|declined');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `last_care_manager_contact_date` SET TAGS ('pii_business_glossary_term' = 'Last Care Manager Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `last_care_manager_contact_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `last_care_manager_contact_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `last_stratification_date` SET TAGS ('pii_business_glossary_term' = 'Last Stratification Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `next_care_manager_contact_date` SET TAGS ('pii_business_glossary_term' = 'Next Care Manager Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `next_care_manager_contact_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `next_care_manager_contact_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `payer_program_name` SET TAGS ('pii_business_glossary_term' = 'Payer Program Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `payer_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `payer_program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_outcome` SET TAGS ('pii_business_glossary_term' = 'Program Outcome');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_outcome` SET TAGS ('pii_value_regex' = 'goals_met|partial_goals_met|goals_not_met|transferred|deceased|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `risk_score_model_version` SET TAGS ('pii_business_glossary_term' = 'Risk Score Model Version');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `source_system_enrollment_code` SET TAGS ('pii_business_glossary_term' = 'Source System Enrollment ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `value_based_contract_type` SET TAGS ('pii_business_glossary_term' = 'Value-Based Contract Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` SET TAGS ('pii_subdomain' = 'coverage_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `financial_assistance_id` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `financial_assistance_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Financial Counselor Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `annual_household_income` SET TAGS ('pii_business_glossary_term' = 'Annual Household Income');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `annual_household_income` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `annual_household_income` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `appeal_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Appeal Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `appeal_flag` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Appeal Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_value_regex' = 'upheld|overturned|pending|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Application Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_number` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Application Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_number` SET TAGS ('pii_value_regex' = '^FA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_source` SET TAGS ('pii_business_glossary_term' = 'Application Source Channel');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_status` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Application Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|cancelled|expired|under_review');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `approved_assistance_amount` SET TAGS ('pii_business_glossary_term' = 'Approved Assistance Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `approved_discount_percentage` SET TAGS ('pii_business_glossary_term' = 'Approved Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `approved_discount_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `balance_eligible_amount` SET TAGS ('pii_business_glossary_term' = 'Balance Eligible Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `collection_hold_flag` SET TAGS ('pii_business_glossary_term' = 'Collections Hold Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `community_benefit_category` SET TAGS ('pii_business_glossary_term' = 'Community Benefit Category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `community_benefit_category` SET TAGS ('pii_value_regex' = 'charity_care|unreimbursed_medicaid|community_health_improvement|subsidized_health_services|research|cash_in_kind');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `denial_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Denial Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `denial_reason` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Denial Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `denial_reason` SET TAGS ('pii_value_regex' = 'income_exceeds_threshold|incomplete_documentation|duplicate_application|ineligible_service|patient_declined|other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `extraordinary_collection_action_flag` SET TAGS ('pii_business_glossary_term' = 'Extraordinary Collection Action (ECA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `fpl_guideline_year` SET TAGS ('pii_business_glossary_term' = 'Federal Poverty Level (FPL) Guideline Year');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `household_size` SET TAGS ('pii_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `income_verification_method` SET TAGS ('pii_business_glossary_term' = 'Income Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `income_verification_method` SET TAGS ('pii_value_regex' = 'self_attestation|tax_return|pay_stub|bank_statement|government_benefit_letter|third_party_database');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `income_verification_method` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `insurance_coverage_verified` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `insurance_coverage_verified` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `insurance_coverage_verified` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `medicaid_application_submitted` SET TAGS ('pii_business_glossary_term' = 'Medicaid Application Submitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `medicaid_application_submitted` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `medicaid_screened` SET TAGS ('pii_business_glossary_term' = 'Medicaid Screening Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `medicaid_screened` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Application Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `payment_plan_duration_months` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Duration (Months)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `payment_plan_duration_months` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `payment_plan_monthly_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Monthly Installment Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `presumptive_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Medicaid Presumptive Eligibility (PE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Program Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'charity_care|medicaid_presumptive_eligibility|sliding_fee_scale|payment_plan|financial_hardship|hill_burton');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Application Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `sdoh_flag` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `sdoh_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `source_system_application_code` SET TAGS ('pii_business_glossary_term' = 'Source System Application ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ALTER COLUMN `write_off_amount` SET TAGS ('pii_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_id` SET TAGS ('pii_business_glossary_term' = 'Portal Account ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `patient_rpm_program_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Rpm Program Enrollment Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Portal Account Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `account_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending_activation|locked|deactivated');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Portal Account Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `account_type` SET TAGS ('pii_value_regex' = 'patient|proxy|shared');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `activation_date` SET TAGS ('pii_business_glossary_term' = 'Account Activation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `activation_method` SET TAGS ('pii_business_glossary_term' = 'Account Activation Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `activation_method` SET TAGS ('pii_value_regex' = 'staff_assisted|self_service|kiosk|mail|email_invite|sms_invite');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `app_link_date` SET TAGS ('pii_business_glossary_term' = 'Digital Health Application Link Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `appointment_scheduling_enabled` SET TAGS ('pii_business_glossary_term' = 'Appointment Self-Scheduling Enabled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Account Creation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('pii_business_glossary_term' = 'Account Deactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('pii_business_glossary_term' = 'Digital Health Application Linked');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `identity_verification_method` SET TAGS ('pii_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `identity_verification_method` SET TAGS ('pii_value_regex' = 'in_person|online_proofing|government_id|knowledge_based|staff_verified|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `identity_verified_date` SET TAGS ('pii_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `identity_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Identity Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `last_login_date` SET TAGS ('pii_business_glossary_term' = 'Last Login Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `linked_app_name` SET TAGS ('pii_business_glossary_term' = 'Linked Digital Health Application Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `linked_app_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `linked_app_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `login_failure_count` SET TAGS ('pii_business_glossary_term' = 'Login Failure Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `messaging_opt_in` SET TAGS ('pii_business_glossary_term' = 'Secure Messaging Opt-In Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('pii_business_glossary_term' = 'Portal Notification Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('pii_business_glossary_term' = 'Portal Notification Mobile Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_preference` SET TAGS ('pii_business_glossary_term' = 'Notification Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_preference` SET TAGS ('pii_value_regex' = 'email|sms|push|in_portal|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('pii_business_glossary_term' = 'Portal Account Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_platform` SET TAGS ('pii_business_glossary_term' = 'Portal Platform');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_platform` SET TAGS ('pii_value_regex' = 'MyChart|HealtheLife|FollowMyHealth|Healow|PatientFusion|Other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_flag` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_level` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_level` SET TAGS ('pii_value_regex' = 'full|limited|view_only');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_level` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_level` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_authorization_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Authorization Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_authorization_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_authorization_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Proxy Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_expiration_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_expiration_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_business_glossary_term' = 'Proxy First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_business_glossary_term' = 'Proxy Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_reference` SET TAGS ('pii_business_glossary_term' = 'Proxy Legal Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_reference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_reference` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_type` SET TAGS ('pii_business_glossary_term' = 'Proxy Legal Document Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_type` SET TAGS ('pii_value_regex' = 'court_order|power_of_attorney|guardianship_decree|parental_consent|advance_directive|other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_relationship_type` SET TAGS ('pii_business_glossary_term' = 'Proxy Relationship Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_relationship_type` SET TAGS ('pii_value_regex' = 'parent|legal_guardian|adult_caregiver|healthcare_poa|spouse|other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_relationship_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_relationship_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_reason` SET TAGS ('pii_value_regex' = 'patient_request|guardian_change|legal_order|deceased|age_of_majority|administrative');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_reason` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `rx_renewal_request_enabled` SET TAGS ('pii_business_glossary_term' = 'Prescription Renewal Request Enabled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `rx_renewal_request_enabled` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `source_system_account_code` SET TAGS ('pii_business_glossary_term' = 'Source System Account ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `terms_accepted_date` SET TAGS ('pii_business_glossary_term' = 'Terms of Use Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `terms_accepted_flag` SET TAGS ('pii_business_glossary_term' = 'Terms of Use Accepted Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `terms_version` SET TAGS ('pii_business_glossary_term' = 'Terms of Use Version');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('pii_business_glossary_term' = 'Test Result Notification Enabled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `two_factor_auth_enrolled` SET TAGS ('pii_business_glossary_term' = 'Two-Factor Authentication (2FA) Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `two_factor_auth_method` SET TAGS ('pii_business_glossary_term' = 'Two-Factor Authentication (2FA) Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `two_factor_auth_method` SET TAGS ('pii_value_regex' = 'sms|email|authenticator_app|hardware_token|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_access_id` SET TAGS ('pii_business_glossary_term' = 'Proxy Access ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_access_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_access_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Proxy Person ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_patient_demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_patient_demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `access_level` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `access_level` SET TAGS ('pii_value_regex' = 'full|limited|view_only|scheduling_only|messaging_only');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `access_status` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `access_status` SET TAGS ('pii_value_regex' = 'active|expired|revoked|pending|suspended');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `age_of_majority_date` SET TAGS ('pii_business_glossary_term' = 'Age of Majority Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `authorization_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Authorization Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `authorization_location` SET TAGS ('pii_business_glossary_term' = 'Authorization Location');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `billing_access_flag` SET TAGS ('pii_business_glossary_term' = 'Proxy Billing Access Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `consent_obtained_by` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `consent_obtained_by` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `consent_obtained_by` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `consent_obtained_method` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `consent_obtained_method` SET TAGS ('pii_value_regex' = 'in_person|electronic|mail|phone|fax');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `consent_obtained_method` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `consent_obtained_method` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `last_access_timestamp` SET TAGS ('pii_business_glossary_term' = 'Proxy Last Access Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `legal_document_effective_date` SET TAGS ('pii_business_glossary_term' = 'Legal Document Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `legal_document_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Legal Document Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `legal_document_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `legal_document_reference` SET TAGS ('pii_business_glossary_term' = 'Legal Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `legal_document_reference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `legal_document_type` SET TAGS ('pii_business_glossary_term' = 'Legal Document Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `legal_document_type` SET TAGS ('pii_value_regex' = 'court_order|power_of_attorney|birth_certificate|adoption_decree|guardianship_order|none_required');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `messaging_access_flag` SET TAGS ('pii_business_glossary_term' = 'Proxy Messaging Access Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `minor_patient_flag` SET TAGS ('pii_business_glossary_term' = 'Minor Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `minor_patient_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `minor_patient_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mychart_proxy_account_number` SET TAGS ('pii_business_glossary_term' = 'MyChart Proxy Account ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mychart_proxy_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mychart_proxy_account_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mychart_proxy_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `mychart_proxy_account_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `phi_restriction_flag` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Restriction Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `portal_access_enabled` SET TAGS ('pii_business_glossary_term' = 'Patient Portal Access Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Proxy Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('pii_business_glossary_term' = 'Proxy Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_business_glossary_term' = 'Proxy First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_first_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_business_glossary_term' = 'Proxy Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_last_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_phone` SET TAGS ('pii_business_glossary_term' = 'Proxy Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_relationship_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_relationship_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_type` SET TAGS ('pii_business_glossary_term' = 'Proxy Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_type` SET TAGS ('pii_value_regex' = 'parent_guardian|adult_caregiver|legal_guardian|healthcare_power_of_attorney|personal_representative|minor_self');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `relationship_to_patient` SET TAGS ('pii_business_glossary_term' = 'Proxy Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `relationship_to_patient` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `relationship_to_patient` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `relationship_type` SET TAGS ('pii_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `restricted_phi_categories` SET TAGS ('pii_business_glossary_term' = 'Restricted Protected Health Information (PHI) Categories');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `restricted_phi_categories` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Proxy Access Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `rx_refill_access_flag` SET TAGS ('pii_business_glossary_term' = 'Prescription (Rx) Refill Access Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `rx_refill_access_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `scheduling_access_flag` SET TAGS ('pii_business_glossary_term' = 'Proxy Scheduling Access Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `source_system_proxy_code` SET TAGS ('pii_business_glossary_term' = 'Source System Proxy ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `source_system_proxy_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `source_system_proxy_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Proxy Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Proxy Identity Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|pending_verification|verification_failed|not_required');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`proxy_access` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Proxy Verified By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` SET TAGS ('pii_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` SET TAGS ('pii_identity_resolution' = 'crosswalk');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` SET TAGS ('pii_hipaa' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` SET TAGS ('pii_role' = 'identity_resolution');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_crosswalk_id` SET TAGS ('pii_business_glossary_term' = 'MRN Crosswalk Record ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_crosswalk_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_crosswalk_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Assigning Care Site');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `primary_mrn_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Primary MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `primary_mrn_mpi_record_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `primary_mrn_mpi_record_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `adt_event_type` SET TAGS ('pii_business_glossary_term' = 'ADT Event Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `adt_message_control_number` SET TAGS ('pii_business_glossary_term' = 'ADT Message Control Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `assigning_authority` SET TAGS ('pii_business_glossary_term' = 'Assigning Authority');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `cerner_euid` SET TAGS ('pii_business_glossary_term' = 'Cerner Enterprise UID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `cerner_euid` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `crosswalk_status` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_business_glossary_term' = 'Enterprise MRN');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `epic_empi_number` SET TAGS ('pii_business_glossary_term' = 'Epic EMPI Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `epic_empi_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `facility_mrn` SET TAGS ('pii_business_glossary_term' = 'Facility MRN');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `facility_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `facility_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `facility_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `fhir_patient_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Patient Reference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `fhir_patient_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `fhir_patient_reference` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_network_name` SET TAGS ('pii_business_glossary_term' = 'HIE Network Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_network_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_patient_number` SET TAGS ('pii_business_glossary_term' = 'HIE Patient Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_patient_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_patient_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `identifier_system_oid` SET TAGS ('pii_business_glossary_term' = 'Identifier System OID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `identifier_type` SET TAGS ('pii_business_glossary_term' = 'Identifier Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `is_golden_record` SET TAGS ('pii_business_glossary_term' = 'Golden Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `is_primary_identifier` SET TAGS ('pii_business_glossary_term' = 'Primary Identifier Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `is_primary_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `is_primary_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `last_adt_event_date` SET TAGS ('pii_business_glossary_term' = 'Last ADT Event Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `match_algorithm` SET TAGS ('pii_business_glossary_term' = 'Match Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `match_confidence_score` SET TAGS ('pii_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `match_status` SET TAGS ('pii_business_glossary_term' = 'Match Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `match_type` SET TAGS ('pii_business_glossary_term' = 'Match Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `meditech_patient_number` SET TAGS ('pii_business_glossary_term' = 'MEDITECH Patient Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `meditech_patient_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `meditech_patient_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_status` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_type` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `overlay_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Overlay Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_number` SET TAGS ('pii_business_glossary_term' = 'Payer Member Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `review_reason` SET TAGS ('pii_business_glossary_term' = 'Review Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_facility_code` SET TAGS ('pii_business_glossary_term' = 'Source Facility Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Source Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_mrn` SET TAGS ('pii_business_glossary_term' = 'Source Mrn');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_patient_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_patient_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_patient_identifier` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `verified_by` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `verified_date` SET TAGS ('pii_business_glossary_term' = 'Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `verified_flag` SET TAGS ('pii_business_glossary_term' = 'Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_log_id` SET TAGS ('pii_business_glossary_term' = 'Communication Log ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Care Gap Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Sender Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `follow_up_communication_log_id` SET TAGS ('pii_business_glossary_term' = 'Follow Up Communication Log Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `follow_up_communication_log_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `care_gap_code` SET TAGS ('pii_business_glossary_term' = 'Care Gap Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `care_gap_description` SET TAGS ('pii_business_glossary_term' = 'Care Gap Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_channel` SET TAGS ('pii_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_date` SET TAGS ('pii_business_glossary_term' = 'Communication Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_number` SET TAGS ('pii_business_glossary_term' = 'Communication Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_status` SET TAGS ('pii_business_glossary_term' = 'Communication Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Communication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_type` SET TAGS ('pii_business_glossary_term' = 'Communication Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_type` SET TAGS ('pii_value_regex' = 'appointment_reminder|care_gap_notification|preventive_screening_outreach|billing_statement|post_discharge_follow_up|population_health_campaign');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `consent_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `consent_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `contact_attempt_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `contact_attempt_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `delivery_failure_reason` SET TAGS ('pii_business_glossary_term' = 'Delivery Failure Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `delivery_status` SET TAGS ('pii_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `delivery_status` SET TAGS ('pii_value_regex' = 'sent|delivered|failed|bounced|undeliverable|pending');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `delivery_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `direction` SET TAGS ('pii_business_glossary_term' = 'Direction');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `fhir_communication_reference` SET TAGS ('pii_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Communication ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `interpreter_used_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `message_body` SET TAGS ('pii_business_glossary_term' = 'Message Body');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `message_content_summary` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `opt_out_channel` SET TAGS ('pii_business_glossary_term' = 'Opt-Out Channel');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `opt_out_date` SET TAGS ('pii_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `opt_out_flag` SET TAGS ('pii_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_date` SET TAGS ('pii_business_glossary_term' = 'Patient Response Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Response Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_text` SET TAGS ('pii_business_glossary_term' = 'Patient Response Text');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_text` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `patient_response_text` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'routine|urgent|asap|stat');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_contact_value` SET TAGS ('pii_business_glossary_term' = 'Recipient Contact Value');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_contact_value` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_contact_value` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_contact_value` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_contact_value` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_type` SET TAGS ('pii_business_glossary_term' = 'Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_type` SET TAGS ('pii_value_regex' = 'patient|proxy|emergency_contact|guarantor|family_member');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `sender_name` SET TAGS ('pii_business_glossary_term' = 'Sender Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `sender_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `sender_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `sender_role` SET TAGS ('pii_business_glossary_term' = 'Sender Role');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `sent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `source_system_communication_code` SET TAGS ('pii_business_glossary_term' = 'Source System Communication ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `communication_log_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Subject');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `subject_line` SET TAGS ('pii_business_glossary_term' = 'Subject Line');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` SET TAGS ('pii_subdomain' = 'coverage_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_reference_id` SET TAGS ('pii_business_glossary_term' = 'Consent Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_reference_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_reference_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Verified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Obtaining Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinician_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Consent Master ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `superseded_consent_reference_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Consent Reference Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `superseded_consent_reference_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `superseded_consent_reference_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `superseded_consent_reference_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `audit_trail_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_effective_date` SET TAGS ('pii_business_glossary_term' = 'Consent Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_effective_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_effective_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_expiration_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_expiration_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_method` SET TAGS ('pii_value_regex' = 'written|verbal|electronic|implied');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_method` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_method` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_revocation_date` SET TAGS ('pii_business_glossary_term' = 'Consent Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_revocation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_revocation_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_scope` SET TAGS ('pii_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_scope` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_scope` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_status` SET TAGS ('pii_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_status` SET TAGS ('pii_value_regex' = 'active|revoked|expired|pending|superseded');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_type` SET TAGS ('pii_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_type` SET TAGS ('pii_value_regex' = 'treatment|research|marketing|phi_disclosure|hie_participation|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `document_reference_number` SET TAGS ('pii_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_business_glossary_term' = 'Enterprise Medical Record Number (EMRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('pii_business_glossary_term' = 'Guardian Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_relationship` SET TAGS ('pii_business_glossary_term' = 'Guardian Relationship');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_relationship` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_relationship` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `hie_participation_flag` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `interpreter_used_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `language_of_consent` SET TAGS ('pii_business_glossary_term' = 'Language of Consent');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `language_of_consent` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `language_of_consent` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `legal_guardian_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Guardian Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `legal_guardian_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `legal_guardian_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('pii_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `phi_disclosure_authorized_flag` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Disclosure Authorized Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `reference_priority` SET TAGS ('pii_business_glossary_term' = 'Reference Priority');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `research_participation_flag` SET TAGS ('pii_business_glossary_term' = 'Research Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `source_system_reference_code` SET TAGS ('pii_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending_verification');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `verified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `witness_required_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` SET TAGS ('pii_association_edges' = 'patient.demographics,quality.measure');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `quality_measure_evaluation_id` SET TAGS ('pii_business_glossary_term' = 'Patient Quality Measure Evaluation ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Attribution Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Quality Measure Evaluation - Demographics Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Measure Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `care_gap_closure_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `care_gap_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Gap Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `denominator_eligible` SET TAGS ('pii_business_glossary_term' = 'Denominator Eligible');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `denominator_flag` SET TAGS ('pii_business_glossary_term' = 'Denominator Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Gap Closure Due Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `exclusion_flag` SET TAGS ('pii_business_glossary_term' = 'Exclusion Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `exclusion_reason` SET TAGS ('pii_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `gap_status` SET TAGS ('pii_business_glossary_term' = 'Gap Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `intervention_code` SET TAGS ('pii_business_glossary_term' = 'Intervention Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `measurement_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `measurement_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `numerator_compliant` SET TAGS ('pii_business_glossary_term' = 'Numerator Compliant');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `numerator_flag` SET TAGS ('pii_business_glossary_term' = 'Numerator Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `outreach_attempted` SET TAGS ('pii_business_glossary_term' = 'Outreach Attempted');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `outreach_date` SET TAGS ('pii_business_glossary_term' = 'Outreach Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` SET TAGS ('pii_association_edges' = 'patient.demographics,quality.quality_program');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Program Enrollment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `care_program_id` SET TAGS ('pii_business_glossary_term' = 'Care Program Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Attributed Provider');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `consent_reference_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `consent_reference_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Program Enrollment - Demographics Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Attribution Payer');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Care Manager');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_employee_id` SET TAGS ('pii_business_glossary_term' = 'Enrolled By User');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_enrolled_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Enrolled By Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_enrolled_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_enrolled_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_override_approved_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_override_approved_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Program Enrollment - Quality Program Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `acuity_level` SET TAGS ('pii_business_glossary_term' = 'Acuity Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `care_coordination_minutes` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `care_manager_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `care_manager_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `consent_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `consent_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `disenrollment_reason` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `engagement_level` SET TAGS ('pii_business_glossary_term' = 'Engagement Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `engagement_score` SET TAGS ('pii_business_glossary_term' = 'Engagement Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_consent_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_consent_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_consent_method` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_consent_method` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('pii_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `expected_duration_days` SET TAGS ('pii_business_glossary_term' = 'Expected Duration');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `expected_duration_days` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `graduation_criteria_met_flag` SET TAGS ('pii_business_glossary_term' = 'Graduation Criteria Met');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `graduation_date` SET TAGS ('pii_business_glossary_term' = 'Graduation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `last_contact_date` SET TAGS ('pii_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `last_contact_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `last_contact_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `last_outreach_date` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `next_contact_date` SET TAGS ('pii_business_glossary_term' = 'Next Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `next_contact_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `next_contact_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `next_scheduled_contact_date` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Contact');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `next_scheduled_contact_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `next_scheduled_contact_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `opt_out_date` SET TAGS ('pii_business_glossary_term' = 'Opt Out Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `opt_out_flag` SET TAGS ('pii_business_glossary_term' = 'Opt Out Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `outreach_attempts_count` SET TAGS ('pii_business_glossary_term' = 'Outreach Attempts');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `payer_attributed_flag` SET TAGS ('pii_business_glossary_term' = 'Payer Attributed');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `priority_score` SET TAGS ('pii_business_glossary_term' = 'Priority Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_outcome` SET TAGS ('pii_business_glossary_term' = 'Program Outcome');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `readmission_risk_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `referral_source_type` SET TAGS ('pii_business_glossary_term' = 'Referral Source Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `risk_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `target_condition_code` SET TAGS ('pii_business_glossary_term' = 'Target Condition');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `assigned_coordinator_id` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ALTER COLUMN `assigned_coordinator_id` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `care_program_id` SET TAGS ('pii_business_glossary_term' = 'Care Program Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `parent_care_program_id` SET TAGS ('pii_business_glossary_term' = 'Parent Care Program Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `parent_care_program_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `accreditation_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `accreditation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `accreditation_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `annual_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `annual_budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `clinical_focus` SET TAGS ('pii_business_glossary_term' = 'Clinical Focus');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `clinical_focus` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `consent_form_version` SET TAGS ('pii_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `consent_form_version` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `consent_form_version` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `consent_required` SET TAGS ('pii_business_glossary_term' = 'Consent Required');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `consent_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `consent_required` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `cost_per_participant` SET TAGS ('pii_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `cost_per_participant` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `current_enrollment_count` SET TAGS ('pii_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `care_program_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `duration_weeks` SET TAGS ('pii_business_glossary_term' = 'Duration Weeks');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `duration_weeks` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `enrollment_capacity` SET TAGS ('pii_business_glossary_term' = 'Enrollment Capacity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `enrollment_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `enrollment_capacity` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `hipaa_compliant` SET TAGS ('pii_business_glossary_term' = 'Hipaa Compliant');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `is_evidence_based` SET TAGS ('pii_business_glossary_term' = 'Is Evidence Based');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `language_support` SET TAGS ('pii_business_glossary_term' = 'Language Support');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `care_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `care_program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `patient_portal_access` SET TAGS ('pii_business_glossary_term' = 'Patient Portal Access');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `patient_portal_access` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `patient_portal_access` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_category` SET TAGS ('pii_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_email` SET TAGS ('pii_business_glossary_term' = 'Program Coordinator Email');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_name` SET TAGS ('pii_business_glossary_term' = 'Program Coordinator Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_phone` SET TAGS ('pii_business_glossary_term' = 'Program Coordinator Phone');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_coordinator_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_duration_months` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `quality_measure_set` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `reimbursement_model` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Model');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `requires_physician_referral` SET TAGS ('pii_business_glossary_term' = 'Requires Physician Referral');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `requires_prior_authorization` SET TAGS ('pii_business_glossary_term' = 'Requires Prior Authorization');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `care_program_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `target_outcome_metric` SET TAGS ('pii_business_glossary_term' = 'Target Outcome Metric');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `target_population` SET TAGS ('pii_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_business_glossary_term' = 'Telehealth Enabled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `updated_by_user` SET TAGS ('pii_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Communication Campaign Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `message_template_id` SET TAGS ('pii_business_glossary_term' = 'Message Template Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `parent_communication_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Parent Communication Campaign Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `parent_communication_campaign_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `actual_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `actual_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `approved_by_name` SET TAGS ('pii_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `approved_by_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `approved_by_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `call_to_action` SET TAGS ('pii_business_glossary_term' = 'Call To Action');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_code` SET TAGS ('pii_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_name` SET TAGS ('pii_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_objective` SET TAGS ('pii_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_business_glossary_term' = 'Campaign Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_category' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_type' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_classification' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_subtype' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_status` SET TAGS ('pii_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_type` SET TAGS ('pii_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_channel` SET TAGS ('pii_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `consent_required_flag` SET TAGS ('pii_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `consent_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `consent_required_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `cost_per_message` SET TAGS ('pii_business_glossary_term' = 'Cost Per Message');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `cost_per_message` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `exclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `frequency_type` SET TAGS ('pii_business_glossary_term' = 'Frequency Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `hipaa_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Hipaa Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `message_content` SET TAGS ('pii_business_glossary_term' = 'Message Content');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `message_subject` SET TAGS ('pii_business_glossary_term' = 'Message Subject');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `multi_language_support_flag` SET TAGS ('pii_business_glossary_term' = 'Multi Language Support Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `opt_out_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Opt Out Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `phi_included_flag` SET TAGS ('pii_business_glossary_term' = 'Phi Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `regulatory_approval_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `reply_to_email_address` SET TAGS ('pii_business_glossary_term' = 'Reply To Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `reply_to_email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `reply_to_email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `reply_to_email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `scheduled_end_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `scheduled_start_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `segmentation_criteria` SET TAGS ('pii_business_glossary_term' = 'Segmentation Criteria');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_email_address` SET TAGS ('pii_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_name` SET TAGS ('pii_business_glossary_term' = 'Sender Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_phone_number` SET TAGS ('pii_business_glossary_term' = 'Sender Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `sender_phone_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_campaign_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `target_audience_description` SET TAGS ('pii_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `target_patient_count` SET TAGS ('pii_business_glossary_term' = 'Target Patient Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `target_patient_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `target_patient_count` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `target_population` SET TAGS ('pii_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `tracking_url` SET TAGS ('pii_business_glossary_term' = 'Tracking Url');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `trigger_event_type` SET TAGS ('pii_business_glossary_term' = 'Trigger Event Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_panel_id` SET TAGS ('pii_business_glossary_term' = 'Attribution Panel Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `care_team_id` SET TAGS ('pii_business_glossary_term' = 'Care Team Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `hie_organization_id` SET TAGS ('pii_business_glossary_term' = 'Organization Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `parent_attribution_panel_id` SET TAGS ('pii_business_glossary_term' = 'Parent Attribution Panel Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `parent_attribution_panel_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_calculation_date` SET TAGS ('pii_business_glossary_term' = 'Attribution Calculation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_method` SET TAGS ('pii_business_glossary_term' = 'Attribution Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_period` SET TAGS ('pii_business_glossary_term' = 'Attribution Period');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_priority` SET TAGS ('pii_business_glossary_term' = 'Attribution Priority');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `auto_assignment_enabled` SET TAGS ('pii_business_glossary_term' = 'Auto Assignment Enabled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `created_by_user_code` SET TAGS ('pii_business_glossary_term' = 'Created By User Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `exclude_emergency_visits` SET TAGS ('pii_business_glossary_term' = 'Exclude Emergency Visits');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `include_telehealth_encounters` SET TAGS ('pii_business_glossary_term' = 'Include Telehealth Encounters');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `include_telehealth_encounters` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `include_telehealth_encounters` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `lookback_period_months` SET TAGS ('pii_business_glossary_term' = 'Lookback Period Months');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `minimum_encounter_threshold` SET TAGS ('pii_business_glossary_term' = 'Minimum Encounter Threshold');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `modified_by_user_code` SET TAGS ('pii_business_glossary_term' = 'Modified By User Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_capacity` SET TAGS ('pii_business_glossary_term' = 'Panel Capacity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_capacity` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_code` SET TAGS ('pii_business_glossary_term' = 'Panel Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_description` SET TAGS ('pii_business_glossary_term' = 'Panel Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_name` SET TAGS ('pii_business_glossary_term' = 'Panel Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_type` SET TAGS ('pii_business_glossary_term' = 'Panel Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `patient_count` SET TAGS ('pii_business_glossary_term' = 'Patient Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `patient_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `patient_count` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `quality_program_participation` SET TAGS ('pii_business_glossary_term' = 'Quality Program Participation');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `risk_adjustment_model` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Model');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `specialty_type` SET TAGS ('pii_business_glossary_term' = 'Specialty Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_panel_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` SET TAGS ('pii_['model_tier' = 'MVM');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` SET TAGS ('pii_'ecm_member' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` SET TAGS ('pii_'mvm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `message_template_id` SET TAGS ('pii_business_glossary_term' = 'Message Template Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `employee_id` SET TAGS ('pii_renamed_from' = 'employee_id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `facility_care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `parent_message_template_id` SET TAGS ('pii_business_glossary_term' = 'Parent Message Template Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `parent_message_template_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `body` SET TAGS ('pii_business_glossary_term' = 'Body');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `callback_phone_number` SET TAGS ('pii_business_glossary_term' = 'Callback Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `callback_phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `callback_phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `callback_phone_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `character_limit` SET TAGS ('pii_business_glossary_term' = 'Character Limit');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `communication_channel` SET TAGS ('pii_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `consent_type` SET TAGS ('pii_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `consent_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `consent_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `contains_phi` SET TAGS ('pii_business_glossary_term' = 'Contains Phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `delivery_time_preference` SET TAGS ('pii_business_glossary_term' = 'Delivery Time Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `hipaa_compliant` SET TAGS ('pii_business_glossary_term' = 'Hipaa Compliant');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `last_used_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `max_retry_attempts` SET TAGS ('pii_business_glossary_term' = 'Max Retry Attempts');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `merge_fields` SET TAGS ('pii_business_glossary_term' = 'Merge Fields');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `message_body` SET TAGS ('pii_business_glossary_term' = 'Message Body');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `message_subject` SET TAGS ('pii_business_glossary_term' = 'Message Subject');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `opt_out_instructions` SET TAGS ('pii_business_glossary_term' = 'Opt Out Instructions');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `reply_to_address` SET TAGS ('pii_business_glossary_term' = 'Reply To Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `reply_to_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `reply_to_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `reply_to_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `requires_consent` SET TAGS ('pii_business_glossary_term' = 'Requires Consent');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `requires_consent` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `requires_consent` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `retry_policy` SET TAGS ('pii_business_glossary_term' = 'Retry Policy');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `sender_name` SET TAGS ('pii_business_glossary_term' = 'Sender Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `sender_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `sender_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `message_template_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Subject');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `template_category` SET TAGS ('pii_business_glossary_term' = 'Template Category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `template_code` SET TAGS ('pii_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `template_name` SET TAGS ('pii_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `template_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `template_type` SET TAGS ('pii_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `template_version` SET TAGS ('pii_business_glossary_term' = 'Template Version');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ALTER COLUMN `usage_count` SET TAGS ('pii_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` SET TAGS ('pii_subdomain' = 'social_determinants');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` SET TAGS ('pii_subdomain' = 'social_determinants');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `address_line1` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `address_line1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `capacity_status` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `capacity_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `capacity_status` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `contact_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `organization_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `state_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` SET TAGS ('pii_subdomain' = 'social_determinants');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` SET TAGS ('pii_subdomain' = 'coverage_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` SET TAGS ('pii_ssot_canonical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` SET TAGS ('pii_coverage_ssot' = 'patient.patient_coverage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Patient Coverage Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Member Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `digital_health_opt_in` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `group_number` SET TAGS ('pii_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `plan_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `plan_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` SET TAGS ('pii_domain' = 'digital_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` ALTER COLUMN `patient_rpm_device_reading_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` ALTER COLUMN `patient_rpm_device_reading_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading` ALTER COLUMN `patient_rpm_alert_threshold_id` SET TAGS ('pii_business_glossary_term' = 'Triggered Alert Threshold Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold` SET TAGS ('pii_domain' = 'digital_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold` ALTER COLUMN `patient_rpm_alert_threshold_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_alert_threshold` ALTER COLUMN `patient_rpm_alert_threshold_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` SET TAGS ('pii_domain' = 'digital_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` ALTER COLUMN `patient_rpm_program_enrollment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` ALTER COLUMN `patient_rpm_program_enrollment_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_rpm_program_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_portal_engagement_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_portal_engagement_event` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_portal_engagement_event` SET TAGS ('pii_domain' = 'digital_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_portal_engagement_event` ALTER COLUMN `patient_portal_engagement_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_portal_engagement_event` ALTER COLUMN `patient_portal_engagement_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` SET TAGS ('pii_domain' = 'digital_health');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` ALTER COLUMN `patient_prom_response_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` ALTER COLUMN `patient_prom_response_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` SET TAGS ('pii_subdomain' = 'social_determinants');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `sdoh_risk_stratification_id` SET TAGS ('pii_business_glossary_term' = 'Sdoh Risk Stratification Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `previous_sdoh_risk_stratification_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `assessment_tool_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `assessment_tool_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `care_management_eligible_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `care_management_eligible_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `consent_to_screen_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `consent_to_screen_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `consent_to_screen_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `consent_to_screen_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `domains_screened_positive_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `domains_screened_positive_count` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `education_barrier_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `education_barrier_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `employment_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `employment_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `financial_strain_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `financial_strain_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `food_insecurity_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `food_insecurity_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `housing_instability_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `housing_instability_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `interpreter_needed_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `interpreter_needed_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `overall_risk_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `overall_risk_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `primary_language` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `primary_language` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `referral_generated_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `referral_generated_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `referral_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `referral_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `risk_tier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `risk_tier` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `social_isolation_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `social_isolation_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `transportation_barrier_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `transportation_barrier_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `utility_insecurity_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `utility_insecurity_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` SET TAGS ('pii_subdomain' = 'social_determinants');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `sdoh_zcode_mapping_id` SET TAGS ('pii_business_glossary_term' = 'Sdoh Zcode Mapping Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `superseded_sdoh_zcode_mapping_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `code_specificity_level` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `code_specificity_level` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `screening_instrument_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `screening_instrument_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` SET TAGS ('pii_subdomain' = 'social_determinants');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `chw_intervention_id` SET TAGS ('pii_business_glossary_term' = 'Chw Intervention Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `follow_up_chw_intervention_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `barriers_identified` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `barriers_identified` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `consent_record_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `consent_record_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `intervention_notes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `intervention_notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `patient_consent_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `patient_consent_obtained_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `presenting_concern` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `presenting_concern` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `service_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `service_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `service_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ALTER COLUMN `service_address` SET TAGS ('pii_uc_classification' = 'pii');
