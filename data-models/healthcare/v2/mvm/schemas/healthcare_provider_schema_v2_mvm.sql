-- Schema for Domain: provider | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`provider` COMMENT 'Authoritative repository for all healthcare professionals and organizational providers. Includes physicians, nurses, allied health professionals, NPI (National Provider Identifier), DEA numbers, credentials, specialties, licensure, hospital privileges, credentialing status, payer enrollment, and provider network affiliations. SSOT for provider identity and authorization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`clinician` (
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician record.',
    `specialty_id` BIGINT COMMENT 'Primary clinical specialty.',
    `npi_registry_id` BIGINT COMMENT 'Link to NPI registry record.',
    `taxonomy_id` BIGINT COMMENT 'NUCC taxonomy code.',
    `board_certification_expiration_date` DECIMAL(18,2) COMMENT 'Board certification expiration date.',
    `board_certified` BOOLEAN COMMENT 'Board certification status.',
    `caqh_provider_number` STRING COMMENT 'CAQH ProView provider number.',
    `clinician_type` STRING COMMENT 'Clinician type (Physician, NP, PA, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credentialing_expiration_date` DECIMAL(18,2) COMMENT 'Credentialing expiration date.',
    `credentialing_status` STRING COMMENT 'Credentialing status (Active, Pending, Expired, etc.).',
    `date_of_birth` DATE COMMENT 'Clinician date of birth.',
    `dea_number` STRING COMMENT 'DEA registration number.',
    `employment_status` STRING COMMENT 'Employment status (Active, Inactive, Terminated, etc.).',
    `employment_type` STRING COMMENT 'Employment type (Full-time, Part-time, Contractor, etc.).',
    `fellowship_completion_date` DATE COMMENT 'Fellowship completion date.',
    `fellowship_program_name` STRING COMMENT 'Fellowship program name.',
    `first_name` STRING COMMENT 'Legal first name.',
    `gender` STRING COMMENT 'Gender identity.',
    `hire_date` DATE COMMENT 'Date of hire.',
    `internship_completion_date` DATE COMMENT 'Internship completion date.',
    `internship_program_name` STRING COMMENT 'Internship program name.',
    `is_active` BOOLEAN COMMENT 'Is Active for clinician.',
    `last_name` STRING COMMENT 'Legal last name.',
    `license_expiration_date` DECIMAL(18,2) COMMENT 'License expiration date.',
    `license_number` STRING COMMENT 'License Number for clinician.',
    `license_state` STRING COMMENT 'State of licensure.',
    `malpractice_expiration_date` DECIMAL(18,2) COMMENT 'Malpractice insurance expiration date.',
    `malpractice_policy_number` STRING COMMENT 'Malpractice insurance policy number.',
    `medicaid_enrolled` BOOLEAN COMMENT 'Medicaid enrollment status.',
    `medical_degree` STRING COMMENT 'Medical degree type (MD, DO, MBBS, etc.).',
    `medical_school_graduation_date` DATE COMMENT 'Medical school graduation date.',
    `medical_school_name` STRING COMMENT 'Medical school attended.',
    `medicare_enrolled` BOOLEAN COMMENT 'Medicare enrollment status.',
    `middle_name` STRING COMMENT 'Middle name or initial.',
    `name_suffix` STRING COMMENT 'Name suffix (Jr, Sr, III, etc.).',
    `npi` STRING COMMENT 'Npi for clinician.',
    `oig_exclusion_check_date` DATE COMMENT 'Date of OIG exclusion screening.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'OIG exclusion screening completed.',
    `payer_enrollment_status` STRING COMMENT 'Payer enrollment status.',
    `primary_source_verified` BOOLEAN COMMENT 'Primary source verification completed.',
    `professional_designation` STRING COMMENT 'Professional designation (MD, DO, NP, PA, RN, etc.).',
    `residency_acgme_accredited` BOOLEAN COMMENT 'ACGME accreditation status of residency.',
    `residency_completion_date` DATE COMMENT 'Residency completion date.',
    `residency_program_name` STRING COMMENT 'Residency program name.',
    `state_license_number` STRING COMMENT 'State medical license number.',
    `termination_date` DATE COMMENT 'Date of termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    `work_email` STRING COMMENT 'Work email address.',
    `work_phone` STRING COMMENT 'Work phone number.',
    CONSTRAINT pk_clinician PRIMARY KEY(`clinician_id`)
) COMMENT 'Individual healthcare provider (physician, NP, PA, etc.) with credentialing, licensure, and employment details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`org_provider` (
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the organizational provider record.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: org_provider has a denormalized primary_specialty STRING column storing the specialty name of the organization (e.g., Cardiology, Orthopedics). This should be normalized to a FK reference to the s',
    `npi_registry_id` BIGINT COMMENT 'Link to NPI registry record.',
    `taxonomy_id` BIGINT COMMENT 'NUCC taxonomy code.',
    `accreditation_body` STRING COMMENT 'Accreditation body (Joint Commission, DNV, etc.).',
    `accreditation_expiration_date` DECIMAL(18,2) COMMENT 'Accreditation expiration date.',
    `accreditation_status` STRING COMMENT 'Accreditation status.',
    `address_line1` STRING COMMENT 'Primary address line 1.',
    `address_line2` STRING COMMENT 'Primary address line 2.',
    `bed_count` STRING COMMENT 'Licensed bed count.',
    `city` STRING COMMENT 'City.',
    `cms_certification_number` STRING COMMENT 'CMS certification number (CCN).',
    `county` STRING COMMENT 'County.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credentialing_expiration_date` DECIMAL(18,2) COMMENT 'Credentialing expiration date.',
    `credentialing_status` STRING COMMENT 'Credentialing status.',
    `critical_access_hospital_flag` BOOLEAN COMMENT 'Critical access hospital designation.',
    `disproportionate_share_flag` BOOLEAN COMMENT 'Disproportionate share hospital designation.',
    `doing_business_as_name` STRING COMMENT 'Doing business as name.',
    `effective_date` DATE COMMENT 'Effective date.',
    `ehr_system` STRING COMMENT 'EHR system in use.',
    `enrollment_status` STRING COMMENT 'Enrollment status.',
    `facility_type` STRING COMMENT 'Facility type (Acute Care, Ambulatory, SNF, etc.).',
    `fax` STRING COMMENT 'Fax number.',
    `fhir_endpoint_url` STRING COMMENT 'FHIR API endpoint URL.',
    `legal_name` STRING COMMENT 'Legal name of the organization.',
    `license_state` STRING COMMENT 'State of licensure.',
    `medicaid_provider_number` STRING COMMENT 'Medicaid provider number.',
    `medicare_participation_flag` BOOLEAN COMMENT 'Medicare participation status.',
    `network_participation_status` STRING COMMENT 'Network participation status.',
    `oig_exclusion_flag` BOOLEAN COMMENT 'OIG exclusion list flag.',
    `organization_type` STRING COMMENT 'Organization type (Hospital, Clinic, Group Practice, etc.).',
    `ownership_type` STRING COMMENT 'Ownership type (For-profit, Non-profit, Government, etc.).',
    `phone` STRING COMMENT 'Primary phone number.',
    `provider_status` STRING COMMENT 'Provider status (Active, Inactive, Terminated, etc.).',
    `sam_exclusion_flag` BOOLEAN COMMENT 'SAM.gov exclusion list flag.',
    `state` STRING COMMENT 'State.',
    `state_license_expiration_date` DECIMAL(18,2) COMMENT 'License expiration date.',
    `state_license_number` STRING COMMENT 'State license number.',
    `tax_identification_number` STRING COMMENT 'Federal tax identification number.',
    `teaching_status` STRING COMMENT 'Teaching hospital status.',
    `termination_date` DATE COMMENT 'Termination date.',
    `trauma_level` STRING COMMENT 'Trauma center designation level.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    `vibe_ensured_flag` BOOLEAN COMMENT 'Marker indicating canonical product list ensured.',
    `website_url` STRING COMMENT 'Website URL.',
    `zip_code` STRING COMMENT 'Zip code.',
    CONSTRAINT pk_org_provider PRIMARY KEY(`org_provider_id`)
) COMMENT 'Organizational provider (hospital, clinic, group practice, etc.) with credentialing, accreditation, and network participation details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`specialty` (
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty record.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED CT concept for specialty.',
    `abms_board_name` STRING COMMENT 'ABMS board name.',
    `acgme_program_code` STRING COMMENT 'ACGME program code.',
    `board_certification_body` STRING COMMENT 'Board certification body.',
    `board_certification_required` BOOLEAN COMMENT 'Board certification required flag.',
    `specialty_category` STRING COMMENT 'Specialty category.',
    `cms_enrollment_specialty_type` STRING COMMENT 'CMS enrollment specialty type.',
    `cms_specialty_code` STRING COMMENT 'CMS specialty code.',
    `specialty_code` STRING COMMENT 'Internal specialty code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `dea_registration_required` DECIMAL(18,2) COMMENT 'DEA registration required flag.',
    `specialty_description` STRING COMMENT 'Detailed specialty description.',
    `display_order` STRING COMMENT 'Display order.',
    `effective_date` DATE COMMENT 'Effective date.',
    `end_date` DATE COMMENT 'End date.',
    `fhir_practitioner_role_code` STRING COMMENT 'FHIR practitioner role code.',
    `hedis_measure_set` STRING COMMENT 'HEDIS measure set.',
    `hospital_privileges_applicable` BOOLEAN COMMENT 'Hospital privileges applicable flag.',
    `mips_eligible` BOOLEAN COMMENT 'MIPS eligible flag.',
    `specialty_name` STRING COMMENT 'Specialty name.',
    `network_adequacy_category` STRING COMMENT 'Network adequacy category.',
    `npi_taxonomy_eligible` BOOLEAN COMMENT 'NPI taxonomy eligible flag.',
    `nucc_classification` STRING COMMENT 'NUCC classification.',
    `nucc_provider_type` STRING COMMENT 'NUCC provider type.',
    `nucc_specialization` STRING COMMENT 'NUCC specialization.',
    `nucc_taxonomy_code` STRING COMMENT 'NUCC taxonomy code.',
    `payer_enrollment_eligible` BOOLEAN COMMENT 'Payer enrollment eligible flag.',
    `pecos_specialty_code` STRING COMMENT 'PECOS specialty code.',
    `prescribing_authority` BOOLEAN COMMENT 'Prescribing authority flag.',
    `primary_care_designation` BOOLEAN COMMENT 'Primary care specialty flag.',
    `prior_authorization_required` BOOLEAN COMMENT 'Prior authorization required flag.',
    `referral_required` BOOLEAN COMMENT 'Referral required flag.',
    `rvu_work_component` DECIMAL(18,2) COMMENT 'RVU work component.',
    `short_description` STRING COMMENT 'Short description.',
    `specialty_status` STRING COMMENT 'Specialty status (Active, Inactive, etc.).',
    `specialty_type` STRING COMMENT 'Specialty type (Medical, Surgical, Diagnostic, etc.).',
    `surgical_specialty` BOOLEAN COMMENT 'Surgical specialty flag.',
    `telehealth_eligible` BOOLEAN COMMENT 'Telehealth eligible flag.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `version_number` STRING COMMENT 'Version number.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    CONSTRAINT pk_specialty PRIMARY KEY(`specialty_id`)
) COMMENT 'Clinical specialty master table with taxonomy codes, board certification requirements, and payer enrollment rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`credential` (
    `credential_id` BIGINT COMMENT 'Unique identifier for the credential record.',
    `cpt_code_id` BIGINT COMMENT 'CPT code authorized by credential.',
    `clinician_id` BIGINT COMMENT 'Clinician holding the credential.',
    `specialty_id` BIGINT COMMENT 'Specialty associated with credential.',
    `board_action_date` DATE COMMENT 'Board action date.',
    `board_action_flag` BOOLEAN COMMENT 'Board action flag.',
    `caqh_submitted` BOOLEAN COMMENT 'CAQH submitted flag.',
    `certifying_board_name` STRING COMMENT 'Certifying board name.',
    `cme_accrediting_organization` STRING COMMENT 'CME accrediting organization.',
    `cme_activity_title` STRING COMMENT 'CME activity title.',
    `cme_activity_type` STRING COMMENT 'CME activity type.',
    `cme_category` STRING COMMENT 'CME category (Category 1, Category 2, etc.).',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'CME credit hours.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credential_number` STRING COMMENT 'Credential number.',
    `credential_status` STRING COMMENT 'Credential status (Active, Expired, Suspended, etc.).',
    `credential_type` STRING COMMENT 'Credential type (License, Certification, DEA, Board Certification, CME, etc.).',
    `days_to_expiration` DECIMAL(18,2) COMMENT 'Days to expiration.',
    `dea_business_activity_type` STRING COMMENT 'DEA business activity type.',
    `dea_schedule_authorizations` STRING COMMENT 'DEA schedule authorizations (II, III, IV, V).',
    `effective_from` DATE COMMENT 'Effective from date.',
    `effective_until` DATE COMMENT 'Effective until date.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date.',
    `issue_date` DATE COMMENT 'Issue date.',
    `issuing_authority_name` STRING COMMENT 'Issuing authority name.',
    `issuing_state` STRING COMMENT 'Issuing state.',
    `moc_status` STRING COMMENT 'Maintenance of certification status.',
    `notes` STRING COMMENT 'Notes.',
    `npdb_queried` BOOLEAN COMMENT 'NPDB queried flag.',
    `npdb_query_date` DATE COMMENT 'NPDB query date.',
    `oig_exclusion_check_date` DATE COMMENT 'OIG exclusion check date.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'OIG exclusion screening completed.',
    `payer_enrollment_relevant` BOOLEAN COMMENT 'Payer enrollment relevant flag.',
    `primary_source_verified` BOOLEAN COMMENT 'Primary source verification completed.',
    `privileging_relevant` BOOLEAN COMMENT 'Privileging relevant flag.',
    `psv_date` DATE COMMENT 'Primary source verification date.',
    `psv_method` STRING COMMENT 'Primary source verification method.',
    `recredentialing_due_date` DATE COMMENT 'Recredentialing due date.',
    `renewal_date` DATE COMMENT 'Renewal date.',
    `restriction_description` STRING COMMENT 'Restriction description.',
    `sam_exclusion_checked` BOOLEAN COMMENT 'SAM exclusion screening completed.',
    `source_system_record_reference` STRING COMMENT 'Source system record reference.',
    `subtype` STRING COMMENT 'Credential subtype.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `verification_source` STRING COMMENT 'Verification source.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    CONSTRAINT pk_credential PRIMARY KEY(`credential_id`)
) COMMENT 'Provider credentials (licenses, certifications, DEA, board certifications, CME) with expiration tracking and primary source verification.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`privileging` (
    `privileging_id` BIGINT COMMENT 'Surrogate primary key.',
    `board_certification_id` BIGINT COMMENT 'Foreign key linking to provider.board_certification. Business justification: The privileging table has a board_certification_required BOOLEAN flag, indicating that board certification is a prerequisite for certain privileges. However, there is no FK linking the privilege to th',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Hospital privileging delineation requires linking each privilege to a specific CPT procedure code — a Joint Commission and CMS requirement for procedure-specific credentialing. The existing plain `cpt',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Clinical privileges are granted to a clinician AT a specific care site (hospital or facility). The privileging table description explicitly states privilege granted to a clinician at a specific care ',
    `clinician_id` BIGINT COMMENT 'FK to the clinician granted the privilege.',
    `specialty_id` BIGINT COMMENT 'FK to the specialty associated with the privilege.',
    `approval_date` DATE COMMENT 'Date the privilege was approved.',
    `board_certification_required` BOOLEAN COMMENT 'Indicates if board certification is required for this privilege.',
    `completed_case_volume` STRING COMMENT 'Number of cases completed under this privilege.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `delineation_form_version` STRING COMMENT 'Version of the privilege delineation form used.',
    `effective_date` DATE COMMENT 'Date the privilege became effective.',
    `emtala_covered` BOOLEAN COMMENT 'Indicates if this privilege covers EMTALA obligations.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Date the privilege expires.',
    `fppe_completion_date` DATE COMMENT 'Date Focused Professional Practice Evaluation was completed.',
    `fppe_required` BOOLEAN COMMENT 'Indicates if FPPE is required.',
    `is_provisional` BOOLEAN COMMENT 'Indicates if this is a provisional privilege.',
    `malpractice_verified` BOOLEAN COMMENT 'Indicates if malpractice coverage was verified.',
    `npdb_report_date` DATE COMMENT 'Date of NPDB report for this privilege.',
    `npdb_report_required` BOOLEAN COMMENT 'Indicates if NPDB reporting is required.',
    `oppe_last_review_date` DATE COMMENT 'Date of last Ongoing Professional Practice Evaluation.',
    `peer_review_score` DECIMAL(18,2) COMMENT 'Peer review score for the privilege.',
    `privilege_category` STRING COMMENT 'Category of privilege (Core, Special, Temporary).',
    `privilege_description` STRING COMMENT 'Description of the clinical privilege.',
    `privilege_name` STRING COMMENT 'Name of the clinical privilege.',
    `privilege_number` STRING COMMENT 'Privilege identification number.',
    `privilege_status` STRING COMMENT 'Current status (Active, Suspended, Revoked, Expired).',
    `privilege_type` STRING COMMENT 'Type of privilege (Admitting, Surgical, Procedural, Consulting).',
    `provisional_end_date` DATE COMMENT 'End date for provisional privilege period.',
    `reappointment_cycle_years` STRING COMMENT 'Number of years in the reappointment cycle.',
    `request_date` DATE COMMENT 'Date the privilege was requested.',
    `required_case_volume` STRING COMMENT 'Minimum case volume required to maintain privilege.',
    `revocation_date` DATE COMMENT 'Date the privilege was revoked.',
    `revocation_reason` STRING COMMENT 'Reason for privilege revocation.',
    `source_record_reference` STRING COMMENT 'Source system record reference.',
    `source_system_code` STRING COMMENT 'Source system code.',
    `suspension_date` DATE COMMENT 'Date the privilege was suspended.',
    `suspension_reason` STRING COMMENT 'Reason for privilege suspension.',
    `telemedicine_authorized` BOOLEAN COMMENT 'Indicates if telemedicine is authorized under this privilege.',
    `training_requirement_met` BOOLEAN COMMENT 'Indicates if training requirements are met.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    CONSTRAINT pk_privileging PRIMARY KEY(`privileging_id`)
) COMMENT 'Clinical privilege granted to a clinician at a specific care site, tracking privilege type, status, approval, FPPE/OPPE requirements, and case volume for medical staff office compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` (
    `network_affiliation_id` BIGINT COMMENT 'Unique surrogate identifier for each provider network affiliation record in the Silver Layer lakehouse. Primary key for this entity.',
    `clinician_id` BIGINT COMMENT 'Reference to the individual clinician or organizational provider associated with this network affiliation record. Links to the provider master entity.',
    `group_id` BIGINT COMMENT 'Reference to the medical group or group practice through which the individual provider participates in this network. Many payer contracts are held at the group level, with individual providers enrolled under the group.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Organizational providers have network affiliations in addition to individual clinicians. FK will be NULL for clinician-only affiliations. No redundant columns to remove.',
    `payer_contract_id` BIGINT COMMENT 'Identifier of the provider contract or participation agreement governing the terms of this network affiliation, including reimbursement rates and obligations. Links to the contract management system.',
    `payer_id` BIGINT COMMENT 'Reference to the health insurance payer or managed care organization that owns or administers the network to which the provider is affiliated.',
    `provider_network_id` BIGINT COMMENT 'Reference to the specific payer network or care network (ACO, HMO, PPO, POS) to which the provider is affiliated.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Network participation is specialty-specific. network_affiliation.specialty_code and specialty_description should reference specialty table.',
    `accepts_new_patients` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients within this network. Distinct from panel_status in that it reflects the providers current operational availability rather than the formal panel designation.',
    `aco_participant_flag` BOOLEAN COMMENT 'Indicates whether the provider is a participating member of an Accountable Care Organization (ACO) under this network affiliation. ACO participation drives shared savings calculations and quality reporting under CMS MSSP and Next Gen ACO programs.',
    `affiliation_status` STRING COMMENT 'Current lifecycle status of the providers network affiliation. active indicates the provider is currently participating and eligible to see network patients. pending indicates enrollment is in process. suspended indicates temporary hold pending investigation or credentialing review.. Valid values are `active|inactive|pending|suspended|terminated`',
    `age_range_max` STRING COMMENT 'Maximum patient age (in years) that the provider accepts within this network affiliation. Null indicates no upper age limit. Used for provider directory filtering and patient-to-provider matching.',
    `age_range_min` STRING COMMENT 'Minimum patient age (in years) that the provider accepts within this network affiliation. Used for provider directory filtering and patient-to-provider matching in managed care systems.',
    `credentialing_expiration_date` DATE COMMENT 'Date on which the providers credentialing with this network expires and re-credentialing must be completed. Typically occurs every two years per NCQA standards. Used to trigger re-credentialing workflows.',
    `credentialing_status` STRING COMMENT 'Current credentialing status of the provider with the payer or network organization. Credentialing must be completed before a provider can be listed as in-network. Tracked via Symplr or CAQH ProView.. Valid values are `credentialed|pending|expired|denied|re_credentialing`',
    `directory_published_flag` BOOLEAN COMMENT 'Indicates whether this provider network affiliation record has been published in the payers public-facing provider directory. CMS requires accurate and up-to-date provider directories for all Medicare Advantage and Marketplace plans.',
    `effective_date` DATE COMMENT 'The date on which the providers participation in the network becomes effective and the provider is eligible to see in-network patients. Used for claims adjudication and provider directory accuracy.',
    `gender_served` STRING COMMENT 'Indicates the patient gender population served by the provider within this network (e.g., all genders, male only, female only, pediatric). Used for provider directory accuracy and patient matching.. Valid values are `all|male|female|pediatric`',
    `geographic_service_area` STRING COMMENT 'Description of the geographic region or service area covered by this network affiliation (e.g., state name, county, metropolitan statistical area, or CMS-defined service area). Used for network adequacy geographic analysis and CMS service area filings.',
    `handicap_accessible` BOOLEAN COMMENT 'Indicates whether the providers practice location associated with this network affiliation is handicap accessible per ADA requirements. Required for CMS provider directory accuracy and ADA compliance reporting.',
    `hospital_affiliation_flag` BOOLEAN COMMENT 'Indicates whether this network affiliation record pertains to a hospital or facility provider (as opposed to an individual clinician). Used to distinguish facility-level from practitioner-level network participation in directory and adequacy reporting.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages spoken by the provider at this network location, using ISO 639-1 language codes. Required for provider directory accuracy and CMS language access compliance under Section 1557 of the ACA.',
    `last_verified_date` DATE COMMENT 'Date on which the network affiliation information was last verified against the payers provider directory or credentialing source. CMS requires provider directories to be updated at least every 90 days.',
    `mips_eligible` BOOLEAN COMMENT 'Indicates whether the provider is eligible for Merit-based Incentive Payment System (MIPS) reporting under this network affiliation. MIPS eligibility affects payment adjustments under MACRA and is tracked at the provider-payer level.',
    `network_adequacy_category` STRING COMMENT 'Provider category used for CMS and state network adequacy analysis. Classifies the providers role in meeting time-and-distance and appointment availability standards required for network certification. [ENUM-REF-CANDIDATE: primary_care|specialist|behavioral_health|hospital|ancillary|pharmacy — promote to reference product if additional categories are needed]. Valid values are `primary_care|specialist|behavioral_health|hospital|ancillary|pharmacy`',
    `network_tier` STRING COMMENT 'Tiered network designation indicating the providers cost and quality tier within the payers network structure. Tier 1 typically represents highest-value providers with lowest patient cost-sharing; higher tiers carry greater patient out-of-pocket costs.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `notes` STRING COMMENT 'Free-text field for operational notes or comments related to this network affiliation record, such as special contract terms, exceptions, or credentialing remarks entered by network management staff.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned by CMS to uniquely identify the provider participating in this network affiliation. Used for claims routing and provider directory publication.. Valid values are `^[0-9]{10}$`',
    `panel_capacity` STRING COMMENT 'Maximum number of patients the provider is willing to accept within this network. Used for network adequacy analysis and patient assignment in managed care models such as HMO and ACO.',
    `panel_current_count` STRING COMMENT 'Current number of attributed or assigned patients on the providers panel within this network. Used alongside panel_capacity to determine panel availability and support network adequacy reporting.',
    `panel_status` STRING COMMENT 'Indicates whether the providers patient panel is open to new patients, closed, or accepting only limited new patients within this network. Critical for network adequacy reporting and patient access compliance required by CMS.. Valid values are `open|closed|limited`',
    `participation_type` STRING COMMENT 'Defines the providers participation classification within the network. Determines patient cost-sharing levels and reimbursement rates. preferred indicates a higher-tier in-network designation with lower patient cost-sharing.. Valid values are `in_network|out_of_network|preferred|non_preferred|tiered`',
    `primary_care_designation` BOOLEAN COMMENT 'Indicates whether the provider is designated as a Primary Care Physician (PCP) within this network. PCPs serve as care coordinators in HMO and ACO models and are required for patient attribution and referral management.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network affiliation record was first created in the data platform. Used for audit trail, data lineage, and compliance with HIPAA record retention requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network affiliation record was last modified in the data platform. Used for change tracking, incremental ETL processing, and audit compliance.',
    `reimbursement_model` STRING COMMENT 'The payment model under which the provider is reimbursed for services rendered to patients in this network. Drives financial analytics and value-based care program tracking. [ENUM-REF-CANDIDATE: fee_for_service|capitation|bundled_payment|value_based|salary|per_diem — promote to reference product if additional models are needed]. Valid values are `fee_for_service|capitation|bundled_payment|value_based|salary|per_diem`',
    `service_area_state` STRING COMMENT 'Two-letter US state code for the primary state in which the provider participates in this network. Used for state-level network adequacy reporting and licensure validation.. Valid values are `^[A-Z]{2}$`',
    `service_area_zip_code` STRING COMMENT 'Primary ZIP code of the providers practice location within this network affiliation. Used for geographic network adequacy analysis, time-and-distance standards compliance, and provider directory accuracy.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `source_record_reference` STRING COMMENT 'The unique identifier of this affiliation record in the originating source system (e.g., Symplr affiliation ID, CAQH provider ID). Used for data lineage, reconciliation, and ETL traceability.',
    `telehealth_eligible` BOOLEAN COMMENT 'Indicates whether the provider is authorized to deliver telehealth services to patients within this network affiliation. Relevant for network adequacy reporting and patient access under CMS telehealth expansion policies.',
    `termination_date` DATE COMMENT 'The date on which the providers participation in the network ends. Null indicates an open-ended, currently active affiliation. Used for claims adjudication to validate in-network eligibility at date of service.',
    `termination_reason` STRING COMMENT 'Reason code for the termination of the providers network affiliation. Used for network management analytics, OIG compliance monitoring, and understanding provider attrition patterns.. Valid values are `voluntary|involuntary|contract_expiration|credentialing_failure|retirement|other`',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    CONSTRAINT pk_network_affiliation PRIMARY KEY(`network_affiliation_id`)
) COMMENT 'Association record linking clinicians and organizational providers to payer networks, ACOs, HMOs, PPOs, and integrated care networks. Captures network name, network tier, participation type, effective and termination dates, panel status (open/closed), and geographic service area. Supports provider directory accuracy and network adequacy reporting required by CMS.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`group` (
    `group_id` BIGINT COMMENT 'Unique surrogate identifier for the provider group record in the lakehouse Silver layer. Serves as the primary key for all downstream joins and lineage tracking.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Medical group NPIs must be validated against the NPPES NPI registry for payer enrollment, network directory publishing, and CMS compliance. The plain `npi` column is a denormalized reference to npi_re',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Provider groups have primary specialties. provider_group.specialty_primary should reference specialty table.',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to provider.provider_taxonomy. Business justification: Provider groups taxonomy code should reference provider_taxonomy table. Removes taxonomy_code STRING.',
    `accepts_new_patients` BOOLEAN COMMENT 'Indicates whether the provider group is currently accepting new patients. Used in patient-facing provider directories, referral management workflows in Salesforce Health Cloud, and network access reporting.',
    `aco_participant` BOOLEAN COMMENT 'Indicates whether the provider group is a participating entity in a CMS Accountable Care Organization (ACO) program such as the Medicare Shared Savings Program (MSSP). Drives value-based care reporting and shared savings calculations.',
    `admin_contact_email` STRING COMMENT 'Primary administrative email address for the provider group used for credentialing correspondence, payer enrollment notifications, and contract communications. Not a patient-facing address.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_entity_name` STRING COMMENT 'The legal name of the billing entity through which the provider group submits professional claims (CMS-1500 / 837P). May differ from the group name when a management services organization (MSO) or billing company handles claims on behalf of the group.',
    `billing_npi` STRING COMMENT 'The 10-digit NPI of the billing entity used on professional claims (CMS-1500 / 837P) when the billing entity differs from the group NPI. Supports accurate remittance reconciliation and ERA (Electronic Remittance Advice) matching.. Valid values are `^[0-9]{10}$`',
    `contract_effective_date` DATE COMMENT 'Date on which the provider groups primary payer or health system contract became effective. Used for billing eligibility validation, retroactive claim adjudication, and contract lifecycle management.',
    `contract_termination_date` DATE COMMENT 'Date on which the provider groups primary contract was or is scheduled to be terminated. Null if the contract is open-ended or currently active. Used for claims eligibility cutoff and network directory updates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the provider group record was first created in the lakehouse Silver layer. Used for audit trails, data lineage, and SCD Type 2 history management. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credentialing_expiration_date` DATE COMMENT 'Date on which the provider groups current credentialing cycle expires and recredentialing must be completed. NCQA requires recredentialing at least every three years. Used to trigger recredentialing workflows in Symplr.',
    `credentialing_status` STRING COMMENT 'Current credentialing status of the provider group as maintained by the health systems medical staff office or delegated credentialing entity. Drives authorization to treat patients and submit claims. Aligned with NCQA credentialing standards and Symplr credentialing workflows.. Valid values are `credentialed|pending_initial|pending_recredentialing|expired|denied|suspended`',
    `doing_business_as_name` STRING COMMENT 'The trade name or doing-business-as (DBA) name under which the provider group operates publicly, if different from the legal name. Used in patient-facing directories and marketing materials.',
    `effective_date` DATE COMMENT 'Date on which the provider group record became operationally effective within the health systems provider master. Used for temporal validity tracking and SCD (Slowly Changing Dimension) management in the lakehouse.',
    `fqhc_designation` BOOLEAN COMMENT 'Indicates whether the provider group holds an active FQHC (Federally Qualified Health Center) designation from HRSA. FQHC status triggers specific CMS cost-based reimbursement rates and grant eligibility under Section 330 of the Public Health Service Act.',
    `group_status` STRING COMMENT 'Current lifecycle status of the provider group record. Active indicates the group is operational and credentialed; pending indicates enrollment or credentialing in progress; suspended indicates temporary hold; terminated indicates the group is no longer operational or contracted.. Valid values are `active|inactive|pending|suspended|terminated`',
    `group_type` STRING COMMENT 'Categorical classification of the provider groups organizational model. Single-specialty groups focus on one clinical discipline; multi-specialty groups span multiple disciplines; FQHC (Federally Qualified Health Center) and RHC (Rural Health Clinic) designations carry specific CMS reimbursement implications; IPA (Independent Practice Association) and ACO (Accountable Care Organization) reflect value-based care structures. [ENUM-REF-CANDIDATE: single_specialty|multi_specialty|fqhc|rhc|independent_practice_association|accountable_care_organization|other — promote to reference product]',
    `hl7_fhir_organization_reference` STRING COMMENT 'The FHIR (Fast Healthcare Interoperability Resources) Organization resource ID for this provider group, used in HL7 FHIR R4 API exchanges with payers, HIEs (Health Information Exchanges), and external systems. Supports interoperability under the CMS Interoperability and Patient Access Rule.',
    `hospital_affiliation` STRING COMMENT 'Name of the primary hospital or health system with which the provider group is affiliated for admitting privileges and care coordination. Used for referral routing, care transitions, and network directory accuracy.',
    `languages_supported` STRING COMMENT 'Comma-delimited list of languages (ISO 639-1 codes) spoken by clinical staff within the provider group. Used for patient-provider matching, CLAS (Culturally and Linguistically Appropriate Services) compliance, and SDOH-informed care access reporting.',
    `last_credentialing_date` DATE COMMENT 'Date on which the most recent credentialing or recredentialing review was completed and approved for the provider group. Used for audit trails and NCQA compliance reporting.',
    `medicaid_enrollment_status` STRING COMMENT 'Enrollment status of the provider group with the state Medicaid program. Determines eligibility to bill Medicaid for covered services. Managed at the state level through state Medicaid Management Information Systems (MMIS).. Valid values are `enrolled|not_enrolled|pending|terminated`',
    `medicare_enrollment_status` STRING COMMENT 'Enrollment status of the provider group with the Medicare program as reported in PECOS (Provider Enrollment, Chain, and Ownership System). Determines eligibility to bill Medicare Part B for professional services.. Valid values are `enrolled|opt_out|not_enrolled|pending|terminated`',
    `mips_eligible` BOOLEAN COMMENT 'Indicates whether the provider group meets CMS eligibility thresholds for participation in MIPS (Merit-based Incentive Payment System) under MACRA. Drives quality reporting obligations and payment adjustment calculations.',
    `mips_group_reporting` BOOLEAN COMMENT 'Indicates whether the provider group has elected to report MIPS quality measures at the group level (using the group NPI/TIN) rather than at the individual clinician level. Affects CMS payment adjustment calculations.',
    `group_name` STRING COMMENT 'The official legal name of the medical group practice or physician organization as registered with state authorities and CMS NPPES. Used on contracts, claims, and payer directories.',
    `network_participation_status` STRING COMMENT 'Current network participation status of the provider group within the health systems contracted payer networks. Drives patient cost-sharing calculations, referral eligibility, and network adequacy reporting.. Valid values are `in_network|out_of_network|pending|terminated`',
    `payer_enrollment_status` STRING COMMENT 'Aggregate enrollment status of the provider group with payers. Indicates whether the group is actively enrolled to submit claims with its contracted payers. Detailed per-payer enrollment is tracked in the provider_payer_enrollment product.. Valid values are `enrolled|pending|not_enrolled|terminated`',
    `primary_fax` STRING COMMENT 'Primary fax number for the provider group used for clinical communications, referral transmissions, and credentialing document exchange. Fax remains a HIPAA-compliant PHI transmission method in healthcare.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `primary_phone` STRING COMMENT 'Primary telephone number for the provider groups main administrative office. Used for credentialing verification, payer directory listings, and referral coordination.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `primary_service_address_line1` STRING COMMENT 'Street address line 1 of the provider groups primary service location. Used for payer directory listings, credentialing applications, and patient-facing location data.',
    `primary_service_city` STRING COMMENT 'City of the provider groups primary service location. Used for geographic network analysis, payer directory accuracy, and regulatory reporting.',
    `primary_service_state` STRING COMMENT 'Two-letter US state code of the provider groups primary service location. Drives state licensure validation, Medicaid enrollment, and network adequacy reporting by state.. Valid values are `^[A-Z]{2}$`',
    `primary_service_zip` STRING COMMENT 'US ZIP or ZIP+4 postal code of the provider groups primary service location. Used for geographic network adequacy analysis, HEDIS reporting, and SDOH (Social Determinants of Health) stratification.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `rhc_designation` BOOLEAN COMMENT 'Indicates whether the provider group holds an active RHC (Rural Health Clinic) designation from CMS. RHC status triggers specific cost-based reimbursement rates and rural access requirements under 42 CFR § 491.',
    `size` STRING COMMENT 'Total number of active clinicians (physicians, APPs, and allied health professionals) affiliated with the provider group. Used for network adequacy assessments, contracting tiers, and population health capacity planning.',
    `source_system_group_reference` STRING COMMENT 'The native identifier for this provider group in the originating source system (e.g., Epic provider group ID, Cerner organization ID, Symplr group record ID). Used for ETL cross-reference, reconciliation, and bi-directional system integration.',
    `tax_identification_number` STRING COMMENT 'The federal Employer Identification Number (EIN) or Tax Identification Number (TIN) assigned to the provider group by the IRS. Used for 1099 reporting, claims billing, and payer contracting. Format: XX-XXXXXXX.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `telehealth_capable` BOOLEAN COMMENT 'Indicates whether the provider group offers telehealth or virtual care services. Used for network directory accuracy, patient access reporting, and CMS telehealth billing eligibility under 42 CFR § 410.78.',
    `termination_date` DATE COMMENT 'Date on which the provider group record was terminated or deactivated in the provider master. Null for active records. Used for SCD management, audit trails, and historical reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the provider group record was most recently modified in the lakehouse Silver layer. Used for change detection, incremental ETL processing, and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    `vibe_mutated_flag` BOOLEAN COMMENT '',
    `website_url` STRING COMMENT 'Public website URL for the provider group. Used in patient-facing provider directories, Salesforce Health Cloud referral management, and payer directory submissions.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_group PRIMARY KEY(`group_id`)
) COMMENT 'Master record for medical group practices, physician organizations, and care delivery groups that aggregate individual clinicians under a shared organizational identity. Captures group NPI, group name, group type (single-specialty, multi-specialty, FQHC), tax ID, billing entity, primary service location, and group size. Supports group-level contracting, billing, and network management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`group_membership` (
    `group_membership_id` BIGINT COMMENT 'Unique surrogate identifier for each clinician-to-organization affiliation or employment record. Primary key for the group_membership data product.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.provider_group. Business justification: group_membership currently has multiple org_provider_id FKs but no provider_group_id. Business semantics: membership in a provider_group entity. Removes group_npi STRING.',
    `clinician_id` BIGINT COMMENT 'Reference to the individual clinician or healthcare professional whose organizational affiliation or employment relationship is being recorded. Links to the provider master record.',
    `org_provider_id` BIGINT COMMENT 'Reference to the organizational entity (group practice, hospital, health system, academic medical center, FQHC, etc.) with which the provider is affiliated or employed.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: group_membership has a denormalized primary_specialty STRING column that stores the specialty name for the clinicians role within the group. This should be normalized to a FK reference to the special',
    `academic_appointment_rank` STRING COMMENT 'The academic faculty rank held by the provider within an affiliated academic medical center or teaching institution. Applicable only for academic affiliations. Null for non-academic organizations.. Valid values are `instructor|assistant_professor|associate_professor|professor|clinical_professor|adjunct`',
    `aco_participation` BOOLEAN COMMENT 'Indicates whether the provider participates in an Accountable Care Organization (ACO) arrangement under this organizational affiliation. Relevant for value-based care attribution, MIPS reporting, and CMS Shared Savings Program compliance.',
    `contract_end_date` DATE COMMENT 'The end date of the formal employment or affiliation contract. Null for open-ended contracts. Used for contract renewal tracking, workforce planning, and credentialing continuity management.',
    `contract_number` STRING COMMENT 'The reference number of the employment or affiliation contract governing this provider-organization relationship. Links to the contract management system for terms, compensation, and obligations.',
    `contract_start_date` DATE COMMENT 'The start date of the formal employment or affiliation contract governing this provider-organization relationship. May differ from the effective_date if there is a gap between contract execution and service commencement.',
    `cost_center_code` STRING COMMENT 'The financial cost center code associated with this providers organizational affiliation. Used for financial attribution, RVU-based compensation modeling, and departmental budget reporting in SAP S/4HANA.',
    `credentialing_expiration_date` DATE COMMENT 'The date on which the providers credentialing approval expires within this organizational affiliation. Triggers recredentialing workflows. NCQA and Joint Commission require recredentialing at least every three years.',
    `credentialing_status` STRING COMMENT 'Current credentialing verification status for this provider within this organizational affiliation. Tracks whether the provider has completed the organizations credentialing and privileging process as required by NCQA and The Joint Commission.. Valid values are `credentialed|pending|expired|suspended|revoked|not_applicable`',
    `department` STRING COMMENT 'The clinical or administrative department within the organization to which the provider is assigned under this affiliation (e.g., Department of Medicine, Department of Surgery, Emergency Department). Used for workforce planning and operational reporting.',
    `departure_reason` STRING COMMENT 'Coded reason for the providers departure or separation from the organizational affiliation. Required for NPDB adverse action reporting context, workforce analytics, and credentialing work history verification. [ENUM-REF-CANDIDATE: resignation|retirement|termination|contract_end|relocation|deceased|other — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which the providers affiliation or employment relationship with the organization became effective. Required for credentialing primary source verification and work history validation per NCQA and Joint Commission standards.',
    `employment_type` STRING COMMENT 'Classification of the providers employment or engagement arrangement with the organization. Determines benefits eligibility, malpractice coverage, tax reporting obligations, and credentialing pathway requirements.. Valid values are `employed|independent_contractor|locum_tenens|per_diem|volunteer|academic_appointment`',
    `end_date` DATE COMMENT 'The date on which the providers affiliation or employment relationship with the organization ended or is scheduled to end. Null for currently active affiliations. Required for complete work history verification per NCQA and Joint Commission credentialing standards.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The proportion of the providers full-time equivalent effort allocated to this organizational affiliation, expressed as a decimal (e.g., 1.0 = full-time, 0.5 = half-time). Used for workforce planning, productivity analysis, and RVU attribution.',
    `is_accepting_patients` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients under this organizational affiliation. Used for patient access management, referral routing, and provider directory accuracy per CMS and NCQA requirements.',
    `is_primary_affiliation` BOOLEAN COMMENT 'Indicates whether this organizational affiliation is the providers primary or principal employment relationship (True) versus a secondary or concurrent affiliation (False). Used for billing attribution, PCP panel assignment, and workforce reporting.',
    `is_voluntary_separation` BOOLEAN COMMENT 'Indicates whether the providers separation from the organization was voluntary (True) or involuntary (False). Critical for NPDB adverse action reporting — involuntary separations related to clinical competence or conduct must be reported to the NPDB.',
    `medical_staff_category` STRING COMMENT 'The medical staff membership category assigned to the provider by the hospital or health systems medical staff office. Governs clinical privileges, voting rights, and committee eligibility per medical staff bylaws. [ENUM-REF-CANDIDATE: active|associate|courtesy|consulting|honorary|provisional|affiliate — 7 candidates stripped; promote to reference product]',
    `membership_role` STRING COMMENT 'The providers functional role or relationship type within the organization. Determines billing attribution rules, malpractice coverage applicability, and credentialing pathway. [ENUM-REF-CANDIDATE: owner|partner|employee|contractor|attending|consulting|locum_tenens|volunteer — promote to reference product]',
    `membership_status` STRING COMMENT 'Current lifecycle state of the providers affiliation or employment relationship with the organization. Drives access control, billing eligibility, and credentialing verification workflows.. Valid values are `active|inactive|pending|suspended|terminated|on_leave`',
    `mips_eligible` BOOLEAN COMMENT 'Indicates whether the provider is eligible for Merit-based Incentive Payment System (MIPS) reporting under this organizational affiliation. Drives quality reporting workflows and CMS payment adjustment calculations under MACRA.',
    `network_participation_status` STRING COMMENT 'The providers payer network participation status under this organizational affiliation. Determines patient cost-sharing obligations and claim adjudication rules. Critical for No Surprises Act compliance and provider directory accuracy.. Valid values are `in_network|out_of_network|pending|terminated`',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, exceptions, or remarks related to this provider-organization affiliation record. Used by credentialing staff for documentation of special circumstances, waivers, or follow-up actions.',
    `npdb_report_date` DATE COMMENT 'The date on which the adverse action or separation event was reported to the National Practitioner Data Bank (NPDB). Required for compliance tracking and audit purposes under HCQIA.',
    `npdb_report_required` BOOLEAN COMMENT 'Indicates whether this separation or adverse action event requires a mandatory report to the National Practitioner Data Bank (NPDB). Triggered by involuntary terminations related to clinical competence, conduct, or privilege revocation.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned to the individual clinician by CMS. Captured at the affiliation level to support billing attribution and payer enrollment verification for this specific organizational context.. Valid values are `^[0-9]{10}$`',
    `payer_enrollment_status` STRING COMMENT 'Status of the providers enrollment with payers under this organizational affiliation (group billing). Determines whether claims can be submitted under the organizations group NPI for this provider. Managed via Symplr Provider Enrollment.. Valid values are `enrolled|pending|not_enrolled|terminated|excluded`',
    `privileging_status` STRING COMMENT 'Current clinical privileging status for this provider at the affiliated organization. Clinical privileges define the specific procedures and services the provider is authorized to perform. Distinct from credentialing status.. Valid values are `granted|pending|provisional|suspended|revoked|not_applicable`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this group membership record was first created in the system. Supports audit trail, data lineage, and compliance with HIPAA record retention requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this group membership record was last modified. Supports change tracking, audit trail, and incremental ETL processing in the Databricks Lakehouse silver layer.',
    `source_system_record_reference` STRING COMMENT 'The native identifier of this affiliation record in the originating operational system (e.g., Symplr provider affiliation ID, Epic provider record ID). Enables bidirectional traceability between the lakehouse silver layer and the system of record.',
    `supervision_level` STRING COMMENT 'The level of supervision required for the provider under this organizational affiliation. Relevant for advanced practice providers (NPs, PAs) whose scope of practice may require physician oversight per state law and organizational policy.. Valid values are `independent|supervised|collaborative|delegated`',
    `tax_identification_number` STRING COMMENT 'The federal Tax Identification Number (Employer Identification Number or Social Security Number) used for billing and tax reporting under this organizational affiliation. Required for claims submission and IRS 1099 reporting.. Valid values are `^[0-9]{9}$`',
    `verified_by` STRING COMMENT 'Name or identifier of the credentialing staff member or system that performed the primary source verification of this affiliation record. Required for credentialing audit trail per NCQA and Joint Commission standards.',
    `verified_date` DATE COMMENT 'The date on which the affiliation or employment information was last verified through primary source verification as required by NCQA and The Joint Commission credentialing standards. Tracks compliance with mandatory verification timelines.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    CONSTRAINT pk_group_membership PRIMARY KEY(`group_membership_id`)
) COMMENT 'Association record capturing the complete current and historical membership, affiliations, and employment relationships of individual clinicians within provider groups, hospitals, health systems, academic medical centers, and other organizational entities. Includes organization name, organization type (group practice, hospital, health system, academic medical center, FQHC), role within the organization (owner, partner, employee, contractor, attending, consulting), effective and end dates, FTE allocation, primary practice location, departure reason, and voluntary/involuntary separation indicator. Provides complete affiliation history for credentialing primary source verification (work history verification is mandatory per NCQA and Joint Commission), NPDB adverse action reporting context, billing attribution, and workforce planning. Serves as the consolidated SSOT for all clinician-to-organization affiliation and employment history records — no other product in this domain stores affiliation history or organizational membership data.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` (
    `dea_registration_id` BIGINT COMMENT 'Unique surrogate identifier for each DEA controlled substance registration record in the enterprise data platform. Primary key for the dea_registration data product.',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed healthcare professional or organizational provider who holds this DEA registration. Links to the authoritative provider master record.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: State PDMP programs and payer enrollment processes require cross-validating DEA registrations against the NPPES NPI registry to confirm provider identity and active enrollment status. The plain `npi_n',
    `business_activity_type` STRING COMMENT 'The DEA-defined category of business activity for which the registration is issued. Determines the type of controlled substance activities the registrant is authorized to perform. Practitioner covers physicians, dentists, and veterinarians; mid-level practitioner covers nurse practitioners and physician assistants; hospital and pharmacy cover institutional registrants. [ENUM-REF-CANDIDATE: practitioner|mid-level_practitioner|hospital|pharmacy|researcher|manufacturer|distributor|importer|exporter|reverse_distributor|narcotic_treatment_program — promote to reference product]',
    `days_until_expiration` STRING COMMENT 'The number of calendar days remaining until the DEA registration expires, calculated as of the most recent data refresh date. Supports proactive credentialing management and pharmacy compliance dashboards. Note: This is a point-in-time snapshot value loaded during ETL; it is not a real-time computed field.',
    `dea_number` STRING COMMENT 'The official DEA registration number assigned by the Drug Enforcement Administration to authorize the registrant to handle controlled substances. Format: two-letter prefix followed by seven digits. Used for pharmacy order validation and controlled substance prescribing verification.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `expiration_alert_date` DATE COMMENT 'The date on which the expiration alert notification was sent to the provider and/or credentialing staff. Null if no alert has been sent. Used for credentialing workflow audit trails.',
    `expiration_alert_sent` BOOLEAN COMMENT 'Indicates whether an expiration alert notification has been sent to the provider and/or credentialing staff regarding the upcoming expiration of this DEA registration. Supports proactive renewal workflow management.',
    `expiration_date` DATE COMMENT 'The calendar date on which the DEA registration expires and the provider is no longer authorized to prescribe or handle controlled substances under this registration. DEA registrations are typically issued for a three-year term. Critical for pharmacy order validation and compliance monitoring.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The registration fee paid to the DEA for the current registration period, in U.S. dollars. DEA registration fees vary by registrant type and are set by federal regulation. Used for credentialing cost tracking and budget reconciliation.',
    `fee_exempt` BOOLEAN COMMENT 'Indicates whether the registrant is exempt from DEA registration fees. Fee exemptions apply to federal, state, and local government practitioners, as well as certain public health service providers. Relevant for registration cost tracking and compliance.',
    `notes` STRING COMMENT 'Free-text field for credentialing staff to document additional context, exceptions, or administrative notes related to the DEA registration. Examples include documentation of DEA correspondence, special conditions, or manual verification notes.',
    `payment_date` DATE COMMENT 'The date on which the DEA registration fee was paid for the current registration period. Used for financial reconciliation and credentialing audit trails.',
    `pdmp_reporting_required` BOOLEAN COMMENT 'Indicates whether the provider holding this DEA registration is subject to mandatory Prescription Drug Monitoring Program (PDMP) reporting requirements in the registered state. PDMP reporting obligations vary by state and practitioner type.',
    `practitioner_type_code` STRING COMMENT 'DEA-assigned code identifying the specific practitioner type category (e.g., MD, DO, DDS, DVM, NP, PA, CRNA). Determines prescribing authority scope and schedule authorization eligibility. Sourced from DEA registration application form. [ENUM-REF-CANDIDATE: MD|DO|DDS|DMD|DVM|NP|PA|CRNA|CNM|PharmD|RPh|ND|OD|DPM|PhD — promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this DEA registration record was first created in the enterprise data platform. Supports data lineage, audit trail, and compliance reporting requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this DEA registration record was most recently updated in the enterprise data platform. Used for change tracking, incremental ETL processing, and audit compliance.',
    `registered_address_line1` STRING COMMENT 'Primary street address line of the practice location registered with the DEA. The DEA registration is location-specific; a provider with multiple practice sites may require separate registrations per location.',
    `registered_address_line2` STRING COMMENT 'Secondary address line (suite, floor, unit number) of the practice location registered with the DEA. Supplements the primary address line for precise location identification.',
    `registered_city` STRING COMMENT 'City of the practice location registered with the DEA for this controlled substance registration.',
    `registered_name` STRING COMMENT 'The full legal name of the individual practitioner or organization as it appears on the DEA registration certificate. May differ from the providers operational display name. Used for verification against DEA public registry and pharmacy dispensing records.',
    `registered_zip_code` STRING COMMENT 'U.S. ZIP or ZIP+4 postal code of the practice location registered with the DEA. Used for geographic analysis of controlled substance prescribing patterns and regulatory reporting.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `registration_date` DATE COMMENT 'The calendar date on which the DEA registration was originally issued or most recently renewed by the Drug Enforcement Administration. Represents the effective start of the current registration period.',
    `registration_state` STRING COMMENT 'The U.S. state or territory in which the DEA registration is valid and the provider is authorized to prescribe controlled substances. DEA registrations are state-specific; a provider practicing in multiple states requires a separate DEA registration for each state. Represented as a two-letter USPS state abbreviation.. Valid values are `^[A-Z]{2}$`',
    `registration_status` STRING COMMENT 'Current lifecycle status of the DEA registration. Active indicates the registration is valid and the provider may prescribe controlled substances. Expired indicates the registration has lapsed and must be renewed before prescribing. Suspended or revoked indicates regulatory action has been taken.. Valid values are `active|expired|suspended|revoked|pending|surrendered`',
    `registration_type` STRING COMMENT 'Indicates whether the DEA registration is held by an individual practitioner or by an institutional entity (e.g., hospital, clinic, pharmacy). Institutional registrations cover all authorized practitioners operating under the institutions DEA number.. Valid values are `individual|institutional`',
    `renewal_application_date` DATE COMMENT 'The date on which the provider submitted a renewal application to the DEA for continuation of the controlled substance registration. DEA regulations require renewal applications to be submitted at least 45 days before expiration. Used for credentialing workflow tracking in Symplr.',
    `renewal_confirmation_number` STRING COMMENT 'The confirmation or tracking number issued by the DEA upon receipt of a renewal application. Used to track the status of pending renewals and follow up with the DEA Diversion Control Division.',
    `revocation_date` DATE COMMENT 'The date on which the DEA registration was formally revoked by the Drug Enforcement Administration. Revocation is a permanent action distinct from suspension. Null when the registration has not been revoked.',
    `schedule_ii_authorized` BOOLEAN COMMENT 'Indicates whether the DEA registration authorizes the provider to prescribe Schedule II controlled substances (e.g., opioids such as oxycodone, stimulants such as amphetamine). Schedule II substances have high abuse potential with severe psychological or physical dependence. Required for CPOE validation in Epic Willow and Cerner PharmNet.',
    `schedule_iii_authorized` BOOLEAN COMMENT 'Indicates whether the DEA registration authorizes the provider to prescribe Schedule III controlled substances (e.g., anabolic steroids, buprenorphine combinations). Schedule III substances have moderate to low physical dependence potential.',
    `schedule_iin_authorized` BOOLEAN COMMENT 'Indicates whether the DEA registration authorizes the provider to prescribe Schedule IIN non-narcotic controlled substances (e.g., stimulants such as methylphenidate, Adderall). Distinct from Schedule IIN narcotic authorizations for pharmacy dispensing and order validation purposes.',
    `schedule_iv_authorized` BOOLEAN COMMENT 'Indicates whether the DEA registration authorizes the provider to prescribe Schedule IV controlled substances (e.g., benzodiazepines, tramadol). Schedule IV substances have lower abuse potential relative to Schedule III.',
    `schedule_v_authorized` BOOLEAN COMMENT 'Indicates whether the DEA registration authorizes the provider to prescribe Schedule V controlled substances (e.g., cough preparations with less than 200mg of codeine per 100mL). Schedule V substances have the lowest abuse potential among controlled substances.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this DEA registration record was sourced or last updated. Supports data lineage tracking and ETL reconciliation across credentialing platforms.. Valid values are `SYMPLR|EPIC|CERNER|MEDITECH|DEA_PORTAL|MANUAL`',
    `source_system_record_reference` STRING COMMENT 'The native record identifier for this DEA registration in the originating operational system (e.g., Symplr provider ID, Epic provider record number). Used for ETL reconciliation and cross-system traceability.',
    `surrender_date` DATE COMMENT 'The date on which the provider voluntarily surrendered the DEA registration to the Drug Enforcement Administration. Voluntary surrender may occur upon retirement, change of practice, or in lieu of revocation proceedings.',
    `suspension_date` DATE COMMENT 'The date on which the DEA registration was suspended by the Drug Enforcement Administration or voluntarily surrendered by the provider. Null when the registration has not been suspended. Triggers immediate pharmacy order blocking in CPOE systems.',
    `suspension_reason` STRING COMMENT 'Narrative description of the reason for suspension or revocation of the DEA registration, as documented by the DEA or the providers credentialing department. Includes regulatory action codes, voluntary surrender reasons, or administrative hold explanations.',
    `verification_date` DATE COMMENT 'The most recent date on which the DEA registration was verified against the DEA Diversion Control Division public registry or through a primary source verification process. Required for Joint Commission and NCQA credentialing compliance.',
    `verification_method` STRING COMMENT 'The method used to verify the DEA registration during the credentialing or re-credentialing process. DEA portal indicates direct query to the DEA Diversion Control Division online registry; primary source indicates direct contact with the DEA; third party indicates use of a credentialing verification organization (CVO).. Valid values are `dea_portal|primary_source|third_party|manual`',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    `x_waiver_authorized` BOOLEAN COMMENT 'Indicates whether the provider holds a DATA 2000 waiver (formerly X-waiver) authorizing the prescribing of buprenorphine for opioid use disorder treatment in an office-based setting. As of the SUPPORT Act (2023), the X-waiver requirement was eliminated, but this flag tracks historical and current waiver status for compliance and analytics.',
    `x_waiver_patient_limit` STRING COMMENT 'The maximum number of patients the provider is authorized to treat with buprenorphine for opioid use disorder under the DATA 2000 waiver. Common limits are 30, 100, or 275 patients depending on provider type and waiver tier. Null if x_waiver_authorized is false or not applicable.',
    CONSTRAINT pk_dea_registration PRIMARY KEY(`dea_registration_id`)
) COMMENT 'Master record of DEA (Drug Enforcement Administration) controlled substance registrations for clinicians authorized to prescribe Schedule II-V medications. Captures DEA number, registration date, expiration date, DEA schedule authorizations, state of registration, registration status, and business activity type. Required for pharmacy order validation and controlled substance compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`board_certification` (
    `board_certification_id` BIGINT COMMENT 'Unique surrogate identifier for each board certification record in the system. Primary key for the board_certification data product within the provider domain.',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed healthcare professional (physician, nurse practitioner, or allied health professional) who holds this board certification. Links to the provider master record.',
    `specialty_id` BIGINT COMMENT 'FK to provider.specialty',
    `board_certification_status` STRING COMMENT 'Status for board certification.',
    `caqh_provider_number` STRING COMMENT 'The CAQH ProView universal provider identifier associated with the provider for this certification record. CAQH ProView is the industry-standard credentialing data repository used by payers and health plans for provider enrollment and re-credentialing. Enables direct linkage to the providers CAQH profile.',
    `certification_number` STRING COMMENT 'The unique alphanumeric certificate number issued by the certifying board to the provider upon successful completion of board examination and certification requirements. Used as the externally-known business identifier for this certification record in credentialing and payer enrollment workflows.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the board certification. Active = valid and in good standing; Expired = past expiration date without renewal; Revoked = rescinded by certifying board due to disciplinary action or fraud; Suspended = temporarily inactive; Pending = examination passed but certificate not yet issued; Lapsed = MOC requirements not met within required window.. Valid values are `Active|Expired|Revoked|Suspended|Pending|Lapsed`',
    `certification_type` STRING COMMENT 'Indicates whether this certification record represents an initial board certification, a recertification cycle, an added qualification (subspecialty), or a Maintenance of Certification (MOC) milestone. Drives credentialing workflow routing and expiration tracking logic.. Valid values are `Initial|Recertification|Added Qualification|Maintenance of Certification`',
    `certifying_board` STRING COMMENT 'Certifying Board for board certification.',
    `certifying_board_code` STRING COMMENT 'Standardized short code or abbreviation identifying the certifying board (e.g., ABIM for American Board of Internal Medicine, ABS for American Board of Surgery). Used in downstream credentialing systems and payer enrollment data exchanges.',
    `certifying_board_name` STRING COMMENT 'Full name of the recognized specialty certifying board that issued this certification (e.g., American Board of Internal Medicine, American Board of Surgery). Must be an ABMS member board or AOA-recognized certifying board for credentialing acceptance.',
    `certifying_organization_type` STRING COMMENT 'Classification of the umbrella organization under which the certifying board operates. ABMS = American Board of Medical Specialties (allopathic physicians), AOA = American Osteopathic Association (osteopathic physicians), ANCC = American Nurses Credentialing Center, AANP = American Association of Nurse Practitioners, AAPA = American Academy of Physician Associates.. Valid values are `ABMS|AOA|ANCC|AANP|AAPA|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this board certification record was first created in the system. Provides the audit trail creation anchor for data governance, lineage tracking, and compliance reporting.',
    `effective_date` DATE COMMENT 'The date on which the current certification cycle or recertification became effective. For initial certifications this may equal initial_certification_date; for recertifications this reflects the start of the renewed certification period.',
    `exam_attempt_number` STRING COMMENT 'The sequential attempt number on which the provider passed the board certification examination. A value of 1 indicates first-attempt pass. Used in quality and credentialing analytics to assess examination performance.',
    `exam_pass_date` DATE COMMENT 'The date on which the provider successfully passed the board certification examination administered by the certifying board. Distinct from initial_certification_date, which reflects when the certificate was formally issued.',
    `expiration_date` DATE COMMENT 'The date on which the current board certification expires and must be renewed through recertification or Maintenance of Certification (MOC). Null for lifetime certifications issued prior to time-limited certification policies. Critical for credentialing expiration alerts and payer enrollment compliance.',
    `initial_certification_date` DATE COMMENT 'The calendar date on which the provider first achieved board certification in this specialty from this certifying board. Represents the effective start of the agreement/credential. Used to calculate years of board certification and tenure in credentialing analytics.',
    `is_active_privileges_required` BOOLEAN COMMENT 'Indicates whether active hospital privileges in this specialty are required to be maintained in conjunction with this board certification per the organizations medical staff bylaws or credentialing policies.',
    `is_lifetime_certification` BOOLEAN COMMENT 'Indicates whether this board certification was issued as a lifetime (non-time-limited) certificate, typically granted to physicians who achieved certification prior to the introduction of time-limited recertification requirements by ABMS member boards. When True, expiration_date is expected to be null.',
    `is_primary_specialty` BOOLEAN COMMENT 'Indicates whether this board certification represents the providers primary specialty designation. A provider may hold multiple board certifications; this flag identifies the principal specialty used for provider directory listings, referral routing, and quality reporting.',
    `issue_date` DATE COMMENT 'Issue Date for board certification.',
    `moc_due_date` DATE COMMENT 'The deadline by which the provider must complete all required Maintenance of Certification (MOC) activities to maintain certification in good standing. Used for proactive credentialing alerts and compliance tracking.',
    `moc_enrollment_date` DATE COMMENT 'The date on which the provider enrolled in the Maintenance of Certification (MOC) program associated with this board certification. Used to track MOC program participation timelines and compliance windows.',
    `moc_program_name` STRING COMMENT 'Name of the specific Maintenance of Certification (MOC) program the provider is enrolled in for this certification (e.g., ABIM MOC, ABS Continuous Certification). Different boards operate distinct MOC programs with varying requirements.',
    `moc_status` STRING COMMENT 'Current status of the providers participation in the Maintenance of Certification (MOC) program as required by the certifying board. MOC programs require ongoing professional development, self-assessment, and practice improvement activities to maintain board certification in good standing.. Valid values are `Compliant|Non-Compliant|Exempt|Not Applicable|In Progress`',
    `notes` STRING COMMENT 'Free-text field for credentialing staff to capture supplementary information about this board certification record, such as special conditions, board correspondence details, or exceptions noted during primary source verification.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the provider holding this board certification, as assigned by CMS. Included here to support direct payer enrollment data submissions and provider directory feeds where the NPI must accompany certification data without requiring a join.. Valid values are `^[0-9]{10}$`',
    `payer_enrollment_required` BOOLEAN COMMENT 'Indicates whether this board certification is required as a condition of the providers enrollment with one or more payers (e.g., Medicare, Medicaid, commercial insurers). Drives payer enrollment workflow triggers when certification status changes.',
    `recertification_cycle_years` STRING COMMENT 'The number of years in the recertification cycle for this board certification as defined by the certifying board (e.g., 10 years for ABIM, 6 years for ABS). Used to project next recertification due dates and plan credentialing renewal workflows.',
    `recertification_date` DATE COMMENT 'The date on which the provider most recently completed recertification for this specialty board certification. Null for initial certifications that have not yet undergone a recertification cycle.',
    `revocation_date` DATE COMMENT 'The date on which the certifying board formally revoked this board certification, if applicable. Null for certifications in good standing. Revocation may result from disciplinary action, fraud, or failure to meet MOC requirements. Triggers immediate credentialing review per OIG and TJC requirements.',
    `revocation_reason` STRING COMMENT 'Narrative description of the reason for revocation of this board certification by the certifying board, if applicable. Null for active certifications. Used in credentialing review, compliance reporting, and OIG exclusion monitoring.',
    `source_system_record_reference` STRING COMMENT 'The unique identifier of this board certification record in the originating operational system of record (e.g., Symplr record ID, CAQH credential ID). Enables traceability and reconciliation between the lakehouse silver layer and the source system.',
    `subspecialty_code` STRING COMMENT 'Standardized code for the subspecialty or added qualification certification, aligned with NUCC taxonomy or ABMS subspecialty codes. Null if no subspecialty applies to this certification record.',
    `subspecialty_name` STRING COMMENT 'Full name of the subspecialty or added qualification for which the provider holds certification, if applicable (e.g., Interventional Cardiology within Cardiology, Pediatric Critical Care within Pediatrics). Null if no subspecialty certification exists for this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this board certification record was most recently modified. Used for change detection, incremental ETL processing, and audit trail maintenance in the Databricks Lakehouse silver layer.',
    `verification_date` DATE COMMENT 'The date on which primary source verification (PSV) of this board certification was most recently completed by contacting the certifying board directly or through an approved verification service (e.g., ABMS Certification Matters, CAQH). Required for TJC and NCQA credentialing compliance.',
    `verification_source` STRING COMMENT 'The primary source or service used to verify this board certification (e.g., ABMS Certification Matters website, AOA Physician Finder, CAQH ProView, direct board contact). Documents the audit trail for credentialing compliance.',
    `verification_status` STRING COMMENT 'Status of the primary source verification (PSV) of this board certification as required by The Joint Commission and NCQA credentialing standards. Verified = confirmed directly with the certifying board; Pending Verification = PSV request submitted but not yet confirmed; Unable to Verify = certifying board could not confirm; Expired Verification = PSV is older than the required re-verification window.. Valid values are `Verified|Pending Verification|Unable to Verify|Expired Verification`',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure product is touched.',
    CONSTRAINT pk_board_certification PRIMARY KEY(`board_certification_id`)
) COMMENT 'Tracks specialty board certifications earned by clinicians from recognized certifying bodies (ABMS, AOA). Captures certifying board name, specialty certified, certification number, initial certification date, expiration date, maintenance of certification (MOC) status, and recertification history. Used in credentialing, provider directory, and quality reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` (
    `taxonomy_id` BIGINT COMMENT 'Unique surrogate identifier for each provider taxonomy code record in the NUCC Health Care Provider Taxonomy reference catalog. Primary key for this table. [_canonical_skip_reason: REFERENCE_LOOKUP — this entity is a NUCC taxonomy code reference table; per-role minimums for REFERENCE_LOOKUP/OTHER are exempt.]',
    `snomed_concept_id` BIGINT COMMENT 'The SNOMED CT concept identifier that semantically maps to this provider taxonomy code, enabling interoperability with clinical terminology systems and FHIR-based health information exchanges.',
    `abms_board_name` STRING COMMENT 'The name of the American Board of Medical Specialties (ABMS) member board associated with this taxonomy code (e.g., American Board of Internal Medicine, American Board of Surgery). Used in board certification verification during credentialing.',
    `acgme_program_code` STRING COMMENT 'The ACGME program specialty code associated with the residency or fellowship training program that corresponds to this taxonomy classification. Used to validate training pathway alignment during provider credentialing.',
    `board_certification_required` BOOLEAN COMMENT 'Indicates whether board certification is a standard credentialing requirement for providers holding this taxonomy code. Used in credentialing completeness validation and payer enrollment eligibility checks.',
    `classification` STRING COMMENT 'The second level of the NUCC taxonomy hierarchy representing the providers primary discipline or specialty grouping within the provider type (e.g., Family Medicine, Internal Medicine, Pediatrics). Used in payer enrollment and claims adjudication to route claims to appropriate fee schedules.',
    `cms_specialty_code` STRING COMMENT 'The two-digit CMS specialty code that maps to this NUCC taxonomy code, used in Medicare and Medicaid claims processing, fee schedule assignment, and PECOS enrollment. Enables crosswalk between NUCC taxonomy and CMS specialty classification for reimbursement purposes.. Valid values are `^[0-9]{2}$`',
    `cms_specialty_description` STRING COMMENT 'The descriptive label associated with the CMS specialty code crosswalk for this taxonomy entry (e.g., General Practice, Cardiology, Pathology). Supports reporting and validation in Medicare claims adjudication workflows.',
    `taxonomy_code` STRING COMMENT 'The 10-character alphanumeric code assigned by the National Uniform Claim Committee (NUCC) that uniquely identifies a provider type, classification, and specialization. Used on CMS-1500 and UB-04 claim forms, NPI registry enrollment, and payer credentialing. Example: 207Q00000X for Family Medicine.. Valid values are `^[0-9]{6}[A-Z0-9]{3}X$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this taxonomy code record was first loaded into the enterprise data platform. Used for data lineage, audit trail, and ETL monitoring.',
    `dea_registration_applicable` BOOLEAN COMMENT 'Indicates whether providers with this taxonomy code are typically required or eligible to obtain a DEA registration number for prescribing controlled substances. Supports credentialing completeness checks and compliance monitoring.',
    `definition` STRING COMMENT 'The official NUCC narrative definition describing the scope of practice, training requirements, and clinical activities associated with this taxonomy code. Used by credentialing staff and payer enrollment teams to validate appropriate taxonomy selection.',
    `display_name` STRING COMMENT 'The full human-readable display name for the taxonomy code as published by NUCC, combining provider type, classification, and specialization into a single descriptive label used in UI dropdowns, reports, and provider directories.',
    `effective_date` DATE COMMENT 'The date on which this taxonomy code became effective and valid for use in NPI registry enrollment, claims submission, and payer credentialing. Aligns with the NUCC code set release date.',
    `end_date` DATE COMMENT 'The date on which this taxonomy code was retired or deactivated by NUCC. Null for currently active codes. Used to prevent use of retired codes in new NPI enrollments and claims submissions.',
    `fhir_practitioner_role_code` STRING COMMENT 'The HL7 FHIR PractitionerRole code that corresponds to this NUCC taxonomy code, used in FHIR-based API integrations, HIE data exchange, and interoperability with external EHR systems.',
    `hospital_privileges_applicable` BOOLEAN COMMENT 'Indicates whether providers with this taxonomy code are subject to hospital privileging and credentialing requirements. Drives privileging workflow initiation in credentialing systems such as Symplr.',
    `individual_or_organization` STRING COMMENT 'Indicates whether this taxonomy code applies to an individual healthcare professional (Type 1 NPI) or an organizational/group provider (Type 2 NPI). Drives NPI enumeration type selection and payer enrollment form routing.. Valid values are `Individual|Organization`',
    `medicaid_enrollment_eligible` BOOLEAN COMMENT 'Indicates whether providers with this taxonomy code are eligible to enroll as Medicaid providers. Supports state Medicaid agency enrollment workflows and payer credentialing validation.',
    `mips_eligible` BOOLEAN COMMENT 'Indicates whether providers with this taxonomy code are eligible to participate in the Merit-based Incentive Payment System (MIPS) under MACRA. Used in quality reporting program enrollment and value-based care analytics.',
    `network_adequacy_category` STRING COMMENT 'The network adequacy classification assigned to this taxonomy code by CMS or state regulators, indicating the minimum provider-to-enrollee ratios and geographic access standards required for health plan network compliance (e.g., Primary Care, Specialist, Behavioral Health, Ancillary).',
    `notes` STRING COMMENT 'Supplemental notes published by NUCC clarifying usage, scope limitations, or cross-references to related taxonomy codes. Assists credentialing and billing staff in selecting the most appropriate taxonomy code for a provider.',
    `npi_type` STRING COMMENT 'The NPI enumeration type associated with this taxonomy code: Type 1 for individual healthcare providers and Type 2 for organizational providers. Determines the NPI application process and NPPES registry classification.. Valid values are `Type 1|Type 2`',
    `nucc_grouping` STRING COMMENT 'The broad grouping category assigned by NUCC above the provider type level, used to segment taxonomy codes into major provider categories such as Individual, Non-Individual, or specific functional groupings (e.g., Behavioral Health & Social Service Providers, Dental Providers). Supports high-level analytics and network adequacy reporting.',
    `pecos_enrollment_eligible` BOOLEAN COMMENT 'Indicates whether providers with this taxonomy code are eligible to enroll in Medicare through the PECOS system. Used by revenue cycle and credentialing teams to determine Medicare participation eligibility during provider onboarding.',
    `prescribing_authority` BOOLEAN COMMENT 'Indicates whether providers classified under this taxonomy code typically hold prescribing authority for medications. Used in pharmacy benefit management, DEA registration workflows, and Computerized Physician Order Entry (CPOE) access control configuration.',
    `primary_care_designation` BOOLEAN COMMENT 'Indicates whether this taxonomy code is recognized as a primary care designation by CMS and payers. Used in network adequacy analysis, HMO/PPO panel assignments, ACO attribution, and HEDIS measure reporting.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether services rendered by providers with this taxonomy code typically require prior authorization from payers. Used in utilization management configuration and claims pre-authorization workflow routing.',
    `provider_type` STRING COMMENT 'The highest-level grouping in the NUCC taxonomy hierarchy that broadly categorizes the provider (e.g., Allopathic & Osteopathic Physicians, Nursing Service Providers, Hospitals, Laboratories). Corresponds to the Type level of the NUCC three-level hierarchy.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether a referral from a primary care provider is typically required before a patient can access services from a provider with this taxonomy code. Relevant for HMO and POS plan configurations.',
    `replacement_taxonomy_code` STRING COMMENT 'The NUCC taxonomy code that replaces this code when it has been retired or deprecated. Enables automated migration of provider taxonomy assignments during NUCC code set updates and supports backward compatibility in claims processing.. Valid values are `^[0-9]{6}[A-Z0-9]{3}X$`',
    `rvu_work_component` DECIMAL(18,2) COMMENT 'The typical physician work Relative Value Unit (RVU) component associated with services delivered under this taxonomy code, used as a benchmark for productivity measurement, compensation modeling, and value-based payment analytics.',
    `source_system_record_reference` STRING COMMENT 'The unique identifier of this taxonomy record in the originating source system (e.g., NUCC internal code ID, NPPES taxonomy reference ID). Used for ETL reconciliation and cross-system data lineage.',
    `specialization` STRING COMMENT 'The third and most granular level of the NUCC taxonomy hierarchy representing a specific area of practice within the classification (e.g., Adolescent Medicine, Geriatric Medicine, Sports Medicine). May be null for taxonomy codes that do not have a defined specialization.',
    `surgical_specialty` BOOLEAN COMMENT 'Indicates whether this taxonomy code represents a surgical specialty. Used in OR scheduling, surgical credentialing workflows, and operative case volume reporting.',
    `taxonomy_status` STRING COMMENT 'The current lifecycle status of this taxonomy code as maintained by NUCC: Active (valid for current use), Retired (no longer valid for new enrollments), or Deprecated (superseded by a replacement code). Drives validation rules in NPI enrollment and claims editing systems.. Valid values are `Active|Retired|Deprecated`',
    `telehealth_eligible` BOOLEAN COMMENT 'Indicates whether providers with this taxonomy code are eligible to deliver and bill for telehealth services under CMS and payer policies. Supports telehealth program configuration and claims validation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this taxonomy code record was last modified in the enterprise data platform, reflecting updates from NUCC code set releases or CMS crosswalk revisions.',
    `version` STRING COMMENT 'The version number of the NUCC Health Care Provider Taxonomy Code Set from which this taxonomy code was sourced (e.g., 23.1, 24.0). NUCC releases updates twice per year; version tracking ensures claims and enrollment systems use the correct code set.. Valid values are `^[0-9]{2}.[0-9]$`',
    CONSTRAINT pk_taxonomy PRIMARY KEY(`taxonomy_id`)
) COMMENT 'Reference catalog of NUCC (National Uniform Claim Committee) Health Care Provider Taxonomy codes used to classify provider type, classification, and specialization on claims and enrollment forms. Captures taxonomy code, provider type, classification, specialization, effective date, and CMS crosswalk to specialty codes. Used in NPI registry, claims submission, and payer enrollment.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_board_certification_id` FOREIGN KEY (`board_certification_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`board_certification`(`board_certification_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`provider` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`provider` SET TAGS ('dbx_domain' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Identifier');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Specialty');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'NPI Registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `board_certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Expiration');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `board_certification_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `board_certified` SET TAGS ('dbx_business_glossary_term' = 'Board Certified');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `caqh_provider_number` SET TAGS ('dbx_business_glossary_term' = 'CAQH Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `caqh_provider_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `clinician_type` SET TAGS ('dbx_business_glossary_term' = 'Clinician Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'DEA Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Fellowship Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_business_glossary_term' = 'Fellowship Program');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `gender` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `gender` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Internship Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_business_glossary_term' = 'Internship Program');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `malpractice_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `malpractice_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `malpractice_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `malpractice_policy_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `malpractice_policy_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `malpractice_policy_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medicaid_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Enrolled');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_degree` SET TAGS ('dbx_business_glossary_term' = 'Medical Degree');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_degree` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_degree` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_graduation_date` SET TAGS ('dbx_business_glossary_term' = 'Medical School Graduation Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_graduation_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_graduation_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_business_glossary_term' = 'Medical School');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medicare_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Medicare Enrolled');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'Npi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `oig_exclusion_check_date` SET TAGS ('dbx_business_glossary_term' = 'OIG Exclusion Check Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `oig_exclusion_checked` SET TAGS ('dbx_business_glossary_term' = 'OIG Exclusion Checked');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `payer_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `primary_source_verified` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verified');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `professional_designation` SET TAGS ('dbx_business_glossary_term' = 'Professional Designation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_acgme_accredited` SET TAGS ('dbx_business_glossary_term' = 'ACGME Accredited Residency');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Residency Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_business_glossary_term' = 'Residency Program');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Provider Identifier');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'NPI Registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_business_glossary_term' = 'CMS Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `critical_access_hospital_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Access Hospital');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `disproportionate_share_flag` SET TAGS ('dbx_business_glossary_term' = 'Disproportionate Share');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'DBA Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `ehr_system` SET TAGS ('dbx_business_glossary_term' = 'EHR System');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_business_glossary_term' = 'Fax');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fhir_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Endpoint URL');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `medicare_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicare Participation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `oig_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'OIG Exclusion Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Phone');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `provider_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `sam_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'SAM Exclusion Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `teaching_status` SET TAGS ('dbx_business_glossary_term' = 'Teaching Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Level');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Identifier');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_business_glossary_term' = 'ABMS Board Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `acgme_program_code` SET TAGS ('dbx_business_glossary_term' = 'ACGME Program Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_certification_body` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Body');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Required');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_category` SET TAGS ('dbx_business_glossary_term' = 'Specialty Category');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `cms_enrollment_specialty_type` SET TAGS ('dbx_business_glossary_term' = 'CMS Enrollment Specialty Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `cms_specialty_code` SET TAGS ('dbx_business_glossary_term' = 'CMS Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Required');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_description` SET TAGS ('dbx_business_glossary_term' = 'Specialty Description');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `fhir_practitioner_role_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Practitioner Role Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `hedis_measure_set` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `hospital_privileges_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hospital Privileges Applicable');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `mips_eligible` SET TAGS ('dbx_business_glossary_term' = 'MIPS Eligible');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Specialty Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_business_glossary_term' = 'NPI Taxonomy Eligible');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `nucc_classification` SET TAGS ('dbx_business_glossary_term' = 'NUCC Classification');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `nucc_provider_type` SET TAGS ('dbx_business_glossary_term' = 'NUCC Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `nucc_specialization` SET TAGS ('dbx_business_glossary_term' = 'NUCC Specialization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `nucc_taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'NUCC Taxonomy Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `payer_enrollment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment Eligible');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `pecos_specialty_code` SET TAGS ('dbx_business_glossary_term' = 'PECOS Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `prescribing_authority` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Authority');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `primary_care_designation` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Designation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `rvu_work_component` SET TAGS ('dbx_business_glossary_term' = 'RVU Work Component');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_status` SET TAGS ('dbx_business_glossary_term' = 'Specialty Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_type` SET TAGS ('dbx_business_glossary_term' = 'Specialty Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `surgical_specialty` SET TAGS ('dbx_business_glossary_term' = 'Surgical Specialty');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Eligible');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('dbx_subdomain' = 'clinical_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Identifier');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `board_action_date` SET TAGS ('dbx_business_glossary_term' = 'Board Action Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `board_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Action Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `caqh_submitted` SET TAGS ('dbx_business_glossary_term' = 'CAQH Submitted');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Board');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('dbx_business_glossary_term' = 'CME Accrediting Organization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_activity_title` SET TAGS ('dbx_business_glossary_term' = 'CME Activity Title');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_activity_type` SET TAGS ('dbx_business_glossary_term' = 'CME Activity Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_category` SET TAGS ('dbx_business_glossary_term' = 'CME Category');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'CME Credit Hours');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `days_to_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiration');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `days_to_expiration` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('dbx_business_glossary_term' = 'DEA Business Activity Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('dbx_business_glossary_term' = 'DEA Schedule Authorizations');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `moc_status` SET TAGS ('dbx_business_glossary_term' = 'MOC Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `npdb_queried` SET TAGS ('dbx_business_glossary_term' = 'NPDB Queried');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `npdb_query_date` SET TAGS ('dbx_business_glossary_term' = 'NPDB Query Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `oig_exclusion_check_date` SET TAGS ('dbx_business_glossary_term' = 'OIG Exclusion Check Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `oig_exclusion_checked` SET TAGS ('dbx_business_glossary_term' = 'OIG Exclusion Checked');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `payer_enrollment_relevant` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment Relevant');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `primary_source_verified` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verified');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `privileging_relevant` SET TAGS ('dbx_business_glossary_term' = 'Privileging Relevant');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `psv_date` SET TAGS ('dbx_business_glossary_term' = 'PSV Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `psv_method` SET TAGS ('dbx_business_glossary_term' = 'PSV Method');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `recredentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `sam_exclusion_checked` SET TAGS ('dbx_business_glossary_term' = 'SAM Exclusion Checked');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Reference');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Subtype');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('dbx_subdomain' = 'clinical_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `board_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `board_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Board Cert Required');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `completed_case_volume` SET TAGS ('dbx_business_glossary_term' = 'Completed Cases');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `delineation_form_version` SET TAGS ('dbx_business_glossary_term' = 'Delineation Form Version');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `emtala_covered` SET TAGS ('dbx_business_glossary_term' = 'EMTALA Covered');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `fppe_completion_date` SET TAGS ('dbx_business_glossary_term' = 'FPPE Completion');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `fppe_required` SET TAGS ('dbx_business_glossary_term' = 'FPPE Required');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `is_provisional` SET TAGS ('dbx_business_glossary_term' = 'Provisional');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `malpractice_verified` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Verified');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `npdb_report_date` SET TAGS ('dbx_business_glossary_term' = 'NPDB Report Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `npdb_report_required` SET TAGS ('dbx_business_glossary_term' = 'NPDB Report Required');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `oppe_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'OPPE Last Review');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `peer_review_score` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Score');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_category` SET TAGS ('dbx_business_glossary_term' = 'Privilege Category');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_description` SET TAGS ('dbx_business_glossary_term' = 'Privilege Description');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_business_glossary_term' = 'Privilege Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_number` SET TAGS ('dbx_business_glossary_term' = 'Privilege Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_status` SET TAGS ('dbx_business_glossary_term' = 'Privilege Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_type` SET TAGS ('dbx_business_glossary_term' = 'Privilege Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `provisional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Provisional End Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `reappointment_cycle_years` SET TAGS ('dbx_business_glossary_term' = 'Reappointment Cycle');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `required_case_volume` SET TAGS ('dbx_business_glossary_term' = 'Required Case Volume');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Ref');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `telemedicine_authorized` SET TAGS ('dbx_business_glossary_term' = 'Telemedicine Authorized');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `training_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Training Met');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('dbx_subdomain' = 'network_participation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `network_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Affiliation ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `aco_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participant Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `age_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Served');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `age_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Served');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending|expired|denied|re_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `directory_published_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Published Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_business_glossary_term' = 'Gender Served');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_value_regex' = 'all|male|female|pediatric');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `handicap_accessible` SET TAGS ('dbx_business_glossary_term' = 'Handicap Accessible Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `hospital_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospital Affiliation Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `mips_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_value_regex' = 'primary_care|specialist|behavioral_health|hospital|ancillary|pharmacy');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Notes');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_business_glossary_term' = 'Panel Capacity');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_current_count` SET TAGS ('dbx_business_glossary_term' = 'Panel Current Count');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Panel Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'open|closed|limited');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `participation_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|preferred|non_preferred|tiered');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `primary_care_designation` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Designation Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `reimbursement_model` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Model');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `reimbursement_model` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|bundled_payment|value_based|salary|per_diem');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `reimbursement_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('dbx_business_glossary_term' = 'Service Area State');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area ZIP Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|contract_expiration|credentialing_failure|retirement|other');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `aco_participant` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participant Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Administrative Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Group Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `contract_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Group Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending_initial|pending_recredentialing|expired|denied|suspended');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Record Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `fqhc_designation` SET TAGS ('dbx_business_glossary_term' = 'Federally Qualified Health Center (FQHC) Designation Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `hl7_fhir_organization_reference` SET TAGS ('dbx_business_glossary_term' = 'HL7 FHIR Organization Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `hospital_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Primary Hospital Affiliation Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `languages_supported` SET TAGS ('dbx_business_glossary_term' = 'Languages Supported');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `last_credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credentialing Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `medicaid_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `medicaid_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|pending|terminated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `medicaid_enrollment_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `medicare_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Medicare Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `medicare_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|opt_out|not_enrolled|pending|terminated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('dbx_business_glossary_term' = 'MIPS Group Reporting Election Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|pending|terminated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `payer_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `payer_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|pending|not_enrolled|terminated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_business_glossary_term' = 'Primary Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Location Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Location City');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Location State');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Location ZIP Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `rhc_designation` SET TAGS ('dbx_business_glossary_term' = 'Rural Health Clinic (RHC) Designation Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Size (Clinician Count)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `source_system_group_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Provider Group Identifier');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Identification Number (TIN/EIN)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Record Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Website URL');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('dbx_subdomain' = 'network_participation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `group_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Group Membership ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `group_membership_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `group_membership_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `academic_appointment_rank` SET TAGS ('dbx_business_glossary_term' = 'Academic Appointment Rank');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `academic_appointment_rank` SET TAGS ('dbx_value_regex' = 'instructor|assistant_professor|associate_professor|professor|clinical_professor|adjunct');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `aco_participation` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending|expired|suspended|revoked|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `departure_reason` SET TAGS ('dbx_business_glossary_term' = 'Departure Reason');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'employed|independent_contractor|locum_tenens|per_diem|volunteer|academic_appointment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepting Patients Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_primary_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Primary Affiliation Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_voluntary_separation` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Separation Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_voluntary_separation` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Category');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_business_glossary_term' = 'Membership Role');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated|on_leave');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `mips_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Eligible Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|pending|terminated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Notes');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npdb_report_date` SET TAGS ('dbx_business_glossary_term' = 'National Practitioner Data Bank (NPDB) Report Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npdb_report_required` SET TAGS ('dbx_business_glossary_term' = 'National Practitioner Data Bank (NPDB) Report Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `payer_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `payer_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|pending|not_enrolled|terminated|excluded');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `privileging_status` SET TAGS ('dbx_business_glossary_term' = 'Privileging Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `privileging_status` SET TAGS ('dbx_value_regex' = 'granted|pending|provisional|suspended|revoked|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `supervision_level` SET TAGS ('dbx_business_glossary_term' = 'Supervision Level');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `supervision_level` SET TAGS ('dbx_value_regex' = 'independent|supervised|collaborative|delegated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('dbx_subdomain' = 'clinical_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `business_activity_type` SET TAGS ('dbx_business_glossary_term' = 'DEA Business Activity Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `days_until_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days Until DEA Registration Expiration');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `days_until_expiration` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `expiration_alert_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Expiration Alert Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `expiration_alert_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `expiration_alert_sent` SET TAGS ('dbx_business_glossary_term' = 'DEA Expiration Alert Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `expiration_alert_sent` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `fee_exempt` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Fee Exemption Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Notes');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Fee Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `pdmp_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Monitoring Program (PDMP) Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `practitioner_type_code` SET TAGS ('dbx_business_glossary_term' = 'DEA Practitioner Type Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'DEA Registered Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'DEA Registered Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'DEA Registered City');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_city` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_name` SET TAGS ('dbx_business_glossary_term' = 'DEA Registered Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_zip_code` SET TAGS ('dbx_business_glossary_term' = 'DEA Registered ZIP Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_zip_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registered_zip_code` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_state` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration State');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_state` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|surrendered');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'individual|institutional');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Renewal Application Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `renewal_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'DEA Renewal Confirmation Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `schedule_ii_authorized` SET TAGS ('dbx_business_glossary_term' = 'Schedule II Controlled Substance Authorization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `schedule_iii_authorized` SET TAGS ('dbx_business_glossary_term' = 'Schedule III Controlled Substance Authorization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `schedule_iin_authorized` SET TAGS ('dbx_business_glossary_term' = 'Schedule IIN (Non-Narcotic) Controlled Substance Authorization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `schedule_iv_authorized` SET TAGS ('dbx_business_glossary_term' = 'Schedule IV Controlled Substance Authorization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `schedule_v_authorized` SET TAGS ('dbx_business_glossary_term' = 'Schedule V Controlled Substance Authorization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SYMPLR|EPIC|CERNER|MEDITECH|DEA_PORTAL|MANUAL');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `surrender_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Surrender Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Suspension Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Suspension Reason');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'dea_portal|primary_source|third_party|manual');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `x_waiver_authorized` SET TAGS ('dbx_business_glossary_term' = 'Buprenorphine (X-Waiver / DATA 2000 Waiver) Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `x_waiver_patient_limit` SET TAGS ('dbx_business_glossary_term' = 'Buprenorphine X-Waiver Patient Limit');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `x_waiver_patient_limit` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `x_waiver_patient_limit` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('dbx_subdomain' = 'clinical_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Board Certification ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `specialty_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `caqh_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Council for Affordable Quality Healthcare (CAQH) Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `caqh_provider_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Active|Expired|Revoked|Suspended|Pending|Lapsed');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'Initial|Recertification|Added Qualification|Maintenance of Certification');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certifying_board` SET TAGS ('dbx_business_glossary_term' = 'Certifying Board');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certifying_board_code` SET TAGS ('dbx_business_glossary_term' = 'Certifying Board Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certifying_board_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Board Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certifying_board_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certifying_board_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certifying_organization_type` SET TAGS ('dbx_business_glossary_term' = 'Certifying Organization Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `certifying_organization_type` SET TAGS ('dbx_value_regex' = 'ABMS|AOA|ANCC|AANP|AAPA|Other');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `exam_attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Board Examination Attempt Number');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `exam_pass_date` SET TAGS ('dbx_business_glossary_term' = 'Board Examination Pass Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `initial_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `is_active_privileges_required` SET TAGS ('dbx_business_glossary_term' = 'Active Privileges Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `is_lifetime_certification` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Certification Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `is_primary_specialty` SET TAGS ('dbx_business_glossary_term' = 'Primary Specialty Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `moc_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance of Certification (MOC) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `moc_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance of Certification (MOC) Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `moc_program_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance of Certification (MOC) Program Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `moc_program_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `moc_program_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `moc_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance of Certification (MOC) Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `moc_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Exempt|Not Applicable|In Progress');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `payer_enrollment_required` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `recertification_cycle_years` SET TAGS ('dbx_business_glossary_term' = 'Recertification Cycle Duration (Years)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `recertification_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Certification Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `subspecialty_code` SET TAGS ('dbx_business_glossary_term' = 'Board Certified Subspecialty Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `subspecialty_name` SET TAGS ('dbx_business_glossary_term' = 'Board Certified Subspecialty Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `subspecialty_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `subspecialty_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending Verification|Unable to Verify|Expired Verification');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Concept ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_business_glossary_term' = 'American Board of Medical Specialties (ABMS) Board Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `acgme_program_code` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Council for Graduate Medical Education (ACGME) Program Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `board_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Provider Classification');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `cms_specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `cms_specialty_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `cms_specialty_description` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Specialty Description');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'NUCC Provider Taxonomy Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}[A-Z0-9]{3}X$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `dea_registration_applicable` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Applicable');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `dea_registration_applicable` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `dea_registration_applicable` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `dea_registration_applicable` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `definition` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Definition');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Display Name');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `display_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Code Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Code End Date');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `fhir_practitioner_role_code` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Practitioner Role Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `hospital_privileges_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hospital Privileges Applicable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `individual_or_organization` SET TAGS ('dbx_business_glossary_term' = 'Individual or Organization Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `individual_or_organization` SET TAGS ('dbx_value_regex' = 'Individual|Organization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `medicaid_enrollment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Enrollment Eligible');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `medicaid_enrollment_eligible` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `mips_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Eligible');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Notes');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `npi_type` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI) Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `npi_type` SET TAGS ('dbx_value_regex' = 'Type 1|Type 2');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `npi_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `npi_type` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `nucc_grouping` SET TAGS ('dbx_business_glossary_term' = 'NUCC Taxonomy Grouping');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `pecos_enrollment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Provider Enrollment and Chain Ownership System (PECOS) Enrollment Eligible');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `prescribing_authority` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Authority Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `primary_care_designation` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Designation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `replacement_taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Replacement Taxonomy Code');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `replacement_taxonomy_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}[A-Z0-9]{3}X$');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `rvu_work_component` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Component');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialization');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `surgical_specialty` SET TAGS ('dbx_business_glossary_term' = 'Surgical Specialty Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `taxonomy_status` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Code Status');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `taxonomy_status` SET TAGS ('dbx_value_regex' = 'Active|Retired|Deprecated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Eligible Indicator');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'NUCC Taxonomy Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]$');
