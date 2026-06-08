-- Schema for Domain: hcp | Business: Pharmaceuticals | Version: v1_mvm
-- Generated on: 2026-05-05 21:10:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`hcp` COMMENT 'Healthcare professional and healthcare organization master data including physicians, pharmacists, hospitals, clinics, and key opinion leaders (KOL). Manages HCP credentials, specialties, prescribing patterns, affiliations, and engagement history. Ensures compliance with Sunshine Act transparency reporting and anti-kickback regulations. Authoritative source for HCP identity and relationship data used across commercial, medical affairs, and clinical operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`master` (
    `master_id` BIGINT COMMENT 'Primary key for master',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: HCPs receiving honoraria or consulting fees are registered as business partners/vendors in SAP for accounts payable processing. Linking hcp.master to masterdata.business_partner enables reconciliation',
    `board_certification_date` DATE COMMENT 'Date when the HCP achieved board certification in their primary specialty.',
    `board_certification_expiration_date` DATE COMMENT 'Expiration date of the current board certification. Requires renewal to maintain certified status.',
    `board_certification_status` STRING COMMENT 'Current status of board certification for the HCP in their primary specialty.. Valid values are `Certified|Not Certified|Certification Expired|In Progress`',
    `data_source` STRING COMMENT 'System or data provider that is the authoritative source for this HCP record (e.g., Veeva CRM, IQVIA OneKey, NPI Registry).. Valid values are `Veeva CRM|Salesforce Health Cloud|IQVIA OneKey|NPI Registry|Manual Entry|Third Party Provider`',
    `date_of_birth` DATE COMMENT 'Date of birth of the healthcare professional. Used for identity verification and credential validation.',
    `dea_expiration_date` DATE COMMENT 'Expiration date of the DEA controlled substance registration. Requires renewal every three years.',
    `dea_number` STRING COMMENT 'DEA registration number authorizing the HCP to prescribe controlled substances. Format: 2 letters followed by 7 digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `dea_status` STRING COMMENT 'Current status of the DEA controlled substance registration.. Valid values are `Active|Inactive|Suspended|Revoked|Expired`',
    `external_source_code` STRING COMMENT 'Unique identifier for this HCP in the external source system (e.g., IQVIA OneKey ID, Veeva CRM Account ID). Used for data lineage and reconciliation.',
    `first_name` STRING COMMENT 'Legal first name (given name) of the healthcare professional as registered with licensing authorities.',
    `gender` STRING COMMENT 'Gender identity of the healthcare professional as self-reported or registered.. Valid values are `Male|Female|Non-Binary|Unknown|Prefer Not to Disclose`',
    `hcp_status` STRING COMMENT 'Current lifecycle status of the HCP record in the master data system. Active indicates the HCP is currently practicing and eligible for engagement.. Valid values are `Active|Inactive|Retired|Deceased|Suspended|Under Review`',
    `kol_status` STRING COMMENT 'Classification indicating whether the HCP is recognized as a Key Opinion Leader in their therapeutic area. KOLs are influential practitioners engaged for medical education, advisory boards, and clinical research.. Valid values are `KOL|Non-KOL|Emerging KOL|Under Review`',
    `kol_tier` STRING COMMENT 'Tiered classification of KOL influence level. Tier 1 represents national/international thought leaders, Tier 2 regional influencers, Tier 3 local experts.. Valid values are `Tier 1|Tier 2|Tier 3|Not Applicable`',
    `last_name` STRING COMMENT 'Legal last name (family name/surname) of the healthcare professional as registered with licensing authorities.',
    `middle_name` STRING COMMENT 'Middle name or initial of the healthcare professional.',
    `npi_number` STRING COMMENT 'Unique 10-digit National Provider Identifier assigned by CMS to healthcare providers in the United States. Authoritative identifier for HCP identity verification and claims processing.. Valid values are `^[0-9]{10}$`',
    `prescribing_authority` BOOLEAN COMMENT 'Boolean flag indicating whether the HCP has legal authority to prescribe medications. True for physicians, nurse practitioners, and physician assistants with prescribing privileges.',
    `primary_email_address` STRING COMMENT 'Primary email address for professional communication with the HCP.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_license_expiration_date` DATE COMMENT 'Expiration date of the primary medical license. Requires renewal to maintain active practice authority.',
    `primary_license_issue_date` DATE COMMENT 'Date when the primary medical license was originally issued by the state medical board.',
    `primary_license_number` STRING COMMENT 'Primary state medical license number issued by the state medical board. Authoritative credential for legal practice authority.',
    `primary_license_state` STRING COMMENT 'Two-letter US state code for the jurisdiction that issued the primary medical license (e.g., CA, NY, TX).. Valid values are `^[A-Z]{2}$`',
    `primary_license_status` STRING COMMENT 'Current status of the primary medical license as reported by the state medical board.. Valid values are `Active|Inactive|Suspended|Revoked|Expired|Pending Renewal`',
    `primary_phone_number` STRING COMMENT 'Primary contact phone number for the HCP at their practice location.',
    `primary_practice_address_line1` STRING COMMENT 'First line of the primary practice address where the HCP sees patients (street address, building number).',
    `primary_practice_address_line2` STRING COMMENT 'Second line of the primary practice address (suite, floor, department).',
    `primary_practice_city` STRING COMMENT 'City of the primary practice location.',
    `primary_practice_country` STRING COMMENT 'Three-letter ISO country code for the primary practice location (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `primary_practice_postal_code` STRING COMMENT 'ZIP code or postal code of the primary practice location. Format: 5 digits or 5+4 digits.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_practice_state` STRING COMMENT 'Two-letter US state code for the primary practice location (e.g., CA, NY, TX).. Valid values are `^[A-Z]{2}$`',
    `primary_specialty` STRING COMMENT 'Primary medical specialty or therapeutic area of practice for the HCP (e.g., Oncology, Cardiology, Immunology). Aligned with AMA specialty taxonomy.',
    `professional_designation` STRING COMMENT 'Professional designation or degree type of the healthcare professional (e.g., MD for Medical Doctor, DO for Doctor of Osteopathic Medicine, PharmD for Doctor of Pharmacy). [ENUM-REF-CANDIDATE: MD|DO|PharmD|RN|NP|PA|DDS|DVM|PhD|Other — 10 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HCP master record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HCP master record was last modified or updated.',
    `suffix` STRING COMMENT 'Professional or generational suffix appended to the HCP name (e.g., Jr., Sr., MD, PhD). [ENUM-REF-CANDIDATE: Jr|Sr|II|III|IV|V|MD|DO|PhD|PharmD|RN|NP|PA — 13 candidates stripped; promote to reference product]',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether payments and transfers of value to this HCP must be reported under the Physician Payments Sunshine Act (Open Payments program).',
    CONSTRAINT pk_master PRIMARY KEY(`master_id`)
) COMMENT 'Master record for individual healthcare professionals (HCPs) including physicians, pharmacists, nurses, and other licensed practitioners. Captures HCP identity (name, date of birth, gender), NPI number, professional credentials, all state medical licenses (license number, issuing authority, jurisdiction, issue/expiration dates, status, renewal history), DEA controlled substance registrations, board certifications, specialty classifications (primary/secondary, ATC/therapeutic area alignment), professional designations, practice addresses, and contact information. Authoritative single source of truth (SSOT) for HCP identity, credentials, licensing, and practice locations used across commercial, medical affairs, and clinical operations. Sourced from Veeva CRM, Salesforce Health Cloud, and third-party data providers (IQVIA OneKey, NPI Registry).';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` (
    `hco_master_id` BIGINT COMMENT 'Primary key for hco_master',
    `address_id` BIGINT COMMENT 'Foreign key linking to masterdata.address. Business justification: HCO master records store facility addresses inline; linking to the MDM canonical address product enforces address standardization and deduplication required for pharmacovigilance site identification, ',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: HCOs are registered as business partners in SAP/MDM for vendor payment processing (site fees, facility payments). Linking hco_master to business_partner enables reconciliation between the HCP domain H',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Account planning, formulary access strategy, and field force territory alignment require mapping HCOs to therapeutic areas. specialty_focus is a denormalized plain-text field; a proper FK to therapeut',
    `accreditation_expiration_date` DATE COMMENT 'Date when the current accreditation certification expires. Triggers re-evaluation and compliance monitoring workflows.',
    `accreditation_status` STRING COMMENT 'Current accreditation status from recognized healthcare accreditation bodies. Indicates quality standards compliance and eligibility for certain programs.. Valid values are `accredited|provisional|not_accredited|pending|expired`',
    `accrediting_body` STRING COMMENT 'Name of the primary accreditation organization that has certified this healthcare organization (e.g., Joint Commission, NCQA, DNV, AAAHC).',
    `bed_count` STRING COMMENT 'Total number of licensed inpatient beds at the healthcare facility. Used for market sizing, territory planning, and commercial targeting segmentation.',
    `cms_certification_number` STRING COMMENT 'CMS Certification Number (CCN) assigned to Medicare-certified healthcare facilities. Six-character alphanumeric identifier used for Medicare reimbursement.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the healthcare organization location. Determines applicable regulatory framework and market access requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HCO master record was first created in the system. Audit field for record lifecycle tracking.',
    `data_source_system` STRING COMMENT 'Name of the source system or data provider from which this HCO record originated (e.g., Veeva CRM, IQVIA OneKey, internal MDM). Used for data lineage and quality assessment.',
    `dba_name` STRING COMMENT 'Trade name or doing business as name used by the healthcare organization for commercial purposes.',
    `dea_registration_number` STRING COMMENT 'DEA registration number for organizations authorized to handle controlled substances. Required for Schedule II-V drug distribution and sample accountability.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `effective_date` DATE COMMENT 'Date when this HCO master record became active and valid for use in operational systems. Start of the records business validity period.',
    `email_address` STRING COMMENT 'Primary email address for administrative contact at the healthcare organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `end_date` DATE COMMENT 'Date when this HCO master record was retired or superseded. Null for currently active records. Used for historical analysis and audit trails.',
    `fax_number` STRING COMMENT 'Primary fax number for the healthcare organization. Still used for HIPAA-compliant document transmission in healthcare.',
    `formulary_status` STRING COMMENT 'Type of drug formulary management approach used by the organization. Determines market access strategy and pull-through tactics.. Valid values are `open|closed|restricted|preferred`',
    `gpo_affiliation` STRING COMMENT 'Name of the primary Group Purchasing Organization (GPO) through which this organization procures pharmaceuticals. Determines contract pricing and access strategy.',
    `hco_name` STRING COMMENT 'Official legal name of the healthcare organization as registered with regulatory authorities.',
    `hco_type` STRING COMMENT 'Classification of the healthcare organization by institutional type. Determines engagement strategy and regulatory requirements.. Valid values are `hospital|clinic|pharmacy|integrated_delivery_network|group_purchasing_organization|academic_medical_center`',
    `idn_affiliation` STRING COMMENT 'Name of the parent Integrated Delivery Network (IDN) or health system to which this organization belongs. Critical for account-based selling and contracting strategy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this HCO master record was last updated. Used for change tracking and data synchronization across systems.',
    `last_verified_date` DATE COMMENT 'Date when the HCO master data was last verified or validated for accuracy. Drives data quality monitoring and stewardship workflows.',
    `magnet_status_flag` BOOLEAN COMMENT 'Indicates whether the hospital has achieved Magnet Recognition from the American Nurses Credentialing Center (ANCC). Signifies nursing excellence and quality of care.',
    `n340b_eligible_flag` BOOLEAN COMMENT 'Indicates whether the organization is eligible for the federal 340B Drug Pricing Program. Impacts pricing, contracting, and distribution strategy.',
    `npi` STRING COMMENT 'Unique 10-digit National Provider Identifier assigned by CMS for healthcare organizations. Type 2 NPI for organizational providers. Required for Medicare/Medicaid billing and HIPAA compliance.. Valid values are `^[0-9]{10}$`',
    `organization_status` STRING COMMENT 'Current operational status of the healthcare organization in the master data system. Drives eligibility for commercial engagement and sample distribution.. Valid values are `active|inactive|suspended|merged|acquired|closed`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the healthcare organization. Impacts contracting approach, pricing strategy, and regulatory obligations.. Valid values are `for_profit|non_profit|government|academic`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the healthcare organization main switchboard or administrative office.',
    `tax_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID for the healthcare organization. Used for financial transactions, 1099 reporting, and Sunshine Act compliance.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `teaching_hospital_flag` BOOLEAN COMMENT 'Indicates whether the organization is a teaching hospital affiliated with a medical school. Teaching hospitals are priority targets for medical affairs and Key Opinion Leader (KOL) engagement.',
    `trauma_level` STRING COMMENT 'Trauma center designation level indicating capability to provide comprehensive emergency care. Level 1 centers have the highest capability.. Valid values are `level_1|level_2|level_3|level_4|not_designated`',
    `website_url` STRING COMMENT 'Official website URL for the healthcare organization. Used for digital engagement and research.',
    CONSTRAINT pk_hco_master PRIMARY KEY(`hco_master_id`)
) COMMENT 'Master record for healthcare organizations (HCOs) including hospitals, clinics, pharmacies, integrated delivery networks (IDNs), group purchasing organizations (GPOs), and academic medical centers. Captures organization name, type, accreditation status, NPI, DEA registration, bed count, magnet status, teaching hospital designation, and geographic footprint. SSOT for institutional identity used in commercial targeting and medical affairs.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`license` (
    `license_id` BIGINT COMMENT 'Unique identifier for the HCP license record. Primary key for the HCP license entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Medical licenses are issued by country-level regulatory authorities. Linking license to masterdata.country enables license validity reporting by regulatory jurisdiction, required for HCP credentialing',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional who holds this license. Links to the master HCP record.',
    `board_name` STRING COMMENT 'The name of the medical board that issued the board certification. Examples: American Board of Internal Medicine, American Board of Surgery. Applicable only for board certification license types.',
    `certification_level` STRING COMMENT 'The level of board certification status. Board certified indicates full certification; board eligible indicates eligibility but not yet certified; recertified indicates successful recertification.. Valid values are `board_certified|board_eligible|recertified|not_certified`',
    `comments` STRING COMMENT 'Free-text field for additional notes, comments, or context about the license. Used by compliance and data stewardship teams for annotations.',
    `controlled_substance_authority` BOOLEAN COMMENT 'Indicates whether this license grants the HCP authority to prescribe controlled substances. True if authorized; False otherwise. Requires valid DEA registration.',
    `data_source` STRING COMMENT 'The name of the source system or data provider from which this license record was obtained. Examples: Veeva CRM, State Medical Board API, third-party credentialing vendor.',
    `data_source_record_reference` STRING COMMENT 'The unique identifier of this license record in the source system. Used for data lineage and reconciliation.',
    `dea_schedule` STRING COMMENT 'The controlled substance schedules the HCP is authorized to prescribe under their DEA registration. Applicable only for DEA registration license types. Critical for compliance with controlled substance regulations.. Valid values are `schedule_ii|schedule_iii|schedule_iv|schedule_v|all_schedules`',
    `disciplinary_action_description` STRING COMMENT 'Detailed description of any disciplinary actions, sanctions, or restrictions associated with the license. Includes nature of action, date, and resolution status. Used for compliance risk assessment.',
    `disciplinary_action_flag` BOOLEAN COMMENT 'Indicates whether the license has any associated disciplinary actions, sanctions, or restrictions. True if disciplinary action exists; False otherwise. Triggers compliance review before HCP engagement.',
    `effective_date` DATE COMMENT 'The date from which the license becomes valid and the HCP is authorized to practice or prescribe. May differ from issue_date if there is a delay in activation. Format: yyyy-MM-dd.',
    `expiration_date` DATE COMMENT 'The date the license expires and is no longer valid unless renewed. Critical for compliance validation before HCP engagement. Format: yyyy-MM-dd.',
    `issue_date` DATE COMMENT 'The date the license was originally issued by the licensing authority. Format: yyyy-MM-dd.',
    `issuing_authority` STRING COMMENT 'The name of the regulatory body, state medical board, or certification organization that issued the license. Examples include State Medical Board of California, DEA, American Board of Internal Medicine.',
    `issuing_state` STRING COMMENT 'The U.S. state or jurisdiction where the license was issued. Uses two-letter state abbreviation (e.g., CA, NY, TX). For federal licenses like DEA, this may indicate the primary registration state.',
    `license_number` STRING COMMENT 'The unique license or credential number issued by the licensing authority. This is the official identifier on the license certificate.',
    `license_status` STRING COMMENT 'Current status of the license in its lifecycle. Active licenses are valid for HCP engagement; expired, suspended, or revoked licenses require compliance review before any promotional or medical interaction.. Valid values are `active|expired|suspended|revoked|pending|inactive`',
    `license_type` STRING COMMENT 'The category of professional license or credential. Distinguishes between medical licenses, DEA (Drug Enforcement Administration) registrations, board certifications, and specialty credentials. [ENUM-REF-CANDIDATE: medical_license|dea_registration|board_certification|specialty_credential|state_pharmacy_license|nursing_license|controlled_substance_license — 7 candidates stripped; promote to reference product]',
    `npi_number` STRING COMMENT 'The 10-digit National Provider Identifier assigned to the HCP by CMS (Centers for Medicare & Medicaid Services). Used for cross-referencing and validation against NPPES database.',
    `prescribing_authority` BOOLEAN COMMENT 'Indicates whether this license grants the HCP authority to prescribe medications. True if the license allows prescribing; False otherwise. Used to validate HCP eligibility for promotional activities and sample distribution.',
    `primary_license_flag` BOOLEAN COMMENT 'Indicates whether this is the HCPs primary or principal license. True if primary; False if secondary or supplementary. Used to identify the main license for compliance validation.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this license record is currently active in the system. True if active; False if logically deleted or archived. Used for soft delete pattern.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this license record was first created in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this license record was last updated in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `renewal_date` DATE COMMENT 'The most recent date the license was renewed. Tracks renewal history for compliance and audit purposes. Format: yyyy-MM-dd.',
    `restriction_description` STRING COMMENT 'Detailed description of any restrictions or limitations on the license. Specifies the nature and scope of restrictions for compliance purposes.',
    `restriction_flag` BOOLEAN COMMENT 'Indicates whether the license has any practice restrictions or limitations. True if restrictions exist; False otherwise. Examples: limited to certain procedures, supervision required, geographic restrictions.',
    `specialty` STRING COMMENT 'The medical specialty or subspecialty associated with this license or board certification. Examples: Oncology, Cardiology, Internal Medicine, Pediatrics. Used for targeting and segmentation in commercial and medical affairs.',
    `specialty_code` STRING COMMENT 'Standardized code representing the medical specialty. May use AMA specialty taxonomy codes or internal classification codes for analytics and reporting.',
    `verification_date` DATE COMMENT 'The date the license was last verified against the issuing authoritys records. Used for compliance audit trails and to ensure data accuracy. Format: yyyy-MM-dd.',
    `verification_method` STRING COMMENT 'The method used to verify the license. Manual indicates human review; automated indicates system-based verification; third_party_service indicates use of external verification vendors; self_reported indicates HCP-provided data pending verification.. Valid values are `manual|automated|third_party_service|self_reported`',
    `verification_source` STRING COMMENT 'The name of the source used to verify the license. Examples: State Medical Board website, NPPES (National Plan and Provider Enumeration System), third-party credentialing service.',
    CONSTRAINT pk_license PRIMARY KEY(`license_id`)
) COMMENT 'Professional licenses and credentials held by each HCP, including state medical licenses, DEA controlled substance registrations, board certifications, and specialty credentials. Tracks license number, issuing authority, state/jurisdiction, issue date, expiration date, license status (active, suspended, revoked), and renewal history. Critical for compliance validation before any promotional or medical engagement.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` (
    `affiliation_id` BIGINT COMMENT 'Unique identifier for the HCP affiliation relationship record. Primary key for the affiliation entity.',
    `affiliation_affiliated_hcp_physician_master_id` BIGINT COMMENT 'Foreign key reference to another HCP in HCP-to-HCP affiliation relationships (e.g., referral networks, group practice partnerships). Nullable when affiliation is HCP-to-HCO.',
    `contract_id` BIGINT COMMENT 'The contract or agreement reference number governing this affiliation relationship, if applicable. Used for compliance tracking and Sunshine Act reporting.',
    `hco_master_id` BIGINT COMMENT 'Foreign key reference to the healthcare organization to which the HCP is affiliated. Links to the HCO master record. Nullable when affiliation is HCP-to-HCP.',
    `investigational_site_id` BIGINT COMMENT 'Foreign key linking to clinical.investigational_site. Business justification: Clinical sites are healthcare organizations where affiliated HCPs practice. Site feasibility assessments, investigator recruitment, enrollment forecasting, and site selection decisions require underst',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who holds this affiliation. Links to the HCP master record.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Tracks which internal organizational unit (e.g., oncology sales team, regional medical affairs) manages the HCP affiliation relationship. Required for territory management, account assignment, and per',
    `admitting_privileges_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the HCP has hospital admitting privileges at this affiliated HCO. True if the HCP can admit patients; False otherwise.',
    `affiliation_status` STRING COMMENT 'Current lifecycle status of the affiliation relationship. Indicates whether the affiliation is currently valid and operational.. Valid values are `active|inactive|suspended|pending_verification|terminated`',
    `affiliation_type` STRING COMMENT 'Classification of the affiliation relationship between the HCP and HCO or between two HCPs. Defines the nature of the professional relationship.. Valid values are `employee|contractor|admitting_privileges|consulting|group_practice_member|referral_partner`',
    `compensation_arrangement_type` STRING COMMENT 'The type of compensation arrangement associated with this affiliation, if any. Required for Sunshine Act transparency reporting and anti-kickback compliance.. Valid values are `salary|hourly|fee_for_service|retainer|equity|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this affiliation record was first created in the system. Used for audit trail and data lineage tracking.',
    `credentialing_expiration_date` DATE COMMENT 'The date when the HCPs credentialing at this affiliated organization expires and requires renewal. Used for compliance monitoring and re-credentialing workflows.',
    `credentialing_status` STRING COMMENT 'The current credentialing status of the HCP at this affiliated organization. Indicates whether the HCP has completed required credentialing processes.. Valid values are `credentialed|pending|expired|revoked|not_required`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quantitative measure of the completeness and accuracy of this affiliation record, typically ranging from 0.00 to 100.00. Used for data stewardship prioritization.',
    `data_source_system` STRING COMMENT 'The operational system or data source from which this affiliation record originated (e.g., Veeva CRM, Salesforce Health Cloud, manual entry, third-party data provider).',
    `dea_number` STRING COMMENT 'The DEA registration number associated with this affiliation, if the HCP prescribes controlled substances at this location. Required for controlled substance prescribing authority verification.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `department_name` STRING COMMENT 'The department, division, or practice unit within the HCO where the HCP holds this affiliation (e.g., Oncology Department, Cardiology Division).',
    `end_date` DATE COMMENT 'The date when the affiliation relationship ended or is scheduled to end. Null for ongoing affiliations.',
    `formulary_influence_level` STRING COMMENT 'Assessment of the HCPs level of influence over formulary decisions at this affiliated organization. Used for Key Opinion Leader (KOL) identification and targeting.. Valid values are `high|medium|low|none`',
    `full_time_equivalent` DECIMAL(18,2) COMMENT 'The proportion of full-time work the HCP dedicates to this affiliation, expressed as a decimal (e.g., 1.00 for full-time, 0.50 for half-time). Used for capacity planning and engagement prioritization.',
    `is_primary_affiliation` BOOLEAN COMMENT 'Boolean flag indicating whether this is the HCPs primary or main affiliation. True if this is the principal place of practice; False otherwise.',
    `kol_designation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the HCP is designated as a Key Opinion Leader (KOL) within this affiliation context. True if KOL status applies; False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this affiliation record was last updated or modified. Used for audit trail and change tracking.',
    `last_verification_date` DATE COMMENT 'The date when this affiliation record was last verified or validated. Used for data quality monitoring and re-verification scheduling.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user or system process that last modified this affiliation record. Used for audit trail and accountability.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about this affiliation relationship. Used for qualitative information that does not fit structured fields.',
    `npi_at_affiliation` STRING COMMENT 'The National Provider Identifier (NPI) the HCP uses at this specific affiliation. An HCP may have different NPIs for different practice locations or affiliations.. Valid values are `^[0-9]{10}$`',
    `prescribing_authority_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the HCP has prescribing authority at this affiliated organization. True if the HCP can prescribe medications; False otherwise.',
    `referral_direction` STRING COMMENT 'The direction of patient referrals in this affiliation relationship. Indicates whether the HCP receives referrals, sends referrals, or both.. Valid values are `inbound|outbound|bidirectional|none`',
    `referral_relationship_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this affiliation represents a referral relationship (HCP-to-HCP). True if the affiliation involves patient referrals; False otherwise.',
    `role_title` STRING COMMENT 'The professional role or job title the HCP holds within this affiliation (e.g., Chief of Cardiology, Attending Physician, Clinical Director, Partner).',
    `specialty_at_affiliation` STRING COMMENT 'The medical specialty or therapeutic area the HCP practices within this specific affiliation. May differ from the HCPs primary specialty if they hold multiple affiliations.',
    `start_date` DATE COMMENT 'The date when the affiliation relationship became effective. Represents the beginning of the professional relationship.',
    `state_license_number` STRING COMMENT 'The state medical license number the HCP holds for practice at this affiliated organization. Required for credentialing and compliance verification.',
    `strength_score` DECIMAL(18,2) COMMENT 'Quantitative measure of the strength or influence of this affiliation relationship, typically ranging from 0.00 to 100.00. Used for network mapping and prescribing influence analysis.',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this affiliation relationship is subject to Sunshine Act transparency reporting requirements. True if reportable; False otherwise.',
    `verification_status` STRING COMMENT 'The verification status of this affiliation record. Indicates whether the affiliation has been confirmed through primary source verification or other validation processes.. Valid values are `verified|unverified|pending_verification|verification_failed`',
    `verified_by` STRING COMMENT 'The name or identifier of the person, system, or process that last verified this affiliation record. Used for audit trail and accountability.',
    CONSTRAINT pk_affiliation PRIMARY KEY(`affiliation_id`)
) COMMENT 'Relationship records linking HCPs to healthcare organizations (HCOs) and to other HCPs, capturing employment, admitting privileges, group practice membership, and referral relationships. Tracks affiliation type (employee, contractor, admitting, consulting), role, start and end dates, primary affiliation flag, and affiliation strength. Essential for account-based selling, network mapping, and understanding prescribing influence hierarchies.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` (
    `kol_profile_id` BIGINT COMMENT 'Unique identifier for the KOL profile record. Primary key for the HCP KOL profile entity.',
    `investigator_id` BIGINT COMMENT 'Foreign key linking to hcp.investigator. Business justification: KOL profiles explicitly track clinical_trial_investigator_flag and principal_investigator_trial_count, indicating that many KOLs are also clinical trial investigators. Linking hcp_kol_profile directly',
    `master_id` BIGINT COMMENT 'Reference to the base HCP master record. Links the KOL profile to the foundational HCP entity containing credentials, specialties, and contact information.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: KOL identification, advisory board selection, and publication tracking are product-specific in pharma. Medical affairs teams map KOL expertise to specific approved products for launch planning, label ',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: KOL profiles track therapeutic area expertise by specific molecular targets to guide MSL engagement strategy, advisory board selection, and investigator identification. Critical for matching scientifi',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: KOL mapping requires identifying which patent families a KOL has contributed to or published on. IP and medical affairs teams use this for advisory board selection and competitive intelligence. Existi',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: KOL profiles are segmented by therapeutic area for medical affairs targeting, MSL assignment, and engagement strategy planning. Replaces denormalized primary_therapeutic_area text with structured FK f',
    `academic_rank` STRING COMMENT 'The KOLs academic title or rank at their primary affiliated institution. Indicates seniority, teaching responsibilities, and academic influence. [ENUM-REF-CANDIDATE: professor|associate_professor|assistant_professor|clinical_instructor|adjunct_faculty|emeritus|none — 7 candidates stripped; promote to reference product]',
    `advisory_board_participation_count` STRING COMMENT 'Total number of advisory board meetings or panels the KOL has participated in. Indicates level of industry engagement and strategic advisory experience.',
    `clinical_trial_investigator_flag` BOOLEAN COMMENT 'Indicates whether the KOL has served as a principal investigator (PI) or sub-investigator on clinical trials. True if the HCP has investigator experience, false otherwise. Used to identify KOLs with hands-on clinical research expertise.',
    `compliance_clearance_date` DATE COMMENT 'Date when the most recent compliance clearance was completed and approved. Used to track clearance currency and schedule re-verification.',
    `compliance_clearance_expiry_date` DATE COMMENT 'Date when the current compliance clearance expires and re-verification is required. Used to proactively manage compliance renewal workflows.',
    `compliance_clearance_status` STRING COMMENT 'Current compliance and credentialing clearance status for the KOL. Cleared indicates the KOL has passed all compliance checks and is eligible for engagement, pending indicates review in progress, flagged indicates potential compliance concerns requiring investigation, excluded indicates the KOL is on an exclusion list (OIG, SAM) and cannot be engaged, and expired indicates clearance has lapsed and requires renewal.. Valid values are `cleared|pending|flagged|excluded|expired`',
    `conflict_of_interest_disclosure` STRING COMMENT 'Summary of disclosed conflicts of interest, including financial relationships with other pharmaceutical or medical device companies, equity holdings, consulting arrangements, or advisory roles. Used to manage transparency and mitigate bias in scientific engagements.',
    `congress_speaking_count` STRING COMMENT 'Number of presentations, lectures, or speaking engagements the KOL has delivered at medical congresses, symposia, or scientific conferences. Reflects public visibility and thought leadership.',
    `data_source` STRING COMMENT 'System or external data provider from which the KOL profile information was sourced or enriched. Examples include Veeva CRM, internal medical affairs databases, third-party KOL intelligence platforms, or manual entry. Used for data lineage and quality assessment.',
    `department_chair_flag` BOOLEAN COMMENT 'Indicates whether the KOL serves as a department chair or division head at their primary institution. True if the KOL holds a leadership position, false otherwise. Reflects institutional leadership and decision-making authority.',
    `fellowship_institution` STRING COMMENT 'Name of the institution where the KOL completed their fellowship training. Indicates specialized training and institutional network.',
    `guideline_authorship_flag` BOOLEAN COMMENT 'Indicates whether the KOL has authored or co-authored clinical practice guidelines, consensus statements, or treatment recommendations. True if guideline authorship exists, false otherwise. Reflects standard-of-care influence.',
    `h_index` STRING COMMENT 'Hirsch index measuring the productivity and citation impact of the KOLs published work. An h-index of n means the researcher has n publications with at least n citations each. Used to quantify scientific influence and publication quality.',
    `kol_status` STRING COMMENT 'Current lifecycle status of the KOL profile. Active KOLs are eligible for engagement, under review indicates pending compliance or credentialing checks, suspended indicates temporary ineligibility, retired indicates the HCP is no longer practicing, and deceased indicates the HCP has passed away.. Valid values are `active|under_review|suspended|retired|deceased`',
    `kol_tier` STRING COMMENT 'Strategic classification of the KOLs influence level and reach. National KOLs have broad industry impact, regional KOLs influence specific geographies or health systems, local KOLs impact individual institutions, emerging KOLs show rising influence, and inactive KOLs are no longer actively engaged.. Valid values are `national|regional|local|emerging|inactive`',
    `last_congress_speaking_date` DATE COMMENT 'Date of the most recent congress or conference speaking engagement by the KOL. Used to assess recency of public thought leadership activity.',
    `last_msl_interaction_date` DATE COMMENT 'Date of the most recent interaction or engagement between an MSL and the KOL. Used to track engagement recency and plan follow-up activities.',
    `last_publication_date` DATE COMMENT 'Date of the KOLs most recent peer-reviewed publication. Indicates currency of scientific contribution and active research status.',
    `medical_school` STRING COMMENT 'Name of the medical school or institution where the KOL obtained their medical degree. Provides context on educational background and institutional affiliations.',
    `msl_engagement_strategy` STRING COMMENT 'Strategic priority level for Medical Science Liaison engagement with this KOL. High priority KOLs receive frequent proactive outreach, medium priority receive periodic engagement, low priority are engaged opportunistically, monitor only are tracked but not actively engaged, and do not contact indicates compliance or relationship restrictions.. Valid values are `high_priority|medium_priority|low_priority|monitor_only|do_not_contact`',
    `orcid_number` STRING COMMENT 'Unique persistent digital identifier for the researcher, used to disambiguate authors and link research outputs. Format: 0000-0000-0000-0000.. Valid values are `^d{4}-d{4}-d{4}-d{3}[0-9X]$`',
    `peer_reviewed_publication_count` STRING COMMENT 'Total number of peer-reviewed journal articles, reviews, and original research publications authored or co-authored by the KOL. Reflects scientific productivity and contribution to medical literature.',
    `primary_affiliation` STRING COMMENT 'The main hospital, academic medical center, research institution, or healthcare organization where the KOL holds a primary appointment or practices. Critical for understanding institutional influence and access.',
    `principal_investigator_trial_count` STRING COMMENT 'Number of clinical trials where the KOL has served as the principal investigator. Reflects depth of clinical research leadership and trial management experience.',
    `profile_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KOL profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `profile_updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated the KOL profile record. Used for audit trail and accountability.',
    `profile_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the KOL profile record was most recently updated. Used for audit trail, change tracking, and data currency assessment.',
    `scopus_author_number` STRING COMMENT 'Unique identifier assigned by Elsevier Scopus to track the KOLs publications and citation metrics. Used for bibliometric analysis and publication tracking.',
    `society_leadership_flag` BOOLEAN COMMENT 'Indicates whether the KOL holds or has held a leadership position (board member, committee chair, president) in a professional medical society. True if leadership role exists, false otherwise. Reflects industry influence and governance participation.',
    `society_membership_list` STRING COMMENT 'List of professional medical societies, associations, or organizations where the KOL holds membership. Examples include American Society of Clinical Oncology (ASCO), American College of Cardiology (ACC), European Society for Medical Oncology (ESMO). Stored as delimited text.',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Indicates whether payments or transfers of value to this KOL must be reported under the Physician Payments Sunshine Act (Open Payments). True if reportable, false otherwise. Used to ensure transparency and compliance with US federal reporting requirements.',
    `total_citation_count` STRING COMMENT 'Cumulative number of citations received across all of the KOLs published works. Indicates the breadth of scientific impact and recognition within the research community.',
    `total_msl_interaction_count` STRING COMMENT 'Cumulative number of documented interactions between MSLs and the KOL. Reflects depth of relationship and engagement history.',
    CONSTRAINT pk_kol_profile PRIMARY KEY(`kol_profile_id`)
) COMMENT 'Key Opinion Leader (KOL) profile extending the base HCP record with scientific influence metrics, publication history, clinical trial investigator status, advisory board participation, congress speaking history, and KOL tier classification (national, regional, local). Tracks h-index, citation count, therapeutic area expertise, and KOL engagement strategy. Used by medical affairs for publication planning, advisory boards, and MSL targeting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` (
    `engagement_id` BIGINT COMMENT 'Unique identifier for the HCP (Healthcare Professional) or HCO (Healthcare Organization) engagement record. Primary key.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Field engagements execute market access strategies at physician level. Sales reps deliver access-focused messaging, discuss formulary positioning, and support PAP enrollment aligned with strategy. Ess',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: HCP engagement records in pharma are brand-specific — MSL and sales interactions are tracked per brand for field force effectiveness reporting, Sunshine Act categorization by product, and brand-level ',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: HCP engagement activities (MSL visits, medical education, transfer-of-value) are tracked against therapeutic area and field medical budgets. hcp_engagement has cost_center_id and internal_order_id but',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: MSL scientific exchange tracking requires recording which specific investigational compound was discussed during an HCP engagement. Medical Affairs CRM reporting and MSL activity dashboards depend on ',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to hcp.consent_record. Business justification: Every HCP engagement must be governed by a valid consent record (opt-in, DNC status, no-see flag). Adding consent_record_id to hcp_engagement directly links the interaction to the specific consent rec',
    `contract_id` BIGINT COMMENT 'Foreign key linking to hcp.contract. Business justification: Many HCP engagements (advisory board meetings, consulting sessions, medical education events) are conducted under formal contracts. Linking hcp_engagement to the governing contract enables FMV complia',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Engagements incur costs (travel, meals, samples) that must be allocated to cost centers for budgeting, variance analysis, and financial reporting. Standard pharma expense management practice.',
    `hco_master_id` BIGINT COMMENT 'Foreign key reference to the healthcare organization where the engagement occurred or that was engaged. Nullable if engagement is with an individual HCP not affiliated with a specific organization context.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Field engagements (congress attendance, speaker programs, promotional activities) are charged to brand or therapeutic area internal orders for cost allocation and ROI tracking. Essential for marketing',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who was engaged. Links to the HCP master data entity.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: MSL/sales engagement CRM reporting and promotional compliance require tracking which specific approved branded medicinal product was discussed. Therapeutic area alone is insufficient for product-level',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: HCP engagements are executed by field medical/commercial teams organized into org units. Linking engagement to org_unit enables engagement activity reporting by organizational unit for budget accounta',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Medical affairs engagements discuss pipeline compounds in discovery phase for scientific exchange, investigator identification, and early KOL engagement. Tracks pre-commercial scientific dialogue that',
    `sales_rep_id` BIGINT COMMENT 'Foreign key reference to the sales representative or Medical Science Liaison (MSL) who conducted the engagement. Links to the sales_rep or employee master data entity.',
    `speaker_program_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_speaker_program. Business justification: Speaker program events are a specific type of HCP engagement. When a field rep or MSL logs an engagement that is part of a speaker program event, linking hcp_engagement to hcp_speaker_program provides',
    `territory_id` BIGINT COMMENT 'Foreign key reference to the sales territory in which this engagement occurred. Links to the territory master data entity for geographic and organizational reporting.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Field engagements are planned, executed, and reported by therapeutic area for territory alignment, call planning, and sales force effectiveness analysis. Core to commercial operations and CRM analytic',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: MSL and medical affairs engagements are frequently conducted in the context of a specific clinical trial (investigator recruitment, scientific exchange, results dissemination). Linking engagement to t',
    `adverse_event_reported_flag` BOOLEAN COMMENT 'Boolean indicator of whether an adverse event was reported by the HCP during this engagement. True if an AE was mentioned, triggering pharmacovigilance follow-up. False otherwise.',
    `call_objective` STRING COMMENT 'The primary objective or goal of the engagement as defined by the sales representative or MSL before the interaction. Describes the intended outcome or message.',
    `channel` STRING COMMENT 'The communication channel or medium through which the engagement was conducted. Distinguishes in-person from remote interactions.. Valid values are `face_to_face|virtual|phone|email|congress|event`',
    `compliance_reviewed_flag` BOOLEAN COMMENT 'Boolean indicator of whether this engagement record has been reviewed and approved by compliance or legal teams. True if reviewed, False if pending review.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Boolean indicator of whether explicit consent was obtained from the HCP for data capture, follow-up communications, or participation in programs. True if consent was documented, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement record was first created in the system. Audit trail field for data lineage and compliance.',
    `duration_minutes` STRING COMMENT 'Total duration of the engagement activity measured in minutes. Calculated from start and end times or manually entered.',
    `end_time` TIMESTAMP COMMENT 'Precise timestamp when the engagement activity concluded. Used for duration calculation and resource planning.',
    `engagement_date` DATE COMMENT 'The date on which the engagement activity occurred or is scheduled to occur. Primary business event timestamp for the interaction.',
    `engagement_number` STRING COMMENT 'Business-facing unique identifier for the engagement record. Human-readable reference number used in Veeva CRM and reporting.. Valid values are `^ENG-[0-9]{8,12}$`',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the engagement record. Tracks whether the engagement was successfully completed or had an alternate outcome.. Valid values are `planned|completed|cancelled|no_show|rescheduled`',
    `engagement_type` STRING COMMENT 'Classification of the engagement activity. Defines the nature of the interaction between field personnel and HCP or HCO. [ENUM-REF-CANDIDATE: detail_visit|lunch_and_learn|congress_meeting|advisory_board|speaker_program|medical_information_request|clinical_trial_discussion|sample_drop|virtual_meeting|phone_call|email_correspondence — 11 candidates stripped; promote to reference product]',
    `follow_up_date` DATE COMMENT 'Scheduled date for the next planned follow-up action or engagement with this HCP. Nullable if no follow-up is planned.',
    `frequency` STRING COMMENT 'Planned or actual frequency of professional interactions between the employee and HCP for this relationship. Used for territory planning, resource allocation, and relationship maintenance strategies.',
    `hcp_feedback` STRING COMMENT 'Free-text capture of feedback, questions, or comments provided by the HCP during the engagement. Used for medical affairs insights and product feedback loops.',
    `key_message_delivered` STRING COMMENT 'The primary approved key message or talking point that was communicated during the engagement. Aligns with approved promotional messaging and Medical-Legal-Regulatory (MLR) reviewed content.',
    `last_interaction_date` DATE COMMENT 'Date of the most recent professional interaction (meeting, call, email exchange, conference encounter) between this employee and HCP. Used to identify stale relationships requiring re-engagement and for compliance reporting of HCP interaction frequency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement record was most recently updated. Audit trail field for change tracking and compliance.',
    `location` STRING COMMENT 'Free-text description of the physical or virtual location where the engagement occurred. May include office name, hospital department, conference venue, or virtual platform name.',
    `materials_shared` STRING COMMENT 'Description or list of promotional materials, medical information documents, or educational resources shared with the HCP during the engagement. May include brochure names, approved material IDs, or content titles.',
    `medical_inquiry_flag` BOOLEAN COMMENT 'Boolean indicator of whether the HCP made a medical information request or inquiry during the engagement. True if a medical inquiry was raised, False otherwise. Triggers medical affairs follow-up.',
    `next_action` STRING COMMENT 'Free-text description of the planned follow-up action or next step resulting from this engagement. May include scheduling another meeting, sending additional information, or other commitments.',
    `outcome` STRING COMMENT 'Qualitative assessment of the engagement result from the field personnel perspective. Captures the receptiveness and outcome of the interaction.. Valid values are `positive|neutral|negative|follow_up_required|no_interest`',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this employee is designated as the primary point of contact for this HCP within the organization. Used for routing inquiries, coordinating multi-functional engagement, and preventing duplicate outreach. An HCP may have different primary contacts for different therapeutic areas.',
    `relationship_end_date` DATE COMMENT 'Date when this employee-HCP engagement relationship was formally ended or reassigned. Null for active relationships. Used for tracking relationship handoffs during territory changes, employee transitions, or strategic deprioritization.',
    `relationship_start_date` DATE COMMENT 'Date when this employee-HCP engagement relationship was formally established or assigned. Used for relationship tenure analysis, onboarding tracking, and historical relationship mapping.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of this HCP-employee engagement relationship. Active relationships require ongoing management and interaction tracking. Inactive or Suspended relationships are retained for historical analysis and potential reactivation.',
    `relationship_strength_score` DECIMAL(18,2) COMMENT 'Quantitative metric (0-100 scale) assessing the strength and quality of this specific HCP-employee engagement relationship based on interaction frequency, responsiveness, collaboration depth, and strategic value. Used for prioritizing engagement efforts and measuring field team effectiveness.',
    `relationship_type` STRING COMMENT 'Classification of the professional engagement relationship type based on the employees role and function in medical affairs (e.g., MSL for field-based scientific exchange, Medical Director for strategic advisory relationships, Clinical Scientist for research collaboration).',
    `samples_provided_flag` BOOLEAN COMMENT 'Boolean indicator of whether product samples were provided to the HCP during this engagement. True if samples were dispensed, False otherwise.',
    `signature_captured_flag` BOOLEAN COMMENT 'Boolean indicator of whether an electronic or physical signature was captured during the engagement. Used for sample accountability, consent documentation, or attestation requirements. True if signature was obtained, False otherwise.',
    `source_system` STRING COMMENT 'The operational system of record from which this engagement record originated. Typically Veeva CRM for field force engagements.. Valid values are `veeva_crm|salesforce_health_cloud|manual_entry`',
    `source_system_code` STRING COMMENT 'The unique identifier of this engagement record in the source operational system. Used for data reconciliation and traceability back to the source.',
    `start_time` TIMESTAMP COMMENT 'Precise timestamp when the engagement activity began. Used for duration calculation and detailed scheduling analytics.',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Boolean indicator of whether this engagement constitutes a transfer of value that must be reported under the Physician Payments Sunshine Act (Open Payments). True if reportable, False otherwise.',
    `territory_assignment` STRING COMMENT 'Geographic or organizational territory code under which this HCP-employee engagement relationship is managed. Used for field force alignment, territory planning, and sales/medical affairs coordination. Territory assignments can change during organizational restructuring while maintaining relationship continuity.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area or disease focus for this specific HCP-employee engagement relationship (e.g., Oncology, Immunology, Rare Diseases). An employee may engage the same HCP across different therapeutic areas, each tracked separately.',
    `transfer_of_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of any transfer of value provided to the HCP during this engagement. Includes meals, honoraria, consulting fees, or other payments. Nullable if no transfer of value occurred. Used for Sunshine Act transparency reporting.',
    `transfer_of_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer of value amount. Nullable if no transfer of value occurred.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_engagement PRIMARY KEY(`engagement_id`)
) COMMENT 'Records of all interactions between field personnel (sales representatives, MSLs, medical affairs) and HCPs or HCOs. Captures engagement type (detail visit, lunch-and-learn, congress meeting, advisory board, medical information request), channel (face-to-face, virtual, phone), date, duration, products discussed, materials shared, and outcome. Primary transactional record for HCP engagement history. Sourced from Veeva CRM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` (
    `sample_request_id` BIGINT COMMENT 'Unique identifier for the drug sample request record. Primary key for sample accountability tracking under 21 CFR Part 203 (Prescription Drug Marketing Act).',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Sample requests are always for a specific commercial brand. Pharma brand teams track sample request volumes by brand for PDMA compliance, brand-level sample budget management, and promotional effectiv',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to hcp.consent_record. Business justification: Under the Prescription Drug Marketing Act (PDMA), drug sample distribution requires documented HCP consent and signature. Linking sample_request to the specific consent_record that authorized the samp',
    `drug_product_id` BIGINT COMMENT 'Foreign key reference to the drug product master data. Identifies the specific pharmaceutical product being sampled.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Sample value (sample_value_usd exists on sample_request) must be posted to GL for cost accounting, Sunshine Act financial reporting, and FDA sample accountability. Pharma finance requires GL account t',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who requested the drug samples. Links to HCP master data for prescriber validation and compliance tracking.',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Sample requests are for specific drug materials tracked in the material master (NDC, shelf life, controlled substance schedule, storage conditions). Linking to masterdata.material enables sample recon',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Samples are manufactured and fulfilled from specific plants. Required for supply chain planning, inventory management, lot traceability, and GDP compliance. Operational necessity for sample distributi',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Sample dispensing errors (expired product, wrong lot, temperature excursion) generate quality deviations under FDA 21 CFR Part 203 sample accountability regulations. Linking sample_request to quality_',
    `sales_rep_id` BIGINT COMMENT 'Foreign key reference to the pharmaceutical sales representative who fulfilled the sample request. Required for accountability and territory tracking.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Sample accountability under PDMA and DEA requires tracking samples at the SKU level (specific country pack, strength, serialization). drug_product_id captures the formulation but SKU captures the exac',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Samples stored at specific locations before distribution to HCPs. Required for inventory control, temperature monitoring, GDP compliance, and DEA-controlled substance tracking. Standard pharma warehou',
    `approval_date` DATE COMMENT 'Date when the sample request was approved for fulfillment. Nullable for pending or rejected requests.',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether the sampled drug product is a DEA-controlled substance requiring additional tracking and HCP DEA validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sample request record was first created in the system. Audit trail for data governance.',
    `dea_number` STRING COMMENT 'DEA registration number of the HCP. Required for controlled substance samples. Format: 2 letters followed by 7 digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `dea_schedule` STRING COMMENT 'DEA controlled substance schedule classification of the sampled drug product. Determines regulatory requirements for sample handling and HCP authorization.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Non-Controlled`',
    `delivery_address_line1` STRING COMMENT 'Primary street address where drug samples were delivered. Typically the HCP practice or clinic address.',
    `delivery_address_line2` STRING COMMENT 'Secondary address information such as suite number, floor, or building designation for sample delivery location.',
    `delivery_city` STRING COMMENT 'City where drug samples were delivered to the HCP.',
    `delivery_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the sample delivery address. Format: 3 uppercase letters (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which drug samples were delivered to the HCP. In-person delivery by sales rep is most common for accountability.. Valid values are `in_person|courier|mail|direct_ship`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for the sample delivery address.',
    `delivery_state_province` STRING COMMENT 'State or province code for the sample delivery address. Used for geographic compliance tracking and territory assignment.',
    `expiration_date` DATE COMMENT 'Expiration date of the drug samples dispensed. Critical for ensuring samples are not distributed beyond shelf life.',
    `fulfillment_date` DATE COMMENT 'Date when the drug samples were physically delivered to the HCP. Also known as sample drop date. Required for PDMA compliance reporting.',
    `hcp_signature_captured` BOOLEAN COMMENT 'Indicates whether the HCP signature was captured at time of sample delivery. Required for PDMA compliance and sample accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sample request record was most recently updated. Audit trail for change tracking and compliance.',
    `lot_number` STRING COMMENT 'Manufacturing lot number of the dispensed drug samples. Required for traceability, recall management, and expiration tracking.. Valid values are `^[A-Z0-9]{6,12}$`',
    `notes` STRING COMMENT 'Free-text notes or comments related to the sample request. May include special handling instructions, HCP preferences, or fulfillment issues.',
    `quantity_approved` STRING COMMENT 'Number of sample units approved for fulfillment. May differ from quantity requested based on inventory availability and HCP sample limits.',
    `quantity_dispensed` STRING COMMENT 'Actual number of sample units delivered to the HCP. Used for inventory reconciliation and accountability tracking under PDMA.',
    `quantity_requested` STRING COMMENT 'Number of sample units requested by the HCP. Measured in individual sample units (e.g., bottles, blister packs, vials).',
    `reconciliation_date` DATE COMMENT 'Date when the sample transaction was reconciled against inventory records. Required for PDMA sample accountability audits.',
    `reconciliation_status` STRING COMMENT 'Status of sample inventory reconciliation for this transaction. Tracks whether dispensed quantities match inventory deductions.. Valid values are `pending|reconciled|discrepancy|adjusted`',
    `rejection_reason` STRING COMMENT 'Free-text explanation for why a sample request was rejected. Common reasons include invalid DEA number, exceeded sample limits, or product unavailability.',
    `request_date` DATE COMMENT 'Date when the HCP submitted the sample request. Principal business event timestamp for request initiation.',
    `request_number` STRING COMMENT 'Business identifier for the sample request. Externally visible tracking number used for audit trail and reconciliation. Format: SR-XXXXXXXXXX.. Valid values are `^SR-[0-9]{10}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the sample request. Tracks progression from initial request through fulfillment and inventory reconciliation.. Valid values are `pending|approved|fulfilled|rejected|cancelled|reconciled`',
    `sample_value_usd` DECIMAL(18,2) COMMENT 'Fair market value of the dispensed drug samples in US dollars. Required for Sunshine Act transparency reporting and financial reconciliation.',
    `signature_timestamp` TIMESTAMP COMMENT 'Date and time when the HCP signed for receipt of drug samples. Captured electronically via mobile device or e-signature platform.',
    `source_system` STRING COMMENT 'Name of the operational system from which this sample request record originated. Typically Veeva CRM sample management module or equivalent.',
    `source_system_code` STRING COMMENT 'Unique identifier of this sample request record in the source operational system. Used for data lineage and troubleshooting.',
    `sunshine_reportable_flag` BOOLEAN COMMENT 'Indicates whether this sample transaction must be reported under the Physician Payments Sunshine Act transparency requirements.',
    CONSTRAINT pk_sample_request PRIMARY KEY(`sample_request_id`)
) COMMENT 'Drug sample requests and fulfillment records for HCPs under the Prescription Drug Marketing Act (PDMA) and FDA sample accountability requirements. Captures sample product, lot number, quantity requested, quantity dispensed, HCP signature, DEA number validation, sample drop date, and representative ID. Tracks sample inventory reconciliation and compliance with 21 CFR Part 203. Sourced from Veeva CRM sample management module.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique identifier for the consent record. Primary key for the consent_record product.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Consent records are governed by country-specific privacy regulations (GDPR, HIPAA, PDPA). Linking consent_record to masterdata.country via country_id enables regulatory jurisdiction lookups for data p',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Consent and DNC records apply not only to individual HCPs but also to healthcare organizations. An HCO may have institution-level no-contact preferences, formulary access restrictions, or opt-out reco',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional or healthcare organization to whom this consent record applies. Links to the HCP master data entity.',
    `channel` STRING COMMENT 'The specific communication channel to which this consent or restriction applies. Enables channel-specific consent management.. Valid values are `email|phone|sms|in_person|digital|mail`',
    `consent_expiration_date` DATE COMMENT 'The date on which the consent automatically expires and is no longer valid. Null for consents with no expiration.',
    `consent_granted_date` DATE COMMENT 'The date on which the HCP granted consent or permission for the specified communication or engagement type. Principal business event timestamp for this record.',
    `consent_language` STRING COMMENT 'The language in which the consent was presented and obtained. ISO 639-1 two-letter language code.',
    `consent_method` STRING COMMENT 'The method by which consent was obtained. Explicit indicates affirmative action by HCP; implicit or inferred indicates consent derived from behavior or context.. Valid values are `explicit|implicit|inferred|default`',
    `consent_source` STRING COMMENT 'The origin or method through which the consent or restriction was captured. Identifies the system or channel that recorded the consent.. Valid values are `web_form|crm|email|phone|paper|third_party`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent record. Indicates whether the consent is active, withdrawn, expired, or under review.. Valid values are `granted|withdrawn|expired|pending|suspended`',
    `consent_text` STRING COMMENT 'The full text or summary of the consent statement presented to and accepted by the HCP. Provides audit trail of what was agreed to.',
    `consent_type` STRING COMMENT 'The category of consent or permission granted by the HCP. Defines the nature of communication or engagement permitted.. Valid values are `promotional|medical|digital|email|phone|sms`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form or policy under which this consent was granted. Enables tracking of consent policy changes over time.',
    `consent_withdrawn_date` DATE COMMENT 'The date on which the HCP withdrew or revoked their consent. Null if consent has not been withdrawn.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was first created in the system. Record audit timestamp for compliance and traceability.',
    `data_source_system` STRING COMMENT 'The name or identifier of the source system from which this consent record originated. Supports data lineage and troubleshooting.',
    `digital_channel_sync_flag` BOOLEAN COMMENT 'Boolean indicator of whether this consent record has been synchronized to digital engagement platforms. True indicates sync is complete.',
    `dnc_flag` BOOLEAN COMMENT 'Boolean indicator of whether the HCP is on the Do Not Contact list. True indicates contact is prohibited.',
    `email_platform_sync_flag` BOOLEAN COMMENT 'Boolean indicator of whether this consent record has been synchronized to email marketing platforms for enforcement. True indicates sync is complete.',
    `enforcement_status` STRING COMMENT 'Indicates whether the consent or restriction is currently being enforced in downstream systems. Active means the rule is enforced; override indicates temporary suspension.. Valid values are `active|inactive|override|pending`',
    `is_current_record` BOOLEAN COMMENT 'Boolean indicator of whether this is the current active version of the consent record. True indicates this is the latest version; false indicates historical version.',
    `legal_hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether this consent record is under legal hold and must be preserved for litigation or regulatory investigation. True indicates legal hold is active.',
    `legal_hold_reason` STRING COMMENT 'Explanation or case reference for why the legal hold was applied. Null if no legal hold is active.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this consent record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was last modified. Record audit timestamp for compliance and traceability.',
    `no_see_flag` BOOLEAN COMMENT 'Boolean indicator of whether the HCP has requested no in-person visits from field representatives. True indicates no-see restriction is active.',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, or special instructions related to this consent record. Used for operational notes and exception handling.',
    `opt_in_flag` BOOLEAN COMMENT 'Boolean indicator of whether the HCP has explicitly opted in to receive communications. True indicates active opt-in consent.',
    `opt_out_flag` BOOLEAN COMMENT 'Boolean indicator of whether the HCP has opted out of communications. True indicates active opt-out or withdrawal.',
    `record_effective_date` DATE COMMENT 'The date from which this consent record version is effective. Supports temporal tracking and historical analysis.',
    `record_end_date` DATE COMMENT 'The date on which this consent record version ceased to be effective. Null for current active records. Supports temporal tracking and historical analysis.',
    `regulatory_basis` STRING COMMENT 'The primary regulatory framework or legal basis governing this consent or restriction. Identifies the compliance driver for the record.. Valid values are `gdpr|hipaa|ccpa|state_law|sunshine_act|other`',
    `restriction_reason` STRING COMMENT 'Free-text explanation or code describing why the restriction was applied. May reference regulatory requirement, HCP request, or internal policy.',
    `restriction_type` STRING COMMENT 'The type of restriction or limitation applied to HCP contact. DNC (Do Not Contact), no-see (field rep restriction), legal hold, compliance-driven restriction, or channel-specific limitation.. Valid values are `dnc|no_see|legal_hold|compliance|channel`',
    `veeva_crm_sync_flag` BOOLEAN COMMENT 'Boolean indicator of whether this consent record has been synchronized to Veeva CRM for field force enforcement. True indicates sync is complete.',
    `veeva_crm_sync_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was last synchronized to Veeva CRM. Null if never synchronized.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this consent record. Supports audit trail and accountability.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Unified consent, opt-in/opt-out, do-not-contact (DNC), and no-see records governing all permissible and restricted communication with HCPs. Single source of truth for contact permissions and restrictions across all channels. Captures consent grants (promotional, medical, digital, email, phone), consent withdrawals, DNC requests, no-see restrictions, compliance-driven contact restrictions, legal holds, and channel-specific limitations. Tracks consent date, withdrawal date, restriction type, restriction reason, regulatory basis (GDPR, HIPAA, CCPA, state law), expiration, and enforcement status. Enforced across all field engagement systems including Veeva CRM, email platforms, and digital channels. Replaces any separate DNC or no-see lists as the single authoritative source.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` (
    `sunshine_transfer_id` BIGINT COMMENT 'Unique identifier for the Open Payments (Sunshine Act) transfer of value record. Primary key for the sunshine_transfer data product.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Sunshine Act transfers to HCPs are processed as AP transactions for payment execution, compliance audit trail, and financial reconciliation. Critical for Open Payments reporting and SOX controls on HC',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Sunshine Act transfers may be made through third-party business partners (CROs, event companies). Linking to the MDM business_partner record enables reconciliation of third-party payments against the ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to hcp.contract. Business justification: Sunshine Act transfers of value (consulting fees, advisory board payments, research grants) are governed by contracts with HCPs. Linking sunshine_transfer to the governing contract enables FMV validat',
    `drug_product_id` BIGINT COMMENT 'Foreign key reference to the drug product or medical device associated with this transfer of value. Nullable for non-product-specific payments.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Sunshine Act transfer-of-value payments must be posted to specific GL accounts for SOX-compliant financial reporting and audit. Pharma finance teams require GL traceability for every reportable paymen',
    `hco_master_id` BIGINT COMMENT 'Foreign key reference to the healthcare organization that received the transfer of value. Nullable when recipient is an individual HCP.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Sunshine Act transfers of value must be reported under the legal entity making the payment. CMS reporting requirement for Open Payments database. Legal entity is the reporting entity.',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Transfers of value for in-licensed products require tracking the licensing agreement for royalty accounting, Sunshine Act attribution to licensed vs. proprietary products, and compliance with licensor',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who received the transfer of value. Links to the HCP master data.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Sunshine Act transfers related to patent-covered products must track the specific patent for regulatory reporting accuracy, compliance audit trails, and product attribution when multiple patents cover',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to finance.payment_run. Business justification: Sunshine Act HCP/HCO payments are disbursed via treasury payment runs. Linking sunshine_transfer to payment_run enables reconciliation of which payment batch settled each reportable transfer-of-value,',
    `speaker_program_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_speaker_program. Business justification: Speaker program honoraria are one of the largest categories of Sunshine Act reportable transfers of value. Linking sunshine_transfer directly to the hcp_speaker_program record that generated the payme',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: Sunshine Act Open Payments reporting requires classifying transfers of value as research-related, with the associated research study identified. Linking sunshine_transfer to trial satisfies CMS resear',
    `cms_publication_date` DATE COMMENT 'The date on which CMS published this transfer record to the public Open Payments database. Typically June 30 for prior year data.',
    `cms_reporting_status` STRING COMMENT 'The current status of this transfer record in the CMS Open Payments submission lifecycle. Tracks progression from draft through final acceptance. [ENUM-REF-CANDIDATE: draft|pending_review|submitted|accepted|disputed|corrected|deleted — 7 candidates stripped; promote to reference product]',
    `cms_submission_date` DATE COMMENT 'The date on which this transfer record was submitted to CMS for the Open Payments program. Used for compliance tracking and audit trails.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this sunshine transfer record was first created in the system. Used for audit trail and data lineage tracking.',
    `delay_publication_indicator` BOOLEAN COMMENT 'Indicates whether publication of this transfer has been delayed due to ongoing research, clinical investigation, or product development activities.',
    `dispute_status` STRING COMMENT 'Indicates whether the covered recipient has disputed this transfer record with CMS and the current resolution status of the dispute.. Valid values are `no_dispute|disputed_by_recipient|under_review|resolved|upheld`',
    `form_of_payment` STRING COMMENT 'The form in which the transfer of value was provided: cash, in-kind items or services, stock, stock options, or other forms. [ENUM-REF-CANDIDATE: cash|in_kind|stock|stock_option|dividend|profit|other — 7 candidates stripped; promote to reference product]',
    `internal_transaction_number` STRING COMMENT 'The companys internal transaction or payment reference number from the source financial or CRM system (e.g., SAP document number, Veeva CRM activity ID).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this sunshine transfer record was last updated. Used for change tracking and audit compliance.',
    `nature_of_payment` STRING COMMENT 'Detailed description of the context and purpose of the payment, including the specific service provided, event attended, or activity performed. Required for CMS transparency reporting.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The monetary value of the transfer in the transaction currency. Represents the gross amount before any adjustments or taxes.',
    `payment_amount_usd` DECIMAL(18,2) COMMENT 'The payment amount converted to US Dollars for CMS reporting purposes. Required for all Open Payments submissions regardless of original currency.',
    `payment_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the transfer of value occurred or was provided to the recipient. Used to determine the applicable reporting period.',
    `payment_type` STRING COMMENT 'The nature of the payment or transfer of value as defined by CMS Open Payments categories. Determines reporting requirements and compliance thresholds. [ENUM-REF-CANDIDATE: consulting_fee|speaker_honorarium|meal|travel|lodging|education|research_grant|charitable_contribution|royalty_license|ownership_interest|gift|entertainment|honoraria|current_or_prospective_ownership|compensation_for_services_other_than_consulting|space_rental_or_facility_fees|food_and_beverage — 17 candidates stripped; promote to reference product]',
    `product_indication` STRING COMMENT 'The therapeutic indication or disease state for which the associated product is marketed or being discussed in the context of this transfer.',
    `product_name` STRING COMMENT 'The marketed name of the drug or biological product associated with this transfer of value. Required when payment is related to a specific product.',
    `product_ndc` STRING COMMENT 'The 11-digit National Drug Code for the associated drug product in 5-4-2 or 11-digit format. Used for product identification in CMS submissions.. Valid values are `^d{5}-d{4}-d{2}$|^d{11}$`',
    `program_year` STRING COMMENT 'The calendar year for which this transfer is being reported to CMS. Determines the applicable reporting deadline and publication cycle.',
    `recipient_address_line1` STRING COMMENT 'The primary street address of the recipients principal business location. Required for CMS Open Payments reporting.',
    `recipient_city` STRING COMMENT 'The city of the recipients principal business location. Required for CMS Open Payments reporting.',
    `recipient_country` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code of the recipients principal business location. Typically USA for domestic Open Payments reporting.. Valid values are `^[A-Z]{3}$`',
    `recipient_first_name` STRING COMMENT 'The first name of the individual healthcare professional who received the transfer of value. Required for CMS Open Payments reporting.',
    `recipient_last_name` STRING COMMENT 'The last name of the individual healthcare professional who received the transfer of value. Required for CMS Open Payments reporting.',
    `recipient_npi` STRING COMMENT 'The 10-digit National Provider Identifier for the recipient healthcare professional or organization. Primary identifier for CMS reporting.. Valid values are `^d{10}$`',
    `recipient_postal_code` STRING COMMENT 'The ZIP code of the recipients principal business location in 5-digit or ZIP+4 format. Required for CMS Open Payments reporting.. Valid values are `^d{5}(-d{4})?$`',
    `recipient_specialty` STRING COMMENT 'The primary medical specialty of the recipient healthcare professional (e.g., Oncology, Cardiology, Internal Medicine). Used for CMS reporting and analytics.',
    `recipient_state` STRING COMMENT 'The two-letter US state or territory code of the recipients principal business location. Required for CMS Open Payments reporting.. Valid values are `^[A-Z]{2}$`',
    `recipient_state_license_number` STRING COMMENT 'The state medical license number of the recipient healthcare professional. Used for identity verification in Open Payments submissions.',
    `recipient_type` STRING COMMENT 'Classification of the payment recipient as defined by CMS: physician (MD/DO), non-physician practitioner (PA, NP, etc.), or teaching hospital.. Valid values are `physician|non_physician_practitioner|teaching_hospital`',
    `research_information_indicator` BOOLEAN COMMENT 'Indicates whether this transfer is related to research activities and may qualify for delayed publication under CMS rules.',
    `third_party_payment_recipient_indicator` BOOLEAN COMMENT 'Indicates whether the payment was made to a third party on behalf of the covered recipient (e.g., payment to a charity designated by the HCP).',
    CONSTRAINT pk_sunshine_transfer PRIMARY KEY(`sunshine_transfer_id`)
) COMMENT 'Open Payments (Sunshine Act) reportable transfers of value from the pharmaceutical company to HCPs and HCOs, as required under 42 CFR Part 403. Captures payment type (consulting fee, speaker honorarium, meal, travel, research grant, royalty), amount, currency, date, product association, nature of payment, and CMS reporting status. Supports annual CMS Open Payments submission and anti-kickback compliance monitoring.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` (
    `speaker_program_id` BIGINT COMMENT 'Unique identifier for the HCP speaker program record. Primary key for the speaker program entity.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Speaker programs are tactical execution vehicles for market access strategies, educating physicians on formulary positioning, PAP enrollment, and reimbursement pathways. Programs are deployed to suppo',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Speaker honoraria payments are processed through AP for payment execution, tax withholding, and audit trail. Essential for Sunshine Act reporting, budget variance analysis, and SOX compliance on promo',
    `brand_plan_id` BIGINT COMMENT 'Foreign key linking to commercial.brand_plan. Business justification: Speaker programs are a promotional tactic executed under a brand plan. Pharma brand teams track speaker program spend and activity counts against brand plan promotional mix targets and budgets. hcp_sp',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Speaker programs have dedicated budgets by therapeutic area and brand. hcp_speaker_program has cost_center_id and internal_order_id but no budget_id. Budget vs. actual honorarium spend tracking for sp',
    `contract_id` BIGINT COMMENT 'Reference number of the speaker bureau contract or agreement governing the relationship, terms, and compensation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Speaker programs are budgeted promotional activities requiring cost center allocation for expense tracking, budget variance analysis, and financial reporting. Standard pharma marketing expense managem',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Speaker programs are budgeted and tracked via therapeutic area or brand-specific internal orders for cost allocation, budget control, and ROI analysis. Essential for promotional spend tracking and var',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Speaker honoraria require an invoice document before AP posting and payment. Linking hcp_speaker_program to invoice enables the billing-to-payment audit trail required for Sunshine Act compliance and ',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional enrolled in the speaker bureau or delivering the program event.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Speaker programs are always executed for a specific approved branded medicinal product. MLR approval, Sunshine Act CMS reporting, compliance certification, and honorarium FMV validation all require id',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Speaker programs are managed by specific medical affairs or commercial org units. Linking to org_unit enables spend-by-org-unit reporting required for internal compliance oversight and Sunshine Act ag',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Speaker programs for patent-protected products track relevant patents for MLR approval of materials, ensuring presentation accuracy regarding patent status, and Sunshine Act product attribution when m',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Speaker programs may cover pipeline/discovery stage assets at scientific congresses for educational purposes. Tracks scientific communication about early-stage programs, supporting thought leader enga',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Speaker programs are organized and budgeted by therapeutic area for compliance tracking, spend analysis, and promotional planning. Replaces denormalized therapeutic_area text with structured FK for fi',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Speaker programs promote specific branded products. Linking to trademark enables brand compliance tracking, MLR approval validation, and ensures speakers are certified for the correct brand. Pharma co',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Speaker program events are held at specific healthcare organization venues (hospitals, medical centers, conference facilities affiliated with HCOs). Linking hcp_speaker_program to the hosting HCO via ',
    `audience_size` STRING COMMENT 'Number of healthcare professionals who attended the speaker program event. Used for reach metrics and ROI analysis.',
    `certification_status` STRING COMMENT 'Current status of the speaker training certification. Must be certified to deliver programs and receive honoraria.. Valid values are `certified|expired|pending_recertification|not_certified`',
    `compliance_approval_date` DATE COMMENT 'Date when compliance approval was granted for the speaker program event. Required before honorarium payment.',
    `compliance_approval_status` STRING COMMENT 'Status of compliance review and approval for the speaker program event. Must be approved before event execution to ensure anti-kickback compliance.. Valid values are `approved|pending|rejected|conditional`',
    `compliance_certification_date` DATE COMMENT 'Date when the HCP completed mandatory compliance training covering anti-kickback regulations, Sunshine Act reporting, and promotional guidelines.',
    `compliance_certification_status` STRING COMMENT 'Current status of the HCP compliance certification. Must be current to participate in speaker programs.. Valid values are `current|expired|pending|not_completed`',
    `contract_effective_date` DATE COMMENT 'Date when the speaker bureau contract becomes effective and binding.',
    `contract_expiration_date` DATE COMMENT 'Date when the speaker bureau contract expires. Requires renewal to continue the speaker relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this speaker program record was first created in the system. Audit trail for record creation.',
    `enrollment_date` DATE COMMENT 'Date when the HCP was enrolled into the speaker bureau. Marks the start of the speaker relationship.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the HCP in the speaker bureau. Determines eligibility to deliver programs and receive honoraria.. Valid values are `active|inactive|suspended|pending_approval|terminated|training_required`',
    `honorarium_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the honorarium payment. Supports multi-currency speaker programs.. Valid values are `^[A-Z]{3}$`',
    `honorarium_paid_usd` DECIMAL(18,2) COMMENT 'Actual honorarium payment in US Dollars made to the HCP for delivering the speaker program. Component of total spend and Sunshine Act reportable value.',
    `honorarium_rate_usd` DECIMAL(18,2) COMMENT 'Standard honorarium payment rate in US Dollars per speaker program event. Rate varies by speaker tier and program type.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this speaker program record was last updated. Audit trail for record changes.',
    `materials_used` STRING COMMENT 'List or description of promotional materials, slide decks, and educational content used during the speaker program. Must be Medical Legal Regulatory (MLR) approved.',
    `mlr_approval_number` STRING COMMENT 'Approval reference number from Medical Legal Regulatory review for the materials used in the speaker program. Ensures promotional compliance.',
    `program_event_number` STRING COMMENT 'Business identifier for the individual speaker program event. Externally visible unique code used for tracking and compliance reporting.',
    `programs_delivered_count` STRING COMMENT 'Cumulative count of speaker programs delivered by this HCP to date. Used for speaker performance tracking and tier progression.',
    `speaker_performance_rating` DECIMAL(18,2) COMMENT 'Quantitative performance rating for the speaker program event on a scale of 0.00 to 5.00. Based on audience feedback, content delivery, and engagement metrics.',
    `speaker_tier` STRING COMMENT 'Classification of the speaker based on expertise, reach, and engagement level. Determines honorarium rates and program eligibility.. Valid values are `tier_1|tier_2|tier_3|regional|national|international`',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Boolean indicator whether this speaker program event and associated transfer of value must be reported under the Physician Payments Sunshine Act.',
    `sunshine_act_reported_date` DATE COMMENT 'Date when the transfer of value for this speaker program was submitted to the CMS Open Payments database for Sunshine Act compliance.',
    `termination_date` DATE COMMENT 'Date when the HCP speaker bureau enrollment was terminated. Null if currently active.',
    `termination_reason` STRING COMMENT 'Business reason for terminating the speaker bureau enrollment. Examples include compliance violation, voluntary withdrawal, performance issues, or contract expiration.',
    `total_spend_usd` DECIMAL(18,2) COMMENT 'Total expenditure in US Dollars for the speaker program event including honorarium, venue costs, meals, and materials. Reportable transfer of value under Sunshine Act.',
    `training_completion_date` DATE COMMENT 'Date when the HCP completed mandatory speaker training for the therapeutic area and approved products. Required before delivering programs.',
    `training_expiration_date` DATE COMMENT 'Date when the speaker training certification expires. Requires recertification to continue delivering programs.',
    CONSTRAINT pk_speaker_program PRIMARY KEY(`speaker_program_id`)
) COMMENT 'Speaker bureau management and individual speaker program event records covering the full speaker lifecycle. Manages HCP enrollment in speaker bureau (speaker tier, therapeutic area, approved products, training completion, certification status, contract terms, honorarium rate, compliance certification), and individual program events (date, venue, format, audience size, spend, compliance approval, materials used). Tracks speaker training completion, programs delivered, speaker performance metrics, and generates Sunshine Act reportable transfers of value. Supports anti-kickback compliance monitoring for speaker fees and honoraria. Single source of truth for all speaker-related data. Managed in Veeva CRM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the HCP contract record. Primary key for the contract entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: HCP contracts specify brand-specific services (speaker programs, advisory boards, consulting). Brand linkage essential for FMV compliance, budget allocation, Sunshine Act reporting, and brand promotio',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: HCP contracts consume budget allocations for medical affairs, clinical operations, and commercial activities. Essential for budget planning, variance tracking, commitment reporting, and ensuring contr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Contract costs (honoraria, consulting fees) must be allocated to cost centers for budget tracking, accrual management, and financial reporting. Standard pharma contract expense management.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: HCP service contracts (consulting, advisory, speaking) are often charged to project-specific internal orders for cost allocation to clinical trials, brand campaigns, or therapeutic area programs. Crit',
    `investigational_site_id` BIGINT COMMENT 'Foreign key linking to clinical.investigational_site. Business justification: Investigator contracts (site investigator agreements) are executed at a specific investigational site. Direct FK enables site-level contract management, budget tracking per site, and regulatory audit ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Contracts must be executed by a specific legal entity with signing authority. Legal and compliance requirement for contract validity, liability management, and regulatory reporting.',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: HCP consulting contracts for licensed products must reference the licensing agreement to ensure compliance with licensor obligations (e.g., approval rights, payment allocation), royalty base calculati',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional who is party to this contract. Links to the HCP master data entity.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: HCP advisory board, consulting, and speaking contracts are executed for a specific medicinal product. FMV rate justification, OIG compliance screening, Sunshine Act reporting, and scope-of-services do',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: HCP consulting and speaker contracts are owned by specific org units (medical affairs, commercial BU). Linking contract to org_unit supports contract spend reporting by organizational unit, a standard',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: HCP contracts (consulting, research, advisory) are scoped to specific patented compounds or technologies. IP counsel and compliance teams must link contracts to covered patents for FTO clearance, Suns',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to finance.payment_run. Business justification: HCP service contracts (consulting, advisory, speaking) result in honorarium disbursements executed via payment runs. Linking contract to payment_run enables treasury and AP teams to track which paymen',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: HCP contracts scope services by therapeutic area for fair market value determination, compliance review, and spend tracking. Required for Sunshine Act reporting and aggregate spend analysis by franchi',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: HCP promotional and speaker contracts are brand-specific. Legal and compliance teams must link contracts to the specific trademark being promoted to enforce brand use restrictions, validate FMV rates ',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: Clinical Trial Agreements (CTAs) and investigator contracts are executed for a specific trial. Linking contract to trial enables financial compliance tracking, budget reconciliation, and regulatory au',
    `annual_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total compensation in USD that can be paid to the HCP under this contract in a calendar year. Enforces anti-kickback compliance and prevents excessive payments.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for this contract. Used for cost allocation and organizational reporting.',
    `compliance_approval_date` DATE COMMENT 'Date when the compliance department approved this contract. Required for audit trails and regulatory inspections.',
    `compliance_approval_status` STRING COMMENT 'Status of compliance review for this contract. Must be approved before contract execution and payment processing.. Valid values are `pending|approved|rejected|conditional`',
    `contract_number` STRING COMMENT 'Externally-visible unique business identifier for the contract. Used for legal reference, payment processing, and audit trails.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract. Controls whether payments can be processed and services can be rendered.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `contract_type` STRING COMMENT 'Classification of the contract based on the nature of services provided by the HCP. Determines applicable compliance rules and FMV benchmarks.. Valid values are `consulting|advisory_board|speaker_program|clinical_research|medical_education|key_opinion_leader`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the contract is executed. Determines applicable regulatory requirements and FMV benchmarks.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contract. Supports multi-currency operations and Sunshine Act reporting.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or terminates. Nullable for open-ended contracts. Used to prevent payments beyond contract term.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes legally binding and services may commence. Used for compliance validation and payment authorization.',
    `exclusion_screening_date` DATE COMMENT 'Date when the most recent exclusion screening was performed. Must be refreshed monthly per OIG guidance.',
    `exclusion_screening_status` STRING COMMENT 'Result of screening the HCP against government exclusion lists (OIG, GSA SAM, FDA Debarment). Must be cleared before contract execution and payment.. Valid values are `pending|cleared|excluded|conditional`',
    `fda_debarment_screening_result` STRING COMMENT 'Result of screening against the FDA Debarment List. Debarred individuals cannot participate in drug development or approval processes.. Valid values are `cleared|debarred|pending`',
    `fmv_methodology` STRING COMMENT 'Methodology used to determine the FMV rate for this contract. Documents compliance with anti-kickback regulations and ensures defensible compensation.. Valid values are `market_survey|third_party_benchmark|internal_analysis|hybrid`',
    `fmv_rate_type` STRING COMMENT 'Unit basis for the FMV compensation rate. Determines how payments are calculated and validated against caps.. Valid values are `hourly|daily|per_engagement|annual_retainer|per_deliverable`',
    `honorarium_rate` DECIMAL(18,2) COMMENT 'Fixed honorarium amount in USD for per-engagement or per-deliverable contracts. Used for speaker programs and advisory board participation.',
    `hourly_rate_max` DECIMAL(18,2) COMMENT 'Maximum hourly compensation rate in USD for services rendered under this contract. Part of the FMV range used for compliance validation.',
    `hourly_rate_min` DECIMAL(18,2) COMMENT 'Minimum hourly compensation rate in USD for services rendered under this contract. Part of the FMV range used for compliance validation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated. Used for audit trails and change tracking.',
    `legal_review_date` DATE COMMENT 'Date when the legal department completed review of this contract. Required for audit trails and contract governance.',
    `legal_review_status` STRING COMMENT 'Status of legal department review for this contract. Must be approved before contract execution.. Valid values are `pending|approved|rejected|conditional`',
    `oig_screening_result` STRING COMMENT 'Result of screening against the OIG List of Excluded Individuals and Entities. HCPs on the exclusion list cannot receive federal healthcare program payments.. Valid values are `cleared|excluded|pending`',
    `payment_frequency` STRING COMMENT 'Frequency at which payments are made to the HCP under this contract. Used for cash flow planning and compliance tracking.. Valid values are `per_service|monthly|quarterly|annual|upon_completion`',
    `payment_terms` STRING COMMENT 'Description of payment schedule, invoicing requirements, and disbursement conditions. Defines when and how the HCP will be compensated.',
    `region` STRING COMMENT 'Geographic region where the HCP will provide services under this contract. Used for FMV rate benchmarking and compliance segmentation.',
    `sam_screening_result` STRING COMMENT 'Result of screening against the GSA System for Award Management exclusion list. Ensures HCP is not debarred from federal contracts.. Valid values are `cleared|excluded|pending`',
    `scope_of_services` STRING COMMENT 'Detailed description of the services the HCP will provide under this contract. Defines deliverables, expectations, and compliance boundaries.',
    `specialty` STRING COMMENT 'Medical specialty of the HCP relevant to this contract. Used for FMV rate benchmarking and compliance validation.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether payments under this contract must be reported under the Physician Payments Sunshine Act (Open Payments). True for most HCP contracts.',
    `termination_reason` STRING COMMENT 'Reason for contract termination if status is terminated. Used for compliance analysis and vendor relationship management.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Contracts, agreements, and associated fair market value (FMV) rate cards between the pharmaceutical company and HCPs for services including consulting, advisory boards, speaker programs, clinical research, and medical education. Captures contract type, effective dates, scope of services, FMV rate ranges by specialty/service/region, FMV methodology, hourly rate min/max, annual caps, honorarium rate, payment terms, compliance approval status, legal review status, and debarment/exclusion screening results (OIG, GSA SAM, FDA Debarment List checks). Supports anti-kickback compliance validation (ensuring compensation within FMV bounds), exclusion screening before financial transfers, and Sunshine Act reporting for all contracted HCP payments.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` (
    `investigator_id` BIGINT COMMENT 'Unique identifier for the clinical trial investigator record. Primary key for the investigator data product.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Clinical investigator payments and site costs are budgeted at trial level for financial planning, commitment tracking, and variance analysis. Essential for clinical trial budget management and ensurin',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Clinical trial investigators conduct trials at specific healthcare organizations (academic medical centers, research hospitals, clinics). While investigator has org_unit_id for internal organizational',
    `master_id` BIGINT COMMENT 'Foreign key reference to the HCP master data product. Links the investigator record to the underlying healthcare professional identity.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Investigator qualification, FDA Form 1572 execution, IRB approval, and GCP training are tied to a specific investigational or approved medicinal product. Clinical operations teams track investigator-t',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Clinical operations organizational units manage investigator relationships and trial site oversight. Required for operational accountability, resource allocation, and performance management in clinica',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Clinical investigators named as inventors on patents arising from company-sponsored research require tracking for IP ownership verification, inventor compensation obligations, Sunshine Act reporting, ',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Investigators are qualified and tracked by therapeutic area expertise for clinical trial site selection, feasibility assessment, and investigator database management. Essential for clinical operations',
    `active_trials_count` STRING COMMENT 'Number of clinical trials currently active for this investigator. Used to assess investigator capacity and workload.',
    `average_enrollment_rate` DECIMAL(18,2) COMMENT 'Average number of subjects enrolled per month by this investigator. Calculated metric used for trial planning and site selection.',
    `conflict_of_interest_declared` BOOLEAN COMMENT 'Indicates whether the investigator has declared any financial or other conflicts of interest that could affect trial conduct or data integrity.',
    `cv_last_updated_date` DATE COMMENT 'Date when the investigators curriculum vitae was last updated in the system.',
    `cv_on_file` BOOLEAN COMMENT 'Indicates whether a current curriculum vitae is on file for the investigator. CV is required for regulatory submissions and site qualification.',
    `data_source` STRING COMMENT 'Source system from which the investigator record was created or last updated (e.g., Oracle Clinical, Veeva Vault, CTMS).',
    `disqualification_date` DATE COMMENT 'Date when the investigator was disqualified from conducting clinical trials, either by regulatory authority or company decision.',
    `disqualification_reason` STRING COMMENT 'Reason for investigator disqualification. May include regulatory violations, data integrity issues, or non-compliance with GCP.',
    `external_source_code` STRING COMMENT 'Unique identifier for this investigator in the source system. Used for data lineage and reconciliation.',
    `fda_1572_on_file` BOOLEAN COMMENT 'Indicates whether a signed FDA Form 1572 (Statement of Investigator) is on file. Required for all US-based clinical trials.',
    `fda_1572_signature_date` DATE COMMENT 'Date when the investigator signed the FDA Form 1572 for the current protocol assignment.',
    `financial_disclosure_date` DATE COMMENT 'Date when the investigator submitted their financial disclosure form for the current trial or reporting period.',
    `financial_disclosure_status` STRING COMMENT 'Status of the investigators financial disclosure submission (FDA Form 3454/3455). Required to identify potential conflicts of interest.. Valid values are `submitted|pending|not_required|overdue`',
    `gcp_training_completion_date` DATE COMMENT 'Date when the investigator completed their most recent GCP training certification.',
    `gcp_training_expiration_date` DATE COMMENT 'Date when the investigators current GCP training certification expires. Investigators must renew training to remain qualified.',
    `gcp_training_status` STRING COMMENT 'Status of the investigators GCP training certification. GCP training is mandatory for all clinical trial investigators per ICH guidelines.. Valid values are `current|expired|not_completed|pending_renewal`',
    `initiated_trial_flag` BOOLEAN COMMENT 'Indicates whether the investigator has conducted or is conducting investigator-initiated trials (IIT) with company products. IITs are investigator-led studies.',
    `investigator_number` STRING COMMENT 'Business identifier assigned to the investigator for tracking across clinical trials. May be company-specific or protocol-specific.',
    `investigator_role` STRING COMMENT 'Role of the investigator on clinical trials. Principal investigator (PI) has primary responsibility; sub-investigators and co-investigators support the PI.. Valid values are `principal_investigator|sub_investigator|co_investigator|coordinating_investigator`',
    `investigator_status` STRING COMMENT 'Current lifecycle status of the investigator. Active investigators are qualified and available for trial assignments. Disqualified status indicates regulatory action by FDA or other authority.. Valid values are `active|inactive|suspended|disqualified|pending_qualification`',
    `irb_approval_date` DATE COMMENT 'Date when the IRB approved the investigator to conduct clinical research at their site.',
    `irb_approval_expiration_date` DATE COMMENT 'Date when the current IRB approval expires. Investigators must obtain renewal to continue trial activities.',
    `irb_approval_status` STRING COMMENT 'Status of IRB approval for the investigator to conduct clinical trials at their affiliated site. IRB approval is required before trial initiation.. Valid values are `approved|pending|expired|not_required`',
    `kol_investigator_flag` BOOLEAN COMMENT 'Indicates whether the investigator is also classified as a Key Opinion Leader (KOL) in their therapeutic area. KOL investigators have additional engagement opportunities.',
    `last_performance_review_date` DATE COMMENT 'Date when the investigators performance was last formally reviewed by clinical operations or medical affairs.',
    `performance_rating` STRING COMMENT 'Overall performance rating assigned to the investigator based on enrollment, data quality, compliance, and site management. Used for future site selection decisions.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `protocol_deviation_count` STRING COMMENT 'Total number of protocol deviations reported for this investigator across all trials. Quality metric for investigator performance assessment.',
    `qualification_date` DATE COMMENT 'Date when the investigator was formally qualified to conduct clinical trials for the company. Represents completion of all qualification requirements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigator record was first created in the data product. Audit trail field.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigator record was last updated. Audit trail field for change tracking.',
    `serious_protocol_deviation_count` STRING COMMENT 'Number of serious protocol deviations reported for this investigator. Serious deviations may impact subject safety or data integrity.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether payments or transfers of value to this investigator must be reported under the Physician Payments Sunshine Act (Open Payments).',
    `total_subjects_enrolled` STRING COMMENT 'Cumulative number of subjects enrolled by this investigator across all trials. Key performance indicator for investigator productivity.',
    `total_trials_conducted` STRING COMMENT 'Total number of clinical trials the investigator has conducted as PI or sub-investigator. Performance metric for investigator selection.',
    CONSTRAINT pk_investigator PRIMARY KEY(`investigator_id`)
) COMMENT 'Clinical trial investigator records for HCPs serving as principal investigators (PIs) or sub-investigators on company-sponsored or investigator-initiated trials. Captures investigator role, GCP training status, CV on file, financial disclosure (Form FDA 3455), IRB approval status, site affiliation, therapeutic area expertise, enrollment performance metrics, and trial participation history. Provides the HCP-domain view of investigator identity and qualifications; clinical trial operational data (protocol, enrollment, visits) resides in the clinical domain. Supports regulatory submissions (Form FDA 1572) and clinical operations planning.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ADD CONSTRAINT `fk_hcp_license_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_affiliation_affiliated_hcp_physician_master_id` FOREIGN KEY (`affiliation_affiliated_hcp_physician_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ADD CONSTRAINT `fk_hcp_kol_profile_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ADD CONSTRAINT `fk_hcp_kol_profile_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`consent_record`(`consent_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_speaker_program_id` FOREIGN KEY (`speaker_program_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`speaker_program`(`speaker_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`consent_record`(`consent_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ADD CONSTRAINT `fk_hcp_consent_record_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ADD CONSTRAINT `fk_hcp_consent_record_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_speaker_program_id` FOREIGN KEY (`speaker_program_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`speaker_program`(`speaker_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`hcp` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `pharmaceuticals_ecm`.`hcp` SET TAGS ('dbx_domain' = 'hcp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Master Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `board_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `board_certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Not Certified|Certification Expired|In Progress');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'Veeva CRM|Salesforce Health Cloud|IQVIA OneKey|NPI Registry|Manual Entry|Third Party Provider');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `dea_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `dea_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `dea_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `dea_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Revoked|Expired');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `external_source_code` SET TAGS ('dbx_business_glossary_term' = 'External Source Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'Male|Female|Non-Binary|Unknown|Prefer Not to Disclose');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `hcp_status` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `hcp_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Retired|Deceased|Suspended|Under Review');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `kol_status` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `kol_status` SET TAGS ('dbx_value_regex' = 'KOL|Non-KOL|Emerging KOL|Under Review');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `kol_tier` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Tier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `kol_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `npi_number` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI) Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `npi_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `npi_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `npi_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `prescribing_authority` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Authority');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Primary License Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Primary License Issue Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Medical License Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_state` SET TAGS ('dbx_business_glossary_term' = 'Primary License State');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_status` SET TAGS ('dbx_business_glossary_term' = 'Primary License Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_license_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Revoked|Expired|Pending Renewal');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_city` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice City');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_country` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Country');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_state` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice State');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_practice_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `primary_specialty` SET TAGS ('dbx_business_glossary_term' = 'Primary Medical Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `professional_designation` SET TAGS ('dbx_business_glossary_term' = 'Professional Designation');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|not_accredited|pending|expired');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare & Medicaid Services (CMS) Certification Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'open|closed|restricted|preferred');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `gpo_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Affiliation');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `hco_name` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `hco_type` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `hco_type` SET TAGS ('dbx_value_regex' = 'hospital|clinic|pharmacy|integrated_delivery_network|group_purchasing_organization|academic_medical_center');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `idn_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Integrated Delivery Network (IDN) Affiliation');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `magnet_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Magnet Status Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `n340b_eligible_flag` SET TAGS ('dbx_business_glossary_term' = '340B Drug Pricing Program Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `organization_status` SET TAGS ('dbx_business_glossary_term' = 'Organization Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `organization_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|merged|acquired|closed');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'for_profit|non_profit|government|academic');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `tax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `teaching_hospital_flag` SET TAGS ('dbx_business_glossary_term' = 'Teaching Hospital Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Center Level');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|not_designated');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) License Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `board_name` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'board_certified|board_eligible|recertified|not_certified');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'License Comments');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `controlled_substance_authority` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Prescribing Authority Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `data_source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Source Record Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule Authorization');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'schedule_ii|schedule_iii|schedule_iv|schedule_v|all_schedules');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `disciplinary_action_description` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Description');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `disciplinary_action_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `disciplinary_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State or Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|inactive');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `npi_number` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI) Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `npi_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `npi_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `prescribing_authority` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Authority Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `primary_license_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary License Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'License Restriction Description');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'License Restriction Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Medical Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'License Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual|automated|third_party_service|self_reported');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Affiliation Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `affiliation_affiliated_hcp_physician_master_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliated Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `contract_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `admitting_privileges_flag` SET TAGS ('dbx_business_glossary_term' = 'Admitting Privileges Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|admitting_privileges|consulting|group_practice_member|referral_partner');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `compensation_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Arrangement Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `compensation_arrangement_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|fee_for_service|retainer|equity|none');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `compensation_arrangement_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending|expired|revoked|not_required');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `dea_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Affiliation End Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `formulary_influence_level` SET TAGS ('dbx_business_glossary_term' = 'Formulary Influence Level');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `formulary_influence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `full_time_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `is_primary_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Primary Affiliation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `kol_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Designation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Notes');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `npi_at_affiliation` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI) at Affiliation');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `npi_at_affiliation` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `npi_at_affiliation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `npi_at_affiliation` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `prescribing_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Authority Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `referral_direction` SET TAGS ('dbx_business_glossary_term' = 'Referral Direction');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `referral_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|bidirectional|none');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `referral_relationship_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Relationship Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `specialty_at_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Specialty at Affiliation');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `state_license_number` SET TAGS ('dbx_business_glossary_term' = 'State License Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `state_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `strength_score` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Strength Score');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|verification_failed');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `kol_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Key Opinion Leader (KOL) Profile ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `academic_rank` SET TAGS ('dbx_business_glossary_term' = 'Academic Rank');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `advisory_board_participation_count` SET TAGS ('dbx_business_glossary_term' = 'Advisory Board Participation Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `clinical_trial_investigator_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Investigator Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `compliance_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Clearance Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `compliance_clearance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Clearance Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `compliance_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Clearance Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `compliance_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|excluded|expired');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `conflict_of_interest_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Disclosure');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `conflict_of_interest_disclosure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `congress_speaking_count` SET TAGS ('dbx_business_glossary_term' = 'Congress Speaking Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `department_chair_flag` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `fellowship_institution` SET TAGS ('dbx_business_glossary_term' = 'Fellowship Institution');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `guideline_authorship_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Guideline Authorship Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `h_index` SET TAGS ('dbx_business_glossary_term' = 'H-Index');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `kol_status` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `kol_status` SET TAGS ('dbx_value_regex' = 'active|under_review|suspended|retired|deceased');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `kol_tier` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Tier Classification');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `kol_tier` SET TAGS ('dbx_value_regex' = 'national|regional|local|emerging|inactive');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `last_congress_speaking_date` SET TAGS ('dbx_business_glossary_term' = 'Last Congress Speaking Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `last_msl_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Medical Science Liaison (MSL) Interaction Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `last_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Last Publication Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `medical_school` SET TAGS ('dbx_business_glossary_term' = 'Medical School');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `medical_school` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `medical_school` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `msl_engagement_strategy` SET TAGS ('dbx_business_glossary_term' = 'Medical Science Liaison (MSL) Engagement Strategy');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `msl_engagement_strategy` SET TAGS ('dbx_value_regex' = 'high_priority|medium_priority|low_priority|monitor_only|do_not_contact');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `orcid_number` SET TAGS ('dbx_business_glossary_term' = 'Open Researcher and Contributor ID (ORCID)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `orcid_number` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}-d{4}-d{3}[0-9X]$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `peer_reviewed_publication_count` SET TAGS ('dbx_business_glossary_term' = 'Peer-Reviewed Publication Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `primary_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Primary Affiliation');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `principal_investigator_trial_count` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Trial Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `profile_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated By');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `scopus_author_number` SET TAGS ('dbx_business_glossary_term' = 'Scopus Author ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `society_leadership_flag` SET TAGS ('dbx_business_glossary_term' = 'Society Leadership Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `society_membership_list` SET TAGS ('dbx_business_glossary_term' = 'Professional Society Membership List');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `total_citation_count` SET TAGS ('dbx_business_glossary_term' = 'Total Citation Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ALTER COLUMN `total_msl_interaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Medical Science Liaison (MSL) Interaction Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` SET TAGS ('dbx_subdomain' = 'field_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `speaker_program_id` SET TAGS ('dbx_business_glossary_term' = 'Hcp Speaker Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `adverse_event_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Reported Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `call_objective` SET TAGS ('dbx_business_glossary_term' = 'Call Objective');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'face_to_face|virtual|phone|email|congress|event');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `compliance_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Time');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_value_regex' = '^ENG-[0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'planned|completed|cancelled|no_show|rescheduled');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Engagement Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `hcp_feedback` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Feedback');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `key_message_delivered` SET TAGS ('dbx_business_glossary_term' = 'Key Message Delivered');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Engagement Location');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `materials_shared` SET TAGS ('dbx_business_glossary_term' = 'Materials Shared');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `medical_inquiry_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Inquiry Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `medical_inquiry_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `medical_inquiry_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Action');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Engagement Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|follow_up_required|no_interest');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `relationship_strength_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength Score');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `samples_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Samples Provided Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'veeva_crm|salesforce_health_cloud|manual_entry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Time');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `territory_assignment` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `transfer_of_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer of Value Amount');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `transfer_of_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `transfer_of_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Transfer of Value Currency');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `transfer_of_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` SET TAGS ('dbx_subdomain' = 'field_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `controlled_substance_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `dea_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'DEA Schedule Classification');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Non-Controlled');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Delivery Method');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'in_person|courier|mail|direct_ship');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Fulfillment Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `hcp_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'HCP Signature Captured Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Notes');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `quantity_approved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Approved');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reconciliation Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reconciliation Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|adjusted');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Rejection Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^SR-[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|fulfilled|rejected|cancelled|reconciled');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `sample_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Sample Value in US Dollars (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'HCP Signature Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `sunshine_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|phone|sms|in_person|digital|mail');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Granted Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'explicit|implicit|inferred|default');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_source` SET TAGS ('dbx_value_regex' = 'web_form|crm|email|phone|paper|third_party');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_text` SET TAGS ('dbx_business_glossary_term' = 'Consent Text');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'promotional|medical|digital|email|phone|sms');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_withdrawn_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawn Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `digital_channel_sync_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel Sync Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `dnc_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact (DNC) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `email_platform_sync_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Platform Sync Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `email_platform_sync_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `email_platform_sync_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|override|pending');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `is_current_record` SET TAGS ('dbx_business_glossary_term' = 'Is Current Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `legal_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `no_see_flag` SET TAGS ('dbx_business_glossary_term' = 'No-See Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `record_end_date` SET TAGS ('dbx_business_glossary_term' = 'Record End Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'gdpr|hipaa|ccpa|state_law|sunshine_act|other');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Restriction Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'dnc|no_see|legal_hold|compliance|channel');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `veeva_crm_sync_flag` SET TAGS ('dbx_business_glossary_term' = 'Veeva Customer Relationship Management (CRM) Sync Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `veeva_crm_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Veeva Customer Relationship Management (CRM) Sync Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `sunshine_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Transfer ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `speaker_program_id` SET TAGS ('dbx_business_glossary_term' = 'Hcp Speaker Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `cms_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare & Medicaid Services (CMS) Publication Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `cms_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare & Medicaid Services (CMS) Reporting Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `cms_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare & Medicaid Services (CMS) Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `delay_publication_indicator` SET TAGS ('dbx_business_glossary_term' = 'Delay Publication Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|disputed_by_recipient|under_review|resolved|upheld');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `form_of_payment` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `internal_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Transaction ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `nature_of_payment` SET TAGS ('dbx_business_glossary_term' = 'Nature of Payment');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `payment_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount in United States Dollars (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `payment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `product_indication` SET TAGS ('dbx_business_glossary_term' = 'Product Indication');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `product_ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `product_ndc` SET TAGS ('dbx_value_regex' = '^d{5}-d{4}-d{2}$|^d{11}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_city` SET TAGS ('dbx_business_glossary_term' = 'Recipient City');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_country` SET TAGS ('dbx_business_glossary_term' = 'Recipient Country');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_first_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient First Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_last_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_value_regex' = '^d{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_specialty` SET TAGS ('dbx_business_glossary_term' = 'Recipient Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_state` SET TAGS ('dbx_business_glossary_term' = 'Recipient State');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_state_license_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient State License Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_state_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_state_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'physician|non_physician_practitioner|teaching_hospital');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `research_information_indicator` SET TAGS ('dbx_business_glossary_term' = 'Research Information Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `third_party_payment_recipient_indicator` SET TAGS ('dbx_business_glossary_term' = 'Third Party Payment Recipient Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` SET TAGS ('dbx_subdomain' = 'field_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `speaker_program_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Speaker Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Venue Hco Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `audience_size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending_recertification|not_certified');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `compliance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_value_regex' = 'current|expired|pending|not_completed');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|training_required');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `honorarium_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `honorarium_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `honorarium_paid_usd` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Paid (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `honorarium_paid_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `honorarium_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Rate (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `honorarium_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `materials_used` SET TAGS ('dbx_business_glossary_term' = 'Materials Used');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `mlr_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Legal Regulatory (MLR) Approval Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `program_event_number` SET TAGS ('dbx_business_glossary_term' = 'Program Event Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `programs_delivered_count` SET TAGS ('dbx_business_glossary_term' = 'Programs Delivered Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `speaker_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Speaker Performance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `speaker_tier` SET TAGS ('dbx_business_glossary_term' = 'Speaker Tier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `speaker_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|regional|national|international');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `sunshine_act_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reported Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `total_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Spend (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `total_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ALTER COLUMN `training_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Contract Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `annual_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Cap Amount');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `annual_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `compliance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'consulting|advisory_board|speaker_program|clinical_research|medical_education|key_opinion_leader');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `exclusion_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Screening Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `exclusion_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Screening Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `exclusion_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|excluded|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `fda_debarment_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Debarment Screening Result');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `fda_debarment_screening_result` SET TAGS ('dbx_value_regex' = 'cleared|debarred|pending');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `fmv_methodology` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Methodology');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `fmv_methodology` SET TAGS ('dbx_value_regex' = 'market_survey|third_party_benchmark|internal_analysis|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `fmv_methodology` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `fmv_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Rate Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `fmv_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|per_engagement|annual_retainer|per_deliverable');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `honorarium_rate` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Rate');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `honorarium_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `hourly_rate_max` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate Maximum');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `hourly_rate_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `hourly_rate_min` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate Minimum');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `hourly_rate_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `oig_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Screening Result');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `oig_screening_result` SET TAGS ('dbx_value_regex' = 'cleared|excluded|pending');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'per_service|monthly|quarterly|annual|upon_completion');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `sam_screening_result` SET TAGS ('dbx_business_glossary_term' = 'System for Award Management (SAM) Screening Result');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `sam_screening_result` SET TAGS ('dbx_value_regex' = 'cleared|excluded|pending');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `active_trials_count` SET TAGS ('dbx_business_glossary_term' = 'Active Trials Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `average_enrollment_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Enrollment Rate');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `conflict_of_interest_declared` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Declared');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `cv_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Vitae (CV) Last Updated Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `cv_on_file` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Vitae (CV) on File');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `disqualification_date` SET TAGS ('dbx_business_glossary_term' = 'Investigator Disqualification Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `external_source_code` SET TAGS ('dbx_business_glossary_term' = 'External Source System Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `fda_1572_on_file` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Form 1572 on File');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `fda_1572_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Form 1572 Signature Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `financial_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Disclosure Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `financial_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Disclosure Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `financial_disclosure_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|not_required|overdue');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `gcp_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Training Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `gcp_training_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Training Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `gcp_training_status` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Training Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `gcp_training_status` SET TAGS ('dbx_value_regex' = 'current|expired|not_completed|pending_renewal');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `initiated_trial_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigator Initiated Trial (IIT) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `investigator_number` SET TAGS ('dbx_business_glossary_term' = 'Investigator Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `investigator_role` SET TAGS ('dbx_business_glossary_term' = 'Investigator Role');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `investigator_role` SET TAGS ('dbx_value_regex' = 'principal_investigator|sub_investigator|co_investigator|coordinating_investigator');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `investigator_status` SET TAGS ('dbx_business_glossary_term' = 'Investigator Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `investigator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|disqualified|pending_qualification');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `irb_approval_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `irb_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `irb_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|expired|not_required');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `kol_investigator_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Investigator Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Investigator Performance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `protocol_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Investigator Qualification Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `serious_protocol_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Protocol Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `total_subjects_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Total Subjects Enrolled');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `total_trials_conducted` SET TAGS ('dbx_business_glossary_term' = 'Total Trials Conducted');
