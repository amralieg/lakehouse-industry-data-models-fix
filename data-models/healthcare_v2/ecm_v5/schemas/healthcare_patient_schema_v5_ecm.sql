-- Schema for Domain: patient | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`patient` COMMENT 'Patient domain expanded with SDOH subdomain for referral management, need closure tracking, CHW interventions, risk stratification, and Z‑code mapping.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` (
    `mpi_record_id` BIGINT COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `clinician_id` BIGINT COMMENT 'Identifier of the assigned primary care provider.',
    `address_line1` STRING COMMENT 'Add pii_phi, pii_pii, pii_sensitive tags',
    `address_line2` STRING COMMENT 'Add pii_phi, pii_pii, pii_sensitive tags',
    `approving_analyst` STRING COMMENT 'Analyst who approved the merge or creation of the MPI record.',
    `city` STRING COMMENT 'Add pii_phi, pii_pii, pii_sensitive tags',
    `confidence_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence (0‑100) that the record correctly matches the patient.',
    `consent_last_updated` TIMESTAMP COMMENT 'Timestamp of the most recent consent status change.',
    `consent_status` STRING COMMENT 'Current consent status for data sharing.. Valid values are `consented|revoked|pending|exempt|partial|unknown`',
    `country` STRING COMMENT 'Country code (ISO 3166‑1 alpha‑3).',
    `created_timestamp` TIMESTAMP COMMENT 'Added Unity Catalog tags for HIPAA retention and RLS predicates.',
    `data_retention_policy` STRING COMMENT 'HIPAA retention annotation (e.g., 7_years).',
    `date_of_birth` DATE COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `deceased_date` DATE COMMENT 'Date of death if the patient is deceased.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates if the patient is deceased.',
    `delta_tblproperties` STRING COMMENT 'Added Delta TBLPROPERTIES for change data feed',
    `duplicate_flag` BOOLEAN COMMENT 'Flag indicating a potential duplicate MPI record.',
    `email_address` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `enterprise_patient_identifier` BIGINT COMMENT 'Enterprise-wide unique patient identifier used as the single source of truth across the organization.',
    `ethnicity` STRING COMMENT 'Self‑reported ethnicity.',
    `external_identifier` STRING COMMENT 'Identifier from external HIE or national registry (e.g., NHS Number, IHI).',
    `external_identifier_source` STRING COMMENT 'Source system or registry for the external_id.',
    `family_name` STRING COMMENT 'add pii_phi,pii_pii,pii_sensitive',
    `gender` STRING COMMENT 'Patients gender as recorded.. Valid values are `male|female|other|unknown|undifferentiated|not_specified`',
    `given_name` STRING COMMENT 'add pii_phi,pii_pii,pii_sensitive',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the MPI record.',
    `marital_status` STRING COMMENT 'Marital status of the patient.. Valid values are `single|married|divorced|widowed|separated|partnered`',
    `match_algorithm` STRING COMMENT 'Name of the identity‑resolution algorithm used.',
    `merge_history` STRING COMMENT 'Audit trail of merge events stored as a JSON string.',
    `middle_name` STRING COMMENT 'Patients middle name(s).',
    `mrn` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `patient_identifier_type` STRING COMMENT 'Type of primary identifier used for the patient.. Valid values are `mrn|national_id|insurance_id|passport|driver_license|other`',
    `phone_number` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `postal_code` STRING COMMENT 'Postal/ZIP code.',
    `preferred_language` STRING COMMENT 'Preferred language for communication.',
    `privacy_restriction_level` STRING COMMENT 'Level of privacy restriction applied to the record.. Valid values are `low|medium|high|critical|restricted|confidential`',
    `race` STRING COMMENT 'Self‑reported race.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit timestamp when the record entered the MPI system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit timestamp of the last modification to the MPI record.',
    `record_status` STRING COMMENT 'Current lifecycle status of the MPI record.. Valid values are `active|inactive|merged|duplicate|archived|pending`',
    `retention_annotation` STRING COMMENT 'Added HIPAA retention annotation (7 years)',
    `rls_policy` STRING COMMENT 'Added RLS predicate example for PHI access',
    `sdh_assessment_score` STRING COMMENT 'Score from a standardized SDOH assessment (0‑100).',
    `sdh_need_closure_date` DATE COMMENT 'Target date to close the identified social need.',
    `sdh_referral_status` STRING COMMENT 'Status of the social determinants of health referral associated with the patient.. Valid values are `open|in_progress|closed|rejected|completed|on_hold`',
    `source_system` STRING COMMENT 'Source system that supplied the record (e.g., Epic, Cerner).',
    `state` STRING COMMENT 'Add pii_phi, pii_pii, pii_sensitive tags',
    `uc_tag` STRING COMMENT 'Added UC tag definition for de‑identified data',
    `unity_catalog_tags` STRING COMMENT 'Add Databricks Unity Catalog tags for governance.',
    `enterprise_patient_id` BIGINT COMMENT 'Enterprise-wide unique patient identifier used as the single source of truth across the organization.',
    `external_id` STRING COMMENT 'Identifier from external HIE or national registry (e.g., NHS Number, IHI).',
    `primary_care_provider_id` BIGINT COMMENT 'Identifier of the assigned primary care provider.',
    `community_resource_id` BIGINT COMMENT 'Identifier of the community resource assigned to address the SDOH need.',
    CONSTRAINT pk_mpi_record PRIMARY KEY(`mpi_record_id`)
) COMMENT 'pii_phi,pii_pii,pii_sensitive';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`demographics` (
    `demographics_id` BIGINT COMMENT 'Unique surrogate key for the demographics record.',
    `clinician_id` BIGINT COMMENT 'Surrogate key of the patient’s designated primary care provider.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Patient demographics MUST belong to a patient (mpi_record). This is a fundamental parent-child relationship. medical_record_number is redundant with mpi_record.mrn.',
    `date_of_birth` DATE COMMENT 'pii_phi,pii_sensitive',
    `death_cause` STRING COMMENT 'Medical cause of death as recorded.',
    `death_certificate_number` STRING COMMENT 'Identifier of the official death certificate.',
    `death_date` DATE COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `death_manner` STRING COMMENT 'Legal classification of death (e.g., natural, accidental).',
    `education_level` STRING COMMENT 'Highest level of education attained by the patient.',
    `email_address` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in an emergency.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `emergency_contact_relationship` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `employment_status` STRING COMMENT 'Current employment condition of the patient.',
    `ethnicity` STRING COMMENT 'Patients self‑reported ethnicity.',
    `first_name` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `food_insecurity_flag` BOOLEAN COMMENT 'Indicates whether the patient experiences food insecurity.',
    `gender_identity` STRING COMMENT 'Self‑identified gender of the patient.. Valid values are `male|female|nonbinary|other`',
    `home_address_line1` STRING COMMENT 'First line of the patients residential address.',
    `home_city` STRING COMMENT 'City component of the residential address.',
    `home_country` STRING COMMENT 'Three‑letter country code of the residential address.',
    `home_state` STRING COMMENT 'State/Province component of the residential address.',
    `home_zip` STRING COMMENT 'Postal code for the residential address.',
    `housing_status` STRING COMMENT 'Patients current housing situation (e.g., stable, temporary, homeless).',
    `income_bracket` STRING COMMENT 'Annual household income range for the patient.',
    `insurance_policy_number` STRING COMMENT 'add pii_phi,pii_pii,pii_sensitive',
    `is_deceased` BOOLEAN COMMENT 'Indicates whether the patient is deceased.',
    `language_barrier_flag` BOOLEAN COMMENT 'Indicates whether language barriers affect the patient’s care.',
    `last_name` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `mailing_address_line1` STRING COMMENT 'First line of the patients mailing address.',
    `mailing_city` STRING COMMENT 'City component of the mailing address.',
    `mailing_country` STRING COMMENT 'Three‑letter country code of the mailing address.',
    `mailing_state` STRING COMMENT 'State/Province component of the mailing address.',
    `mailing_zip` STRING COMMENT 'Postal code for the mailing address.',
    `marital_status` STRING COMMENT 'Current marital status of the patient.. Valid values are `single|married|divorced|widowed|separated|partnered`',
    `national_identifier` STRING COMMENT 'Added pii_phi, pii_pii, pii_sensitive tags to attribute.',
    `preferred_language` STRING COMMENT 'Language the patient prefers for communication.',
    `primary_phone` STRING COMMENT 'Main telephone number for patient contact.',
    `race` STRING COMMENT 'Patients self‑reported race.',
    `record_audit_created` TIMESTAMP COMMENT 'Date‑time when the demographics record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date‑time of the most recent update to the demographics record.',
    `record_status` STRING COMMENT 'Current lifecycle status of the demographics record.. Valid values are `active|inactive|archived|pending`',
    `sex_assigned_at_birth` STRING COMMENT 'Biological sex recorded at birth.',
    `social_security_number` STRING COMMENT 'add pii_phi,pii_pii,pii_sensitive',
    `ssn` STRING COMMENT 'Adds pii classification tags for PHI attributes',
    `transportation_access_flag` BOOLEAN COMMENT 'Indicates whether the patient has reliable transportation to access care.',
    `medical_record_number` STRING COMMENT 'Unique identifier assigned to the patient within the health system.',
    `national_id` STRING COMMENT 'Country‑specific national identification number.',
    `primary_care_provider_id` BIGINT COMMENT 'Surrogate key of the patient’s designated primary care provider.',
    CONSTRAINT pk_demographics PRIMARY KEY(`demographics_id`)
) COMMENT 'Core patient demographic profile — legal name, date of birth, gender identity, sex assigned at birth, race, ethnicity, preferred language, marital status, religion, addresses (home, mailing, temporary, work with geocoding and SDOH census tract linkage), phone numbers, email, emergency contacts with authorization levels and healthcare proxy designations, deceased status (date, cause, manner of death, death certificate reference), and PHI-protected identity attributes. SSOT for patient identity attributes downstream of MPI, multi-address management, and emergency contact records. Supports population health outreach, EMTALA-compliant emergency contact access, vital statistics reporting, and population health stratification. Compliant with HIPAA PHI classification, CMS demographic data requirements, and aligned with HL7 FHIR Patient resource demographics elements. Sourced from EHR registration modules, ADT systems, and state vital records.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`address` (
    `address_id` BIGINT COMMENT 'System-generated unique identifier for each address record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility (hospital, clinic, etc.) associated with the address, if applicable.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient to whom this address belongs.',
    `address_description` STRING COMMENT 'Free‑form notes or description about the address (e.g., special delivery instructions).',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record.. Valid values are `active|inactive|deprecated`',
    `address_type` STRING COMMENT 'Classification of the address purpose (e.g., home, mailing, temporary, work, other).. Valid values are `home|mailing|temporary|work|other`',
    `census_tract` STRING COMMENT 'Census tract identifier used for SDOH analysis.',
    `city` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `country_code` STRING COMMENT 'Three‑letter ISO country code.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or district name for the address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created.',
    `do_not_mail_flag` BOOLEAN COMMENT 'Indicates that the patient has opted out of mail communications.',
    `effective_end_date` DATE COMMENT 'Date when the address ceased to be effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the address became effective for use.',
    `geocode_accuracy` STRING COMMENT 'Indicates the confidence level of the geocoding result.. Valid values are `high|medium|low`',
    `is_mailing` BOOLEAN COMMENT 'True if this address is used for mailing communications.',
    `is_primary` BOOLEAN COMMENT 'True if this address is the primary address for the patient or facility.',
    `is_temporary` BOOLEAN COMMENT 'True if the address is temporary (e.g., for a short‑term stay).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `line1` STRING COMMENT 'First line of the street address.',
    `line2` STRING COMMENT 'Second line of the street address (e.g., apartment, suite).',
    `line3` STRING COMMENT 'Optional third line of the street address.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `postal_code` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `^[0-9A-Z -]{3,10}$`',
    `source_record_reference` STRING COMMENT 'Unique identifier of the address record in the source system.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the address (e.g., Epic, Cerner).',
    `state` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `^[A-Z]{2}$`',
    `street` STRING COMMENT 'Add PII/PHI classification tags',
    `street_address` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the address record.',
    `validation_source` STRING COMMENT 'Origin of the validation result.. Valid values are `system|manual|third_party`',
    `validation_status` STRING COMMENT 'Result of address validation process.. Valid values are `valid|invalid|pending`',
    `zip_code` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `patient_id` BIGINT COMMENT 'Identifier of the patient to whom this address belongs.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility (hospital, clinic, etc.) associated with the address, if applicable.',
    `status` STRING COMMENT 'Current lifecycle status of the address record.. Valid values are `active|inactive|deprecated`',
    `source_record_id` STRING COMMENT 'Unique identifier of the address record in the source system.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Patient address records supporting multiple address types (home, mailing, temporary, work) with full address components, geocoding coordinates, county/census tract for SDOH analysis, address validation status, effective date ranges, and do-not-mail flags. Supports population health outreach, care gap closure, and SDOH stratification. Sourced from Epic and Cerner registration systems.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`insurance_coverage` (
    `insurance_coverage_id` BIGINT COMMENT 'System-generated unique identifier for the insurance coverage record.',
    `insurance_network_participation_id` BIGINT COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient (member) to whom this coverage applies.',
    `payer_id` BIGINT COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `benefit_limit_amount` DECIMAL(18,2) COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `benefit_limit_units` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `claim_submission_method` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.. Valid values are `EDI|Web|Phone|Fax`',
    `claim_submission_status` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.. Valid values are `allowed|denied|pending`',
    `cob_priority` STRING COMMENT 'Numeric priority for coordination of benefits when multiple coverages exist (1 = primary).',
    `copay_amount` DECIMAL(18,2) COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `coverage_notes` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `coverage_number` STRING COMMENT 'Removed boilerplate phrase "This column stores...".',
    `coverage_status` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.. Valid values are `active|inactive|terminated|pending`',
    `coverage_type` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.. Valid values are `medical|dental|vision|rx|mental_health`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the coverage record was first created in the system.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `effective_from` DATE COMMENT 'Date when the coverage becomes active and eligible for claims.',
    `effective_until` DATE COMMENT 'Date when the coverage ends or is no longer in effect (null for open‑ended).',
    `eligibility_details` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `group_number` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this coverage is the primary payer for the patient.',
    `member_number` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `plan_name` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `plan_type` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.. Valid values are `HMO|PPO|POS|Medicare|Medicaid|Self-Pay`',
    `pre_auth_required` BOOLEAN COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `prior_auth_requirement` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.. Valid values are `required|not_required|conditional`',
    `sdoh_z_code` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `subscriber_relationship` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.. Valid values are `self|spouse|child|parent|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the coverage record.',
    `verification_source` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `verification_status` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.. Valid values are `verified|unverified|pending|failed`',
    `verification_timestamp` TIMESTAMP COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient (member) to whom this coverage applies.',
    `member_id` STRING COMMENT 'Identifier assigned by the payer to the covered individual (often the same as the insurance card number).',
    `network_id` BIGINT COMMENT 'Identifier of the payer network (e.g., in‑network, out‑of‑network) applicable to this coverage.',
    CONSTRAINT pk_insurance_coverage PRIMARY KEY(`insurance_coverage_id`)
) COMMENT 'Patient insurance coverage, eligibility, and verification records. Captures payer name, plan name, plan type (HMO, PPO, POS, Medicare, Medicaid, self-pay), member ID, group number, subscriber relationship, coverage effective and termination dates, coordination of benefits (COB) priority, copay/deductible/out-of-pocket amounts, pre-authorization requirements, and real-time/batch eligibility verification transactions (270/271 EDI, portal, phone) with verification status, confirmed coverage details, verification date/time, payer queried, and verification audit trail. SSOT for patient payer eligibility and verification consumed by billing and claims domains. Supports front-end RCM workflows, claim denial prevention, and prior authorization management. Aligned with X12 270/271 transaction standards and HL7 FHIR Coverage resource. Sourced from EHR revenue cycle and eligibility verification modules.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`guarantor` (
    `guarantor_id` BIGINT COMMENT 'System-generated unique identifier for the guarantor record.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom this guarantor is responsible.',
    `address_line1` STRING COMMENT 'Primary street address of the guarantor.',
    `address_line2` STRING COMMENT 'Secondary address information (apartment, suite, etc.).',
    `address_verified` BOOLEAN COMMENT 'True if the guarantors mailing address has been validated.',
    `city` STRING COMMENT 'City component of the guarantors mailing address.',
    `collection_status` STRING COMMENT 'Current status of the guarantors outstanding balances in the collection process.. Valid values are `current|delinquent|written_off|in_collection`',
    `country` STRING COMMENT 'ISO‑3 country code of the guarantors address.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the guarantor record was first created.',
    `credit_rating` STRING COMMENT 'Qualitative credit rating derived from the credit score.. Valid values are `excellent|good|fair|poor|unknown`',
    `credit_score` STRING COMMENT 'Numerical credit score used for risk assessment of the guarantor.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `demographic_age` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `demographic_gender` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `effective_from` DATE COMMENT 'Date when the guarantors responsibility becomes effective.',
    `effective_until` DATE COMMENT 'Date when the guarantors responsibility ends (null for open‑ended).',
    `email_address` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_verified` BOOLEAN COMMENT 'True if the guarantors email address has been validated.',
    `employer_contact` STRING COMMENT 'Contact information (phone or email) for the guarantors employer.',
    `employer_name` STRING COMMENT 'Name of the guarantors employer, if applicable.',
    `guarantor_name` STRING COMMENT 'Legal full name of the guarantor (individual or organization).',
    `guarantor_status` STRING COMMENT 'Lifecycle status of the guarantor record.. Valid values are `active|inactive|suspended|closed`',
    `guarantor_type` STRING COMMENT 'Indicates whether the guarantor is a natural person or a legal entity.. Valid values are `individual|organization`',
    `is_primary_guarantor` BOOLEAN COMMENT 'Indicates whether this guarantor is the primary financial responsibility for the patient.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment made by the guarantor.',
    `legal_entity_name` STRING COMMENT 'Registered legal name of the guarantor organization.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the guarantor.',
    `payment_method` STRING COMMENT 'Guarantors preferred method for making payments.. Valid values are `check|credit_card|bank_transfer|online|cash`',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30, Due on receipt).',
    `phone_number` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `phone_verified` BOOLEAN COMMENT 'True if the guarantors phone number has been validated.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the guarantors mailing address.',
    `relationship_to_patient` STRING COMMENT 'Describes the legal relationship between guarantor and patient.. Valid values are `self|spouse|parent|child|guardian|other`',
    `responsibility_percentage` DECIMAL(18,2) COMMENT 'Portion of the total patient balance for which the guarantor is liable, expressed as a percentage.',
    `ssn_masked` STRING COMMENT 'Add tags pii_phi, pii_pii, pii_sensitive to attribute.',
    `state` STRING COMMENT 'State or province component of the guarantors mailing address.',
    `tax_exempt` BOOLEAN COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `tax_identifier` STRING COMMENT 'Tax ID (e.g., EIN for organizations) associated with the guarantor.',
    `total_responsibility_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount the guarantor is liable for.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the guarantor record.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient for whom this guarantor is responsible.',
    `tax_id` STRING COMMENT 'Tax ID (e.g., EIN for organizations) associated with the guarantor.',
    CONSTRAINT pk_guarantor PRIMARY KEY(`guarantor_id`)
) COMMENT 'Financial guarantor record identifying the individual or entity responsible for patient account balances. Captures guarantor name, relationship to patient, address, phone, employer information, SSN (masked), and account responsibility percentage. Supports RCM billing workflows, patient financial counseling, and self-pay collection processes. Sourced from EHR revenue cycle and patient accounting modules.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`emergency_contact` (
    `emergency_contact_id` BIGINT COMMENT 'Unique surrogate key for the emergency contact record.',
    `alternate_contact_emergency_contact_id` BIGINT COMMENT 'Reference to an alternate emergency contact for redundancy.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient to whom this emergency contact is associated.',
    `address_line1` STRING COMMENT 'First line of the emergency contacts street address.',
    `address_line2` STRING COMMENT 'Second line of the address, if applicable.',
    `authorization_level` STRING COMMENT 'Level of authority granted to the contact regarding patient health information.. Valid values are `phi|healthcare_proxy|legal_guardian|none`',
    `authorized_to_receive_phi` BOOLEAN COMMENT 'Indicates whether the contact is authorized to receive protected health information.',
    `city` STRING COMMENT 'City of the emergency contacts address.',
    `consent_expiration_date` DATE COMMENT 'Date when the consent for this contact expires, if applicable.',
    `consent_given_date` DATE COMMENT 'Date when the patient gave consent for this contact to be used.',
    `contact_type` STRING COMMENT 'Indicates whether the contact is personal (family/friend) or professional (legal representative).. Valid values are `personal|professional|other`',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the emergency contacts address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emergency contact record was created.',
    `deceased_date` DATE COMMENT 'Date of death of the emergency contact, if applicable.',
    `effective_from` DATE COMMENT 'Date from which this emergency contact record is considered effective.',
    `effective_until` DATE COMMENT 'Date until which this emergency contact record remains effective; null if indefinite.',
    `email` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `email_address` STRING COMMENT 'Primary email address for contacting the emergency contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `emergency_contact_status` STRING COMMENT 'Current status of the emergency contact record.. Valid values are `active|inactive|pending|deceased`',
    `full_name` STRING COMMENT 'Legal full name of the emergency contact person.',
    `is_deceased` BOOLEAN COMMENT 'Indicates whether the emergency contact is deceased.',
    `is_primary_contact` BOOLEAN COMMENT 'Flag indicating if this contact is the primary emergency contact for the patient.',
    `language_preference` STRING COMMENT 'Preferred language for communication with the emergency contact.. Valid values are `en|es|fr|de|zh|other`',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact information was last verified for accuracy.',
    `notes` STRING COMMENT 'Free-text notes regarding the emergency contact (e.g., special instructions).',
    `phone_home` STRING COMMENT 'Home telephone number of the emergency contact.. Valid values are `^[2-9]d{2}[2-9]d{2}d{4}$`',
    `phone_mobile` STRING COMMENT 'Mobile telephone number of the emergency contact.. Valid values are `^[2-9]d{2}[2-9]d{2}d{4}$`',
    `phone_number` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `phone_work` STRING COMMENT 'Work telephone number of the emergency contact.. Valid values are `^[2-9]d{2}[2-9]d{2}d{4}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code of the emergency contacts address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `preferred_contact_method` STRING COMMENT 'Preferred method to contact the emergency contact.. Valid values are `phone|email|mail|sms`',
    `priority_order` STRING COMMENT 'Rank indicating the order in which contacts should be used (1 = highest priority).',
    `relationship_to_patient` STRING COMMENT 'Nature of the relationship between the emergency contact and the patient. [ENUM-REF-CANDIDATE: spouse|parent|child|sibling|friend|legal_guardian|other — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Originating system that supplied the emergency contact data.. Valid values are `Epic|Cerner|Other`',
    `source_system_code` STRING COMMENT 'Identifier of the record in the source system.',
    `state_province` STRING COMMENT 'State or province of the emergency contacts address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the emergency contact record.',
    `verification_status` STRING COMMENT 'Current verification status of the contact information.. Valid values are `verified|unverified|pending`',
    `patient_id` BIGINT COMMENT 'Identifier of the patient to whom this emergency contact is associated.',
    `status` STRING COMMENT 'Current status of the emergency contact record.. Valid values are `active|inactive|pending|deceased`',
    `source_system_id` STRING COMMENT 'Identifier of the record in the source system.',
    `alternate_contact_id` BIGINT COMMENT 'Reference to an alternate emergency contact for redundancy.',
    CONSTRAINT pk_emergency_contact PRIMARY KEY(`emergency_contact_id`)
) COMMENT 'Patient emergency contact records capturing contact name, relationship type, priority order, phone numbers (home, mobile, work), address, and authorization level (e.g., authorized to receive PHI, healthcare proxy, legal guardian). Supports EMTALA compliance, care coordination, and discharge planning workflows. Sourced from Epic and Cerner registration modules.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_assessment` (
    `sdoh_assessment_id` BIGINT COMMENT 'Unique surrogate key for each SDOH assessment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who conducted the assessment.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient who completed the assessment.',
    `assessment_date` DATE COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `assessment_location` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `assessment_status` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `pending|in_progress|completed|cancelled`',
    `assessment_type` STRING COMMENT 'Classification of the assessment (e.g., initial, follow_up, annual, ad_hoc).',
    `assessor_role` STRING COMMENT 'Professional role of the assessor.. Valid values are `social_worker|case_manager|nurse|counselor`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `external_assessment_reference` STRING COMMENT 'Business identifier assigned by the source system for the assessment (e.g., encounter number).',
    `financial_strain_score` DECIMAL(18,2) COMMENT 'Score for the financial strain domain.',
    `food_insecurity_score` DECIMAL(18,2) COMMENT 'Score for the food insecurity domain.',
    `housing_instability_score` DECIMAL(18,2) COMMENT 'Score for the housing instability domain.',
    `identified_needs` STRING COMMENT 'Free‑text description of patient‑identified social needs.',
    `interpersonal_safety_score` DECIMAL(18,2) COMMENT 'Score for the interpersonal safety domain.',
    `notes` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk score summarizing the patients SDOH burden.',
    `patient_consent` BOOLEAN COMMENT 'Indicates whether the patient consented to share SDOH information with external partners.',
    `reassessment_due_date` DATE COMMENT 'Scheduled date for the next SDOH reassessment.',
    `referral_date` DATE COMMENT 'Date the referral was made.',
    `referral_disposition` STRING COMMENT 'Outcome of any referral made as a result of the assessment.. Valid values are `referred|self_resolved|no_action|declined`',
    `screening_result` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `screening_tool` STRING COMMENT 'Standardized SDOH screening instrument used.. Valid values are `ahc_hrs|prapare|hunger_vital_sign|whoqol`',
    `social_isolation_score` DECIMAL(18,2) COMMENT 'Score for the social isolation domain.',
    `transportation_score` DECIMAL(18,2) COMMENT 'Score for the transportation domain.',
    `updated_by` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient who completed the assessment.',
    `external_assessment_id` STRING COMMENT 'Business identifier assigned by the source system for the assessment (e.g., encounter number).',
    `referral_resource_id` BIGINT COMMENT 'Identifier of the community resource to which the patient was referred.',
    `assessor_id` BIGINT COMMENT 'Identifier of the staff member who conducted the assessment.',
    `created_by` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    CONSTRAINT pk_sdoh_assessment PRIMARY KEY(`sdoh_assessment_id`)
) COMMENT 'Social Determinants of Health (SDOH) assessment records capturing screening tool used (AHC HRSN, PRAPARE, Hunger Vital Sign, WHO WHOQOL), assessment date, domain scores (food insecurity, housing instability, transportation, interpersonal safety, financial strain, social isolation), identified needs, referral disposition, and reassessment schedule. Supports population health management, ACO quality reporting, CMS SDOH initiatives, and community health needs assessments. Aligned with HL7 FHIR SDOH Clinical Care implementation guide and Gravity Project value sets. Sourced from population health and care management platforms.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique identifier for the patient preference record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the patient’s primary care provider.',
    `emergency_contact_id` BIGINT COMMENT 'FK to patient.emergency_contact',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient to whom these preferences apply.',
    `pharmacy_location_id` BIGINT COMMENT 'Identifier of the pharmacy the patient prefers for medication dispensing.',
    `accessibility_needs` STRING COMMENT 'Specific accessibility accommodations required by the patient (e.g., hearing aid, wheelchair access).',
    `care_setting_preference` STRING COMMENT 'Preferred setting for receiving care.. Valid values are `inpatient|outpatient|telehealth|home|rehab`',
    `consent_for_marketing` BOOLEAN COMMENT 'Indicates if patient consents to receive marketing communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the preference record was initially created.',
    `cultural_preference` STRING COMMENT 'Cultural considerations influencing care delivery.',
    `interpreter_needed` BOOLEAN COMMENT 'Indicates whether the patient requires an interpreter for clinical interactions.',
    `language_proficiency_level` STRING COMMENT 'Patients proficiency in the preferred language.. Valid values are `basic|conversational|fluent|native`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the preference record.',
    `notes` STRING COMMENT 'Free-text notes regarding special considerations or comments about the patient’s preferences.',
    `opt_out_sms` BOOLEAN COMMENT 'Indicates if patient has opted out of SMS messages.',
    `patient_bigint_surrogate_key_for_clean_keying` BIGINT COMMENT 'FK to patient.mpi_record.BIGINT surrogate key for clean keying',
    `portal_enrollment_status` STRING COMMENT 'Current enrollment status of the patient in the online portal.. Valid values are `enrolled|not_enrolled|pending`',
    `preference_bigint_surrogate_key_for_clean_keying` BIGINT COMMENT 'FK to patient.mpi_record.BIGINT surrogate key for clean keying',
    `preference_category` STRING COMMENT 'High-level category of the preference.. Valid values are `communication|pharmacy|accessibility|cultural|religious`',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference record.. Valid values are `active|inactive|pending|archived`',
    `preferred_communication_channel` STRING COMMENT 'Primary channel the patient prefers for receiving communications.. Valid values are `phone|email|portal|mail|text`',
    `preferred_contact_time` TIMESTAMP COMMENT 'Typical time of day the patient prefers to be contacted.',
    `preferred_language` STRING COMMENT 'Language the patient prefers for communication and care delivery. [ENUM-REF-CANDIDATE: English|Spanish|Mandarin|French|Arabic|Hindi|Other — promote to reference product]',
    `preferred_notification_method` STRING COMMENT 'Method preferred for notifications about appointments, results, etc.. Valid values are `email|sms|phone|mail`',
    `religious_preference` STRING COMMENT 'Religious practices that affect care decisions.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient to whom these preferences apply.',
    `patient_name` STRING COMMENT 'Legal full name of the patient.',
    `preferred_pharmacy_id` BIGINT COMMENT 'Identifier of the pharmacy the patient prefers for medication dispensing.',
    `primary_care_provider_id` BIGINT COMMENT 'Identifier of the patient’s primary care provider.',
    `emergency_contact_name` STRING COMMENT 'Name of the emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact.',
    `email_address` STRING COMMENT 'Primary email address for patient communications.',
    `phone_number` STRING COMMENT 'Primary phone number for patient communications.',
    `status` STRING COMMENT 'Current lifecycle status of the preference record.. Valid values are `active|inactive|pending|archived`',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Patient care and communication preferences capturing preferred language for care, interpreter needs, preferred communication channel (phone, portal, mail, text), preferred pharmacy, PCP preference, care setting preferences, accessibility needs (hearing, vision, mobility), cultural and religious care preferences, and patient portal enrollment status. Supports patient-centered care delivery, CAHPS survey performance, and health equity initiatives. Sourced from EHR registration and patient engagement platforms.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`pcp_attribution` (
    `pcp_attribution_id` BIGINT COMMENT 'System-generated unique identifier for the PCP attribution record.',
    `attribution_panel_id` BIGINT COMMENT 'Foreign key linking to patient.attribution_panel. Business justification: PCP attribution references an attribution panel definition. The existing attribution_panel STRING column becomes redundant when replaced by the FK to the attribution_panel reference table.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient (e.g., MRN) to which the attribution applies.',
    `attribution_confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence (0‑100) indicating the reliability of the attribution assignment.',
    `attribution_effective_end_date` DATE COMMENT 'Date when the attribution ends or is superseded (null if open‑ended).',
    `attribution_effective_start_date` DATE COMMENT 'Date when the attribution becomes effective for the patient.',
    `attribution_method` STRING COMMENT 'Method used to determine the attribution (claims‑based, enrollment‑based, manual assignment, or algorithmic model).. Valid values are `claims|enrollment|manual|algorithmic`',
    `attribution_source` STRING COMMENT 'Source system or feed that supplied the attribution data (e.g., Epic, Salesforce Health Cloud).',
    `attribution_status` STRING COMMENT 'Current lifecycle status of the attribution record.. Valid values are `active|inactive|pending|terminated`',
    `attribution_type` STRING COMMENT 'Classification of the attribution relationship (primary, secondary, or shared).. Valid values are `primary|secondary|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the attribution record was first created in the system.',
    `notes` STRING COMMENT 'Free‑text comments or notes regarding the attribution.',
    `plan_type` STRING COMMENT 'Type of health plan under which the attribution is recorded.. Valid values are `ACO|HMO|PPO|POS|Medicaid|Medicare`',
    `provider_npi` STRING COMMENT 'National Provider Identifier of the primary care provider to which the patient is attributed.',
    `reason_for_attribution` STRING COMMENT 'Business reason or rule that led to the patient being attributed to the provider.',
    `updated_by` STRING COMMENT 'User or process identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the attribution record.',
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient (e.g., MRN) to which the attribution applies.',
    `attribution_panel` STRING COMMENT 'Name of the attribution panel or cohort used for assignment.',
    `created_by` STRING COMMENT 'User or process identifier that created the attribution record.',
    CONSTRAINT pk_pcp_attribution PRIMARY KEY(`pcp_attribution_id`)
) COMMENT 'Patient attribution to Primary Care Physician (PCP) or care team records capturing attributed provider NPI, attribution method (claims-based, enrollment-based, manual), attribution panel, attribution effective and end dates, ACO/HMO/PPO plan attribution, and attribution confidence score. SSOT for care team assignment used in population health, HEDIS, MIPS, and value-based care reporting. Sourced from population health management and payer attribution feeds.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`eligibility_check` (
    `eligibility_check_id` BIGINT COMMENT 'System-generated unique identifier for the eligibility check transaction.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient for whom eligibility is being verified.',
    `payer_id` BIGINT COMMENT 'Unique identifier of the insurance payer.',
    `coinsurance_percent` DECIMAL(18,2) COMMENT 'Percentage of costs the patient shares after deductible is met.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed copayment amount the patient must pay for services.',
    `coverage_end_date` DATE COMMENT 'Effective end date of the patient’s coverage period returned by the payer.',
    `coverage_start_date` DATE COMMENT 'Effective start date of the patient’s coverage period returned by the payer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility check record was first created in the system.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount applicable to the patient’s coverage.',
    `eligibility_status` STRING COMMENT 'Result of the eligibility check indicating whether the patient is covered.. Valid values are `eligible|ineligible|pending|error`',
    `error_code` STRING COMMENT 'Standardized error code returned by the payer when the verification fails.',
    `error_message` STRING COMMENT 'Human‑readable description of the error returned by the payer.',
    `notes` STRING COMMENT 'Free‑form notes entered by staff regarding the eligibility verification.',
    `patient_address` STRING COMMENT 'Primary residential address of the patient.',
    `patient_dob` DATE COMMENT 'Date of birth of the patient.',
    `patient_mrn` STRING COMMENT 'Medical Record Number that uniquely identifies the patient within the health system.',
    `patient_name` STRING COMMENT 'Legal full name of the patient.',
    `patient_phone` STRING COMMENT 'Primary contact phone number for the patient.',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether a prior authorization is required for the service.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility request was sent to the payer.',
    `request_tracking_number` STRING COMMENT 'External or business identifier for the eligibility verification request.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility response was received from the payer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the eligibility check record.',
    `verification_method` STRING COMMENT 'Method used to perform the eligibility verification (e.g., EDI 270 transaction, web portal, phone call).. Valid values are `edi_270|portal|phone`',
    `verification_source_system` STRING COMMENT 'Source system that originated the eligibility request.. Valid values are `Epic|Cerner|Custom|Other`',
    `request_id` STRING COMMENT 'External or business identifier for the eligibility verification request.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient for whom eligibility is being verified.',
    `payer_name` STRING COMMENT 'Name of the insurance payer organization.',
    `benefit_plan_id` BIGINT COMMENT 'Identifier of the specific benefit plan under which coverage is provided.',
    `benefit_plan_name` STRING COMMENT 'Descriptive name of the benefit plan.',
    CONSTRAINT pk_eligibility_check PRIMARY KEY(`eligibility_check_id`)
) COMMENT 'Real-time and batch insurance eligibility verification transaction records capturing verification date and time, payer queried, verification method (270/271 EDI, portal, phone), eligibility status returned, coverage details confirmed, copay/deductible amounts verified, prior authorization requirements, and verification source system. Supports front-end RCM workflows and reduces claim denials. Sourced from Epic Resolute and Cerner Revenue Cycle eligibility modules.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`registration_event` (
    `registration_event_id` BIGINT COMMENT 'System-generated unique identifier for the registration event record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility where the registration took place.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who performed the registration.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient whose identity is being created or updated.',
    `completeness_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) indicating how complete the registration data is.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration event record was first captured in the lakehouse.',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the registration event occurred in the source system.',
    `identity_verification_method` STRING COMMENT 'Method used to verify patient identity during registration.. Valid values are `photo_id|insurance_card|biometric`',
    `is_test_event` BOOLEAN COMMENT 'Indicates whether the record is a test/synthetic event used for system validation.',
    `notes` STRING COMMENT 'Free‑form text field for additional comments or observations about the registration.',
    `patient_dob` DATE COMMENT 'Patients birth date, used for age‑based eligibility and reporting.',
    `patient_mrn` STRING COMMENT 'Enterprise‑wide medical record number assigned to the patient.',
    `registration_event_number` STRING COMMENT 'Human‑readable identifier assigned to the registration event (e.g., MRN‑REG‑20231015‑001).',
    `registration_event_status` STRING COMMENT 'Current lifecycle state of the registration event.. Valid values are `pending|completed|cancelled|merged|unmerged`',
    `registration_source` STRING COMMENT 'Origin of the registration request (e.g., emergency department walk‑in, scheduled appointment, inter‑facility transfer, online pre‑registration).. Valid values are `ed_walk_in|scheduled|transfer|online_pre_registration`',
    `registration_type` STRING COMMENT 'Category of registration activity (e.g., new patient, pre‑registration, record update, merge, unmerge).. Valid values are `new|pre_registration|update|merge|unmerge`',
    `source_system` STRING COMMENT 'Originating EHR or system that generated the registration event.. Valid values are `Epic|Cerner|MEDITECH|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this registration event record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient whose identity is being created or updated.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the registration took place.',
    `registration_staff_id` BIGINT COMMENT 'Identifier of the staff member who performed the registration.',
    `status` STRING COMMENT 'Current lifecycle state of the registration event.. Valid values are `pending|completed|cancelled|merged|unmerged`',
    CONSTRAINT pk_registration_event PRIMARY KEY(`registration_event_id`)
) COMMENT 'Patient registration lifecycle event records capturing event type (new registration, pre-registration, update, merge, unmerge), registration date and time, registering facility, registration source (ED walk-in, scheduled, transfer, online pre-registration), registration completeness score, identity verification method (photo ID, insurance card, biometric), and registration staff. Provides the audit trail for patient identity creation and maintenance events within the MPI lifecycle. Distinct from encounter-level ADT events — this product tracks identity/registration events, not clinical visit movements. Sourced from EHR ADT and registration modules.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`identity_merge_history` (
    `identity_merge_history_id` BIGINT COMMENT 'Surrogate primary key for each identity merge history record.',
    `employee_id` BIGINT COMMENT 'Identifier of the HIM analyst who approved the merge.',
    `primary_employee_id` BIGINT COMMENT 'System user identifier who performed the last update on the merge history record.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the merge was approved by the analyst.',
    `duplicate_count` STRING COMMENT 'Number of duplicate records identified in this merge operation.',
    `identity_label` STRING COMMENT 'Human-readable name of the patient (e.g., full legal name) associated with the surviving MRN.',
    `lifecycle_status` STRING COMMENT 'Current status of the patient identity record after merge.. Valid values are `active|merged|reversed|inactive`',
    `linked_records_count` STRING COMMENT 'Total number of related records (appointments, encounters, etc.) affected by the merge.',
    `merge_algorithm` STRING COMMENT 'Name of the algorithm or process used to determine duplicate records (e.g., deterministic, probabilistic).',
    `merge_batch_reference` BIGINT COMMENT 'Identifier for the batch process if merges are processed in bulk.',
    `merge_confidence_score` DECIMAL(18,2) COMMENT 'Confidence percentage (0-100) indicating certainty of the merge decision.',
    `merge_rationale` STRING COMMENT 'Free-text explanation of why the records were merged (e.g., duplicate MRN, name similarity).',
    `merge_timestamp` TIMESTAMP COMMENT 'Date and time when the merge operation was executed.',
    `merge_type` STRING COMMENT 'Indicates whether the merge was performed manually, automatically, or via predefined rule.. Valid values are `manual|automatic|rule_based`',
    `non_surviving_mrn` STRING COMMENT 'Medical Record Number(s) that were merged into the surviving MRN and deactivated.',
    `notes` STRING COMMENT 'Additional free-text comments or observations about the merge.',
    `patient_type` STRING COMMENT 'Classification of patient relationship (e.g., inpatient, outpatient).. Valid values are `inpatient|outpatient|emergency|telehealth`',
    `primary_contact` STRING COMMENT 'Primary contact method for the patient (e.g., phone number or email).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this merge history record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this merge history record.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates if the merge has been reversed (true) or not (false).',
    `reversal_reason` STRING COMMENT 'Explanation for why the merge was undone.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the merge was reversed, if applicable.',
    `source_system` STRING COMMENT 'Originating system of the merge event (e.g., Epic MPI, 3M CDI).',
    `surviving_mrn` STRING COMMENT 'Medical Record Number retained as the primary identifier after merge.',
    `approving_analyst_id` BIGINT COMMENT 'Identifier of the HIM analyst who approved the merge.',
    `audit_user_id` BIGINT COMMENT 'System user identifier who performed the last update on the merge history record.',
    `merge_batch_id` BIGINT COMMENT 'Identifier for the batch process if merges are processed in bulk.',
    CONSTRAINT pk_identity_merge_history PRIMARY KEY(`identity_merge_history_id`)
) COMMENT 'Patient identity merge and unmerge history records tracking MPI overlay events, duplicate patient record resolution, surviving and non-surviving MRNs, merge rationale, merge algorithm used, merge confidence score, approving HIM analyst, merge date, and reversal history. Critical for MPI integrity, HIPAA compliance, and audit trail requirements. Sourced from Epic MPI management and 3M HIS tools.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`flag` (
    `flag_id` BIGINT COMMENT 'Unique identifier for the patient flag record.',
    `behavioral_health_psychiatric_assessment_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.psychiatric_assessment. Business justification: Clinical safety workflow: when psychiatric assessment identifies suicide/violence risk, a patient flag is created referencing the source assessment. Required for Joint Commission safety alert document',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.sud_episode. Business justification: Patient flags for active substance use disorder or relapse risk reference the SUD episode. Supports clinical decision support alerts, ED notifications, and controlled substance prescribing safety chec',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Clinical decision support: patient flags (e.g., high readmission risk, sepsis alert) are generated from AI risk scores. Linking enables clinicians to review the underlying prediction, supports CDS aud',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who created or confirmed the flag.',
    `mpi_record_id` BIGINT COMMENT 'Unique patient identifier (e.g., MRN) to which the flag applies.',
    `visit_id` BIGINT COMMENT 'Encounter during which the flag was initially raised, if applicable.',
    `sdoh_referral_id` BIGINT COMMENT 'Identifier of the SDOH referral record linked to the flag.',
    `alert_code` STRING COMMENT 'Standardized code (e.g., SNOMED, LOINC) representing the alert type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the flag record was first created.',
    `expiration_date` DATE COMMENT 'Date when the flag is scheduled to expire or be reviewed.',
    `flag_category` STRING COMMENT 'Broad classification of the flag for reporting and analytics.. Valid values are `clinical|administrative|financial|safety|legal|sdoh`',
    `flag_code` STRING COMMENT 'System‑generated code uniquely identifying the flag type.',
    `flag_description` STRING COMMENT 'Detailed description of the flag, including clinical or administrative details.',
    `flag_name` STRING COMMENT 'Human‑readable name of the flag (e.g., "Fall Risk").',
    `flag_status` STRING COMMENT 'Current lifecycle status of the flag.. Valid values are `active|inactive|resolved`',
    `flag_type` STRING COMMENT 'Specific type of flag indicating the condition or concern.. Valid values are `allergy|fall_risk|behavioral|financial|language|infection_precaution`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the flag was last reviewed by clinical staff.',
    `need_closure` BOOLEAN COMMENT 'Indicates whether the flag requires a formal closure process.',
    `onset_date` DATE COMMENT 'Date when the flag became effective for the patient.',
    `priority_level` STRING COMMENT 'Operational priority for addressing the flag.. Valid values are `routine|urgent|emergency`',
    `resolution_notes` STRING COMMENT 'Notes describing how the flag was resolved or mitigated.',
    `review_status` STRING COMMENT 'Current review state of the flag.. Valid values are `pending|reviewed|closed`',
    `sdhz_code` STRING COMMENT 'Z‑code or other classification for the SDOH referral associated with the flag.',
    `severity` STRING COMMENT 'Severity level of the flag indicating risk or impact.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating EHR or system that generated the flag.. Valid values are `Epic|Cerner|Meditech|Custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the flag record.',
    `patient_id` BIGINT COMMENT 'Unique patient identifier (e.g., MRN) to which the flag applies.',
    `description` STRING COMMENT 'Detailed description of the flag, including clinical or administrative details.',
    `flagged_by_provider_id` BIGINT COMMENT 'Identifier of the provider who created or confirmed the flag.',
    `related_encounter_id` BIGINT COMMENT 'Encounter during which the flag was initially raised, if applicable.',
    `sdhz_referral_id` BIGINT COMMENT 'Identifier of the SDOH referral record linked to the flag.',
    `community_resource_id` BIGINT COMMENT 'Identifier of the community resource or service referenced for the flag.',
    CONSTRAINT pk_flag PRIMARY KEY(`flag_id`)
) COMMENT 'Patient-level clinical and administrative alert flags capturing flag type (VIP, behavioral alert, fall risk, latex allergy, infectious precaution, financial hardship, interpreter needed, AMA history, legal hold, safety risk), flag severity, flag description, onset and expiration dates, flagging provider or staff, and active status. Persistent patient-level flags that travel with the patient across encounters — distinct from encounter-specific clinical alerts. Supports safe care delivery, staff safety, and administrative workflows across all care settings. Sourced from EHR clinical alert and patient safety systems.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`population_segment` (
    `population_segment_id` BIGINT COMMENT 'Unique surrogate key for each population segment record.',
    `community_resource_id` BIGINT COMMENT 'Identifier of the community resource linked to the segment for SDOH interventions.',
    `avg_age` DECIMAL(18,2) COMMENT 'Mean age of patients in the segment.',
    `care_gap_count` STRING COMMENT 'Number of evidence‑based care gaps identified for the segment.',
    `chf_flag` BOOLEAN COMMENT 'True if the segment includes patients with CHF.',
    `ckd_flag` BOOLEAN COMMENT 'True if the segment includes patients with CKD.',
    `copd_flag` BOOLEAN COMMENT 'True if the segment includes patients with COPD.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the segment record was first created in the data lake.',
    `diabetes_flag` BOOLEAN COMMENT 'True if the segment includes patients with diabetes.',
    `effective_end_date` DATE COMMENT 'Date when the segment definition is retired; null for open‑ended segments.',
    `effective_start_date` DATE COMMENT 'Date when the segment definition becomes operational for analytics.',
    `last_stratification_date` DATE COMMENT 'Date when the segment was most recently calculated.',
    `model_version` STRING COMMENT 'Version identifier of the segmentation model used.',
    `need_closure_date` DATE COMMENT 'Target date by which identified SDOH needs should be resolved.',
    `percent_female` DECIMAL(18,2) COMMENT 'Proportion of female patients (0‑100).',
    `percent_male` DECIMAL(18,2) COMMENT 'Proportion of male patients (0‑100).',
    `percent_medicaid` DECIMAL(18,2) COMMENT 'Share of patients covered by Medicaid.',
    `percent_medicare` DECIMAL(18,2) COMMENT 'Share of patients covered by Medicare.',
    `percent_private_insurance` DECIMAL(18,2) COMMENT 'Share of patients with private payer coverage.',
    `population_segment_status` STRING COMMENT 'Current lifecycle status of the segment.. Valid values are `active|inactive|retired`',
    `population_size` BIGINT COMMENT 'Count of distinct patients assigned to the segment.',
    `referral_management_status` STRING COMMENT 'Current status of SDOH referrals associated with the segment.. Valid values are `pending|in_progress|completed|closed`',
    `region_code` STRING COMMENT 'Broad geographic region of the segment.. Valid values are `NORTHEAST|MIDWEST|SOUTH|WEST`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score for the segment (e.g., 0.00 – 99.99).',
    `risk_score_date` DATE COMMENT 'Date on which the risk score was generated.',
    `risk_score_method` STRING COMMENT 'Algorithmic approach used for risk scoring.. Valid values are `logistic|gradient_boost|neural_network|rule_based`',
    `risk_score_source` STRING COMMENT 'Model or methodology used to generate the risk score.. Valid values are `cms_hcc|acg|proprietary`',
    `risk_tier` STRING COMMENT 'Risk tier derived from the risk score (e.g., low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `sdhz_zcode` STRING COMMENT 'ICD‑10‑CM Z‑code representing social determinants of health for the segment.',
    `segment_category` STRING COMMENT 'Higher‑level category indicating the primary data domain of the segment.. Valid values are `clinical|administrative|sdoh|combined`',
    `segment_creation_source` STRING COMMENT 'System or process that originated the segment definition.. Valid values are `epic|cerner|manual|external`',
    `segment_description` STRING COMMENT 'Free‑text description of the segment purpose and criteria.',
    `segment_last_updated_by` STRING COMMENT 'User or service identifier that performed the most recent update.',
    `segment_name` STRING COMMENT 'Human‑readable name describing the segment (e.g., "Diabetes High‑Risk Cohort").',
    `segment_retention_policy` STRING COMMENT 'Data retention rule applied to the segment per HIPAA and organizational policy.. Valid values are `retain_7_years|retain_10_years|retain_indefinite`',
    `segment_type` STRING COMMENT 'Broad classification of the segment based on risk or disease focus.. Valid values are `chronic|high_risk|rising_risk|healthy`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the segment record.',
    `zip_code_prefix` STRING COMMENT 'First three digits of patient ZIP codes for geographic aggregation.',
    `status` STRING COMMENT 'Current lifecycle status of the segment.. Valid values are `active|inactive|retired`',
    CONSTRAINT pk_population_segment PRIMARY KEY(`population_segment_id`)
) COMMENT 'Patient population segmentation and risk stratification records capturing segment type (chronic disease cohort, high-risk, rising-risk, healthy), risk tier, risk score source (CMS HCC, ACG, proprietary), attributed care program, chronic condition flags (diabetes, CHF, COPD, CKD), care gap count, last stratification date, and stratification model version. Supports population health management, ACO performance, and HEDIS measure targeting. Sourced from Epic Healthy Planet.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`care_program_enrollment` (
    `care_program_enrollment_id` BIGINT COMMENT 'Unique surrogate key for each care program enrollment record.',
    `care_plan_id` BIGINT COMMENT 'Reference to the detailed care plan associated with this enrollment.',
    `care_program_id` BIGINT COMMENT 'FK to patient.care_program',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Risk-stratified enrollment process: care programs enroll patients based on AI risk scores. Linking the qualifying risk score enables audit of enrollment criteria, regulatory reporting, and program ROI',
    `clinician_id` BIGINT COMMENT 'Identifier of the care manager responsible for the patient within the program.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient enrolled in the care program, as stored in the Master Patient Index.',
    `care_gap_count` STRING COMMENT 'Number of identified care gaps for the patient at enrollment time.',
    `chf_flag` BOOLEAN COMMENT 'Indicates whether the patient has a documented diagnosis of congestive heart failure.',
    `ckd_flag` BOOLEAN COMMENT 'Indicates whether the patient has a documented diagnosis of chronic kidney disease.',
    `copd_flag` BOOLEAN COMMENT 'Indicates whether the patient has a documented diagnosis of chronic obstructive pulmonary disease.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `diabetes_flag` BOOLEAN COMMENT 'Indicates whether the patient has a documented diagnosis of diabetes.',
    `disenrollment_date` DATE COMMENT 'Date the patient was removed from the care program, if applicable.',
    `eligibility_criteria_version` STRING COMMENT 'Version of the eligibility rule set applied.',
    `enrollment_date` DATE COMMENT 'Date the patient was enrolled in the care program.',
    `enrollment_method` STRING COMMENT 'Method by which the patient was enrolled.. Valid values are `online|phone|in_person|referral|other`',
    `enrollment_notes` STRING COMMENT 'Free-text notes captured at enrollment regarding patient preferences, barriers, or special considerations.',
    `enrollment_number` STRING COMMENT 'External reference number for the enrollment used in reporting and communication.',
    `enrollment_reason` STRING COMMENT 'Reason why the patient was enrolled (e.g., high HbA1c, recent hospitalization).',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment request, indicating how the patient entered the program.. Valid values are `referral|internal|self|community|other`',
    `is_active` BOOLEAN COMMENT 'Indicates if the enrollment record is currently active (true) or inactive (false).',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the patient met eligibility criteria for the program at enrollment.',
    `is_high_priority` BOOLEAN COMMENT 'Indicates if the enrollment is flagged as high priority for care coordination.',
    `last_stratification_date` DATE COMMENT 'Date when the most recent risk stratification was performed for the patient.',
    `need_closure_status` STRING COMMENT 'sdoh_need_closure. Valid values are `open|closed|in_progress|blocked`',
    `outcome_measure_date` DATE COMMENT 'Date when the program outcome score was recorded.',
    `program_end_date` DATE COMMENT 'Scheduled end date of the care program for the patient.',
    `program_outcome_score` DECIMAL(18,2) COMMENT 'Aggregated outcome metric for the enrollment (e.g., improvement index), captured at program closure.',
    `program_start_date` DATE COMMENT 'Scheduled start date of the care program for the patient.',
    `program_status` STRING COMMENT 'Current status of the enrollment within the program lifecycle.. Valid values are `active|completed|withdrawn|expired|suspended|pending`',
    `program_type` STRING COMMENT 'Broad classification of the program type.. Valid values are `disease_specific|population|preventive|rehab|other`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score derived from the selected risk model.',
    `risk_score_source` STRING COMMENT 'Source of the risk score used for tier assignment.. Valid values are `cms_hcc|acg|proprietary|custom|other`',
    `risk_tier` STRING COMMENT 'Risk tier assigned to the patient based on stratification models, where Tier 1 is highest risk.. Valid values are `tier1|tier2|tier3|tier4|tier5|tier6`',
    `sdhz_code` STRING COMMENT 'Z-code representing the primary social determinant of health factor associated with the enrollment.. Valid values are `Z[0-9]{2}`',
    `segment_type` STRING COMMENT 'Categorization of the patient segment for enrollment, indicating the primary risk or disease cohort.. Valid values are `chronic|high_risk|rising_risk|healthy|other`',
    `strat_model_version` STRING COMMENT 'Version identifier of the risk stratification model used for this enrollment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient enrolled in the care program, as stored in the Master Patient Index.',
    `program_name` STRING COMMENT 'Name of the care management program (e.g., Diabetes Management, Heart Failure Reduction).',
    `assigned_care_manager_id` BIGINT COMMENT 'Identifier of the care manager responsible for the patient within the program.',
    `referral_id` BIGINT COMMENT 'Identifier of the referral that triggered the enrollment, if applicable.',
    `community_resource_id` BIGINT COMMENT 'Reference to the community resource (e.g., food bank, transportation service) assigned to the patient.',
    CONSTRAINT pk_care_program_enrollment PRIMARY KEY(`care_program_enrollment_id`)
) COMMENT 'Patient population health segmentation, risk stratification, and care program enrollment records. Captures segment type (chronic disease cohort, high-risk, rising-risk, healthy), risk tier, risk score source (CMS HCC, ACG, proprietary), chronic condition flags (diabetes, CHF, COPD, CKD), care gap count, stratification model version, last stratification date, program name, enrollment and disenrollment dates, program status, assigned care manager, care plan linkage, enrollment source, and program outcomes. SSOT for population health segmentation and care management program participation. Supports ACO performance, PCMH workflows, HEDIS measure targeting, chronic disease management, and value-based care reporting. Sourced from population health management platforms and care management systems.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`financial_assistance` (
    `financial_assistance_id` BIGINT COMMENT 'Unique surrogate key for each financial assistance application record.',
    `employee_id` BIGINT COMMENT 'Identifier of the case manager assigned to the patient’s assistance case.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who is requesting financial assistance.',
    `referral_id` BIGINT COMMENT 'Identifier of the referral record linked to this assistance request.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the requested amount (e.g., charity discount).',
    `application_date` TIMESTAMP COMMENT 'Timestamp when the patient submitted the assistance application.',
    `application_status` STRING COMMENT 'Current processing status of the assistance application.. Valid values are `submitted|under_review|approved|denied|withdrawn`',
    `approval_date` DATE COMMENT 'Date when the assistance application was approved.',
    `approved_assistance_amount` DECIMAL(18,2) COMMENT 'Dollar amount approved for the patient after eligibility review.',
    `assistance_application_number` STRING COMMENT 'External reference number assigned to the assistance application for tracking and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assistance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the requested amount.',
    `eligibility_flag` STRING COMMENT 'Indicates whether the patient meets eligibility criteria for the requested program.. Valid values are `eligible|ineligible|pending`',
    `eligibility_reason` STRING COMMENT 'Explanation why the patient was deemed eligible or ineligible.',
    `expiration_date` DATE COMMENT 'Date when the approved assistance benefit expires.',
    `federal_poverty_level_percentage` DECIMAL(18,2) COMMENT 'Patients income expressed as a percentage of the federal poverty level.',
    `income_verification_method` STRING COMMENT 'Method used to verify the patient’s income for eligibility.. Valid values are `paystub|tax_return|bank_statement|self_declaration|government_verification`',
    `need_closure_date` DATE COMMENT 'Date when the patient’s financial need was considered resolved.',
    `notes` STRING COMMENT 'Free‑text notes entered by staff regarding the assistance request.',
    `program_type` STRING COMMENT 'Category of financial assistance program applied for.. Valid values are `charity_care|medicaid_presumptive|sliding_fee_scale|payment_plan|financial_hardship`',
    `referral_source` STRING COMMENT 'Origin of the referral that triggered the assistance request.. Valid values are `internal|external|community|self`',
    `requested_assistance_amount` DECIMAL(18,2) COMMENT 'Total dollar amount the patient is requesting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assistance record.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient who is requesting financial assistance.',
    `community_resource_id` BIGINT COMMENT 'Identifier of the community resource or program providing supplemental support.',
    `case_manager_id` BIGINT COMMENT 'Identifier of the case manager assigned to the patient’s assistance case.',
    CONSTRAINT pk_financial_assistance PRIMARY KEY(`financial_assistance_id`)
) COMMENT 'Patient financial assistance and charity care application records capturing application date, assistance program type (charity care, Medicaid presumptive eligibility, sliding fee scale, payment plan, financial hardship), application status, income verification method, federal poverty level percentage, approved assistance amount or discount percentage, approval date, and expiration date. Supports RCM financial counseling, 501(c)(3) community benefit reporting, and uncompensated care tracking. Sourced from EHR revenue cycle and financial counseling modules.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`portal_account` (
    `portal_account_id` BIGINT COMMENT 'Unique surrogate key for the patient portal account record.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: A patient portal account belongs to a specific patient. patient_mrn is redundant since it can be retrieved via JOIN to mpi_record.',
    `access_level` STRING COMMENT 'Level of data access granted to the account holder or proxy.. Valid values are `full|limited|view_only`',
    `account_activation_date` DATE COMMENT 'Date when the portal account was first activated for use.',
    `account_creation_date` DATE COMMENT 'Date when the portal account record was initially created.',
    `account_deactivation_date` DATE COMMENT 'Date when the portal account was deactivated or closed.',
    `account_number` STRING COMMENT 'External business identifier assigned to the portal account, used for patient communication and support.',
    `account_type` STRING COMMENT 'Classifies the account holder: patient, proxy (parent/guardian), caregiver, or family member.. Valid values are `patient|proxy|caregiver|family_member`',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing significant audit events or manual adjustments to the portal account.',
    `authorization_end_date` DATE COMMENT 'Date when the portal accounts access rights expire.',
    `authorization_start_date` DATE COMMENT 'Date when the portal accounts access rights become effective.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the patient has provided consent for portal data sharing.',
    `consent_given_date` DATE COMMENT 'Date when the patient consented to portal access.',
    `consent_revoked` BOOLEAN COMMENT 'Indicates whether the patient has withdrawn consent for portal data sharing.',
    `consent_revoked_date` DATE COMMENT 'Date when the patient revoked consent.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the portal account record was first created in the system.',
    `digital_health_app_link` STRING COMMENT 'URL or identifier linking the portal account to a connected digital health application.',
    `effective_from` DATE COMMENT 'Date when the portal account became active.',
    `effective_until` DATE COMMENT 'Date when the portal account is scheduled to expire or be deactivated (null for open‑ended).',
    `email` STRING COMMENT 'Primary email address for portal communications and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `last_login_ip` STRING COMMENT 'IP address from which the most recent portal login originated.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful portal login.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the portal account record.',
    `legal_document_reference` STRING COMMENT 'Reference (e.g., document ID) to legal agreements authorizing portal access.',
    `messaging_opt_in` BOOLEAN COMMENT 'Indicates whether the account holder has opted in to receive portal messaging (email/SMS).',
    `phone_number` STRING COMMENT 'Primary telephone number for SMS alerts and two‑factor authentication.',
    `portal_account_status` STRING COMMENT 'Current lifecycle status of the portal account.. Valid values are `active|inactive|suspended|pending|closed`',
    `proxy_access_enabled` BOOLEAN COMMENT 'Flag indicating whether a proxy (e.g., parent, legal guardian) is authorized to act on behalf of the primary account holder.',
    `proxy_identifier` STRING COMMENT 'Unique identifier for the proxy user (e.g., employee ID, external system ID).',
    `proxy_type` STRING COMMENT 'Specifies the legal relationship of the proxy to the primary patient.. Valid values are `parent_guardian|adult_caregiver|legal_guardian|power_of_attorney`',
    `revocation_date` DATE COMMENT 'Date when portal access was revoked, if applicable.',
    `sdoh_need_closure_date` DATE COMMENT 'Target date by which the identified SDOH need should be resolved.',
    `sdoh_referral_status` STRING COMMENT 'Current status of the SDOH referral associated with the portal account.. Valid values are `referred|in_progress|closed|no_need`',
    `sdoh_risk_score` STRING COMMENT 'Numeric score (0‑100) indicating the overall social risk level for the patient.',
    `sdoh_z_codes` STRING COMMENT 'Pipe‑separated list of Z‑codes representing documented social determinants of health for the patient.',
    `two_factor_enabled` BOOLEAN COMMENT 'Indicates whether the account has two‑factor authentication activated.',
    `two_factor_enrolled_date` DATE COMMENT 'Date when the user successfully enrolled in two‑factor authentication.',
    `username` STRING COMMENT 'User‑chosen login name for the portal; may be email or alphanumeric handle.',
    `status` STRING COMMENT 'Current lifecycle status of the portal account.. Valid values are `active|inactive|suspended|pending|closed`',
    `patient_mrn` STRING COMMENT 'Unique patient identifier used across clinical systems; links the portal account to the patient master record.',
    `sdoh_community_resource_id` STRING COMMENT 'Identifier of the community resource assigned to address the SDOH need.',
    CONSTRAINT pk_portal_account PRIMARY KEY(`portal_account_id`)
) COMMENT 'Patient portal and digital engagement account record capturing portal platform, account creation date, activation status, last login date, two-factor authentication enrollment, proxy access grants (parent/guardian, adult caregiver, legal guardian, healthcare POA) with proxy identity, access levels (full, limited, view-only), authorization and expiration dates, revocation dates, supporting legal documentation references, messaging opt-in status, appointment self-scheduling enablement, and digital health app linkages. SSOT for patient digital engagement and proxy access management. Supports patient engagement, HIPAA-compliant proxy access, MIPS Promoting Interoperability measures, and digital front door strategy. Aligned with HL7 FHIR RelatedPerson resource for proxy relationships. Sourced from patient portal and proxy management systems.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`proxy_access` (
    `proxy_access_id` BIGINT COMMENT 'System-generated unique identifier for each proxy access record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the individual who is granted proxy access (e.g., MRN of the proxy).',
    `access_level` STRING COMMENT 'Scope of data and functionality the proxy is permitted to view or act upon.. Valid values are `full|limited|view_only`',
    `authorization_date` DATE COMMENT 'Date when the proxy access became effective.',
    `bigint_surrogate_key_for_clean_keying` BIGINT COMMENT 'Unique identifier of the patient for whom proxy access is granted.',
    `expiration_date` DATE COMMENT 'Date when the proxy access expires or is scheduled to terminate (null for open‑ended).',
    `legal_document_reference` STRING COMMENT 'Reference to the legal document (e.g., file name or storage URI) that authorizes the proxy relationship.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special instructions related to the proxy access.',
    `proxy_access_number` STRING COMMENT 'Human‑readable reference number assigned to the proxy access agreement.',
    `proxy_access_status` STRING COMMENT 'Current state of the proxy access agreement.. Valid values are `active|inactive|revoked|pending`',
    `proxy_email` STRING COMMENT 'Primary email address for contacting the proxy.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `proxy_name` STRING COMMENT 'Legal full name of the proxy individual.',
    `proxy_phone` STRING COMMENT 'Primary telephone number for the proxy.',
    `proxy_type` STRING COMMENT 'Category of proxy relationship indicating the legal or care role of the proxy.. Valid values are `parent_guardian|adult_caregiver|legal_guardian|healthcare_power_of_attorney`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the proxy access record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the proxy access record.',
    `revocation_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the proxy access was revoked, if applicable.',
    `proxy_person_id` BIGINT COMMENT 'Unique identifier of the individual who is granted proxy access (e.g., MRN of the proxy).',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient for whom proxy access is granted.',
    `status` STRING COMMENT 'Current state of the proxy access agreement.. Valid values are `active|inactive|revoked|pending`',
    CONSTRAINT pk_proxy_access PRIMARY KEY(`proxy_access_id`)
) COMMENT 'Patient proxy and authorized representative access records capturing proxy type (parent/guardian, adult caregiver, legal guardian, healthcare power of attorney), proxy identity, access level granted (full, limited, view-only), authorization date, expiration date, revocation date, and supporting legal documentation reference. Supports HIPAA-compliant proxy access management in patient portals and clinical settings. Sourced from Epic MyChart proxy management.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` (
    `mrn_crosswalk_id` BIGINT COMMENT 'Surrogate primary key for the MRN crosswalk record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or health system where the local MRN is assigned.',
    `mpi_record_id` BIGINT COMMENT 'Unique enterprise-wide identifier for the patient (master patient index).',
    `cerner_euid` STRING COMMENT 'Cerner system identifier for the patient.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the crosswalk record was first created.',
    `data_source_type` STRING COMMENT 'Method by which the identifier was obtained.. Valid values are `system|manual|import`',
    `effective_end_date` DATE COMMENT 'Date when the identifier mapping expires or is superseded (null if open-ended).',
    `effective_start_date` DATE COMMENT 'Date when the identifier mapping becomes valid.',
    `epic_empi_identifier` STRING COMMENT 'Epic EMPI identifier linking the patient across Epic modules.',
    `facility_mrn` STRING COMMENT 'Patients medical record number as assigned by the specific facility.',
    `hie_identifier` STRING COMMENT 'Identifier used by regional HIEs for patient matching.',
    `insurance_policy_number` STRING COMMENT 'Policy number linking the patient to a specific insurance contract.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this identifier is the primary MRN for the patient within the facility.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'When the identifier mapping was last verified against source systems.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Confidence percentage (0‑100) that the crosswalk mapping is correct.',
    `meditech_mrn` STRING COMMENT 'Patient MRN as stored in MEDITECH Expanse.',
    `mrn_bigint_surrogate_key_for_clean_keying` BIGINT COMMENT 'FK to patient.mpi_record.BIGINT surrogate key for clean keying',
    `notes` STRING COMMENT 'Free‑form comments or audit notes about the mapping.',
    `payer_member_number` STRING COMMENT 'Member ID assigned by the health insurer.',
    `primary_contact_method` STRING COMMENT 'Preferred channel to reach the patient for identifier updates.. Valid values are `phone|email|mail|portal`',
    `privacy_consent_flag` BOOLEAN COMMENT 'Indicates if patient consented to share this identifier across systems.',
    `record_status` STRING COMMENT 'Current lifecycle status of the crosswalk record.. Valid values are `active|inactive|deprecated|pending`',
    `source_system` STRING COMMENT 'Originating system that supplied the identifier.. Valid values are `Epic|Cerner|MEDITECH|HIE|Other`',
    `source_system_record_reference` STRING COMMENT 'Native primary key or unique ID from the source system.',
    `updated_by` STRING COMMENT 'User or process that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the crosswalk record.',
    `verification_status` STRING COMMENT 'Current verification state of the identifier mapping.. Valid values are `verified|unverified|failed`',
    `enterprise_patient_id` BIGINT COMMENT 'Unique enterprise-wide identifier for the patient (master patient index).',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or health system where the local MRN is assigned.',
    `epic_empi_id` STRING COMMENT 'Epic EMPI identifier linking the patient across Epic modules.',
    `payer_member_id` STRING COMMENT 'Member ID assigned by the health insurer.',
    `source_system_record_id` STRING COMMENT 'Native primary key or unique ID from the source system.',
    `patient_name` STRING COMMENT 'Legal full name of the patient for reference.',
    `created_by` STRING COMMENT 'User or process that created the record.',
    CONSTRAINT pk_mrn_crosswalk PRIMARY KEY(`mrn_crosswalk_id`)
) COMMENT 'Cross-facility and cross-system MRN (Medical Record Number) crosswalk table mapping a patients enterprise patient_id to facility-specific MRNs, EHR system identifiers (Epic EMPI, Cerner EUID), payer member IDs, and external HIE identifiers. Enables enterprise-wide patient matching and identity resolution across Epic, Cerner, MEDITECH, and HIE platforms. Sourced from MPI and ADT integration layers.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`communication_log` (
    `communication_log_id` BIGINT COMMENT 'Unique surrogate key for each communication log record.',
    `clinician_id` BIGINT COMMENT 'Internal surrogate identifier of the provider (clinician, staff) who originated the communication.',
    `communication_campaign_id` BIGINT COMMENT 'Identifier of the outreach campaign to which this communication belongs.',
    `employee_id` BIGINT COMMENT 'Internal identifier of the staff member or system that originated the communication.',
    `message_template_id` BIGINT COMMENT 'Identifier of the message template used to generate the communication content.',
    `mpi_record_id` BIGINT COMMENT 'Internal surrogate identifier of the patient involved in the communication.',
    `actual_timestamp` TIMESTAMP COMMENT 'Actual date and time the communication was transmitted or received.',
    `attachment_count` STRING COMMENT 'Number of attachments included with the communication.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether the communication includes one or more attachments.',
    `audit_trail` STRING COMMENT 'Free‑form log of audit events related to the communication (e.g., edits, re‑sends).',
    `body_text` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `channel` STRING COMMENT 'Medium used to deliver the communication: phone call, SMS, email, patient portal message, or postal mail.. Valid values are `phone|sms|email|portal|mail`',
    `communication_log_status` STRING COMMENT 'Current delivery state of the communication.. Valid values are `sent|delivered|failed|read|bounced`',
    `communication_timestamp` TIMESTAMP COMMENT 'Date and time when the communication event occurred (sent or received).',
    `communication_type` STRING COMMENT 'Category of the communication, e.g., appointment reminder, care gap notification, billing statement, post‑discharge follow‑up, survey.. Valid values are `reminder|notification|outreach|billing|post_discharge|survey`',
    `compliance_flag` STRING COMMENT 'Indicates the regulatory compliance regime applicable to the communication.. Valid values are `hipaa|gdpr|none`',
    `consent_given_flag` BOOLEAN COMMENT 'Indicates whether the patient provided consent for this communication channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the communication log record was first created in the data lake.',
    `delivery_attempts` STRING COMMENT 'Number of attempts made to deliver the communication before achieving final status.',
    `direction` STRING COMMENT 'Indicates whether the communication was sent to the patient (outbound) or received from the patient (inbound).. Valid values are `outbound|inbound`',
    `is_test_message` BOOLEAN COMMENT 'True if the communication was generated for testing purposes and not sent to a real patient.',
    `language_code` STRING COMMENT 'ISO 639‑1 code indicating the language used in the communication.',
    `opt_out_flag` BOOLEAN COMMENT 'True if the patient has opted out of this type of communication.',
    `priority` STRING COMMENT 'Business priority assigned to the communication for processing or escalation.. Valid values are `low|medium|high`',
    `recipient_email` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `recipient_phone` STRING COMMENT 'Phone number of the patient or other recipient.. Valid values are `^+?[0-9]{1,3}[ -]?(?[0-9]{1,4})?[ -]?[0-9]{3,4}[ -]?[0-9]{3,4}$`',
    `response_flag` BOOLEAN COMMENT 'True if the patient responded to the communication.',
    `response_text` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the patient response was recorded.',
    `retention_period_days` STRING COMMENT 'Number of days the communication record must be retained to satisfy HIPAA or other regulations.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned date and time for sending the communication (used for automated outreach).',
    `sender_role` STRING COMMENT 'Business role of the sender (e.g., nurse, physician, administrative staff, automated system).. Valid values are `nurse|physician|admin|system`',
    `source_record_reference` STRING COMMENT 'Original identifier of the communication record in the source system.',
    `source_system` STRING COMMENT 'Originating source system (e.g., Epic, Cerner, Salesforce Health Cloud) that generated the communication record.',
    `subject` STRING COMMENT 'Subject line or brief title of the communication.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the communication log record.',
    `patient_id` BIGINT COMMENT 'Internal surrogate identifier of the patient involved in the communication.',
    `provider_id` BIGINT COMMENT 'Internal surrogate identifier of the provider (clinician, staff) who originated the communication.',
    `status` STRING COMMENT 'Current delivery state of the communication.. Valid values are `sent|delivered|failed|read|bounced`',
    `campaign_id` BIGINT COMMENT 'Identifier of the outreach campaign to which this communication belongs.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the outreach campaign.',
    `sender_id` BIGINT COMMENT 'Internal identifier of the staff member or system that originated the communication.',
    `source_record_id` STRING COMMENT 'Original identifier of the communication record in the source system.',
    `message_template_name` STRING COMMENT 'Human‑readable name of the message template.',
    CONSTRAINT pk_communication_log PRIMARY KEY(`communication_log_id`)
) COMMENT 'Patient communication and correspondence history capturing outreach type (appointment reminder, care gap notification, preventive screening outreach, billing statement, post-discharge follow-up, population health campaign), communication channel (phone call, SMS, email, patient portal message, postal mail), communication date, sender, recipient, delivery status, patient response, opt-out preferences, and campaign linkage. Supports patient engagement workflows, care gap closure tracking, CAHPS communication metrics, and population health outreach effectiveness analysis. Aligned with HL7 FHIR Communication resource. Sourced from patient engagement platforms, care management systems, and outreach automation tools.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`consent_reference` (
    `consent_reference_id` BIGINT COMMENT 'System-generated unique identifier for the consent reference record.',
    `consent_record_id` BIGINT COMMENT 'Unique identifier of the consent master record defining the consent terms.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient to which the consent applies.',
    `consent_notes` STRING COMMENT 'Free‑form notes or comments related to the consent record.',
    `consent_obtained_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the patient provided the consent.',
    `consent_revoked_timestamp` TIMESTAMP COMMENT 'Date‑time when the consent was revoked, if applicable.',
    `consent_source` STRING COMMENT 'Method used to capture the consent (e.g., electronic, paper, verbal).. Valid values are `electronic|paper|verbal|phone|email`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent for the patient.. Valid values are `active|revoked|expired|pending|withdrawn|suspended`',
    `consent_type` STRING COMMENT 'Category of consent (e.g., treatment, research, marketing, data sharing).. Valid values are `treatment|research|marketing|data_sharing|billing|other`',
    `consent_version` STRING COMMENT 'Version identifier of the consent document to track revisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent reference record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the consent becomes effective for the patient.',
    `effective_until` DATE COMMENT 'Date when the consent expires or is no longer valid. Null indicates an open‑ended consent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent reference record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient to which the consent applies.',
    `consent_master_id` BIGINT COMMENT 'Unique identifier of the consent master record defining the consent terms.',
    CONSTRAINT pk_consent_reference PRIMARY KEY(`consent_reference_id`)
) COMMENT 'Lightweight reference record linking a patient to their consent records in the consent domain SSOT. Captures patient_id and consent_master_id FK for cross-domain joins.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`patient_coverage` (
    `patient_coverage_id` BIGINT COMMENT 'Unique surrogate key for each patient coverage record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan (product) providing the coverage.',
    `insurance_dependent_id` BIGINT COMMENT 'Identifier of the dependent covered under the subscribers plan, if applicable.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient (member) to whom this coverage applies.',
    `payer_id` BIGINT COMMENT 'Unique identifier of the insurance payer.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary subscriber (often the employee or policyholder).',
    `benefit_level` STRING COMMENT 'Scope of benefits (e.g., individual vs. family).. Valid values are `individual|family|group|employee|dependent`',
    `cob_priority` STRING COMMENT 'Numeric priority for coordination of benefits; lower numbers indicate higher priority.',
    `coinsurance_percent` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays after deductible.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed amount the member pays for a covered service.',
    `coverage_number` STRING COMMENT 'External reference number for the coverage as provided by the payer.',
    `coverage_status` STRING COMMENT 'High‑level status of the coverage lifecycle.. Valid values are `current|expired|future|terminated`',
    `coverage_tier` STRING COMMENT 'Level of benefits within the plan (e.g., premium).. Valid values are `basic|standard|premium|platinum|gold|silver`',
    `coverage_type` STRING COMMENT 'Category of services covered (e.g., medical, pharmacy).. Valid values are `medical|pharmacy|dental|vision|mental_health|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the coverage record was first created.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual amount the member must pay before benefits apply.',
    `effective_end_date` DATE COMMENT 'Date when the coverage ends or is scheduled to end (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the coverage becomes effective.',
    `eligibility_check_date` DATE COMMENT 'Date when eligibility was last verified.',
    `eligibility_expiration_date` DATE COMMENT 'Date when the current eligibility determination expires.',
    `eligibility_status` STRING COMMENT 'Current eligibility determination for the coverage.. Valid values are `eligible|ineligible|pending|unknown`',
    `enrollment_date` DATE COMMENT 'Date the patient enrolled in the coverage.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the coverage enrollment.. Valid values are `active|inactive|pending|terminated|suspended`',
    `group_number` STRING COMMENT 'Employer or group identifier associated with the plan.',
    `is_active` BOOLEAN COMMENT 'True if the coverage is currently active.',
    `is_primary_coverage` BOOLEAN COMMENT 'Indicates if this record is the primary coverage for the patient.',
    `member_number` STRING COMMENT 'Member ID assigned by the payer for this coverage.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense the member will pay in a benefit year.',
    `payer_type` STRING COMMENT 'Classification of the payer (government, private, etc.).. Valid values are `government|private|self_pay|other`',
    `plan_type` STRING COMMENT 'Design of the plan (e.g., HMO, PPO).. Valid values are `HMO|PPO|POS|EPO|HDHP|Other`',
    `relationship_to_subscriber` STRING COMMENT 'Legal relationship of the covered individual to the primary subscriber.. Valid values are `self|spouse|child|parent|other`',
    `source_system` STRING COMMENT 'Originating source system for the coverage data.. Valid values are `Epic|Cerner|Meditech|Other`',
    `source_system_record_reference` STRING COMMENT 'Native identifier of the record in the source system.',
    `termination_date` DATE COMMENT 'Date the coverage was terminated.',
    `termination_reason` STRING COMMENT 'Free‑text reason why the coverage was terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the coverage record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient (member) to whom this coverage applies.',
    `coverage_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan (product) providing the coverage.',
    `dependent_id` BIGINT COMMENT 'Identifier of the dependent covered under the subscribers plan, if applicable.',
    `plan_name` STRING COMMENT 'Descriptive name of the insurance plan.',
    `payer_name` STRING COMMENT 'Legal name of the insurance carrier.',
    `source_system_record_id` STRING COMMENT 'Native identifier of the record in the source system.',
    CONSTRAINT pk_patient_coverage PRIMARY KEY(`patient_coverage_id`)
) COMMENT 'This association product represents the enrollment and coverage relationship between a patient (MPI record) and a health insurance plan. It captures the complete lifecycle of insurance coverage including enrollment periods, member identification, coordination of benefits priority, coverage tier, and relationship to the primary subscriber. Each record represents one patients enrollment in one health plan during a specific time period, supporting scenarios where patients have multiple concurrent coverages (e.g., dual Medicare/Medicaid, COB scenarios) or sequential coverages over time (job changes, plan switches). This is the authoritative source for coverage verification, eligibility determination, and claims adjudication routing.. Existence Justification: In healthcare operations, patients routinely have multiple health plan coverages simultaneously (dual Medicare/Medicaid eligibility, primary employer coverage plus spouses plan for COB, retiree supplemental coverage) and sequentially over time (job changes, aging into Medicare, Medicaid eligibility changes). Each health plan covers thousands to millions of patients. The business actively manages these coverage relationships as operational records with specific enrollment periods, member IDs per plan, COB priority sequencing, coverage tier assignments, and eligibility verification workflows.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` (
    `quality_measure_evaluation_id` BIGINT COMMENT 'Unique identifier for the quality measure evaluation record.',
    `care_team_id` BIGINT COMMENT 'Care team responsible for the patient during evaluation.',
    `clinician_id` BIGINT COMMENT 'Provider who performed the evaluation.',
    `employee_id` BIGINT COMMENT 'User identifier who recorded the evaluation.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient evaluated.',
    `measure_id` BIGINT COMMENT 'Identifier of the quality measure being evaluated.',
    `referral_id` BIGINT COMMENT 'Referral identifier if evaluation triggered a referral.',
    `audit_trail` STRING COMMENT 'Audit trail notes for changes to the evaluation record.',
    `closure_reason_code` STRING COMMENT 'Code indicating reason for gap closure.',
    `compliance_indicator` STRING COMMENT 'Overall compliance indicator for the measure.. Valid values are `compliant|non_compliant|partial|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was created.',
    `data_source_system` STRING COMMENT 'Source system where evaluation data originated.. Valid values are `Epic|Cerner|Meditech|Custom`',
    `denominator_status` STRING COMMENT 'Whether the patient is included in the denominator.. Valid values are `included|excluded|unknown`',
    `eligibility_status` STRING COMMENT 'Eligibility of the patient for the quality measure.. Valid values are `eligible|ineligible|unknown`',
    `evaluation_date` DATE COMMENT 'Date when the evaluation was performed.',
    `evaluation_status` STRING COMMENT 'Overall status of the evaluation record.. Valid values are `completed|pending|in_progress|cancelled`',
    `exemption_reason_code` STRING COMMENT 'Code describing the reason for exemption.',
    `gap_closure_date` DATE COMMENT 'Date when the quality gap was closed.',
    `gap_closure_status` STRING COMMENT 'Current status of gap closure.. Valid values are `closed|open|pending`',
    `gap_status` STRING COMMENT 'Indicates if the patient has a quality gap for this measure.. Valid values are `gap|no_gap|unknown`',
    `is_exempt` BOOLEAN COMMENT 'Indicates if the patient is exempt from the measure.',
    `last_outreach_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent outreach attempt.',
    `measurement_period_end` DATE COMMENT 'End date of the measurement period for the quality measure.',
    `measurement_period_start` DATE COMMENT 'Start date of the measurement period for the quality measure.',
    `notes` STRING COMMENT 'Free-text notes about the evaluation.',
    `numerator_status` STRING COMMENT 'Whether the patient met the numerator criteria.. Valid values are `met|not_met|exempt|unknown`',
    `outreach_attempts` STRING COMMENT 'Number of outreach attempts made to close the gap.',
    `outreach_success_flag` BOOLEAN COMMENT 'Indicates if any outreach attempt was successful.',
    `population_category` STRING COMMENT 'Population segment category (e.g., adult, pediatric, SDOH risk).',
    `referral_status` STRING COMMENT 'Status of the referral associated with the evaluation.. Valid values are `initiated|completed|cancelled|pending`',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score associated with the patient for this measure.',
    `score_unit` STRING COMMENT 'Unit of the evaluation score.. Valid values are `percent|points|ratio`',
    `score_value` DECIMAL(18,2) COMMENT 'Numeric result of the measure evaluation (e.g., percentage).',
    `sdhz_code` STRING COMMENT 'Social Determinants of Health Z-code associated with the patient for this measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was last updated.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient evaluated.',
    `evaluating_provider_id` BIGINT COMMENT 'Provider who performed the evaluation.',
    `recorded_by_user_id` BIGINT COMMENT 'User identifier who recorded the evaluation.',
    CONSTRAINT pk_quality_measure_evaluation PRIMARY KEY(`quality_measure_evaluation_id`)
) COMMENT 'This association product represents the evaluation of individual patients against specific quality measures across measurement periods. It captures population health gap management, quality reporting compliance tracking, and patient-level measure performance. Each record links one patient demographics profile to one quality measure with attributes tracking eligibility determination, compliance status, gap identification, and closure activities. This is the operational foundation for HEDIS reporting, CMS eCQM submission, MIPS quality performance, value-based care gap closure workflows, and population health outreach campaigns.. Existence Justification: In healthcare quality management, each patient is evaluated against multiple quality measures (HEDIS, CMS eCQMs, MIPS) across measurement years, and each quality measure is evaluated against thousands of eligible patients. The business actively manages these patient-measure evaluations as operational records, tracking denominator eligibility, numerator compliance, gap identification, outreach attempts, and closure activities. This is the core operational entity for population health gap closure workflows, HEDIS submission, VBP performance improvement, and care management prioritization.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`program_enrollment` (
    `program_enrollment_id` BIGINT COMMENT 'System‑generated unique identifier for each enrollment record.',
    `care_program_id` BIGINT COMMENT 'Identifier of the quality improvement program to which the patient is enrolled.',
    `clinician_id` BIGINT COMMENT 'Identifier of the care manager responsible for the patient within this program.',
    `mpi_record_id` BIGINT COMMENT 'Internal identifier linking the enrollment to the patient (restricted, pii_identifier).',
    `actual_metric_value` DECIMAL(18,2) COMMENT 'Observed metric value for the patient during the enrollment period.',
    `disenrollment_date` DATE COMMENT 'Date the patient was removed from the program, if applicable.',
    `disenrollment_reason` STRING COMMENT 'Reason for terminating the enrollment (e.g., patient request, ineligibility).',
    `eligibility_criteria` STRING COMMENT 'Free‑text description of the criteria used to assess eligibility.',
    `eligibility_status` STRING COMMENT 'Current eligibility determination for the patient within the program.. Valid values are `eligible|ineligible|pending_review`',
    `enrollment_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `enrollment_end_date` DATE COMMENT 'Date the enrollment ends or is terminated (nullable for open‑ended).',
    `enrollment_notes` STRING COMMENT 'Free‑form notes entered by quality staff about the enrollment.',
    `enrollment_number` STRING COMMENT 'External enrollment reference number assigned by the program sponsor.',
    `enrollment_reason` STRING COMMENT 'Business reason for enrolling the patient in the program.. Valid values are `quality_improvement|regulatory|financial|clinical`',
    `enrollment_region_code` STRING COMMENT 'Three‑letter ISO country code where the enrollment was recorded.',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment request.. Valid values are `referral|self_enroll|provider_order|automated`',
    `enrollment_start_date` DATE COMMENT 'Date the enrollment becomes effective.',
    `enrollment_state` STRING COMMENT 'Two‑letter US state code associated with the enrollment location.',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the enrollment.. Valid values are `active|inactive|pending|terminated|suspended`',
    `enrollment_type` STRING COMMENT 'Category of quality program (e.g., CMS Value‑Based Purchasing, MIPS, HEDIS, ACO, internal).. Valid values are `CMS_VBP|MIPS|HEDIS|ACO|INTERNAL`',
    `enrollment_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `enrollment_zip` STRING COMMENT 'Postal code of the patient’s residence at enrollment (restricted, pii_address).',
    `is_primary_enrollment` BOOLEAN COMMENT 'Indicates whether this enrollment is the patient’s primary quality program.',
    `metric_measurement_date` DATE COMMENT 'Date on which the actual metric value was recorded.',
    `program_category` STRING COMMENT 'High‑level classification of the program.. Valid values are `value_based|population_health|clinical_outcome|financial`',
    `program_subcategory` STRING COMMENT 'More specific sub‑type of the program.. Valid values are `vbp|mips|hedis|aco|internal`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score derived from SDOH and clinical data.',
    `risk_tier` STRING COMMENT 'Risk stratification tier assigned to the patient for this program.. Valid values are `high|medium|low|none`',
    `target_metric_code` STRING COMMENT 'Code identifying the performance metric the program tracks for this patient.',
    `target_metric_value` DECIMAL(18,2) COMMENT 'Target value for the metric (e.g., target HEDIS score).',
    `patient_id` BIGINT COMMENT 'Internal identifier linking the enrollment to the patient (restricted, pii_identifier).',
    `program_id` BIGINT COMMENT 'Identifier of the quality improvement program to which the patient is enrolled.',
    `assigned_care_manager_id` BIGINT COMMENT 'Identifier of the care manager responsible for the patient within this program.',
    CONSTRAINT pk_program_enrollment PRIMARY KEY(`program_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between patients and quality programs. It captures patient participation in CMS Value-Based Purchasing, MIPS, HEDIS, ACO, and other quality improvement programs. Each record links one patient to one quality program with enrollment dates, risk stratification, eligibility status, and program-specific performance tracking. SSOT for quality program membership, risk tier assignment, and patient-level program participation tracking. Supports CMS quality reporting, risk-adjusted outcome calculation, and program-specific patient cohort identification.. Existence Justification: In healthcare quality operations, patients are simultaneously enrolled in multiple quality programs (e.g., a patient may be enrolled in Hospital VBP, HEDIS, ACO REACH, and internal care management programs at the same time). Each quality program tracks many patients for performance measurement, risk stratification, and outcome reporting. The enrollment relationship is actively managed by quality teams who create enrollment records, assign risk tiers, track eligibility periods, and manage disenrollments based on program-specific criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`care_program` (
    `care_program_id` BIGINT COMMENT 'Unique surrogate key for the care program.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider responsible for coordinating care within the program.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient enrolled in the program.',
    `audit_status` STRING COMMENT 'Result of the most recent audit.. Valid values are `passed|failed|pending`',
    `community_resource_directory` STRING COMMENT 'Link or reference to the directory of community resources associated with the program.',
    `compliance_status` STRING COMMENT 'Current compliance status with regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care program record was created.',
    `current_enrollment` STRING COMMENT 'Current number of participants enrolled.',
    `data_retention_period_days` STRING COMMENT 'Number of days to retain program data per policy.',
    `discharge_date` DATE COMMENT 'Date when the patient exited the program.',
    `discharge_reason` STRING COMMENT 'Reason for patient discharge from the program.. Valid values are `goal_met|non_compliance|transfer|deceased|other`',
    `effective_from` DATE COMMENT 'Date when the program becomes effective.',
    `effective_until` DATE COMMENT 'Date when the program ends or is scheduled to end; null for ongoing.',
    `eligibility_criteria` STRING COMMENT 'Textual description of criteria patients must meet to enroll.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of participants allowed in the program.',
    `enrollment_date` DATE COMMENT 'Date when the patient was enrolled in the program.',
    `enrollment_end_date` DATE COMMENT 'Last date for enrollment; null if open-ended.',
    `enrollment_start_date` DATE COMMENT 'Date when patient enrollment into the program can begin.',
    `is_active` BOOLEAN COMMENT 'Indicates if the program record is currently active.',
    `is_sdoh_related` BOOLEAN COMMENT 'Indicates if the program addresses social determinants of health.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `notes` STRING COMMENT 'Free-text notes regarding the patient’s participation.',
    `outcome_metric_actual` DECIMAL(18,2) COMMENT 'Most recent actual value of the outcome metric.',
    `outcome_metric_name` STRING COMMENT 'Name of the key outcome metric tracked for the program.',
    `outcome_metric_target` DECIMAL(18,2) COMMENT 'Target value for the outcome metric.',
    `program_budget` DECIMAL(18,2) COMMENT 'Allocated budget for the program.',
    `program_category` STRING COMMENT 'High-level category grouping of the program.. Valid values are `clinical|social|preventive|rehab|palliative`',
    `program_code` STRING COMMENT 'Business code used to reference the program.',
    `program_currency` STRING COMMENT 'Currency code for budget and expenditure.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `program_goal` STRING COMMENT 'Primary clinical or social goal the program aims to achieve.',
    `program_name` STRING COMMENT 'Descriptive name of the care program.',
    `program_owner` STRING COMMENT 'Business unit or department owning the program.',
    `program_spent` DECIMAL(18,2) COMMENT 'Total amount spent to date on the program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|completed|suspended|pending`',
    `program_subcategory` STRING COMMENT 'More specific subcategory within the program category.',
    `program_type` STRING COMMENT 'Category of the program indicating its primary focus.. Valid values are `disease_management|wellness|rehabilitation|palliative|preventive`',
    `program_version` STRING COMMENT 'Version identifier for the program definition.',
    `referral_source` STRING COMMENT 'Origin of the referral that led to enrollment.. Valid values are `provider|self|community|hospital|clinic`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score assigned to the program based on patient population and services.',
    `sdlc_stage` STRING COMMENT 'Software development lifecycle stage for the programs digital components.. Valid values are `design|development|testing|production|decommissioned`',
    `sdoh_need_closure_tracking` BOOLEAN COMMENT 'Flag indicating tracking of closure of identified needs.',
    `sdoh_referral_management` STRING COMMENT 'Details on how SDOH referrals are managed within the program.',
    `target_population` STRING COMMENT 'Description of the demographic or clinical segment the program serves.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `care_coordinator_id` BIGINT COMMENT 'Identifier of the provider responsible for coordinating care within the program.',
    `community_resource_id` BIGINT COMMENT 'Reference to external community resource linked to the program (e.g., food bank, transportation service).',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient enrolled in the program.',
    CONSTRAINT pk_care_program PRIMARY KEY(`care_program_id`)
) COMMENT 'Master reference table for care_program. Referenced by program_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`communication_campaign` (
    `communication_campaign_id` BIGINT COMMENT 'Unique identifier for the communication campaign.',
    `employee_id` BIGINT COMMENT 'Identifier of the user responsible for the campaign.',
    `message_template_id` BIGINT COMMENT 'Identifier of the message template used for the campaign content.',
    `actual_reach` BIGINT COMMENT 'Actual number of individuals reached by the campaign.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for the campaign in the primary currency.',
    `campaign_code` STRING COMMENT 'Business code for the campaign used in reporting and external references.',
    `campaign_manager_email` STRING COMMENT 'Email address of the campaign manager.',
    `campaign_manager_phone` STRING COMMENT 'Phone number of the campaign manager.',
    `campaign_name` STRING COMMENT 'Descriptive name of the communication campaign.',
    `campaign_type` STRING COMMENT 'Category of the campaign indicating its purpose.. Valid values are `patient_education|appointment_reminder|health_alert|survey|promotion`',
    `channel` STRING COMMENT 'Primary communication channel used for the campaign.. Valid values are `email|sms|push|portal|mail`',
    `click_through_rate` DECIMAL(18,2) COMMENT 'Percentage of recipients who clicked on the campaign link (if applicable).',
    `communication_campaign_status` STRING COMMENT 'Current lifecycle status of the campaign.. Valid values are `draft|active|paused|completed|cancelled`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the campaign complies with regulatory requirements (true) or requires review (false).',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Percentage of recipients who completed the desired action after interaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `end_date` DATE COMMENT 'Planned end date of the campaign.',
    `expected_reach` BIGINT COMMENT 'Projected number of individuals the campaign aims to reach.',
    `is_archived` BOOLEAN COMMENT 'Indicates if the campaign record is archived (true) or active (false).',
    `is_test_campaign` BOOLEAN COMMENT 'Flag indicating whether the campaign is a test (true) or production (false).',
    `language` STRING COMMENT 'Language of the campaign content (e.g., EN, ES, FR).',
    `last_sent_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent communication sent as part of the campaign.',
    `launch_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the campaign was launched.',
    `notes` STRING COMMENT 'Free-text field for additional notes or comments about the campaign.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether recipients can opt out of future communications (true) or not (false).',
    `priority` STRING COMMENT 'Priority level assigned to the campaign for scheduling and resource allocation.. Valid values are `low|medium|high|critical`',
    `regulatory_approval_date` DATE COMMENT 'Date when the campaign received regulatory approval, if required.',
    `response_rate` DECIMAL(18,2) COMMENT 'Overall response rate from recipients (percentage).',
    `retention_period_days` STRING COMMENT 'Number of days to retain campaign data for audit and compliance purposes.',
    `segmentation_criteria` STRING COMMENT 'Criteria or rule set used to segment the target audience.',
    `source_system` STRING COMMENT 'Source system where the campaign originated (e.g., Salesforce Health Cloud).',
    `start_date` DATE COMMENT 'Planned start date of the campaign.',
    `target_audience` STRING COMMENT 'Description of the intended audience segment for the campaign (e.g., diabetic patients, seniors).',
    `total_messages_sent` BIGINT COMMENT 'Total number of messages dispatched in the campaign.',
    `updated_by` STRING COMMENT 'Name of the user who last updated the campaign.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    `status` STRING COMMENT 'Current lifecycle status of the campaign.. Valid values are `draft|active|paused|completed|cancelled`',
    `owner_user_id` BIGINT COMMENT 'Identifier of the user responsible for the campaign.',
    `created_by` STRING COMMENT 'Name of the user who created the campaign.',
    CONSTRAINT pk_communication_campaign PRIMARY KEY(`communication_campaign_id`)
) COMMENT 'Master reference table for communication_campaign. Referenced by campaign_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`attribution_panel` (
    `attribution_panel_id` BIGINT COMMENT 'System‑generated unique identifier for each attribution panel record.',
    `attribution_logic` STRING COMMENT 'Expression or algorithm (in pseudo‑code) that defines how attribution is calculated for this panel.',
    `attribution_panel_description` STRING COMMENT 'Free‑form text describing the business rules, purpose, and scope of the panel.',
    `audit_created_by` STRING COMMENT 'User identifier of the person who initially created the panel record.',
    `audit_updated_by` STRING COMMENT 'User identifier of the person who most recently modified the panel record.',
    `compliance_framework` STRING COMMENT 'Regulatory framework(s) that the panel must adhere to.. Valid values are `HIPAA|HITECH|GDPR|PCI|None`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the attribution panel record was first created in the data lake.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) representing the overall quality of the panels source data.',
    `effective_end_date` DATE COMMENT 'Date on which the attribution panel ceases to be effective; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the attribution panel becomes effective for business use.',
    `is_sensitive` BOOLEAN COMMENT 'Indicates whether the panel contains sensitive or restricted information requiring special handling.',
    `last_review_date` DATE COMMENT 'Date when the panel was last reviewed for relevance, compliance, or accuracy.',
    `linked_metric` STRING COMMENT 'Name of the primary business metric (e.g., revenue, patient outcome) that this panel feeds.',
    `owner_department` STRING COMMENT 'Internal department responsible for maintaining the panel (e.g., Finance, Clinical Analytics).',
    `panel_code` STRING COMMENT 'Human‑readable code used to reference the attribution panel in external systems and reporting.',
    `panel_name` STRING COMMENT 'Descriptive name of the attribution panel that conveys its purpose or scope.',
    `panel_status` STRING COMMENT 'Current lifecycle state of the panel indicating whether it is in use, being defined, or retired.. Valid values are `active|inactive|draft|pending|retired|archived`',
    `panel_type` STRING COMMENT 'Category that defines the primary domain or function of the panel (e.g., clinical, financial, operational).. Valid values are `clinical|financial|operational|research|marketing|quality`',
    `retention_period_days` STRING COMMENT 'Number of days the panel data must be retained to satisfy legal or policy requirements.',
    `source_system` STRING COMMENT 'Name of the originating operational system (e.g., Epic, Cerner, Salesforce Health Cloud) that supplied the panel definition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the attribution panel record.',
    `version_number` STRING COMMENT 'Incremental version of the panel definition to support change management.',
    `description` STRING COMMENT 'Free‑form text describing the business rules, purpose, and scope of the panel.',
    CONSTRAINT pk_attribution_panel PRIMARY KEY(`attribution_panel_id`)
) COMMENT 'Master reference table for attribution_panel. Referenced by attribution_panel_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`message_template` (
    `message_template_id` BIGINT COMMENT 'System-generated unique identifier for the message template.',
    `employee_id` BIGINT COMMENT 'Employee who approved this message template for use. FK to workforce.employee.',
    `message_employee_id` BIGINT COMMENT 'Employee who originally created this message template. FK to workforce.employee.',
    `primary_employee_id` BIGINT COMMENT 'Employee who owns and is accountable for this message template lifecycle. FK to workforce.employee.',
    `approval_status` STRING COMMENT 'Current approval state of the template.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User identifier who approved the template.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the template was approved.',
    `audience_scope` STRING COMMENT 'Intended recipient group for the template.. Valid values are `patient|provider|staff|all`',
    `body_content` STRING COMMENT 'Full body text (or HTML) of the message template.',
    `channel` STRING COMMENT 'Delivery medium for the message (e.g., email, SMS).. Valid values are `email|sms|patient_portal|voice|mail`',
    `compliance_tag` STRING COMMENT 'Indicates regulatory compliance scope of the template content.. Valid values are `hipaa|gdpr|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was first created.',
    `effective_from` DATE COMMENT 'Date when the template becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the template should no longer be used (nullable).',
    `employee_role` STRING COMMENT 'employee_role',
    `is_sensitive` BOOLEAN COMMENT 'True if the template may contain protected health information (PHI).',
    `language_code` STRING COMMENT 'Two‑letter language code indicating the language of the template content.',
    `max_send_attempts` STRING COMMENT 'Maximum number of delivery attempts before giving up.',
    `message_template_description` STRING COMMENT 'Removed boilerplate phrase "This column stores..." from patient.message_template.description.',
    `message_template_status` STRING COMMENT 'Current lifecycle state of the template.. Valid values are `draft|active|inactive|archived`',
    `placeholder_variables` STRING COMMENT 'Comma‑separated list or JSON of variable tokens that can be substituted at send time.',
    `priority_level` STRING COMMENT 'Business priority assigned to messages generated from this template.. Valid values are `low|medium|high|critical`',
    `retention_period_days` STRING COMMENT 'Number of days the template record must be retained for audit purposes.',
    `send_time_offset_minutes` STRING COMMENT 'Number of minutes to offset the send time relative to the triggering event.',
    `subject_line` STRING COMMENT 'Subject or title line used in the communication.',
    `template_code` STRING COMMENT 'External code or short identifier used in integration interfaces.',
    `template_name` STRING COMMENT 'Human‑readable name of the template used for display and selection.',
    `template_type` STRING COMMENT 'Category of communication the template supports.. Valid values are `appointment_reminder|lab_result|prescription_refill|billing_statement|general_communication`',
    `updated_by` STRING COMMENT 'User identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the template record.',
    `version_number` STRING COMMENT 'Incremental version of the template for change management.',
    `status` STRING COMMENT 'Current lifecycle state of the template.. Valid values are `draft|active|inactive|archived`',
    `description` STRING COMMENT 'Detailed description of the templates purpose and usage.',
    `created_by` STRING COMMENT 'User identifier (e.g., username) that created the template.',
    CONSTRAINT pk_message_template PRIMARY KEY(`message_template_id`)
) COMMENT 'Master reference table for message_template. Referenced by message_template_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`referral_management` (
    `referral_management_id` BIGINT COMMENT 'Primary key for referral_management',
    `clinician_id` BIGINT COMMENT 'The provider who identified the SDOH need and initiated the referral.',
    `community_resource_id` BIGINT COMMENT 'Foreign key linking to patient.community_resource. Business justification: Referral management directs patients to community resources. Adding FK to community_resource for the target resource of the referral.',
    `employee_id` BIGINT COMMENT 'The community health worker assigned to coordinate and follow up on this SDOH referral.',
    `facility_organization_id` BIGINT COMMENT 'The community-based organization (CBO) or social service agency receiving this referral.',
    `insurance_coverage_id` BIGINT COMMENT 'The patients insurance coverage record, relevant for determining CBO eligibility and potential reimbursement for SDOH services.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Referral management records belong to a patient. patient_id exists but has no FK defined. Adding mpi_record_id FK for proper patient linkage.',
    `referral_patient_mpi_record_id` BIGINT COMMENT 'The patient for whom this SDOH referral was created.',
    `sdoh_assessment_id` BIGINT COMMENT 'Foreign key linking to patient.sdoh_assessment. Business justification: Referrals originate from SDOH assessments. Adding FK to link the referral back to the originating assessment for closed-loop tracking.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which the SDOH need was identified and the referral initiated.',
    `accepted_timestamp` TIMESTAMP COMMENT 'Date and time the receiving community-based organization acknowledged and accepted the referral.',
    `actual_completion_date` DATE COMMENT 'Date the referral was actually completed with service delivery confirmed or need closure documented.',
    `closure_reason` STRING COMMENT 'Reason the referral was closed, whether successfully completed or terminated without full resolution.',
    `consent_date` DATE COMMENT 'Date the patient signed or verbally provided consent for information sharing related to this referral.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether the patient provided informed consent to share their information with the receiving CBO for this referral.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this referral record was first created in the system.',
    `first_contact_date` DATE COMMENT 'Actual date of first successful contact between the patient and the assigned CHW or CBO representative.',
    `followup_attempts` STRING COMMENT 'Number of follow-up contact attempts made to the patient or CBO to track referral progress.',
    `hipaa_retention_date` DATE COMMENT 'Date after which this record is eligible for archival or destruction per HIPAA and state medical record retention requirements.',
    `icd10_z_code` STRING COMMENT 'ICD-10-CM Z-code capturing the social determinant factor (e.g., Z59.0 Homelessness, Z56.0 Unemployment).',
    `intervention_count` STRING COMMENT 'Total number of CHW interventions or touchpoints performed for this referral (calls, visits, resource connections).',
    `is_closed_loop` BOOLEAN COMMENT 'Indicates whether the referral has achieved closed-loop status with confirmed outcome feedback from the receiving organization.',
    `last_followup_date` DATE COMMENT 'Most recent date a follow-up contact was attempted or completed for this referral.',
    `need_closure_status` STRING COMMENT 'Outcome status indicating whether the identified social need was successfully addressed through the referral.',
    `outcome_notes` STRING COMMENT 'Free-text documentation of the referral outcome, services delivered, and any remaining unmet needs.',
    `patient_preferred_language` STRING COMMENT 'ISO 639 language code for the patients preferred communication language, critical for CBO service matching.',
    `patient_satisfaction_rating` STRING COMMENT 'Patient-reported satisfaction score (1-5 scale) with the referral experience and services received.',
    `priority` STRING COMMENT 'Clinical urgency level assigned to the referral based on patient risk and need severity.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this referral counts toward HEDIS, MIPS, or ACO quality measure reporting for SDOH screening and intervention.',
    `referral_date` DATE COMMENT 'Date the referral was formally created and submitted to the receiving organization.',
    `referral_number` STRING COMMENT 'Externally-visible business identifier for the SDOH referral, used in correspondence with community-based organizations and payers.',
    `referral_reason` STRING COMMENT 'Free-text clinical narrative describing the specific social need and circumstances prompting this referral.',
    `referral_source` STRING COMMENT 'Channel or mechanism through which the referral was initiated.',
    `referral_status` STRING COMMENT 'Current state of the referral in its workflow lifecycle from creation through resolution.',
    `referral_type` STRING COMMENT 'Primary category of social determinant need driving this referral. [ENUM-REF-CANDIDATE: food_insecurity|housing_instability|transportation|utility_assistance|employment|interpersonal_safety|education|childcare|legal_services|financial_strain — promote to reference product]',
    `risk_stratification_level` STRING COMMENT 'Patient risk tier derived from screening results and clinical context, used to prioritize CHW outreach and resource allocation.',
    `scheduled_contact_date` DATE COMMENT 'Date the CHW or CBO is scheduled to make initial contact with the patient regarding this referral.',
    `screening_score` STRING COMMENT 'Numeric score from the SDOH screening instrument indicating severity or risk level of the identified need.',
    `screening_tool_code` STRING COMMENT 'Identifier for the validated screening instrument used to identify the need (e.g., PRAPARE, AHC-HRSN, HUNT).',
    `screening_tool_responses` STRING COMMENT 'Serialized patient responses to the SDOH screening questionnaire items used to generate the referral.',
    `sdoh_domain` STRING COMMENT 'Healthy People 2030 SDOH domain classification for population health stratification and reporting.',
    `service_requested` STRING COMMENT 'Specific service or resource requested from the receiving organization (e.g., food pantry enrollment, housing application assistance).',
    `service_taxonomy_code` STRING COMMENT 'Standardized service taxonomy code from the AIRS/211 LA classification system identifying the type of community service.',
    `target_completion_date` DATE COMMENT 'Expected date by which the referred service should be delivered and the social need addressed.',
    `transportation_barrier` BOOLEAN COMMENT 'Indicates whether the patient has identified transportation as a barrier to accessing the referred service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this referral record was last modified.',
    CONSTRAINT pk_referral_management PRIMARY KEY(`referral_management_id`)
) COMMENT 'Referral management for SDOH';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`need_closure_tracking` (
    `need_closure_tracking_id` BIGINT COMMENT 'Primary key for need_closure_tracking',
    `care_plan_id` BIGINT COMMENT 'The care plan under which this SDOH need closure is being managed, linking social interventions to clinical goals.',
    `clinician_id` BIGINT COMMENT 'The provider or supervisor to whom this need was escalated for additional intervention or oversight.',
    `community_resource_id` BIGINT COMMENT 'Identifier for the community-based organization or social service resource involved in addressing this need.',
    `employee_id` BIGINT COMMENT 'The community health worker or care navigator assigned to coordinate closure of this SDOH need.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Need closure tracking records belong to a patient. patient_id exists as BIGINT but has no FK defined. Adding proper mpi_record_id FK. Not removing patient_id as it may serve as a legacy identifier.',
    `need_patient_mpi_record_id` BIGINT COMMENT 'The patient whose SDOH need is being tracked for closure. Links to the master patient record.',
    `prior_closure_tracking_need_closure_tracking_id` BIGINT COMMENT 'Reference to a previous need closure tracking record for the same need category if this is a recurrence.',
    `referral_management_id` BIGINT COMMENT 'Foreign key linking to patient.referral_management. Business justification: Need closure tracking has referral_id (BIGINT) linking to the referral that initiated the need. Connecting to referral_management for closed-loop tracking.',
    `sdoh_assessment_id` BIGINT COMMENT 'Foreign key linking to patient.sdoh_assessment. Business justification: Need closure tracking originates from an SDOH assessment screening. Adding FK to link back to the originating assessment for traceability.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which the SDOH need was identified or last assessed.',
    `actual_closure_date` DATE COMMENT 'Date when the SDOH need was confirmed as resolved or formally closed. Null if still open or in progress.',
    `barrier_to_closure` STRING COMMENT 'Primary barrier preventing successful closure of the SDOH need (e.g., waitlist, eligibility, transportation, language, documentation).',
    `closure_reason` STRING COMMENT 'Reason for closing the need tracking record, distinguishing between successful resolution and other closure circumstances.',
    `closure_status` STRING COMMENT 'Current lifecycle status of the need closure tracking process indicating whether the identified SDOH need has been resolved, partially addressed, or remains open.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether the patient has provided consent for sharing their SDOH information with community-based organizations and care coordinators.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this need closure tracking record was first created in the system.',
    `days_open` STRING COMMENT 'Number of calendar days the need has been open from identification to current date or closure date. Used for timeliness reporting and SLA monitoring.',
    `escalation_date` DATE COMMENT 'Date when the need closure tracking was escalated to a supervisor or higher-level care coordinator.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this need has been escalated due to missed follow-ups, worsening conditions, or inability to connect the patient with resources.',
    `follow_up_frequency_days` STRING COMMENT 'Number of days between scheduled follow-up contacts for this need, based on priority and engagement level.',
    `goal_description` STRING COMMENT 'Patient-centered goal statement describing the desired outcome for resolving this SDOH need (e.g., secure stable housing within 60 days).',
    `identified_date` DATE COMMENT 'Date when the SDOH need was first identified through screening, clinical assessment, or patient self-report.',
    `intervention_type` STRING COMMENT 'Primary type of intervention being applied to address the SDOH need.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent outreach attempt to the patient regarding this SDOH need.',
    `last_outreach_method` STRING COMMENT 'Communication channel used for the most recent outreach attempt to the patient.',
    `need_category` STRING COMMENT 'Primary category of the social determinant of health need being tracked. [ENUM-REF-CANDIDATE: food_insecurity|housing|transportation|employment|education|utilities|interpersonal_safety|childcare|legal_services|financial_strain — promote to reference product]',
    `need_subcategory` STRING COMMENT 'Detailed subcategory further classifying the SDOH need within the primary category (e.g., homelessness risk, utility shutoff, food desert access).',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next follow-up contact or reassessment of the SDOH need.',
    `notes` STRING COMMENT 'Free-text clinical and coordination notes documenting interactions, barriers, progress, and observations related to need closure. May contain PHI.',
    `outcome_measure` STRING COMMENT 'Assessment of the outcome achieved at closure or reassessment, measuring whether the patients situation improved relative to the identified need.',
    `outreach_attempt_count` STRING COMMENT 'Total number of outreach attempts made to the patient or community resource to facilitate need closure.',
    `overdue_flag` BOOLEAN COMMENT 'Indicates whether the need closure has exceeded its target closure date without resolution.',
    `patient_engagement_level` STRING COMMENT 'Assessment of the patients level of engagement and participation in addressing their identified SDOH need.',
    `priority_level` STRING COMMENT 'Urgency classification of the SDOH need based on clinical risk assessment and patient circumstances. Critical indicates immediate safety concern.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this need closure record contributes to a quality measure denominator or numerator for HEDIS, MIPS, or ACO reporting.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this is a recurring SDOH need that was previously closed and has resurfaced for the same patient.',
    `reporting_period` STRING COMMENT 'Fiscal quarter during which this need closure activity is reported for quality measurement and regulatory submissions (e.g., 2024-Q1).',
    `risk_stratification_tier` STRING COMMENT 'Population health risk tier assigned to the patient for this need, used to determine intervention intensity and resource allocation.',
    `screening_score` DECIMAL(18,2) COMMENT 'Numeric score from the SDOH screening tool that quantifies the severity or risk level of the identified need.',
    `screening_tool_used` STRING COMMENT 'Name of the validated screening instrument used to identify the need (e.g., PRAPARE, AHC-HRSN, SDOH-2, WellRx).',
    `source_system` STRING COMMENT 'Operational system from which this need closure tracking record originated (e.g., Epic Healthy Planet, Salesforce Health Cloud, Unite Us).',
    `target_closure_date` DATE COMMENT 'Expected date by which the SDOH need should be resolved based on care plan goals and resource availability.',
    `tracking_number` STRING COMMENT 'Externally visible business identifier for this need closure tracking record, used in care coordination communications and reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this need closure tracking record was last modified.',
    `verification_date` DATE COMMENT 'Date when need closure was verified through the specified verification method.',
    `verification_method` STRING COMMENT 'Method used to verify that the SDOH need was actually resolved (e.g., patient self-report, CBO confirmation letter, home visit observation).',
    `z_code` STRING COMMENT 'ICD-10-CM Z-code representing the social determinant of health factor (e.g., Z59.0 Homelessness, Z56.0 Unemployment). Used for clinical documentation and claims coding.',
    CONSTRAINT pk_need_closure_tracking PRIMARY KEY(`need_closure_tracking_id`)
) COMMENT 'Need closure tracking for SDOH referrals';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`chw_interventions` (
    `chw_interventions_id` BIGINT COMMENT 'Primary key for chw_interventions',
    `care_plan_id` BIGINT COMMENT 'Identifier of the patient care plan that this intervention supports or contributes to.',
    `care_program_id` BIGINT COMMENT 'Identifier of the CHW program or grant-funded initiative under which this intervention was performed.',
    `care_site_id` BIGINT COMMENT 'Identifier of the care site or facility associated with the intervention, if conducted at a healthcare facility.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: CHW interventions are performed for a specific patient. patient_id exists but has no FK. Adding mpi_record_id FK for proper patient linkage.',
    `need_closure_tracking_id` BIGINT COMMENT 'Identifier of the specific SDOH need being addressed by this intervention (e.g., food insecurity, housing instability).',
    `chw_need_need_closure_tracking_id` BIGINT COMMENT 'Foreign key linking to patient.need_closure_tracking. Business justification: CHW interventions have need_id (BIGINT) linking to the specific need being addressed. Connecting to need_closure_tracking.',
    `chw_patient_mpi_record_id` BIGINT COMMENT 'The patient who is the recipient of the community health worker intervention.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinical provider supervising or overseeing the CHWs intervention activities.',
    `community_resource_id` BIGINT COMMENT 'Identifier of the community-based organization or resource to which the patient was connected or referred.',
    `employee_id` BIGINT COMMENT 'Identifier of the community health worker who performed or facilitated the intervention.',
    `referral_id` BIGINT COMMENT 'Identifier of the SDOH referral that triggered this intervention, linking back to the referral management workflow.',
    `referral_management_id` BIGINT COMMENT 'Foreign key linking to patient.referral_management. Business justification: CHW interventions have referral_id (BIGINT) linking to the referral that triggered the intervention. Connecting to referral_management.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which this intervention was initiated or documented, if applicable.',
    `attempt_count` STRING COMMENT 'Number of contact attempts made to reach the patient for this intervention, used for outreach effectiveness analysis.',
    `barrier_identified` STRING COMMENT 'Description of barriers encountered during the intervention that prevented or limited successful need closure (e.g., language, transportation, eligibility).',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this intervention qualifies for reimbursement under applicable payer contracts or Medicaid CHW billing codes.',
    `cancellation_reason` STRING COMMENT 'Reason the intervention was cancelled or deferred, if applicable, supporting barrier analysis and program improvement.',
    `chw_interventions_status` STRING COMMENT 'Current lifecycle status of the intervention indicating its progress from planning through completion or closure.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether patient consent was obtained for the CHW intervention and any associated data sharing with community organizations.',
    `cpt_code` STRING COMMENT 'CPT code associated with the intervention for billing purposes, such as health behavior assessment and intervention codes.',
    `delivery_mode` STRING COMMENT 'The modality through which the intervention was delivered to the patient or community member.',
    `documentation_complete` BOOLEAN COMMENT 'Indicates whether all required documentation for this intervention has been completed by the CHW.',
    `duration_minutes` STRING COMMENT 'Total duration of the intervention in minutes, used for productivity tracking and program cost analysis.',
    `effective_date` DATE COMMENT 'The business-effective date of this intervention record, supporting SCD Type 2 historization in the lakehouse.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the CHW intervention session or activity concluded.',
    `expiration_date` DATE COMMENT 'The date this version of the record ceases to be current, supporting SCD Type 2 historization. NULL indicates the current active record.',
    `follow_up_date` DATE COMMENT 'Scheduled date for the next follow-up contact or intervention with the patient.',
    `follow_up_notes` STRING COMMENT 'Notes documenting follow-up instructions, pending actions, or next steps for the patient or CHW.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up contact or intervention is needed after this session.',
    `funding_source` STRING COMMENT 'The funding source or grant that supports this intervention activity, used for program financial reporting and sustainability tracking.',
    `goal_progress_notes` STRING COMMENT 'Documentation of progress toward patient-defined health or social goals as part of the care plan.',
    `hcpcs_code` STRING COMMENT 'HCPCS Level II code for CHW services when applicable for Medicaid or Medicare billing.',
    `icd10_z_code` STRING COMMENT 'ICD-10-CM Z-code documenting the social determinant factor addressed, supporting clinical documentation and reimbursement.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter or translation service was used during the intervention.',
    `intervention_category` STRING COMMENT 'Broad category grouping the intervention by the health domain it addresses, used for population health analytics and program evaluation.',
    `intervention_date` DATE COMMENT 'The date on which the CHW intervention was performed or delivered to the patient.',
    `intervention_number` STRING COMMENT 'Business-facing unique number assigned to this intervention for tracking and communication purposes.',
    `intervention_type` STRING COMMENT 'Classification of the type of CHW intervention performed, such as health education, system navigation, patient advocacy, care coordination, resource connection, or follow-up contact.',
    `is_current` BOOLEAN COMMENT 'Flag indicating whether this is the most current version of the intervention record in the SCD Type 2 history.',
    `language_used` STRING COMMENT 'ISO 639-3 three-letter code for the language in which the intervention was conducted, supporting health equity and language access reporting.',
    `location_type` STRING COMMENT 'Type of physical or virtual location where the intervention took place.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the patient did not attend a scheduled in-person or virtual intervention session.',
    `notes` STRING COMMENT 'Free-text clinical and social notes documented by the CHW during or after the intervention, may contain PHI.',
    `outcome_description` STRING COMMENT 'Narrative description of the intervention outcome, documenting what was achieved or barriers encountered.',
    `outcome_status` STRING COMMENT 'Result classification indicating whether the intervention successfully addressed the identified need.',
    `patient_engagement_level` STRING COMMENT 'Assessment of the patients level of engagement and participation during the intervention session.',
    `priority` STRING COMMENT 'Priority level assigned to the intervention based on patient acuity, need severity, and risk stratification score.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this intervention contributes to a quality measure or HEDIS metric for population health reporting.',
    `resource_provided` STRING COMMENT 'Description of the specific community resource, service, or material provided to the patient during the intervention.',
    `risk_stratification_score` DECIMAL(18,2) COMMENT 'Patient risk score at the time of intervention, used to prioritize CHW outreach and measure impact on risk reduction.',
    `scheduled_date` DATE COMMENT 'The originally scheduled date for the intervention, used for adherence tracking and no-show analysis.',
    `sdoh_domain` STRING COMMENT 'The specific SDOH domain being addressed by this intervention, aligned with Healthy People 2030 and ICD-10 Z-code categories.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the CHW intervention session or activity began.',
    CONSTRAINT pk_chw_interventions PRIMARY KEY(`chw_interventions_id`)
) COMMENT 'Community health worker interventions';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`risk_stratification` (
    `risk_stratification_id` BIGINT COMMENT 'Primary key for risk_stratification',
    `care_site_id` BIGINT COMMENT 'Identifier of the care site or facility where the assessment was conducted.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the patients health plan at time of assessment, relevant for value-based care program alignment and payer reporting.',
    `clinician_id` BIGINT COMMENT 'Identifier of the primary care physician attributed to the patient for population health management and care coordination.',
    `risk_clinician_id` BIGINT COMMENT 'Identifier of the provider or community health worker who performed the risk assessment.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Risk stratification records belong to a patient. patient_id exists but has no FK. Adding mpi_record_id FK.',
    `risk_patient_mpi_record_id` BIGINT COMMENT 'Identifier of the patient being assessed for social determinants of health risk.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the risk stratification was performed, if applicable.',
    `assessment_date` DATE COMMENT 'Date on which the SDOH risk stratification assessment was performed.',
    `assessment_method` STRING COMMENT 'Method by which the SDOH screening was administered to the patient.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the risk stratification assessment was recorded in the system.',
    `assessment_tool_code` STRING COMMENT 'Code identifying the standardized screening tool used for SDOH risk assessment (e.g., PRAPARE, AHC-HRSN, WE-CARE, IHELP, or custom instrument).',
    `assessment_tool_version` STRING COMMENT 'Version number of the screening tool used, ensuring reproducibility and comparability of scores over time.',
    `care_gap_identified` BOOLEAN COMMENT 'Indicates whether the risk assessment identified gaps in preventive care or chronic disease management linked to social determinants.',
    `census_tract_code` STRING COMMENT '11-digit FIPS census tract code for the patients residence, used for geographic SDOH analysis and community resource mapping.',
    `composite_risk_score` DECIMAL(18,2) COMMENT 'Numeric composite score representing the aggregate SDOH risk level, typically on a 0-100 scale where higher values indicate greater social risk burden.',
    `confidence_level` STRING COMMENT 'Confidence level in the accuracy of the risk stratification based on data completeness, patient engagement, and screening tool validity.',
    `consent_to_share` BOOLEAN COMMENT 'Indicates whether the patient consented to share their SDOH information with community-based organizations for referral purposes.',
    `data_source` STRING COMMENT 'Primary source of data used to generate the risk stratification, indicating whether from patient screening, EHR data mining, claims analytics, or combined sources.',
    `ed_utilization_risk` STRING COMMENT 'Predicted risk level for avoidable emergency department utilization based on SDOH factors, supporting care management outreach prioritization.',
    `education_barrier_flag` BOOLEAN COMMENT 'Indicates whether the patient reports educational attainment barriers or health literacy challenges affecting care engagement.',
    `effective_from` DATE COMMENT 'Date from which this risk stratification record is considered the current active assessment for the patient, supporting SCD Type 2 historization.',
    `effective_to` DATE COMMENT 'Date until which this risk stratification record is considered current; null indicates the active record. Supports SCD Type 2 historization for temporal analytics.',
    `employment_status_concern` STRING COMMENT 'Patients employment status as it relates to SDOH risk, capturing unemployment or underemployment as social risk factors.',
    `financial_strain_flag` BOOLEAN COMMENT 'Indicates whether the patient screens positive for financial resource strain or inability to meet basic needs.',
    `food_insecurity_flag` BOOLEAN COMMENT 'Indicates whether the patient screens positive for food insecurity, mapped to ICD-10 Z59.4x codes.',
    `geographic_risk_index` DECIMAL(18,2) COMMENT 'Area-level deprivation or risk index score based on patients census tract or ZIP code, incorporating Area Deprivation Index or Social Vulnerability Index data.',
    `housing_instability_flag` BOOLEAN COMMENT 'Indicates whether the patient screens positive for housing instability or homelessness, mapped to ICD-10 Z59.0x codes.',
    `interpersonal_safety_flag` BOOLEAN COMMENT 'Indicates whether the patient screens positive for interpersonal violence or safety concerns in the home environment.',
    `intervention_type` STRING COMMENT 'Type of intervention recommended or initiated by the community health worker based on the risk assessment findings.',
    `is_current` BOOLEAN COMMENT 'Flag indicating whether this is the most recent active risk stratification for the patient, supporting SCD Type 2 pattern for Delta Lake temporal queries.',
    `language_barrier_noted` BOOLEAN COMMENT 'Indicates whether a language barrier was identified during the screening that may affect assessment accuracy or care navigation.',
    `need_closure_date` DATE COMMENT 'Date on which the identified SDOH need was resolved or closed, enabling measurement of time-to-resolution.',
    `need_closure_status` STRING COMMENT 'Tracks whether the identified SDOH need has been successfully addressed and closed through intervention or referral completion.',
    `notes` STRING COMMENT 'Free-text clinical notes or observations recorded by the assessor regarding the patients social circumstances and risk factors.',
    `primary_icd10_z_code` STRING COMMENT 'Primary ICD-10-CM Z-code representing the dominant social determinant identified during screening, used for clinical documentation and billing.',
    `prior_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score from the most recent previous assessment, enabling trend analysis and intervention effectiveness measurement.',
    `program_enrollment_code` STRING COMMENT 'Code identifying the population health or value-based care program under which this risk stratification was performed (e.g., ACO, PCMH, Medicaid waiver).',
    `readmission_risk` STRING COMMENT 'Predicted risk level for 30-day hospital readmission attributable to unmet social needs, used for discharge planning and transitions of care.',
    `reassessment_due_date` DATE COMMENT 'Scheduled date for the next SDOH risk reassessment, based on risk tier and organizational protocols.',
    `referral_organization_name` STRING COMMENT 'Name of the community-based organization or social service agency to which the patient was referred for SDOH need resolution.',
    `referral_status` STRING COMMENT 'Current status of the community-based organization referral generated from this risk assessment for need closure tracking.',
    `risk_category` STRING COMMENT 'Overall risk tier assigned to the patient based on composite SDOH scoring, used for population health segmentation and care management prioritization.',
    `risk_stratification_status` STRING COMMENT 'Lifecycle status of the risk stratification record indicating whether it is finalized, amended, or voided.',
    `score_change_direction` STRING COMMENT 'Direction of change in risk score compared to the prior assessment, supporting population health trend monitoring.',
    `screening_completion_pct` DECIMAL(18,2) COMMENT 'Percentage of screening questions answered by the patient, indicating completeness of the assessment data used for scoring.',
    `sdoh_domain` STRING COMMENT 'Primary Healthy People 2030 SDOH domain classification for the identified risk, aligning with the five key SDOH areas defined by HHS.',
    `secondary_icd10_z_code` STRING COMMENT 'Secondary ICD-10-CM Z-code for an additional social determinant identified, supporting comprehensive SDOH documentation.',
    `social_isolation_flag` BOOLEAN COMMENT 'Indicates whether the patient screens positive for social isolation or lack of adequate social support network.',
    `transportation_barrier_flag` BOOLEAN COMMENT 'Indicates whether the patient reports transportation barriers affecting access to healthcare services, mapped to ICD-10 Z59.82.',
    CONSTRAINT pk_risk_stratification PRIMARY KEY(`risk_stratification_id`)
) COMMENT 'Risk stratification based on SDOH';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`z_code_mapping` (
    `z_code_mapping_id` BIGINT COMMENT 'Primary key for z_code_mapping',
    `hedis_measure_id` BIGINT COMMENT 'The HEDIS measure identifier that references this Z-code for SDOH-related quality reporting, such as Social Need Screening and Intervention measures.',
    `snomed_concept_id` BIGINT COMMENT 'The SNOMED CT concept identifier that corresponds to this Z-code, enabling clinical terminology interoperability and semantic mapping across health information systems.',
    `clinical_documentation_guidance` STRING COMMENT 'Guidance text for clinical documentation improvement specialists and coders on when and how to assign this Z-code based on patient encounter documentation.',
    `cms_fiscal_year` STRING COMMENT 'The CMS fiscal year in which this Z-code was introduced or last updated in the ICD-10-CM code set. Used for version tracking and annual code set reconciliation.',
    `cms_quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this Z-code is included in CMS quality measure specifications (e.g., HEDIS, MIPS) for SDOH screening and intervention reporting requirements.',
    `code_description` STRING COMMENT 'The official ICD-10-CM long description of the Z-code as published by CMS, used for clinical documentation and coding reference.',
    `code_range_end` STRING COMMENT 'The ending code in the ICD-10-CM Z-code range that this mapping covers. Used in conjunction with code_range_start to define inclusive code groupings.',
    `code_range_start` STRING COMMENT 'The starting code in the ICD-10-CM Z-code range that this mapping covers. Enables grouping of related codes under a single SDOH category for bulk classification.',
    `code_version` STRING COMMENT 'The specific ICD-10-CM code set version (e.g., FY2024, FY2025) in which this mapping was validated. Ensures traceability to the authoritative code set release.',
    `effective_end_date` DATE COMMENT 'The date after which this Z-code mapping is no longer valid. Null indicates the mapping is currently active with no planned termination. Supports SCD Type 2 historization.',
    `effective_start_date` DATE COMMENT 'The date from which this Z-code mapping becomes effective for clinical documentation and coding purposes. Aligns with CMS fiscal year ICD-10-CM code set updates.',
    `equity_measure_flag` BOOLEAN COMMENT 'Indicates whether this Z-code is referenced in CMS health equity quality measures or stratification requirements for disparities reporting.',
    `fhir_condition_category` STRING COMMENT 'The FHIR Condition resource category value used when representing this SDOH finding in FHIR-based health information exchanges and interoperability transactions.',
    `fhir_value_set_uri` STRING COMMENT 'The canonical URI of the FHIR ValueSet that includes this Z-code, enabling automated terminology validation in FHIR-based clinical decision support and data exchange.',
    `gravity_code` STRING COMMENT 'The corresponding code from the HL7 Gravity Project SDOH Clinical Care standard, enabling interoperability between SDOH screening tools, EHR systems, and community-based organizations via FHIR resources.',
    `icd10_block` STRING COMMENT 'The ICD-10-CM block grouping (e.g., Z55-Z65 for persons with potential health hazards related to socioeconomic and psychosocial circumstances) for hierarchical classification.',
    `icd10_chapter` STRING COMMENT 'The ICD-10-CM chapter designation (Chapter 21: Factors influencing health status and contact with health services) for hierarchical code navigation and reporting grouping.',
    `icd10_code` STRING COMMENT 'The ICD-10-CM Z-code representing a social determinant of health factor. Z-codes (Z55-Z65) capture factors influencing health status and contact with health services, including socioeconomic circumstances, housing, education, and psychosocial factors.',
    `intervention_category` STRING COMMENT 'The recommended category of intervention for patients identified with this Z-code, such as resource navigation, case management, direct assistance, or community referral. Guides care coordination workflows.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this Z-code is a valid billable diagnosis code that can be submitted on claims. Only codes at the highest level of specificity are billable per CMS guidelines.',
    `is_primary_diagnosis_eligible` BOOLEAN COMMENT 'Indicates whether this Z-code can be reported as the principal or first-listed diagnosis on a claim. Some Z-codes are only valid as secondary diagnoses per ICD-10-CM coding guidelines.',
    `last_reviewed_date` DATE COMMENT 'The date this mapping was last reviewed by the clinical terminology or CDI team for accuracy and currency against the latest ICD-10-CM code set release.',
    `loinc_panel_code` STRING COMMENT 'The LOINC code for the SDOH screening panel or assessment instrument (e.g., AHC-HRSN, PRAPARE, HUNT) that typically generates this Z-code finding.',
    `mapping_confidence_level` STRING COMMENT 'The confidence level of the semantic mapping between the Z-code and the SDOH category, following HL7 concept map equivalence conventions (exact, broad, narrow, partial).',
    `mapping_source` STRING COMMENT 'The authoritative source or organization that established this particular Z-code to SDOH mapping (e.g., Gravity Project, internal CDI team, state Medicaid program).',
    `mapping_status` STRING COMMENT 'Current lifecycle status of this Z-code mapping record. Active mappings are used in production clinical workflows; deprecated mappings are retained for historical reference.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, coding tips, or implementation guidance for this Z-code mapping record.',
    `payer_acceptance_notes` STRING COMMENT 'Notes regarding payer-specific acceptance or rejection patterns for this Z-code, including known commercial payer limitations or Medicare/Medicaid coverage policies.',
    `population_prevalence_tier` STRING COMMENT 'Relative prevalence tier of this SDOH factor in the general patient population, used for population health analytics, resource planning, and community health needs assessments.',
    `referral_resource_type` STRING COMMENT 'The type of community-based organization or resource typically associated with addressing this SDOH need (e.g., food bank, housing authority, transportation service, legal aid, employment agency).',
    `reviewed_by` STRING COMMENT 'The name or identifier of the clinical terminologist, coder, or CDI specialist who last reviewed and validated this mapping.',
    `risk_domain` STRING COMMENT 'The specific risk domain this Z-code addresses for risk stratification purposes. Aligns with CMS quality measure stratification and Accountable Health Communities (AHC) model domains.',
    `screening_instrument` STRING COMMENT 'The name of the validated SDOH screening tool or assessment instrument associated with this Z-code (e.g., AHC-HRSN, PRAPARE, Hunger Vital Sign, PHQ-2, HITS). Used to trace the origin of SDOH documentation.',
    `sdoh_category` STRING COMMENT 'The primary SDOH domain category as defined by Healthy People 2030 framework. Maps the Z-code to one of the five core SDOH domains for population health stratification and intervention planning.',
    `sdoh_subcategory` STRING COMMENT 'A more granular classification within the SDOH category, such as food insecurity, housing instability, transportation barriers, unemployment, or social isolation. Used for targeted intervention matching and referral routing.',
    `severity_tier` STRING COMMENT 'The severity classification tier assigned to this Z-code for risk stratification and intervention prioritization. Determines urgency of community health worker outreach and referral management.',
    `sort_order` STRING COMMENT 'Numeric sort order for presenting Z-code mappings in clinical user interfaces, reports, and dropdown selections within EHR systems.',
    CONSTRAINT pk_z_code_mapping PRIMARY KEY(`z_code_mapping_id`)
) COMMENT 'Z‑code mapping table for SDOH';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh` (
    `sdoh_id` BIGINT COMMENT 'Primary key for sdoh',
    `chw_interventions` STRING COMMENT 'attribute',
    `need_closure_tracking` STRING COMMENT 'attribute',
    `referral_management` STRING COMMENT 'attribute',
    `risk_stratification` STRING COMMENT 'attribute',
    `z_code_mapping` STRING COMMENT 'attribute',
    CONSTRAINT pk_sdoh PRIMARY KEY(`sdoh_id`)
) COMMENT 'Table storing SDOH referrals and their outcomes.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` (
    `sdoh_subdomain_id` BIGINT COMMENT 'Primary key for sdoh_subdomain',
    `care_plan_id` BIGINT COMMENT 'Identifier of the associated care plan that incorporates this SDOH need as a goal or intervention target.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider or staff member who first identified and documented this SDOH need.',
    `employee_id` BIGINT COMMENT 'Identifier of the Community Health Worker assigned to manage this patients SDOH need, coordinate referrals, and perform follow-up interventions.',
    `facility_organization_id` BIGINT COMMENT 'Identifier of the community-based organization receiving the SDOH referral, linking to the organization registry.',
    `program_enrollment_id` BIGINT COMMENT 'Identifier linking to the specific social assistance program enrollment (e.g., SNAP, WIC, Section 8) that resulted from this SDOH referral.',
    `sdoh_assessment_id` BIGINT COMMENT 'Foreign key linking to patient.sdoh_assessment. Business justification: SDOH subdomain records capture screening results that originate from an SDOH assessment. Adding FK for traceability.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: SDOH subdomain records belong to a patient. patient_id exists but has no FK. Adding mpi_record_id FK.',
    `sdoh_patient_mpi_record_id` BIGINT COMMENT 'The patient for whom this SDOH need, referral, or intervention is documented.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which this SDOH need was identified or assessed.',
    `area_deprivation_index` STRING COMMENT 'National Area Deprivation Index ranking (1-100) for the patients neighborhood, with higher values indicating greater socioeconomic disadvantage.',
    `associated_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code for the clinical condition that is exacerbated by or related to this SDOH need (e.g., diabetes complicated by food insecurity).',
    `closure_reason` STRING COMMENT 'Reason for closing the SDOH need tracking record, documenting the outcome of intervention efforts.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether the patient provided consent for sharing SDOH information with community-based organizations and social service agencies.',
    `data_source_system` STRING COMMENT 'Source system from which the SDOH data was captured (e.g., Epic Healthy Planet, Salesforce Health Cloud, Unite Us, Aunt Bertha/findhelp).',
    `domain_category` STRING COMMENT 'Primary SDOH domain category as defined by the Gravity Project taxonomy. [ENUM-REF-CANDIDATE: food_insecurity|housing_instability|transportation|financial_strain|interpersonal_safety|education|social_isolation|employment|health_literacy|utilities|childcare|legal — promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which this SDOH subdomain record is considered active and clinically relevant.',
    `end_date` DATE COMMENT 'Date on which this SDOH subdomain record is no longer active, either due to resolution, patient relocation, or reassessment.',
    `episode_number` STRING COMMENT 'Sequential episode number for recurring SDOH needs, tracking how many times this specific need category has been identified for the patient.',
    `follow_up_count` STRING COMMENT 'Number of follow-up contacts or attempts made by the CHW or care team to address this specific SDOH need.',
    `follow_up_date` DATE COMMENT 'Scheduled date for the next follow-up contact with the patient to reassess the SDOH need status and intervention effectiveness.',
    `geographic_barrier_flag` BOOLEAN COMMENT 'Indicates whether the patient faces geographic barriers (e.g., rural location, food desert, transportation desert) that compound their SDOH needs.',
    `goal_description` STRING COMMENT 'Description of the patient-centered goal established to address this social determinant need (e.g., secure stable housing within 90 days).',
    `goal_status` STRING COMMENT 'Current status of the SDOH-related patient goal within the care plan.',
    `goal_target_date` DATE COMMENT 'Target date by which the SDOH-related goal is expected to be achieved.',
    `icd10_z_code` STRING COMMENT 'ICD-10-CM Z-code representing the specific social determinant factor (e.g., Z59.0 Homelessness, Z56.0 Unemployment). Used for claims documentation and population health analytics.',
    `identified_by_role` STRING COMMENT 'Role of the person who identified or documented the SDOH need during the care process.',
    `insurance_coverage_type` STRING COMMENT 'Patients insurance coverage type at the time of SDOH screening, relevant for understanding access barriers and eligibility for social programs.',
    `intervention_date` DATE COMMENT 'Date on which the Community Health Worker intervention was performed or the service was delivered to the patient.',
    `intervention_notes` STRING COMMENT 'Free-text notes documenting the details of the CHW intervention, patient response, barriers encountered, and next steps planned.',
    `intervention_outcome` STRING COMMENT 'Outcome of the Community Health Worker intervention indicating whether the social need was successfully addressed.',
    `intervention_type` STRING COMMENT 'Type of intervention performed by the Community Health Worker to address the identified social determinant need.',
    `is_recurring_need` BOOLEAN COMMENT 'Indicates whether this social determinant need is a recurring or chronic issue for the patient, requiring ongoing monitoring and intervention.',
    `language_barrier_flag` BOOLEAN COMMENT 'Indicates whether the patient has a language barrier that may impact SDOH screening accuracy, referral navigation, or service access.',
    `need_status` STRING COMMENT 'Current lifecycle status of the identified social determinant need from initial identification through resolution or patient declination.',
    `patient_zip_code` STRING COMMENT 'Patients ZIP code at the time of SDOH screening, used for geographic analysis, Area Deprivation Index mapping, and community resource matching.',
    `population_health_cohort` STRING COMMENT 'Population health management cohort to which this patient is assigned based on their SDOH risk profile (e.g., high-risk housing, food desert, dual-eligible).',
    `preferred_language_code` STRING COMMENT 'ISO 639 language code for the patients preferred language, used to match with linguistically appropriate community resources.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDOH subdomain record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this SDOH subdomain record.',
    `referral_closed_date` DATE COMMENT 'Date on which the SDOH referral was closed, either through successful service delivery, patient declination, or inability to contact.',
    `referral_date` DATE COMMENT 'Date on which the referral to a community-based organization or social service was initiated.',
    `referral_status` STRING COMMENT 'Current status of the community-based organization (CBO) referral generated to address the identified social need.',
    `referred_organization_name` STRING COMMENT 'Name of the community-based organization, social service agency, or resource to which the patient was referred for SDOH need resolution.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk stratification score derived from screening responses, indicating the degree of social risk impacting health outcomes. Higher values indicate greater risk.',
    `screening_date` DATE COMMENT 'Date on which the SDOH screening was administered to the patient.',
    `screening_instrument_code` STRING COMMENT 'Code identifying the validated screening tool used to assess social needs (e.g., PRAPARE, AHC-HRSN, HITS, PHQ-2). Maps to LOINC panel codes.',
    `screening_score_raw` STRING COMMENT 'Raw numeric score from the validated screening instrument before risk stratification interpretation.',
    `service_delivery_method` STRING COMMENT 'Method by which the SDOH intervention or service was delivered to the patient.',
    `severity_level` STRING COMMENT 'Assessed severity of the social determinant need based on screening score thresholds and clinical judgment, used for prioritization and risk stratification.',
    `snomed_condition_code` STRING COMMENT 'SNOMED CT concept ID representing the SDOH condition or finding identified during screening.',
    `time_to_first_contact_days` STRING COMMENT 'Number of days between referral initiation and first contact with the patient by the community-based organization or CHW.',
    `time_to_resolution_days` STRING COMMENT 'Number of days from SDOH need identification to resolution or closure, measuring the effectiveness of the intervention pathway.',
    CONSTRAINT pk_sdoh_subdomain PRIMARY KEY(`sdoh_subdomain_id`)
) COMMENT 'Table for SDOH subdomain with referral management, need closure tracking, CHW interventions, risk stratification, and Z‑code mapping.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` (
    `sdoh_referral_management_id` BIGINT COMMENT 'description',
    `care_site_id` BIGINT COMMENT 'description',
    `community_resource_id` BIGINT COMMENT 'Foreign key linking to patient.community_resource. Business justification: SDOH referral management directs patients to community-based organizations/resources. Adding FK to community_resource for the specific resource being referred to.',
    `facility_organization_id` BIGINT COMMENT 'STRING',
    `icd_code_id` BIGINT COMMENT 'BIGINT',
    `mpi_record_id` BIGINT COMMENT 'BIGINT',
    `referral_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.referral. Business justification: SDOH screening-to-PAC placement closed-loop workflow: when housing instability or transportation barriers identified via SDOH assessment trigger formal PAC referral (home health, SNF), this FK enables',
    `clinician_id` BIGINT COMMENT 'BIGINT',
    `sdoh_assessment_id` BIGINT COMMENT 'BIGINT',
    `visit_id` BIGINT COMMENT 'BIGINT',
    `z_code_mapping_id` BIGINT COMMENT 'description',
    `accepted_date` DATE COMMENT 'description',
    `cbo_acknowledgment_date` DATE COMMENT 'description',
    `closed_loop_confirmed_flag` BOOLEAN COMMENT 'description',
    `closed_loop_status_code` STRING COMMENT 'description',
    `completed_date` DATE COMMENT 'description',
    `confirmation_date` DATE COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `is_current` BOOLEAN COMMENT 'description',
    `notes` STRING COMMENT 'STRING',
    `outcome_code` STRING COMMENT 'STRING',
    `outcome_notes` STRING COMMENT 'description',
    `referral_category` STRING COMMENT 'description',
    `referral_date` DATE COMMENT 'DATE',
    `referral_outcome` STRING COMMENT 'description',
    `referral_priority_code` STRING COMMENT 'description',
    `referral_reason` STRING COMMENT 'description',
    `referral_reason_code` STRING COMMENT 'description',
    `referral_status` STRING COMMENT 'STRING',
    `referral_status_code` STRING COMMENT 'description',
    `referral_type_code` STRING COMMENT 'STRING',
    `sdoh_domain_category` STRING COMMENT 'description',
    `sdoh_domain_code` STRING COMMENT 'description',
    `service_delivery_date` DATE COMMENT 'description',
    `service_requested` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `valid_from` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_sdoh_referral_management PRIMARY KEY(`sdoh_referral_management_id`)
) COMMENT 'Referral management table for SDOH referrals.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` (
    `sdoh_need_closure_id` BIGINT COMMENT 'Primary key for sdoh_need_closure',
    `care_plan_id` BIGINT COMMENT 'Identifier of the patient care plan that included this SDOH need as a goal or intervention target.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider or community health worker who documented the need closure.',
    `sdoh_referral_management_id` BIGINT COMMENT 'Foreign key linking to patient.sdoh_referral_management. Business justification: SDOH need closure has referral_id (BIGINT) linking to the SDOH referral that initiated the need. Connecting to sdoh_referral_management.',
    `sdoh_assessment_id` BIGINT COMMENT 'Foreign key linking to patient.sdoh_assessment. Business justification: SDOH need closure tracks closure of needs identified during assessment. Adding FK to sdoh_assessment for traceability back to the screening that identified the need.',
    `sdoh_id` BIGINT COMMENT 'Identifier of the original SDOH need assessment record that this closure resolves.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: SDOH need closure records belong to a patient. patient_id exists but has no FK. Adding mpi_record_id FK.',
    `sdoh_patient_mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose SDOH need has been closed or resolved.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the need closure was documented or confirmed.',
    `barrier_to_resolution` STRING COMMENT 'Primary barrier encountered during the intervention process that impeded or delayed need resolution (e.g., language barrier, lack of transportation to services).',
    `cbo_name` STRING COMMENT 'Name of the community-based organization that provided services leading to need closure.',
    `closure_date` DATE COMMENT 'Date on which the SDOH need was formally closed or resolved in the care management system.',
    `closure_notes` STRING COMMENT 'Free-text clinical or care management notes documenting the circumstances and details of the need closure.',
    `closure_reason` STRING COMMENT 'Primary reason why the SDOH need was closed, indicating whether the underlying social determinant was addressed.',
    `closure_status` STRING COMMENT 'Current lifecycle status of the SDOH need closure indicating the outcome of the intervention or referral process.',
    `closure_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the need closure was recorded in the system, used for audit and workflow tracking.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this SDOH need closure record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this closure record originated (e.g., Epic Healthy Planet, Salesforce Health Cloud, Unite Us).',
    `days_to_closure` STRING COMMENT 'Number of calendar days between the initial SDOH need identification and formal closure, used for operational performance tracking.',
    `external_referral_tracking_number` STRING COMMENT 'Tracking number assigned by the external community-based organization or referral platform for cross-system reconciliation.',
    `followup_attempts` STRING COMMENT 'Total number of follow-up contact attempts made before the need was closed, indicating engagement effort.',
    `goal_achievement_status` STRING COMMENT 'Status indicating whether the care plan goal associated with this SDOH need was achieved at the time of closure.',
    `intervention_id` BIGINT COMMENT 'Identifier of the community health worker intervention that contributed to need closure.',
    `is_equity_flagged` BOOLEAN COMMENT 'Indicates whether this closure is flagged for health equity analysis, identifying disparities in SDOH need resolution across populations.',
    `is_patient_consent_obtained` BOOLEAN COMMENT 'Indicates whether patient consent was obtained for sharing SDOH information with community organizations during the closure process.',
    `is_recurring_need` BOOLEAN COMMENT 'Indicates whether this SDOH need has been identified and closed previously for the same patient, flagging chronic social instability.',
    `last_followup_date` DATE COMMENT 'Date of the most recent follow-up contact with the patient regarding this SDOH need prior to closure.',
    `loinc_code` STRING COMMENT 'LOINC code representing the specific SDOH screening question or panel used in the closure assessment.',
    `need_category` STRING COMMENT 'Category of the social determinant need that was addressed, aligned with Gravity Project value sets and ICD-10 Z-codes. [ENUM-REF-CANDIDATE: food_insecurity|housing_instability|transportation|financial_strain|social_isolation|education|employment|utilities|personal_safety|childcare|legal — promote to reference product]',
    `outcome_score` STRING COMMENT 'Numeric score (typically 1-10) representing the degree to which the patients social need was resolved at closure, used for quality measurement.',
    `patient_reported_outcome` STRING COMMENT 'Patients self-reported assessment of whether their social need has improved following intervention, captured during follow-up.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this closure event qualifies for inclusion in CMS or HEDIS quality measure reporting for SDOH screening and intervention.',
    `recurrence_count` STRING COMMENT 'Number of times this same category of SDOH need has been identified for the patient, supporting risk stratification.',
    `risk_level_at_closure` STRING COMMENT 'Patients SDOH risk stratification level at the time of need closure, indicating residual social vulnerability.',
    `screening_tool_used` STRING COMMENT 'Name of the validated screening tool used to assess need resolution (e.g., PRAPARE, AHC-HRSN, FIND tool).',
    `service_delivered` STRING COMMENT 'Description of the specific service or resource delivered to the patient that addressed the identified social need (e.g., food pantry enrollment, housing voucher).',
    `snomed_code` STRING COMMENT 'SNOMED CT concept code representing the SDOH finding or condition at closure for interoperability and clinical decision support.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp when this SDOH need closure record was last modified.',
    `verification_method` STRING COMMENT 'Method used to verify that the SDOH need was actually resolved before formal closure.',
    `z_code` STRING COMMENT 'ICD-10-CM Z-code representing the specific social determinant of health condition documented at closure (e.g., Z59.0 for homelessness).',
    CONSTRAINT pk_sdoh_need_closure PRIMARY KEY(`sdoh_need_closure_id`)
) COMMENT 'Need closure tracking table for SDOH interventions.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` (
    `sdoh_chw_intervention_id` BIGINT COMMENT 'description',
    `community_resource_id` BIGINT COMMENT 'Foreign key linking to patient.community_resource. Business justification: CHW interventions provide community resources to patients. Adding FK to community_resource for tracking which resource was provided.',
    `employee_id` BIGINT COMMENT 'BIGINT',
    `mpi_record_id` BIGINT COMMENT 'BIGINT',
    `sdoh_need_closure_id` BIGINT COMMENT 'description',
    `sdoh_need_closure_tracking_id` BIGINT COMMENT 'BIGINT',
    `sdoh_referral_management_id` BIGINT COMMENT 'description',
    `barriers_identified` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `duration_minutes` STRING COMMENT 'INT',
    `follow_up_date` DATE COMMENT 'description',
    `follow_up_needed_flag` BOOLEAN COMMENT 'description',
    `follow_up_required_flag` BOOLEAN COMMENT 'BOOLEAN',
    `intervention_date` DATE COMMENT 'DATE',
    `intervention_description` STRING COMMENT 'STRING',
    `intervention_duration_minutes` STRING COMMENT 'description',
    `intervention_mode_code` STRING COMMENT 'description',
    `intervention_notes` STRING COMMENT 'description',
    `intervention_type` STRING COMMENT 'STRING',
    `intervention_type_code` STRING COMMENT 'description',
    `location_type` STRING COMMENT 'STRING',
    `next_contact_date` DATE COMMENT 'description',
    `next_follow_up_date` DATE COMMENT 'description',
    `outcome_code` STRING COMMENT 'STRING',
    `outcome_notes` STRING COMMENT 'description',
    `patient_engagement_level_code` STRING COMMENT 'description',
    `resources_provided` STRING COMMENT 'STRING',
    `updated_at` TIMESTAMP COMMENT 'TIMESTAMP',
    CONSTRAINT pk_sdoh_chw_intervention PRIMARY KEY(`sdoh_chw_intervention_id`)
) COMMENT 'Community health worker (CHW) intervention tracking table.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_risk_stratification` (
    `sdoh_risk_stratification_id` BIGINT COMMENT 'description',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: AI governance and model lineage: SDOH risk scores are produced by ML models. FDA/CMS transparency requirements mandate documenting which model version generated each risk stratification for bias monit',
    `geographic_region_id` BIGINT COMMENT 'description',
    `mpi_record_id` BIGINT COMMENT 'BIGINT',
    `sdoh_assessment_id` BIGINT COMMENT 'BIGINT',
    `area_deprivation_index` DECIMAL(18,2) COMMENT 'INT',
    `assessment_date` DATE COMMENT 'DATE',
    `composite_sdoh_risk_score` DECIMAL(18,2) COMMENT 'description',
    `composite_social_risk_score` DECIMAL(18,2) COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `data_sources` STRING COMMENT 'STRING',
    `data_sources_used` STRING COMMENT 'description',
    `education_literacy_score` DECIMAL(18,2) COMMENT 'description',
    `financial_strain_flag` BOOLEAN COMMENT 'description',
    `financial_strain_score` DECIMAL(18,2) COMMENT 'DECIMAL(5,2)',
    `food_insecurity_flag` BOOLEAN COMMENT 'description',
    `food_insecurity_score` DECIMAL(18,2) COMMENT 'DECIMAL(5,2)',
    `housing_instability_flag` BOOLEAN COMMENT 'description',
    `housing_instability_score` DECIMAL(18,2) COMMENT 'DECIMAL(5,2)',
    `is_current` BOOLEAN COMMENT 'description',
    `next_reassessment_date` DATE COMMENT 'description',
    `risk_score` DECIMAL(18,2) COMMENT 'description',
    `risk_score_date` DATE COMMENT 'description',
    `risk_tier` STRING COMMENT 'STRING',
    `risk_tier_code` STRING COMMENT 'description',
    `scoring_model_version` STRING COMMENT 'STRING',
    `social_isolation_flag` BOOLEAN COMMENT 'description',
    `social_isolation_score` DECIMAL(18,2) COMMENT 'DECIMAL(5,2)',
    `social_vulnerability_index` DECIMAL(18,2) COMMENT 'DECIMAL(5,4)',
    `transportation_barrier_flag` BOOLEAN COMMENT 'description',
    `transportation_barrier_score` DECIMAL(18,2) COMMENT 'DECIMAL(5,2)',
    `updated_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `valid_from` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_sdoh_risk_stratification PRIMARY KEY(`sdoh_risk_stratification_id`)
) COMMENT 'Risk stratification table for SDOH.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` (
    `sdoh_zcode_mapping_id` BIGINT COMMENT 'Primary key for sdoh_zcode_mapping',
    `snomed_concept_id` BIGINT COMMENT 'The SNOMED CT concept identifier that corresponds to this SDOH Z-code, supporting clinical terminology mapping and interoperability across EHR systems.',
    `age_applicability` STRING COMMENT 'The patient age range for which this Z-code is clinically applicable (e.g., pediatric, adult, all ages), supporting clinical decision support and coding validation edits.',
    `ahc_domain` STRING COMMENT 'The CMS Accountable Health Communities model domain classification for this Z-code, aligning with the five core AHC screening domains for health-related social needs.',
    `billable_code_flag` BOOLEAN COMMENT 'Indicates whether this Z-code is a valid billable diagnosis code that can be submitted on claims (UB-04 or CMS-1500) as a primary or secondary diagnosis.',
    `clinical_documentation_guidance` STRING COMMENT 'Clinical documentation improvement guidance for providers on when and how to document this Z-code, supporting CDI programs and accurate SDOH capture in the EHR.',
    `cms_quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this Z-code is referenced in CMS quality measures, HEDIS measures, or value-based payment programs requiring SDOH documentation.',
    `code_category_range` STRING COMMENT 'The ICD-10-CM chapter/block range this Z-code belongs to (e.g., Z55-Z65 for persons with potential health hazards related to socioeconomic and psychosocial circumstances).',
    `code_description` STRING COMMENT 'The official long description of the ICD-10-CM Z-code as published in the CMS code set, used for clinical documentation and claims submission.',
    `code_specificity_level` STRING COMMENT 'The level of specificity of the Z-code: category (3-character), subcategory (4-5 character), or full_code (maximum specificity required for claims).',
    `coding_guideline_reference` STRING COMMENT 'Reference to the specific ICD-10-CM Official Coding Guideline section applicable to this Z-code (e.g., Section I.C.21 for factors influencing health status).',
    `effective_end_date` DATE COMMENT 'The date this Z-code was retired or replaced in the ICD-10-CM code set. Null indicates the code is currently active.',
    `effective_start_date` DATE COMMENT 'The date this Z-code became effective in the ICD-10-CM code set, used for temporal validity checking during claims processing and clinical documentation.',
    `fhir_condition_category` STRING COMMENT 'The FHIR Condition resource category code used when representing this SDOH Z-code in interoperability exchanges, supporting health information exchange (HIE) and care coordination.',
    `fiscal_year_introduced` STRING COMMENT 'The CMS fiscal year in which this Z-code was first introduced into the ICD-10-CM code set (e.g., FY2022), supporting version tracking and historical analysis.',
    `gender_applicability` STRING COMMENT 'The patient gender for which this Z-code is applicable, used in coding validation edits to prevent inappropriate code assignment.',
    `gravity_project_code` STRING COMMENT 'The corresponding code from the Gravity Project SDOH Clinical Care value sets, enabling interoperability with FHIR-based SDOH screening and referral workflows.',
    `healthy_people_2030_objective` STRING COMMENT 'The corresponding Healthy People 2030 objective identifier that this SDOH Z-code aligns with, supporting national health improvement priority tracking.',
    `icd10_code` STRING COMMENT 'The ICD-10-CM Z-code representing a social determinant of health factor. Z-codes (Z55-Z65) capture circumstances influencing health status and contact with health services related to social and economic factors.',
    `intervention_category` STRING COMMENT 'The category of community-based intervention or referral service typically associated with this SDOH need (e.g., housing assistance, food programs, employment services, transportation, utility assistance).',
    `last_reviewed_date` DATE COMMENT 'The date this mapping was last reviewed by clinical informatics or health information management staff for accuracy and currency.',
    `loinc_code` STRING COMMENT 'The LOINC code associated with the SDOH screening question or assessment panel that typically generates this Z-code diagnosis, linking screening instruments to coded outcomes.',
    `mapping_status` STRING COMMENT 'Current status of this Z-code mapping record indicating whether it is actively used, deprecated due to code retirement, or pending clinical informatics review.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, exceptions, or special considerations for this Z-code mapping that are not captured in structured fields.',
    `parent_code` STRING COMMENT 'The parent code in the ICD-10-CM hierarchy for this Z-code, enabling roll-up reporting and hierarchical navigation of SDOH categories.',
    `population_health_priority` STRING COMMENT 'The organizational priority level assigned to this SDOH factor for population health management initiatives, risk stratification, and community health worker intervention targeting.',
    `primary_diagnosis_eligible` BOOLEAN COMMENT 'Indicates whether this Z-code can be reported as the principal/primary diagnosis on a claim or encounter, per ICD-10-CM coding guidelines.',
    `reviewed_by` STRING COMMENT 'The identifier or name of the clinical informaticist or HIM professional who last reviewed and validated this mapping record.',
    `risk_adjustment_eligible` BOOLEAN COMMENT 'Indicates whether this Z-code is eligible for inclusion in CMS Hierarchical Condition Category (HCC) risk adjustment models or Medicare Advantage risk scoring.',
    `screening_instrument` STRING COMMENT 'The validated screening tool or assessment instrument commonly used to identify this SDOH need (e.g., PRAPARE, AHC-HRSN, HITS, PHQ-2, Hunger Vital Sign).',
    `sdoh_domain` STRING COMMENT 'The high-level SDOH domain category this Z-code maps to, such as economic stability, education access, healthcare access, neighborhood/built environment, or social/community context. [ENUM-REF-CANDIDATE: economic_stability|education_access|healthcare_access|neighborhood_environment|social_community_context|food_insecurity|housing_instability — promote to reference product]',
    `sdoh_subcategory` STRING COMMENT 'The specific subcategory within the SDOH domain, providing granular classification such as homelessness, food insecurity, unemployment, transportation barriers, or interpersonal violence.',
    `short_description` STRING COMMENT 'The abbreviated description of the ICD-10-CM Z-code used in clinical interfaces, charge capture screens, and summary reporting.',
    `sort_order` STRING COMMENT 'Numeric sort order for displaying Z-codes in clinical pick lists, screening result summaries, and reporting hierarchies.',
    `version_number` STRING COMMENT 'The version of this mapping record, incremented when SDOH domain assignments, terminology crosswalks, or clinical guidance are updated.',
    CONSTRAINT pk_sdoh_zcode_mapping PRIMARY KEY(`sdoh_zcode_mapping_id`)
) COMMENT 'Z‑code mapping table for SDOH codes.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking` (
    `sdoh_need_closure_tracking_id` BIGINT COMMENT 'BIGINT',
    `mpi_record_id` BIGINT COMMENT 'BIGINT',
    `sdoh_assessment_id` BIGINT COMMENT 'BIGINT',
    `sdoh_need_closure_id` BIGINT COMMENT 'description',
    `referral_management_id` BIGINT COMMENT 'description',
    `sdoh_referral_management_id` BIGINT COMMENT 'BIGINT',
    `actual_resolution_date` DATE COMMENT 'DATE',
    `closure_reason` STRING COMMENT 'description',
    `closure_reason_code` STRING COMMENT 'description',
    `closure_verification_method` STRING COMMENT 'description',
    `closure_verified_flag` BOOLEAN COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `follow_up_count` STRING COMMENT 'description',
    `follow_up_required_flag` BOOLEAN COMMENT 'description',
    `identified_date` DATE COMMENT 'DATE',
    `intervention_count` STRING COMMENT 'description',
    `is_current` BOOLEAN COMMENT 'description',
    `last_follow_up_date` DATE COMMENT 'description',
    `need_category` STRING COMMENT 'STRING',
    `need_category_code` STRING COMMENT 'description',
    `need_description` STRING COMMENT 'STRING',
    `need_status` STRING COMMENT 'description',
    `need_status_code` STRING COMMENT 'description',
    `next_follow_up_date` DATE COMMENT 'description',
    `priority_level` STRING COMMENT 'description',
    `sdoh_need_closure_tracking_status` STRING COMMENT 'description',
    `severity_level` STRING COMMENT 'description',
    `severity_level_code` STRING COMMENT 'description',
    `target_resolution_date` DATE COMMENT 'DATE',
    `updated_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `z_code` STRING COMMENT 'STRING',
    `valid_from` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_sdoh_need_closure_tracking PRIMARY KEY(`sdoh_need_closure_tracking_id`)
) COMMENT 'Table tracking SDOH need closure status.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` (
    `sdoh_z_code_mapping_id` BIGINT COMMENT 'description',
    `diagnosis_id` BIGINT COMMENT 'description',
    `icd_code_id` BIGINT COMMENT 'BIGINT',
    `mpi_record_id` BIGINT COMMENT 'BIGINT',
    `sdoh_assessment_id` BIGINT COMMENT 'BIGINT',
    `sdoh_need_closure_id` BIGINT COMMENT 'description',
    `sdoh_need_closure_tracking_id` BIGINT COMMENT 'description',
    `visit_id` BIGINT COMMENT 'description',
    `cms_required_flag` BOOLEAN COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `effective_date` DATE COMMENT 'DATE',
    `end_date` DATE COMMENT 'DATE',
    `gravity_project_code` STRING COMMENT 'description',
    `icd10_code` STRING COMMENT 'description',
    `icd10_description` STRING COMMENT 'description',
    `mapping_confidence_score` DECIMAL(18,2) COMMENT 'description',
    `mapping_source` STRING COMMENT 'description',
    `mapping_source_code` STRING COMMENT 'description',
    `screening_instrument` STRING COMMENT 'description',
    `screening_question_code` STRING COMMENT 'STRING',
    `screening_question_number` STRING COMMENT 'description',
    `screening_response_value` DECIMAL(18,2) COMMENT 'STRING',
    `sdoh_category` STRING COMMENT 'description',
    `sdoh_domain_category` STRING COMMENT 'description',
    `sdoh_domain_code` STRING COMMENT 'description',
    `sdoh_subcategory` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    `z_code` STRING COMMENT 'STRING',
    `z_code_description` STRING COMMENT 'STRING',
    CONSTRAINT pk_sdoh_z_code_mapping PRIMARY KEY(`sdoh_z_code_mapping_id`)
) COMMENT 'Table mapping SDOH Z‑codes to assessments.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` (
    `sdoh_chw_interventions_id` BIGINT COMMENT 'Primary key for sdoh_chw_interventions',
    `care_plan_id` BIGINT COMMENT 'The care plan this intervention is associated with, linking CHW activities to the patients overall care coordination.',
    `clinician_id` BIGINT COMMENT 'The licensed provider who supervises the CHW for clinical oversight and billing authorization purposes.',
    `community_resource_id` BIGINT COMMENT 'Foreign key linking to patient.community_resource. Business justification: sdoh_chw_interventions references community resources by name/type. Adding FK to community_resource. community_resource_name and community_resource_type are redundant via JOIN to community_resource (w',
    `employee_id` BIGINT COMMENT 'The community health worker who performed or is responsible for this intervention.',
    `referral_management_id` BIGINT COMMENT 'Foreign key linking to patient.referral_management. Business justification: sdoh_chw_interventions has referral_id (BIGINT) linking to the referral. Connecting to referral_management.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: SDOH CHW interventions records belong to a patient. patient_id exists but has no FK. Adding mpi_record_id FK.',
    `sdoh_patient_mpi_record_id` BIGINT COMMENT 'The patient who is the subject of this CHW intervention.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which this intervention was initiated or documented, if applicable.',
    `activity_description` STRING COMMENT 'Detailed narrative of the activities performed during this CHW intervention.',
    `barrier_identified` STRING COMMENT 'Description of barriers encountered during the intervention that prevented or hindered need closure (e.g., language, transportation, eligibility).',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this CHW intervention qualifies for reimbursement under applicable payer contracts or Medicaid CHW billing codes.',
    `cpt_code` STRING COMMENT 'The CPT code used for billing this CHW intervention when applicable (e.g., 98960-98962 for self-management education).',
    `delivery_mode` STRING COMMENT 'The modality through which the CHW intervention was delivered to the patient.',
    `documentation_complete` BOOLEAN COMMENT 'Indicates whether all required documentation for this intervention has been completed by the CHW.',
    `duration_minutes` STRING COMMENT 'Total duration of the intervention activity in minutes, used for productivity and workload analysis.',
    `end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the CHW intervention activity concluded.',
    `follow_up_count` STRING COMMENT 'Number of follow-up attempts made for this intervention to track engagement persistence.',
    `follow_up_date` DATE COMMENT 'The scheduled date for the next follow-up contact with the patient regarding this intervention.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up is needed after this intervention to ensure need closure.',
    `funding_source` STRING COMMENT 'The funding source or grant that supports this CHW intervention (e.g., Medicaid waiver, community benefit, federal grant).',
    `goal_description` STRING COMMENT 'Narrative description of the specific goal or objective this intervention aims to achieve for the patient.',
    `hipaa_authorization_type` STRING COMMENT 'Type of HIPAA authorization obtained for sharing patient information with external community organizations.',
    `icd10_z_code` STRING COMMENT 'The ICD-10 Z-code that maps to the social determinant being addressed (e.g., Z59.0 for homelessness, Z59.4 for food insecurity).',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter or translation service was used during the intervention.',
    `intervention_date` DATE COMMENT 'The date on which the CHW intervention was performed or delivered to the patient.',
    `intervention_number` STRING COMMENT 'Externally visible business identifier for the CHW intervention, used for tracking and communication.',
    `intervention_type` STRING COMMENT 'Classification of the CHW intervention activity type such as patient navigation, health education, advocacy, resource connection, follow-up, or screening.',
    `is_initial_contact` BOOLEAN COMMENT 'Indicates whether this is the first CHW contact with the patient for this particular SDOH need.',
    `language_used` STRING COMMENT 'ISO 639 language code indicating the language in which the intervention was conducted.',
    `location_address` STRING COMMENT 'The physical address where the intervention was conducted, particularly for home visits and community outreach.',
    `location_type` STRING COMMENT 'The type of setting where the intervention took place.',
    `need_closure_date` DATE COMMENT 'The date on which the SDOH need addressed by this intervention was confirmed as resolved or closed.',
    `outcome` STRING COMMENT 'The result or outcome of the intervention indicating whether the patients SDOH need was addressed.',
    `outcome_notes` STRING COMMENT 'Free-text notes documenting the outcome details, barriers encountered, and next steps.',
    `patient_consent_obtained` BOOLEAN COMMENT 'Indicates whether the patient provided consent for the CHW intervention and information sharing with community resources.',
    `patient_satisfaction_rating` STRING COMMENT 'Patient-reported satisfaction rating for this intervention on a 1-5 scale, used for quality improvement.',
    `priority` STRING COMMENT 'Priority level assigned to this intervention based on patient need severity and risk stratification.',
    `program_name` STRING COMMENT 'Name of the CHW program or grant-funded initiative under which this intervention is performed.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this CHW intervention record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this CHW intervention record was last modified.',
    `resource_connection_confirmed` BOOLEAN COMMENT 'Indicates whether the patient successfully connected with the referred community resource (closed-loop referral confirmation).',
    `resource_referral_made` BOOLEAN COMMENT 'Indicates whether a referral to a community resource or social service was made as part of this intervention.',
    `risk_score` DECIMAL(18,2) COMMENT 'The patients SDOH risk stratification score at the time of intervention, used to prioritize CHW caseload and measure impact.',
    `scheduled_date` DATE COMMENT 'The originally scheduled date for this intervention, used for planning and adherence tracking.',
    `screening_tool_used` STRING COMMENT 'Name of the validated SDOH screening instrument used to identify the need (e.g., PRAPARE, AHC-HRSN, WellRx).',
    `sdoh_chw_interventions_status` STRING COMMENT 'Current lifecycle status of the CHW intervention indicating its progress through the workflow.',
    `sdoh_domain` STRING COMMENT 'The SDOH domain being addressed by this intervention (e.g., food insecurity, housing instability, transportation barriers, financial strain, social isolation, education access). [ENUM-REF-CANDIDATE: food_insecurity|housing_instability|transportation|financial_strain|social_isolation|education|employment|safety|health_literacy|childcare|legal — promote to reference product]',
    `start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the CHW intervention activity began.',
    CONSTRAINT pk_sdoh_chw_interventions PRIMARY KEY(`sdoh_chw_interventions_id`)
) COMMENT 'Community health worker interventions table.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`sdoh_referral` (
    `sdoh_referral_id` BIGINT COMMENT 'Surrogate primary key for the SDOH referral record.',
    `community_resource_id` BIGINT COMMENT 'Foreign key linking to patient.community_resource. Business justification: SDOH referrals connect patients to community resources. Adding FK to community_resource for closed-loop referral tracking.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record identifying the patient for this SDOH referral.',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician identifying the provider who initiated the SDOH referral.',
    `sdoh_assessment_id` BIGINT COMMENT 'FK to patient.sdoh_assessment linking this referral to the originating SDOH screening.',
    `visit_id` BIGINT COMMENT 'FK to encounter.visit linking this referral to the encounter where the need was identified.',
    `closure_reason` STRING COMMENT 'Reason for referral closure: need_resolved, service_delivered, patient_declined, patient_unreachable, cbo_capacity_full, moved_out_of_area.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether patient consent was obtained before sharing information with the CBO.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this referral record was created.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether clinical follow-up is required after CBO engagement.',
    `is_current` BOOLEAN COMMENT 'SCD Type 2 flag indicating whether this is the current active version of the record.',
    `notes` STRING COMMENT 'Free-text notes about the referral, patient preferences, or special circumstances.',
    `priority_level` STRING COMMENT 'Urgency of the SDOH need: emergent, urgent, routine. Drives SLA for CBO response.',
    `referral_accepted_datetime` TIMESTAMP COMMENT 'Timestamp when the CBO acknowledged and accepted the referral.',
    `referral_closed_datetime` TIMESTAMP COMMENT 'Timestamp when the referral was closed (need met, unmet, or cancelled).',
    `referral_sent_datetime` TIMESTAMP COMMENT 'Timestamp when the referral was transmitted to the CBO or community resource.',
    `referral_source` STRING COMMENT 'Source of the referral: clinical_screening, self_report, care_manager, chw, community_partner, health_plan.',
    `referral_status` STRING COMMENT 'Current status of the referral: pending, sent, accepted, in_progress, completed, closed_met, closed_unmet, cancelled, expired.',
    `row_valid_from` TIMESTAMP COMMENT 'SCD Type 2 validity start timestamp for this record version.',
    `sdoh_need_category_code` STRING COMMENT 'High-level SDOH need category (e.g., food_insecurity, housing_instability, transportation, interpersonal_safety, utility_needs). Maps to Gravity Project value sets.',
    `sdoh_need_subcategory_code` STRING COMMENT 'Detailed SDOH need subcategory from Gravity Project taxonomy for granular classification.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the last update to this referral record.',
    `z_code` STRING COMMENT 'ICD-10-CM Z-code associated with this SDOH need (e.g., Z59.0 Homelessness, Z59.4 Lack of adequate food). Used for claims and quality reporting.',
    CONSTRAINT pk_sdoh_referral PRIMARY KEY(`sdoh_referral_id`)
) COMMENT 'Table for SDOH referral management.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient`.`community_resource` (
    `community_resource_id` BIGINT COMMENT 'Primary key for community_resource',
    `accepts_medicaid_flag` BOOLEAN COMMENT 'Indicates whether the community resource accepts Medicaid as a form of payment or eligibility verification for services rendered.',
    `accepts_uninsured_flag` BOOLEAN COMMENT 'Indicates whether the community resource provides services to individuals without health insurance coverage, important for SDOH referral matching.',
    `accessibility_features` STRING COMMENT 'Description of physical and communication accessibility features available at the resource location (e.g., wheelchair accessible, ASL interpreter, TTY line).',
    `address_line_1` STRING COMMENT 'Primary street address of the community resource location where services are delivered or where clients report for intake.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite number, building name, or floor for the community resource location.',
    `capacity_limit` STRING COMMENT 'Maximum number of individuals or families the community resource can serve at any given time, used for referral load balancing and waitlist management.',
    `city` STRING COMMENT 'City or municipality where the community resource is physically located.',
    `closed_loop_enabled_flag` BOOLEAN COMMENT 'Indicates whether this community resource supports closed-loop referral tracking, meaning they provide feedback on referral outcomes back to the referring healthcare organization.',
    `community_resource_category` STRING COMMENT 'Organizational category of the community resource provider, indicating the sector or entity type that operates the resource.',
    `community_resource_description` STRING COMMENT 'Detailed narrative description of the services, programs, and support offered by the community resource, including scope of assistance and target population served.',
    `community_resource_name` STRING COMMENT 'The official name of the community resource, organization, or program (e.g., Meals on Wheels of Greater Springfield, County Housing Authority Assistance Program).',
    `community_resource_status` STRING COMMENT 'Current operational status of the community resource indicating whether it is available for patient referrals and community health worker (CHW) interventions.',
    `contact_person_name` STRING COMMENT 'Name of the primary liaison or intake coordinator at the community resource who handles referrals from healthcare organizations.',
    `cost_to_client` STRING COMMENT 'Indicates the cost structure for clients accessing this community resource, enabling care coordinators to match patients with affordable services.',
    `county` STRING COMMENT 'County or parish where the community resource is located, important for jurisdictional eligibility and geographic service area determination.',
    `current_availability_flag` BOOLEAN COMMENT 'Indicates whether the community resource currently has capacity to accept new referrals. True means accepting referrals; false means at capacity or temporarily unavailable.',
    `data_sharing_consent_required_flag` BOOLEAN COMMENT 'Indicates whether patient consent is required before sharing patient information with this community resource as part of the referral process, per HIPAA and state privacy regulations.',
    `effective_end_date` DATE COMMENT 'Date after which this community resource is no longer available for referrals, representing program closure, contract expiration, or seasonal end date. Null for open-ended resources.',
    `effective_start_date` DATE COMMENT 'Date from which this community resource became available for referrals, representing the start of its operational period or contract term.',
    `eligibility_criteria` STRING COMMENT 'Description of eligibility requirements for accessing this community resource, including income thresholds, age ranges, residency requirements, or insurance status.',
    `email_address` STRING COMMENT 'Primary email contact for the community resource organization, used for electronic referral communication and follow-up.',
    `external_identifier` STRING COMMENT 'Externally-assigned unique code or identifier for the community resource, such as a 2-1-1 taxonomy code, NPI for qualifying organizations, or a community information exchange (CIE) registry ID.',
    `funding_source` STRING COMMENT 'Primary funding source for the community resource (e.g., federal grant, state block grant, private foundation, United Way), relevant for sustainability assessment and reporting.',
    `hours_of_operation` STRING COMMENT 'Structured or free-text description of the community resources operating hours and days of service availability (e.g., Mon-Fri 8:00AM-5:00PM).',
    `icd10_z_code` STRING COMMENT 'ICD-10-CM Z-code associated with the social determinant this resource addresses (e.g., Z59.0 for homelessness, Z59.4 for lack of adequate food), enabling clinical documentation linkage.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether this community resource operates only during specific seasons or time periods (e.g., winter heating assistance, summer meal programs).',
    `languages_offered` STRING COMMENT 'Comma-separated list of languages in which services are available at this community resource, critical for matching patients with language-appropriate services.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the community resource location, used for proximity-based referral matching and mapping.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the community resource location, used for proximity-based referral matching and mapping.',
    `notes` STRING COMMENT 'Free-text administrative notes about the community resource, including special instructions for referrals, known limitations, or internal coordination details.',
    `organization_name` STRING COMMENT 'Name of the parent or sponsoring organization that operates or funds this community resource, if different from the resource name itself.',
    `partnership_agreement_flag` BOOLEAN COMMENT 'Indicates whether the healthcare organization has a formal partnership or memorandum of understanding (MOU) with this community resource for closed-loop referral tracking.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the community resource, used by care coordinators and community health workers to initiate referrals.',
    `postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the community resource location, used for geographic matching of patients to nearby resources.',
    `quality_rating` DECIMAL(18,2) COMMENT 'Aggregate quality or satisfaction rating for the community resource based on patient feedback, care coordinator assessments, or accreditation scores, on a scale of 0.0 to 5.0.',
    `record_created_datetime` TIMESTAMP COMMENT 'Timestamp when this community resource record was first created in the system, supporting audit trail and data governance requirements.',
    `record_updated_datetime` TIMESTAMP COMMENT 'Timestamp when this community resource record was last modified, supporting data currency tracking and SCD Type 2 change detection.',
    `referral_method` STRING COMMENT 'Preferred or accepted method for submitting referrals to this community resource from healthcare organizations or community health workers.',
    `referral_turnaround_days` STRING COMMENT 'Expected number of business days from referral submission to initial client contact or service initiation, used for setting patient expectations and follow-up scheduling.',
    `resource_type` STRING COMMENT 'Primary classification of the community resource by the type of social need it addresses. Aligns with SDOH domains. [ENUM-REF-CANDIDATE: food_assistance|housing|transportation|employment|education|behavioral_health|legal_services|financial_assistance|childcare|utilities|clothing|substance_use — promote to reference product]',
    `sdoh_domain_code` STRING COMMENT 'Standardized code representing the SDOH domain addressed by this resource, aligned with the Gravity Project value sets (e.g., food insecurity, housing instability, transportation access).',
    `seasonal_availability_notes` STRING COMMENT 'Description of seasonal availability windows for resources that do not operate year-round (e.g., November through March for heating assistance).',
    `service_area_description` STRING COMMENT 'Narrative description of the geographic area served by this community resource (e.g., All of Franklin County, ZIP codes 43201-43215), used for eligibility determination.',
    `state_code` STRING COMMENT 'Two-letter state or territory code for the community resource location, per USPS standards.',
    `taxonomy_code` STRING COMMENT 'Alliance of Information and Referral Systems (AIRS) taxonomy code classifying the specific service type offered, enabling standardized categorization across community information exchanges.',
    `transportation_available_flag` BOOLEAN COMMENT 'Indicates whether the community resource provides or arranges transportation for clients to access services, critical for patients with transportation barriers.',
    `verification_date` DATE COMMENT 'Date when the community resource information was last verified for accuracy by a care coordinator, community health worker, or resource directory administrator.',
    `verified_by` STRING COMMENT 'Name or identifier of the staff member who last verified the accuracy of this community resource record.',
    `website_url` STRING COMMENT 'Official website URL for the community resource where patients and care teams can find additional information about services and eligibility.',
    CONSTRAINT pk_community_resource PRIMARY KEY(`community_resource_id`)
) COMMENT 'Master reference table for community_resource. Referenced by community_resource_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ADD CONSTRAINT `fk_patient_demographics_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ADD CONSTRAINT `fk_patient_address_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ADD CONSTRAINT `fk_patient_guarantor_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ADD CONSTRAINT `fk_patient_emergency_contact_alternate_contact_emergency_contact_id` FOREIGN KEY (`alternate_contact_emergency_contact_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`emergency_contact`(`emergency_contact_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ADD CONSTRAINT `fk_patient_emergency_contact_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_emergency_contact_id` FOREIGN KEY (`emergency_contact_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`emergency_contact`(`emergency_contact_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_attribution_panel_id` FOREIGN KEY (`attribution_panel_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`attribution_panel`(`attribution_panel_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ADD CONSTRAINT `fk_patient_portal_account_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ADD CONSTRAINT `fk_patient_proxy_access_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_communication_campaign_id` FOREIGN KEY (`communication_campaign_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`communication_campaign`(`communication_campaign_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_message_template_id` FOREIGN KEY (`message_template_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`message_template`(`message_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_message_template_id` FOREIGN KEY (`message_template_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`message_template`(`message_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_referral_patient_mpi_record_id` FOREIGN KEY (`referral_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_need_patient_mpi_record_id` FOREIGN KEY (`need_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_prior_closure_tracking_need_closure_tracking_id` FOREIGN KEY (`prior_closure_tracking_need_closure_tracking_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`need_closure_tracking`(`need_closure_tracking_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_referral_management_id` FOREIGN KEY (`referral_management_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`referral_management`(`referral_management_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_need_closure_tracking_id` FOREIGN KEY (`need_closure_tracking_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`need_closure_tracking`(`need_closure_tracking_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_chw_need_need_closure_tracking_id` FOREIGN KEY (`chw_need_need_closure_tracking_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`need_closure_tracking`(`need_closure_tracking_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_chw_patient_mpi_record_id` FOREIGN KEY (`chw_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_referral_management_id` FOREIGN KEY (`referral_management_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`referral_management`(`referral_management_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ADD CONSTRAINT `fk_patient_risk_stratification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ADD CONSTRAINT `fk_patient_risk_stratification_risk_patient_mpi_record_id` FOREIGN KEY (`risk_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_program_enrollment_id` FOREIGN KEY (`program_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`program_enrollment`(`program_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_sdoh_patient_mpi_record_id` FOREIGN KEY (`sdoh_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_z_code_mapping_id` FOREIGN KEY (`z_code_mapping_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`z_code_mapping`(`z_code_mapping_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_referral_management_id` FOREIGN KEY (`sdoh_referral_management_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_referral_management`(`sdoh_referral_management_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_id` FOREIGN KEY (`sdoh_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh`(`sdoh_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_patient_mpi_record_id` FOREIGN KEY (`sdoh_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ADD CONSTRAINT `fk_patient_sdoh_chw_intervention_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ADD CONSTRAINT `fk_patient_sdoh_chw_intervention_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ADD CONSTRAINT `fk_patient_sdoh_chw_intervention_sdoh_need_closure_id` FOREIGN KEY (`sdoh_need_closure_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_need_closure`(`sdoh_need_closure_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ADD CONSTRAINT `fk_patient_sdoh_chw_intervention_sdoh_need_closure_tracking_id` FOREIGN KEY (`sdoh_need_closure_tracking_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking`(`sdoh_need_closure_tracking_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ADD CONSTRAINT `fk_patient_sdoh_chw_intervention_sdoh_referral_management_id` FOREIGN KEY (`sdoh_referral_management_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_referral_management`(`sdoh_referral_management_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_risk_stratification` ADD CONSTRAINT `fk_patient_sdoh_risk_stratification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_risk_stratification` ADD CONSTRAINT `fk_patient_sdoh_risk_stratification_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking` ADD CONSTRAINT `fk_patient_sdoh_need_closure_tracking_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking` ADD CONSTRAINT `fk_patient_sdoh_need_closure_tracking_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking` ADD CONSTRAINT `fk_patient_sdoh_need_closure_tracking_sdoh_need_closure_id` FOREIGN KEY (`sdoh_need_closure_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_need_closure`(`sdoh_need_closure_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking` ADD CONSTRAINT `fk_patient_sdoh_need_closure_tracking_referral_management_id` FOREIGN KEY (`referral_management_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`referral_management`(`referral_management_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking` ADD CONSTRAINT `fk_patient_sdoh_need_closure_tracking_sdoh_referral_management_id` FOREIGN KEY (`sdoh_referral_management_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_referral_management`(`sdoh_referral_management_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ADD CONSTRAINT `fk_patient_sdoh_z_code_mapping_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ADD CONSTRAINT `fk_patient_sdoh_z_code_mapping_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ADD CONSTRAINT `fk_patient_sdoh_z_code_mapping_sdoh_need_closure_id` FOREIGN KEY (`sdoh_need_closure_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_need_closure`(`sdoh_need_closure_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ADD CONSTRAINT `fk_patient_sdoh_z_code_mapping_sdoh_need_closure_tracking_id` FOREIGN KEY (`sdoh_need_closure_tracking_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking`(`sdoh_need_closure_tracking_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ADD CONSTRAINT `fk_patient_sdoh_chw_interventions_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ADD CONSTRAINT `fk_patient_sdoh_chw_interventions_referral_management_id` FOREIGN KEY (`referral_management_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`referral_management`(`referral_management_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ADD CONSTRAINT `fk_patient_sdoh_chw_interventions_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ADD CONSTRAINT `fk_patient_sdoh_chw_interventions_sdoh_patient_mpi_record_id` FOREIGN KEY (`sdoh_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`patient` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `healthcare_ecm_v1`.`patient` SET TAGS ('dbx_domain' = 'patient');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Patient Index Record ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_add_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_rls_predicate' = 'patient_id = current_user()');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_unity_catalog_tag' = 'hipaa_retention');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `approving_analyst` SET TAGS ('dbx_business_glossary_term' = 'Approving Analyst');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `approving_analyst` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `approving_analyst` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `city` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `consent_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Consent Last Updated');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|revoked|pending|exempt|partial|unknown');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `country` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `country` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `country` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Death');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_business_glossary_term' = 'Deceased Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `duplicate_flag` SET TAGS ('dbx_business_glossary_term' = 'Potential Duplicate Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_identifier` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `external_identifier` SET TAGS ('dbx_business_glossary_term' = 'External Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `external_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `external_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `external_identifier_source` SET TAGS ('dbx_business_glossary_term' = 'External Identifier Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Family Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown|undifferentiated|not_specified');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Given Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|partnered');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `match_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Match Algorithm');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `merge_history` SET TAGS ('dbx_business_glossary_term' = 'Merge History');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Middle Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_add_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_entity_type' = 'Add tags pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Identifier Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_value_regex' = 'mrn|national_id|insurance_id|passport|driver_license|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_sensitive' = 'pii_sensitive');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `privacy_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Privacy Restriction Level');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `privacy_restriction_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical|restricted|confidential');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `race` SET TAGS ('dbx_business_glossary_term' = 'Race');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|duplicate|archived|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'SDOH Assessment Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_assessment_score` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_assessment_score` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_assessment_score` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_need_closure_date` SET TAGS ('dbx_business_glossary_term' = 'SDOH Need Closure Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_need_closure_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_need_closure_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_need_closure_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_referral_status` SET TAGS ('dbx_business_glossary_term' = 'SDOH Referral Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_referral_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected|completed|on_hold');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_referral_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_referral_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `sdh_referral_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `state` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_unity_catalog_tag' = 'hipaa_retention');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `external_id` SET TAGS ('dbx_business_glossary_term' = 'External Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `external_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `external_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `primary_care_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_cause` SET TAGS ('dbx_business_glossary_term' = 'Cause of Death');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_cause` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_cause` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Death Certificate Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Death');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_manner` SET TAGS ('dbx_business_glossary_term' = 'Manner of Death');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_manner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `death_manner` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Full Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity (Self‑Reported)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (Legal)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_add_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_classification_example' = 'Add tags pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `food_insecurity_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Insecurity Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|nonbinary|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 1');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_business_glossary_term' = 'Home City');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_country` SET TAGS ('dbx_business_glossary_term' = 'Home Country (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_business_glossary_term' = 'Home State');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_zip` SET TAGS ('dbx_business_glossary_term' = 'Home ZIP/Postal Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_zip` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `home_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `housing_status` SET TAGS ('dbx_business_glossary_term' = 'Housing Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Income Bracket');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `is_deceased` SET TAGS ('dbx_business_glossary_term' = 'Deceased Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `is_deceased` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `is_deceased` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `language_barrier_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Barrier Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (Family)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `last_name` SET TAGS ('dbx_add_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `last_name` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_country` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_business_glossary_term' = 'Mailing State');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_zip` SET TAGS ('dbx_business_glossary_term' = 'Mailing ZIP/Postal Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_zip` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `mailing_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|partnered');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `national_identifier` SET TAGS ('dbx_business_glossary_term' = 'National Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `national_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `national_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `preferred_language` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `preferred_language` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `race` SET TAGS ('dbx_business_glossary_term' = 'Race (Self‑Reported)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `race` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `race` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `sex_assigned_at_birth` SET TAGS ('dbx_business_glossary_term' = 'Sex Assigned at Birth');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `sex_assigned_at_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `sex_assigned_at_birth` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `social_security_number` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `social_security_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `social_security_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `transportation_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Access Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `national_id` SET TAGS ('dbx_business_glossary_term' = 'National Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `national_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `national_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ALTER COLUMN `primary_care_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ADDR_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FAC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `care_site_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `care_site_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_description` SET TAGS ('dbx_business_glossary_term' = 'Address Description (ADDR_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_description` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type (ADDR_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|mailing|temporary|work|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract (CENSUS_TRACT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3) (COUNTRY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County (COUNTY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `do_not_mail_flag` SET TAGS ('dbx_business_glossary_term' = 'Do‑Not‑Mail Flag (DO_NOT_MAIL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy (GEOCODE_ACC)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `is_mailing` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Flag (IS_MAILING)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag (IS_PRIMARY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `is_temporary` SET TAGS ('dbx_business_glossary_term' = 'Temporary Address Flag (IS_TEMPORARY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR_LINE1)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR_LINE2)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3 (ADDR_LINE3)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z -]{3,10}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (SRC_REC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code (STATE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `state` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `street` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `street` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `street` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `street_address` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Validation Source (VAL_SOURCE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_value_regex' = 'system|manual|third_party');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status (VAL_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FAC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `facility_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `facility_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Address Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ALTER COLUMN `source_record_id` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (SRC_REC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` SET TAGS ('dbx_subdomain' = 'coverage_eligibility');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Network ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `payer_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `payer_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `benefit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `benefit_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Units');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `claim_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Method');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `claim_submission_method` SET TAGS ('dbx_value_regex' = 'EDI|Web|Phone|Fax');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `claim_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `claim_submission_status` SET TAGS ('dbx_value_regex' = 'allowed|denied|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `cob_priority` SET TAGS ('dbx_business_glossary_term' = 'COB Priority');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_notes` SET TAGS ('dbx_business_glossary_term' = 'Coverage Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_number` SET TAGS ('dbx_business_glossary_term' = 'Coverage Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx|mental_health');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_details` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Details');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `member_number` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Maximum');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|POS|Medicare|Medicaid|Self-Pay');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `pre_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Authorization Required Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `prior_auth_requirement` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Requirement');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `prior_auth_requirement` SET TAGS ('dbx_value_regex' = 'required|not_required|conditional');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `sdoh_z_code` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health Z‑Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|failed');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ALTER COLUMN `network_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Network ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` SET TAGS ('dbx_subdomain' = 'coverage_eligibility');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_verified` SET TAGS ('dbx_business_glossary_term' = 'Address Verified Flag (ADDR_VERIFIED)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `address_verified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status (COL_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'current|delinquent|written_off|in_collection');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country (COUNTRY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating (CREDIT_RATING)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `credit_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|unknown');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `credit_rating` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score (CREDIT_SCORE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `credit_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `demographic_age` SET TAGS ('dbx_business_glossary_term' = 'Age (AGE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `demographic_gender` SET TAGS ('dbx_business_glossary_term' = 'Gender (GENDER)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `demographic_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `demographic_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `email_verified` SET TAGS ('dbx_business_glossary_term' = 'Email Verified Flag (EMAIL_VERIFIED)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `email_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `email_verified` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `employer_contact` SET TAGS ('dbx_business_glossary_term' = 'Employer Contact (EMP_CONTACT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('dbx_business_glossary_term' = 'Employer Name (EMPLOYER)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Full Name (NAME)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Type (TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_value_regex' = 'individual|organization');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `is_primary_guarantor` SET TAGS ('dbx_business_glossary_term' = 'Primary Guarantor Flag (PRIMARY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date (LAST_PAY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name (LEGAL_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Notes (NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method (PAY_METHOD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|credit_card|bank_transfer|online|cash');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_number` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_verified` SET TAGS ('dbx_business_glossary_term' = 'Phone Verified Flag (PHONE_VERIFIED)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `phone_verified` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `relationship_to_patient` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Patient (REL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `relationship_to_patient` SET TAGS ('dbx_value_regex' = 'self|spouse|parent|child|guardian|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `responsibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Percentage (PCT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (Masked) (SSN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TAX_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `total_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Responsibility Amount (TOTAL_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `total_responsibility_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `total_responsibility_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `tax_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TAX_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`guarantor` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `alternate_contact_emergency_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Alternate Contact ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDRESS1)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDRESS2)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level (AUTH_LEVEL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'phi|healthcare_proxy|legal_guardian|none');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `authorized_to_receive_phi` SET TAGS ('dbx_business_glossary_term' = 'Authorized to Receive PHI (PHI_AUTH)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date (CONSENT_EXP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_given_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Date (CONSENT_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type (CONTACT_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'personal|professional|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Deceased Date (DECEASED_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `emergency_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `emergency_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deceased');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Full Name (NAME)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `is_deceased` SET TAGS ('dbx_business_glossary_term' = 'Is Deceased (DECEASED)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact (PRIMARY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG_PREF)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp (VERIFIED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_business_glossary_term' = 'Home Phone Number (HOME_PHONE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_value_regex' = '^[2-9]d{2}[2-9]d{2}d{4}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number (MOBILE_PHONE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_value_regex' = '^[2-9]d{2}[2-9]d{2}d{4}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_entity_type' = 'pii_phi');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number (WORK_PHONE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_value_regex' = '^[2-9]d{2}[2-9]d{2}d{4}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method (PREF_METHOD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|sms');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'Priority Order (PRIORITY)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `relationship_to_patient` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Patient (REL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (SRC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VERIF_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deceased');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `source_system_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (SRC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`emergency_contact` ALTER COLUMN `alternate_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Alternate Contact ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` SET TAGS ('dbx_patient_sdoh_assessment' = 'Expanded SDOH subdomain with referral management');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` SET TAGS ('dbx_need_closure' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` SET TAGS ('dbx_CHW_interventions' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` SET TAGS ('dbx_risk_stratification' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` SET TAGS ('dbx_Z‑code_mapping' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health Assessment ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_location` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_business_glossary_term' = 'Assessor Role');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_value_regex' = 'social_worker|case_manager|nurse|counselor');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `external_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'External Assessment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `financial_strain_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Strain Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `food_insecurity_score` SET TAGS ('dbx_business_glossary_term' = 'Food Insecurity Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `housing_instability_score` SET TAGS ('dbx_business_glossary_term' = 'Housing Instability Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `identified_needs` SET TAGS ('dbx_business_glossary_term' = 'Identified Needs');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `interpersonal_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Interpersonal Safety Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `patient_consent` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent for SDOH Data Sharing');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `reassessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Due Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_disposition` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_disposition` SET TAGS ('dbx_value_regex' = 'referred|self_resolved|no_action|declined');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `screening_tool` SET TAGS ('dbx_business_glossary_term' = 'Screening Tool');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `screening_tool` SET TAGS ('dbx_value_regex' = 'ahc_hrs|prapare|hunger_vital_sign|whoqol');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `social_isolation_score` SET TAGS ('dbx_business_glossary_term' = 'Social Isolation Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `transportation_score` SET TAGS ('dbx_business_glossary_term' = 'Transportation Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `external_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'External Assessment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `referral_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Resource Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessor_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessor_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `assessor_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` SET TAGS ('dbx_subdomain' = 'engagement_outreach');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Identifier (PCP_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Pharmacy Identifier (PFI)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `accessibility_needs` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Needs (AN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `care_setting_preference` SET TAGS ('dbx_business_glossary_term' = 'Care Setting Preference (CSP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `care_setting_preference` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|telehealth|home|rehab');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `consent_for_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag (MCF)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `cultural_preference` SET TAGS ('dbx_business_glossary_term' = 'Cultural Preference (CP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `interpreter_needed` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Needed Flag (IN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `language_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency Level (LPL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `language_proficiency_level` SET TAGS ('dbx_value_regex' = 'basic|conversational|fluent|native');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp (LUT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes (PN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `opt_out_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Opt-Out Flag (SMS_OO)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `patient_bigint_surrogate_key_for_clean_keying` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `portal_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Portal Enrollment Status (PES)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `portal_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preference_bigint_surrogate_key_for_clean_keying` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preference_category` SET TAGS ('dbx_business_glossary_term' = 'Preference Category (PCAT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preference_category` SET TAGS ('dbx_value_regex' = 'communication|pharmacy|accessibility|cultural|religious');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Status (PRS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel (PCC)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'phone|email|portal|mail|text');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preferred_contact_time` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Time (PCT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language (PL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preferred_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Notification Method (PNM)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preferred_notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `religious_preference` SET TAGS ('dbx_business_glossary_term' = 'Religious Preference (RP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `patient_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Full Name (PFN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `patient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `patient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `preferred_pharmacy_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Pharmacy Identifier (PFI)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `primary_care_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Identifier (PCP_ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name (ECN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone (ECP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Status (PRS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` SET TAGS ('dbx_subdomain' = 'population_stratification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `pcp_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician Attribution ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Attribution Confidence Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_method` SET TAGS ('dbx_business_glossary_term' = 'Attribution Method');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_method` SET TAGS ('dbx_value_regex' = 'claims|enrollment|manual|algorithmic');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|shared');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Attribution Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'ACO|HMO|PPO|POS|Medicaid|Medicare');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Provider National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `reason_for_attribution` SET TAGS ('dbx_business_glossary_term' = 'Reason for Attribution');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_panel` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`pcp_attribution` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` SET TAGS ('dbx_subdomain' = 'coverage_eligibility');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `eligibility_check_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `coinsurance_percent` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `copay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending|error');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_address` SET TAGS ('dbx_business_glossary_term' = 'Patient Address');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_dob` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_dob` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_dob` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Full Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_phone` SET TAGS ('dbx_business_glossary_term' = 'Patient Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `prior_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Request Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `request_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Request Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Response Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'edi_270|portal|phone');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_source_system` SET TAGS ('dbx_business_glossary_term' = 'Verification Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Custom|Other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Request Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ALTER COLUMN `benefit_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Staff ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Registration Completeness Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'photo_id|insurance_card|biometric');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `is_test_event` SET TAGS ('dbx_business_glossary_term' = 'Test Event Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `patient_dob` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `patient_dob` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `patient_dob` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_event_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_event_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_event_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled|merged|unmerged');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_source` SET TAGS ('dbx_value_regex' = 'ed_walk_in|scheduled|transfer|online_pre_registration');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'new|pre_registration|update|merge|unmerge');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|MEDITECH|Other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `registration_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Staff ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled|merged|unmerged');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `identity_merge_history_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Merge History ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Analyst ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit User ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `duplicate_count` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `identity_label` SET TAGS ('dbx_business_glossary_term' = 'Identity Label');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `identity_label` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `identity_label` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|merged|reversed|inactive');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `linked_records_count` SET TAGS ('dbx_business_glossary_term' = 'Linked Records Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Merge Algorithm');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Merge Batch ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Merge Confidence Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_rationale` SET TAGS ('dbx_business_glossary_term' = 'Merge Rationale');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Merge Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_type` SET TAGS ('dbx_business_glossary_term' = 'Merge Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_type` SET TAGS ('dbx_value_regex' = 'manual|automatic|rule_based');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_mrn` SET TAGS ('dbx_business_glossary_term' = 'Non-Surviving Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `non_surviving_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `patient_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `patient_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|telehealth');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `primary_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `primary_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_mrn` SET TAGS ('dbx_business_glossary_term' = 'Surviving Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `surviving_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `approving_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Analyst ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `audit_user_id` SET TAGS ('dbx_business_glossary_term' = 'Audit User ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ALTER COLUMN `merge_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Merge Batch ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` SET TAGS ('dbx_subdomain' = 'population_stratification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_id` SET TAGS ('dbx_business_glossary_term' = 'Flag ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Psychiatric Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Sud Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Flagging Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `sdoh_referral_id` SET TAGS ('dbx_business_glossary_term' = 'SDOH Referral Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `alert_code` SET TAGS ('dbx_business_glossary_term' = 'Alert Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Flag Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_category` SET TAGS ('dbx_business_glossary_term' = 'Flag Category');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_category` SET TAGS ('dbx_value_regex' = 'clinical|administrative|financial|safety|legal|sdoh');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_code` SET TAGS ('dbx_business_glossary_term' = 'Flag Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_description` SET TAGS ('dbx_business_glossary_term' = 'Flag Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_name` SET TAGS ('dbx_business_glossary_term' = 'Flag Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_status` SET TAGS ('dbx_business_glossary_term' = 'Flag Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_status` SET TAGS ('dbx_value_regex' = 'active|inactive|resolved');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_type` SET TAGS ('dbx_business_glossary_term' = 'Flag Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flag_type` SET TAGS ('dbx_value_regex' = 'allergy|fall_risk|behavioral|financial|language|infection_precaution');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `need_closure` SET TAGS ('dbx_business_glossary_term' = 'Need Closure Indicator');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Flag Onset Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Flag Priority Level');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergency');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Flag Resolution Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Flag Review Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|closed');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `sdhz_code` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Flag Severity');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Meditech|Custom');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Flag Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `flagged_by_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Flagging Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `related_encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Related Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `sdhz_referral_id` SET TAGS ('dbx_business_glossary_term' = 'SDOH Referral Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` SET TAGS ('dbx_subdomain' = 'population_stratification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `population_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Population Segment ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `avg_age` SET TAGS ('dbx_business_glossary_term' = 'Average Age');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `care_gap_count` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `chf_flag` SET TAGS ('dbx_business_glossary_term' = 'Congestive Heart Failure Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `ckd_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Kidney Disease Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `copd_flag` SET TAGS ('dbx_business_glossary_term' = 'COPD Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `diabetes_flag` SET TAGS ('dbx_business_glossary_term' = 'Diabetes Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `last_stratification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stratification Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Stratification Model Version');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `need_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Need Closure Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `percent_female` SET TAGS ('dbx_business_glossary_term' = 'Female Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `percent_male` SET TAGS ('dbx_business_glossary_term' = 'Male Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `percent_medicaid` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Coverage Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `percent_medicare` SET TAGS ('dbx_business_glossary_term' = 'Medicare Coverage Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `percent_private_insurance` SET TAGS ('dbx_business_glossary_term' = 'Private Insurance Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `population_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `population_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Segment Population Size');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `referral_management_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Management Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `referral_management_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'U.S. Region Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'NORTHEAST|MIDWEST|SOUTH|WEST');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Calculation Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_method` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Methodology');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_method` SET TAGS ('dbx_value_regex' = 'logistic|gradient_boost|neural_network|rule_based');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_value_regex' = 'cms_hcc|acg|proprietary');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `sdhz_zcode` SET TAGS ('dbx_business_glossary_term' = 'Z‑Code (SDOH)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_category` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Category');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_category` SET TAGS ('dbx_value_regex' = 'clinical|administrative|sdoh|combined');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_creation_source` SET TAGS ('dbx_business_glossary_term' = 'Segment Creation Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_creation_source` SET TAGS ('dbx_value_regex' = 'epic|cerner|manual|external');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Updated By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Segment Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_retention_policy` SET TAGS ('dbx_value_regex' = 'retain_7_years|retain_10_years|retain_indefinite');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'chronic|high_risk|rising_risk|healthy');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `zip_code_prefix` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code Prefix');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `zip_code_prefix` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `zip_code_prefix` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`population_segment` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` SET TAGS ('dbx_subdomain' = 'population_stratification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `care_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `care_program_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Care Manager Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `care_gap_count` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `chf_flag` SET TAGS ('dbx_business_glossary_term' = 'Congestive Heart Failure Flag (Chronic Condition)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `chf_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `chf_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `ckd_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Kidney Disease Flag (Chronic Condition)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `ckd_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `ckd_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `copd_flag` SET TAGS ('dbx_business_glossary_term' = 'COPD Flag (Chronic Condition)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `copd_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `copd_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `diabetes_flag` SET TAGS ('dbx_business_glossary_term' = 'Diabetes Flag (Chronic Condition)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `diabetes_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `diabetes_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `eligibility_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Version');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online|phone|in_person|referral|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (External Identifier)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'referral|internal|self|community|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `is_high_priority` SET TAGS ('dbx_business_glossary_term' = 'High Priority Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `last_stratification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stratification Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `need_closure_status` SET TAGS ('dbx_business_glossary_term' = 'Need Closure Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `need_closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|blocked');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `outcome_measure_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_outcome_score` SET TAGS ('dbx_business_glossary_term' = 'Program Outcome Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|completed|withdrawn|expired|suspended|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'disease_specific|population|preventive|rehab|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source (CMS HCC, ACG, Proprietary)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_value_regex' = 'cms_hcc|acg|proprietary|custom|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier (Tier 1-6)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|tier5|tier6');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `sdhz_code` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health Z-code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `sdhz_code` SET TAGS ('dbx_value_regex' = 'Z[0-9]{2}');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Type (CHRONIC, HIGH_RISK, RISING_RISK, HEALTHY, OTHER)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'chronic|high_risk|rising_risk|healthy|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `strat_model_version` SET TAGS ('dbx_business_glossary_term' = 'Stratification Model Version');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Care Program Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `assigned_care_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Care Manager Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` SET TAGS ('dbx_subdomain' = 'coverage_eligibility');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `financial_assistance_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Case Manager ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Assistance Adjustment Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|denied|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `approved_assistance_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Assistance Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `approved_assistance_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `approved_assistance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `assistance_application_number` SET TAGS ('dbx_business_glossary_term' = 'Assistance Application Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Reason');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `federal_poverty_level_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `income_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Method');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `income_verification_method` SET TAGS ('dbx_value_regex' = 'paystub|tax_return|bank_statement|self_declaration|government_verification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `need_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Need Closure Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assistance Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'charity_care|medicaid_presumptive|sliding_fee_scale|payment_plan|financial_hardship');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'internal|external|community|self');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `requested_assistance_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Assistance Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `requested_assistance_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `requested_assistance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ALTER COLUMN `case_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Case Manager ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` SET TAGS ('dbx_subdomain' = 'engagement_outreach');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_id` SET TAGS ('dbx_business_glossary_term' = 'Portal Account ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Portal Access Level');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `account_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Activation Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `account_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Creation Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `account_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Deactivation Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'patient|proxy|caregiver|family_member');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `authorization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `authorization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `consent_given_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `consent_revoked` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `consent_revoked_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_link` SET TAGS ('dbx_business_glossary_term' = 'Digital Health App Link');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_link` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_link` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Account Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Account Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Portal Email Address');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `last_login_ip` SET TAGS ('dbx_business_glossary_term' = 'Last Login IP Address');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `last_login_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `last_login_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `legal_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Reference');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `messaging_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Messaging Opt‑In Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Portal Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_status` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_enabled` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Enabled');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_identifier` SET TAGS ('dbx_business_glossary_term' = 'Proxy Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_type` SET TAGS ('dbx_business_glossary_term' = 'Proxy Relationship Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_type` SET TAGS ('dbx_value_regex' = 'parent_guardian|adult_caregiver|legal_guardian|power_of_attorney');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Access Revocation Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `sdoh_need_closure_date` SET TAGS ('dbx_business_glossary_term' = 'SDOH Need Closure Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `sdoh_referral_status` SET TAGS ('dbx_business_glossary_term' = 'SDOH Referral Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `sdoh_referral_status` SET TAGS ('dbx_value_regex' = 'referred|in_progress|closed|no_need');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `sdoh_risk_score` SET TAGS ('dbx_business_glossary_term' = 'SDOH Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `sdoh_z_codes` SET TAGS ('dbx_business_glossary_term' = 'SDOH Z‑Code List');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `two_factor_enabled` SET TAGS ('dbx_business_glossary_term' = 'Two‑Factor Authentication Enabled');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `two_factor_enrolled_date` SET TAGS ('dbx_business_glossary_term' = 'Two‑Factor Enrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `username` SET TAGS ('dbx_business_glossary_term' = 'Portal Username');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`portal_account` ALTER COLUMN `sdoh_community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` SET TAGS ('dbx_subdomain' = 'engagement_outreach');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_access_id` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Proxy Person ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Level');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `bigint_surrogate_key_for_clean_keying` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `bigint_surrogate_key_for_clean_keying` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `bigint_surrogate_key_for_clean_keying` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `legal_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Reference');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_access_number` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_access_status` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_access_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('dbx_business_glossary_term' = 'Proxy Email Address');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_name` SET TAGS ('dbx_business_glossary_term' = 'Proxy Full Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_phone` SET TAGS ('dbx_business_glossary_term' = 'Proxy Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_type` SET TAGS ('dbx_business_glossary_term' = 'Proxy Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_type` SET TAGS ('dbx_value_regex' = 'parent_guardian|adult_caregiver|legal_guardian|healthcare_power_of_attorney');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_person_id` SET TAGS ('dbx_business_glossary_term' = 'Proxy Person ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_person_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `proxy_person_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`proxy_access` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_crosswalk_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number Crosswalk ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (Facility ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Patient Identifier (Patient ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `cerner_euid` SET TAGS ('dbx_business_glossary_term' = 'Cerner Enterprise Unique Identifier (EUID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `cerner_euid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `cerner_euid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `data_source_type` SET TAGS ('dbx_value_regex' = 'system|manual|import');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `epic_empi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Epic Enterprise Master Patient Index Identifier (EMPI)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `epic_empi_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `epic_empi_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `facility_mrn` SET TAGS ('dbx_business_glossary_term' = 'Facility Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `facility_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `facility_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_identifier` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `hie_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Identifier Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `meditech_mrn` SET TAGS ('dbx_business_glossary_term' = 'MEDITECH Medical Record Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `meditech_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `meditech_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `mrn_bigint_surrogate_key_for_clean_keying` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Crosswalk Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Member Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|portal');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|MEDITECH|HIE|Other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `enterprise_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Patient Identifier (Patient ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (Facility ID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `epic_empi_id` SET TAGS ('dbx_business_glossary_term' = 'Epic Enterprise Master Patient Index Identifier (EMPI)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `epic_empi_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `epic_empi_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Member Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `payer_member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_record_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `source_system_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `patient_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Full Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `patient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `patient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` SET TAGS ('dbx_subdomain' = 'engagement_outreach');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `communication_log_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Log ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `communication_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `message_template_id` SET TAGS ('dbx_business_glossary_term' = 'Message Template Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `body_text` SET TAGS ('dbx_business_glossary_term' = 'Communication Body Text');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `body_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `body_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|sms|email|portal|mail');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `communication_log_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Delivery Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `communication_log_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|read|bounced');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `communication_type` SET TAGS ('dbx_value_regex' = 'reminder|notification|outreach|billing|post_discharge|survey');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'hipaa|gdpr|none');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `consent_given_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `delivery_attempts` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Communication Direction');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'outbound|inbound');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `is_test_message` SET TAGS ('dbx_business_glossary_term' = 'Test Message Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt‑Out Preference Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Communication Priority');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{1,3}[ -]?(?[0-9]{1,4})?[ -]?[0-9]{3,4}[ -]?[0-9]{3,4}$');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `response_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `response_text` SET TAGS ('dbx_business_glossary_term' = 'Response Text');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `response_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `response_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `sender_role` SET TAGS ('dbx_business_glossary_term' = 'Sender Role');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `sender_role` SET TAGS ('dbx_value_regex' = 'nurse|physician|admin|system');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Communication Delivery Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|read|bounced');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `sender_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `source_record_id` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ALTER COLUMN `message_template_name` SET TAGS ('dbx_business_glossary_term' = 'Message Template Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` SET TAGS ('dbx_subdomain' = 'engagement_outreach');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Master Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_obtained_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_revoked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_source` SET TAGS ('dbx_value_regex' = 'electronic|paper|verbal|phone|email');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending|withdrawn|suspended');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'treatment|research|marketing|data_sharing|billing|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_master_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Master Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` SET TAGS ('dbx_subdomain' = 'coverage_eligibility');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Coverage Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Plan Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `insurance_dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `insurance_dependent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `insurance_dependent_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Subscriber Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `benefit_level` SET TAGS ('dbx_business_glossary_term' = 'Benefit Level');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `benefit_level` SET TAGS ('dbx_value_regex' = 'individual|family|group|employee|dependent');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `cob_priority` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Priority');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coinsurance_percent` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coinsurance_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coinsurance_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment Amount (USD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `copay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_number` SET TAGS ('dbx_business_glossary_term' = 'Coverage Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'current|expired|future|terminated');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|platinum|gold|silver');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|pharmacy|dental|vision|mental_health|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Deductible Amount (USD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `eligibility_check_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `eligibility_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending|unknown');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `is_primary_coverage` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `member_number` SET TAGS ('dbx_business_glossary_term' = 'Member Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Maximum (USD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `payer_type` SET TAGS ('dbx_value_regex' = 'government|private|self_pay|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|POS|EPO|HDHP|Other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Meditech|Other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `coverage_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Plan Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `dependent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `dependent_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `source_system_record_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `source_system_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ALTER COLUMN `source_system_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` SET TAGS ('dbx_subdomain' = 'population_stratification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `quality_measure_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Evaluation ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluating Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `closure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `compliance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Compliance Indicator');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `compliance_indicator` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|unknown');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Meditech|Custom');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `denominator_status` SET TAGS ('dbx_business_glossary_term' = 'Denominator Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `denominator_status` SET TAGS ('dbx_value_regex' = 'included|excluded|unknown');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|unknown');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'completed|pending|in_progress|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `exemption_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `gap_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Closure Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `gap_closure_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Closure Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `gap_closure_status` SET TAGS ('dbx_value_regex' = 'closed|open|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `gap_status` SET TAGS ('dbx_value_regex' = 'gap|no_gap|unknown');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Exemption Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `last_outreach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `numerator_status` SET TAGS ('dbx_business_glossary_term' = 'Numerator Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `numerator_status` SET TAGS ('dbx_value_regex' = 'met|not_met|exempt|unknown');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `outreach_attempts` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempts Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `outreach_success_flag` SET TAGS ('dbx_business_glossary_term' = 'Outreach Success Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `population_category` SET TAGS ('dbx_business_glossary_term' = 'Population Category');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'initiated|completed|cancelled|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `score_unit` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score Unit');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `score_unit` SET TAGS ('dbx_value_regex' = 'percent|points|ratio');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `score_value` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score Value');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `sdhz_code` SET TAGS ('dbx_business_glossary_term' = 'SDOH Z-Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `sdhz_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `sdhz_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `evaluating_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluating Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ALTER COLUMN `recorded_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` SET TAGS ('dbx_subdomain' = 'population_stratification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `care_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Care Manager Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `actual_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `disenrollment_reason` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Reason');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_review');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_reason` SET TAGS ('dbx_value_regex' = 'quality_improvement|regulatory|financial|clinical');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_region_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Region Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'referral|self_enroll|provider_order|automated');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_state` SET TAGS ('dbx_business_glossary_term' = 'Enrollment State Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'CMS_VBP|MIPS|HEDIS|ACO|INTERNAL');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_zip` SET TAGS ('dbx_business_glossary_term' = 'Enrollment ZIP/Postal Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_zip` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `enrollment_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `is_primary_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Primary Enrollment Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `metric_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Metric Measurement Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'value_based|population_health|clinical_outcome|financial');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Program Subcategory');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_subcategory` SET TAGS ('dbx_value_regex' = 'vbp|mips|hedis|aco|internal');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `target_metric_code` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `target_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ALTER COLUMN `assigned_care_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Care Manager Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` SET TAGS ('dbx_subdomain' = 'population_stratification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `care_program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Identifier (CPID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (CCI)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUD_ST)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `community_resource_directory` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Directory (CRD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_ST)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `current_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count (CEC)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (DRP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Program Discharge Date (DISCH_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `discharge_reason` SET TAGS ('dbx_business_glossary_term' = 'Discharge Reason (DISCH_RSN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `discharge_reason` SET TAGS ('dbx_value_regex' = 'goal_met|non_compliance|transfer|deceased|other');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date (PESD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date (PEED)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (EC)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity (ECAP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ENR_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date (EED)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date (ESD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (IAF)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `is_sdoh_related` SET TAGS ('dbx_business_glossary_term' = 'Is SDOH Related Flag (SDOH_FLG)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date (LAD)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes (PN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `outcome_metric_actual` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric Actual (OMA)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `outcome_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric Name (OMN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `outcome_metric_target` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric Target (OMT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_budget` SET TAGS ('dbx_business_glossary_term' = 'Program Budget (PB)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category (PCAT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'clinical|social|preventive|rehab|palliative');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Care Program Code (CPC)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_currency` SET TAGS ('dbx_business_glossary_term' = 'Program Currency (PCUR)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_goal` SET TAGS ('dbx_business_glossary_term' = 'Program Goal (PG)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Care Program Name (CPN)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner (PO)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_spent` SET TAGS ('dbx_business_glossary_term' = 'Program Expenditure (PEXP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Care Program Status (CPS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|suspended|pending');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Program Subcategory (PSUB)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Care Program Type (CPT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'disease_management|wellness|rehabilitation|palliative|preventive');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Program Version (PV)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source (RS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'provider|self|community|hospital|clinic');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Program Risk Score (PRS)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `sdlc_stage` SET TAGS ('dbx_business_glossary_term' = 'SDLC Stage (SDLC)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `sdlc_stage` SET TAGS ('dbx_value_regex' = 'design|development|testing|production|decommissioned');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `sdoh_need_closure_tracking` SET TAGS ('dbx_business_glossary_term' = 'SDOH Need Closure Tracking (SDOH_NCT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `sdoh_referral_management` SET TAGS ('dbx_business_glossary_term' = 'SDOH Referral Management (SDOH_RM)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population (TP)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `care_coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (CCI)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Identifier (CRI)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PID)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` SET TAGS ('dbx_subdomain' = 'engagement_outreach');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Campaign ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `message_template_id` SET TAGS ('dbx_business_glossary_term' = 'Message Template ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `actual_reach` SET TAGS ('dbx_business_glossary_term' = 'Actual Reach Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Communication Campaign Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Campaign Manager Email');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Campaign Manager Phone');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Communication Campaign Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Campaign Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'patient_education|appointment_reminder|health_alert|survey|promotion');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|portal|mail');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `click_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `communication_campaign_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `expected_reach` SET TAGS ('dbx_business_glossary_term' = 'Expected Reach Count');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Archived Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `is_test_campaign` SET TAGS ('dbx_business_glossary_term' = 'Test Campaign Indicator');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Campaign Language');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `last_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sent Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `launch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Launch Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `response_rate` SET TAGS ('dbx_business_glossary_term' = 'Overall Response Rate');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `segmentation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Criteria');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `total_messages_sent` SET TAGS ('dbx_business_glossary_term' = 'Total Messages Sent');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `updated_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `owner_user_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `created_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` SET TAGS ('dbx_subdomain' = 'population_stratification');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_logic` SET TAGS ('dbx_business_glossary_term' = 'Attribution Logic Definition');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `attribution_panel_description` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `audit_created_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Created By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `audit_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated By');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'HIPAA|HITECH|GDPR|PCI|None');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Data Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `linked_metric` SET TAGS ('dbx_business_glossary_term' = 'Linked Metric');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_code` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_name` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|pending|retired|archived');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `panel_type` SET TAGS ('dbx_value_regex' = 'clinical|financial|operational|research|marketing|quality');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`attribution_panel` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Attribution Panel Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` SET TAGS ('dbx_subdomain' = 'engagement_outreach');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` SET TAGS ('dbx_patient_message_template' = 'patient_message_template');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `message_template_id` SET TAGS ('dbx_business_glossary_term' = 'Message Template Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_patient_message_template_employee_role_id' = 'BIGINT');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_patient_message_template_employee_role_id' = 'BIGINT');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `message_employee_id` SET TAGS ('dbx_creator_employee_id' = 'BIGINT');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `message_employee_id` SET TAGS ('dbx_employee_role_id' = 'BIGINT');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `message_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `message_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Template Approval Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `audience_scope` SET TAGS ('dbx_business_glossary_term' = 'Audience Scope');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `audience_scope` SET TAGS ('dbx_value_regex' = 'patient|provider|staff|all');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `body_content` SET TAGS ('dbx_business_glossary_term' = 'Message Body Content');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|sms|patient_portal|voice|mail');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `compliance_tag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `compliance_tag` SET TAGS ('dbx_value_regex' = 'hipaa|gdpr|none');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `employee_role` SET TAGS ('dbx_employee_role' = 'STRING');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Content Flag');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (ISO 639‑1)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `max_send_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Send Attempts');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `message_template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `message_template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `message_template_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `placeholder_variables` SET TAGS ('dbx_business_glossary_term' = 'Template Placeholder Variables');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Message Priority Level');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `send_time_offset_minutes` SET TAGS ('dbx_business_glossary_term' = 'Send Time Offset (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Message Subject Line');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Message Template Code');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Message Template Name');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Message Template Type');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'appointment_reminder|lab_result|prescription_refill|billing_statement|general_communication');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Template Version Number');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `referral_management_id` SET TAGS ('dbx_business_glossary_term' = 'referral_management Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `referral_patient_mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `referral_patient_mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Sdoh Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `referral_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `referral_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `screening_tool_responses` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ALTER COLUMN `screening_tool_responses` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ALTER COLUMN `need_closure_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'need_closure_tracking Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ALTER COLUMN `referral_management_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Referral Management Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Sdoh Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ALTER COLUMN `chw_interventions_id` SET TAGS ('dbx_business_glossary_term' = 'chw_interventions Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ALTER COLUMN `chw_need_need_closure_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Need Need Closure Tracking Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ALTER COLUMN `referral_management_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Referral Management Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `risk_stratification_id` SET TAGS ('dbx_business_glossary_term' = 'risk_stratification Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `risk_patient_mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `risk_patient_mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `census_tract_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `census_tract_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `education_barrier_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `education_barrier_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `employment_status_concern` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `employment_status_concern` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `financial_strain_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `financial_strain_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `food_insecurity_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `food_insecurity_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `housing_instability_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `housing_instability_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `social_isolation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `social_isolation_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `transportation_barrier_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ALTER COLUMN `transportation_barrier_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`z_code_mapping` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`z_code_mapping` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`z_code_mapping` ALTER COLUMN `z_code_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'z_code_mapping Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`z_code_mapping` ALTER COLUMN `is_primary_diagnosis_eligible` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`z_code_mapping` ALTER COLUMN `is_primary_diagnosis_eligible` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh` ALTER COLUMN `sdoh_id` SET TAGS ('dbx_business_glossary_term' = 'sdoh Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `sdoh_subdomain_id` SET TAGS ('dbx_business_glossary_term' = 'sdoh_subdomain Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Sdoh Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `associated_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `associated_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `intervention_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `intervention_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `patient_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `patient_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `population_health_cohort` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ALTER COLUMN `population_health_cohort` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Referral Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `sdoh_need_closure_id` SET TAGS ('dbx_business_glossary_term' = 'sdoh_need_closure Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `sdoh_referral_management_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Sdoh Referral Management Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Sdoh Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `closure_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `closure_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `patient_reported_outcome` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ALTER COLUMN `patient_reported_outcome` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_risk_stratification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_risk_stratification` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_risk_stratification` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `sdoh_zcode_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'sdoh_zcode_mapping Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `population_health_priority` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `population_health_priority` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `primary_diagnosis_eligible` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` ALTER COLUMN `primary_diagnosis_eligible` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure_tracking` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ALTER COLUMN `sdoh_chw_interventions_id` SET TAGS ('dbx_business_glossary_term' = 'sdoh_chw_interventions Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ALTER COLUMN `referral_management_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Referral Management Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` SET TAGS ('dbx_delta_tblproperties_quality' = 'gold');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` SET TAGS ('dbx_liquid_clustering_keys' = 'mpi_record_id');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` SET TAGS ('dbx_subdomain' = 'social_determinants');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `state_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient`.`community_resource` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
