-- Schema for Domain: hcp | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`hcp` COMMENT 'Healthcare professional and healthcare organization master data including physicians, pharmacists, hospitals, clinics, and key opinion leaders (KOL). Manages HCP credentials, specialties, prescribing patterns, affiliations, and engagement history. Ensures compliance with Sunshine Act transparency reporting and anti-kickback regulations. Authoritative source for HCP identity and relationship data used across commercial, medical affairs, and clinical operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`master` (
    `master_id` BIGINT COMMENT 'Primary key for master',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: HCPs are employed or contracted by legal entities. Required for Sunshine Act reporting, compliance tracking, contract execution authority, and financial consolidation. Standard pharma legal structure.',
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
    `secondary_specialty` STRING COMMENT 'Secondary or sub-specialty area of practice for the HCP, if applicable.',
    `suffix` STRING COMMENT 'Professional or generational suffix appended to the HCP name (e.g., Jr., Sr., MD, PhD). [ENUM-REF-CANDIDATE: Jr|Sr|II|III|IV|V|MD|DO|PhD|PharmD|RN|NP|PA — 13 candidates stripped; promote to reference product]',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether payments and transfers of value to this HCP must be reported under the Physician Payments Sunshine Act (Open Payments program).',
    CONSTRAINT pk_master PRIMARY KEY(`master_id`)
) COMMENT 'Master record for individual healthcare professionals (HCPs) including physicians, pharmacists, nurses, and other licensed practitioners. Captures HCP identity (name, date of birth, gender), NPI number, professional credentials, all state medical licenses (license number, issuing authority, jurisdiction, issue/expiration dates, status, renewal history), DEA controlled substance registrations, board certifications, specialty classifications (primary/secondary, ATC/therapeutic area alignment), professional designations, practice addresses, and contact information. Authoritative single source of truth (SSOT) for HCP identity, credentials, licensing, and practice locations used across commercial, medical affairs, and clinical operations. Sourced from Veeva CRM, Salesforce Health Cloud, and third-party data providers (IQVIA OneKey, NPI Registry).';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` (
    `hco_master_id` BIGINT COMMENT 'Primary key for hco_master',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: HCOs are owned/operated by legal entities. Essential for corporate structure mapping, financial consolidation, compliance reporting, and understanding IDN/GPO relationships. Removes denormalized paren',
    `accreditation_expiration_date` DATE COMMENT 'Date when the current accreditation certification expires. Triggers re-evaluation and compliance monitoring workflows.',
    `accreditation_status` STRING COMMENT 'Current accreditation status from recognized healthcare accreditation bodies. Indicates quality standards compliance and eligibility for certain programs.. Valid values are `accredited|provisional|not_accredited|pending|expired`',
    `accrediting_body` STRING COMMENT 'Name of the primary accreditation organization that has certified this healthcare organization (e.g., Joint Commission, NCQA, DNV, AAAHC).',
    `address_line_1` STRING COMMENT 'Primary street address line for the healthcare organization headquarters or primary location. Used for territory assignment and geographic analytics.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information.',
    `bed_count` STRING COMMENT 'Total number of licensed inpatient beds at the healthcare facility. Used for market sizing, territory planning, and commercial targeting segmentation.',
    `city` STRING COMMENT 'City name for the healthcare organization primary address.',
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
    `postal_code` STRING COMMENT 'Postal or ZIP code for the healthcare organization address. Used for geographic segmentation and logistics planning.',
    `specialty_focus` STRING COMMENT 'Primary clinical specialty or therapeutic area focus of the healthcare organization (e.g., oncology, cardiology, pediatrics). Used for targeted medical affairs and commercial engagement.',
    `state_province` STRING COMMENT 'State or province code for the healthcare organization address. Used for state-level regulatory compliance and territory management.',
    `tax_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID for the healthcare organization. Used for financial transactions, 1099 reporting, and Sunshine Act compliance.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `teaching_hospital_flag` BOOLEAN COMMENT 'Indicates whether the organization is a teaching hospital affiliated with a medical school. Teaching hospitals are priority targets for medical affairs and Key Opinion Leader (KOL) engagement.',
    `trauma_level` STRING COMMENT 'Trauma center designation level indicating capability to provide comprehensive emergency care. Level 1 centers have the highest capability.. Valid values are `level_1|level_2|level_3|level_4|not_designated`',
    `website_url` STRING COMMENT 'Official website URL for the healthcare organization. Used for digital engagement and research.',
    CONSTRAINT pk_hco_master PRIMARY KEY(`hco_master_id`)
) COMMENT 'Master record for healthcare organizations (HCOs) including hospitals, clinics, pharmacies, integrated delivery networks (IDNs), group purchasing organizations (GPOs), and academic medical centers. Captures organization name, type, accreditation status, NPI, DEA registration, bed count, magnet status, teaching hospital designation, and geographic footprint. SSOT for institutional identity used in commercial targeting and medical affairs.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`license` (
    `license_id` BIGINT COMMENT 'Unique identifier for the HCP license record. Primary key for the HCP license entity.',
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
    `issuing_country` STRING COMMENT 'The country where the license was issued. Uses three-letter ISO country code. Primarily USA for domestic operations, but may include other countries for global HCP engagement. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|JPN|CHN|IND|BRA|AUS — 11 candidates stripped; promote to reference product]',
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
    `conflict_of_interest_id` BIGINT COMMENT 'Foreign key linking to compliance.conflict_of_interest. Business justification: HCP affiliations with institutions, other HCPs, or organizations create potential conflicts requiring disclosure in clinical trials, advisory boards, and speaker programs. Links affiliation to conflic',
    `contract_id` BIGINT COMMENT 'The contract or agreement reference number governing this affiliation relationship, if applicable. Used for compliance tracking and Sunshine Act reporting.',
    `hco_master_id` BIGINT COMMENT 'Foreign key reference to the healthcare organization to which the HCP is affiliated. Links to the HCO master record. Nullable when affiliation is HCP-to-HCP.',
    `investigational_site_id` BIGINT COMMENT 'Foreign key linking to clinical.investigational_site. Business justification: Clinical sites are healthcare organizations where affiliated HCPs practice. Site feasibility assessments, investigator recruitment, enrollment forecasting, and site selection decisions require underst',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who holds this affiliation. Links to the HCP master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Medical Science Liaisons (MSLs) are employees who maintain scientific relationships with affiliated HCPs. Essential for MSL territory assignment, field medical activity tracking, resource planning, an',
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

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` (
    `hcp_kol_profile_id` BIGINT COMMENT 'Unique identifier for the KOL profile record. Primary key for the HCP KOL profile entity.',
    `master_id` BIGINT COMMENT 'Reference to the base HCP master record. Links the KOL profile to the foundational HCP entity containing credentials, specialties, and contact information.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Medical affairs employees (MSL managers, therapeutic area medical directors) own KOL engagement strategies and relationship management. Essential for KOL engagement planning, resource allocation, acco',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: KOL profiles track therapeutic area expertise by specific molecular targets to guide MSL engagement strategy, advisory board selection, and investigator identification. Critical for matching scientifi',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: KOL tier assessment incorporates patent inventorship as a measure of scientific leadership and innovation. Tracks primary patent contributions for speaker bureau qualification, advisory board selectio',
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
    `secondary_therapeutic_areas` STRING COMMENT 'Additional therapeutic areas where the KOL has recognized expertise or active research involvement. Stored as a delimited list to support multi-specialty KOLs.',
    `society_leadership_flag` BOOLEAN COMMENT 'Indicates whether the KOL holds or has held a leadership position (board member, committee chair, president) in a professional medical society. True if leadership role exists, false otherwise. Reflects industry influence and governance participation.',
    `society_membership_list` STRING COMMENT 'List of professional medical societies, associations, or organizations where the KOL holds membership. Examples include American Society of Clinical Oncology (ASCO), American College of Cardiology (ACC), European Society for Medical Oncology (ESMO). Stored as delimited text.',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Indicates whether payments or transfers of value to this KOL must be reported under the Physician Payments Sunshine Act (Open Payments). True if reportable, false otherwise. Used to ensure transparency and compliance with US federal reporting requirements.',
    `total_citation_count` STRING COMMENT 'Cumulative number of citations received across all of the KOLs published works. Indicates the breadth of scientific impact and recognition within the research community.',
    `total_msl_interaction_count` STRING COMMENT 'Cumulative number of documented interactions between MSLs and the KOL. Reflects depth of relationship and engagement history.',
    CONSTRAINT pk_hcp_kol_profile PRIMARY KEY(`hcp_kol_profile_id`)
) COMMENT 'Key Opinion Leader (KOL) profile extending the base HCP record with scientific influence metrics, publication history, clinical trial investigator status, advisory board participation, congress speaking history, and KOL tier classification (national, regional, local). Tracks h-index, citation count, therapeutic area expertise, and KOL engagement strategy. Used by medical affairs for publication planning, advisory boards, and MSL targeting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` (
    `hcp_engagement_id` BIGINT COMMENT 'Unique identifier for the HCP (Healthcare Professional) or HCO (Healthcare Organization) engagement record. Primary key.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Field engagements execute market access strategies at physician level. Sales reps deliver access-focused messaging, discuss formulary positioning, and support PAP enrollment aligned with strategy. Ess',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Engagements incur costs (travel, meals, samples) that must be allocated to cost centers for budgeting, variance analysis, and financial reporting. Standard pharma expense management practice.',
    `engagement_id` BIGINT COMMENT 'Unique identifier for this HCP-employee engagement relationship record. Primary key for the association.',
    `hco_master_id` BIGINT COMMENT 'Foreign key reference to the healthcare organization where the engagement occurred or that was engaged. Nullable if engagement is with an individual HCP not affiliated with a specific organization context.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Field engagements may trigger compliance incidents: adverse events not reported, off-label promotion, consent violations, or inappropriate materials. Links engagement to resulting incident investigati',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Field engagements (congress attendance, speaker programs, promotional activities) are charged to brand or therapeutic area internal orders for cost allocation and ROI tracking. Essential for marketing',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who was engaged. Links to the HCP master data entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Medical affairs employees (MSLs, medical directors) conduct scientific engagements with HCPs distinct from commercial sales calls. Required for medical affairs activity tracking, resource allocation, ',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Medical affairs engagements discuss pipeline compounds in discovery phase for scientific exchange, investigator identification, and early KOL engagement. Tracks pre-commercial scientific dialogue that',
    `sales_rep_id` BIGINT COMMENT 'Foreign key reference to the sales representative or Medical Science Liaison (MSL) who conducted the engagement. Links to the sales_rep or employee master data entity.',
    `territory_id` BIGINT COMMENT 'Foreign key reference to the sales territory in which this engagement occurred. Links to the territory master data entity for geographic and organizational reporting.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Field engagements are planned, executed, and reported by therapeutic area for territory alignment, call planning, and sales force effectiveness analysis. Core to commercial operations and CRM analytic',
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
    CONSTRAINT pk_hcp_engagement PRIMARY KEY(`hcp_engagement_id`)
) COMMENT 'Records of all interactions between field personnel (sales representatives, MSLs, medical affairs) and HCPs or HCOs. Captures engagement type (detail visit, lunch-and-learn, congress meeting, advisory board, medical information request), channel (face-to-face, virtual, phone), date, duration, products discussed, materials shared, and outcome. Primary transactional record for HCP engagement history. Sourced from Veeva CRM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` (
    `sample_request_id` BIGINT COMMENT 'Unique identifier for the drug sample request record. Primary key for sample accountability tracking under 21 CFR Part 203 (Prescription Drug Marketing Act).',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Sample distribution creates COGS entries for inventory valuation relief and P&L impact. Required for accurate gross-to-net calculations, promotional expense tracking, and compliance with inventory acc',
    `drug_product_id` BIGINT COMMENT 'Foreign key reference to the drug product master data. Identifies the specific pharmaceutical product being sampled.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Sample distribution violations (DEA schedule discrepancies, missing signatures, unauthorized recipients, reconciliation failures) trigger compliance incidents requiring investigation, CAPA, and potent',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who requested the drug samples. Links to HCP master data for prescriber validation and compliance tracking.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Samples are manufactured and fulfilled from specific plants. Required for supply chain planning, inventory management, lot traceability, and GDP compliance. Operational necessity for sample distributi',
    `sales_rep_id` BIGINT COMMENT 'Foreign key reference to the pharmaceutical sales representative who fulfilled the sample request. Required for accountability and territory tracking.',
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
    `ndc_code` STRING COMMENT 'FDA National Drug Code identifying the specific drug product, package size, and manufacturer. Format: XXXXX-XXXX-XX (labeler-product-package).. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
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
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional or healthcare organization to whom this consent record applies. Links to the HCP master data entity.',
    `privacy_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_obligation. Business justification: Each consent record implements a specific privacy obligation (GDPR Article 6, CCPA opt-out rights, HIPAA authorization). Consent types map directly to regulatory requirements. Essential for privacy co',
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
    `regulatory_jurisdiction` STRING COMMENT 'The geographic or legal jurisdiction under which this consent or restriction is governed. May be country code, state code, or region identifier.',
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
    `submission_id` BIGINT COMMENT 'The unique identifier assigned by CMS for this Open Payments submission record. Used for tracking and reconciliation with CMS Open Payments database.',
    `disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_disclosure. Business justification: Sunshine Act transfers are the transactional source data for Open Payments compliance disclosures submitted to CMS. Each disclosure aggregates multiple transfers for regulatory reporting. Critical for',
    `drug_product_id` BIGINT COMMENT 'Foreign key reference to the drug product or medical device associated with this transfer of value. Nullable for non-product-specific payments.',
    `hco_master_id` BIGINT COMMENT 'Foreign key reference to the healthcare organization that received the transfer of value. Nullable when recipient is an individual HCP.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Sunshine Act transfers of value must be reported under the legal entity making the payment. CMS reporting requirement for Open Payments database. Legal entity is the reporting entity.',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Transfers of value for in-licensed products require tracking the licensing agreement for royalty accounting, Sunshine Act attribution to licensed vs. proprietary products, and compliance with licensor',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who received the transfer of value. Links to the HCP master data.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Sunshine Act transfers related to patent-covered products must track the specific patent for regulatory reporting accuracy, compliance audit trails, and product attribution when multiple patents cover',
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
    `third_party_recipient_name` STRING COMMENT 'The name of the third-party entity that received the payment on behalf of the covered recipient. Populated when third_party_payment_recipient_indicator is true.',
    CONSTRAINT pk_sunshine_transfer PRIMARY KEY(`sunshine_transfer_id`)
) COMMENT 'Open Payments (Sunshine Act) reportable transfers of value from the pharmaceutical company to HCPs and HCOs, as required under 42 CFR Part 403. Captures payment type (consulting fee, speaker honorarium, meal, travel, research grant, royalty), amount, currency, date, product association, nature of payment, and CMS reporting status. Supports annual CMS Open Payments submission and anti-kickback compliance monitoring.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` (
    `prescribing_pattern_id` BIGINT COMMENT 'Unique identifier for the prescribing pattern record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Prescribing patterns track brand-specific Rx volume (TRx/NRx) for market share analysis, competitive benchmarking, and HCP targeting. Essential for brand performance dashboards and sales force effecti',
    `coverage_decision_id` BIGINT COMMENT 'Foreign key linking to market.coverage_decision. Business justification: Coverage decisions (PA, step therapy, restrictions) directly drive prescribing patterns. Market access teams measure prescribing impact of coverage policy changes. Fundamental relationship for access ',
    `market_formulary_position_id` BIGINT COMMENT 'Foreign key linking to market.formulary_position. Business justification: Prescribing patterns are directly influenced by formulary tier, PA requirements, and step therapy. Market access teams analyze prescribing impact of formulary changes. Core analytics relationship for ',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who prescribed the medication.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key reference to the drug product being prescribed.',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to market.payer_account. Business justification: Prescribing patterns are analyzed by payer account to understand market share, formulary impact, and competitive dynamics. Standard commercial analytics link physician prescribing to payer coverage. E',
    `territory_id` BIGINT COMMENT 'Foreign key linking to commercial.territory. Business justification: Prescribing data is analyzed by commercial territory for HCP targeting, call planning, and sales performance measurement. Territory-level Rx trends drive resource allocation and quota setting in pharm',
    `average_days_supply` DECIMAL(18,2) COMMENT 'Average number of days supply per prescription written by the HCP for the product.',
    `brand_prescriptions` BIGINT COMMENT 'Number of brand-name (non-generic) prescriptions written by the HCP for the product during the reporting period.',
    `brand_vs_generic_ratio` DECIMAL(18,2) COMMENT 'Ratio of brand prescriptions to generic prescriptions, indicating HCP preference for brand vs generic products.',
    `competitive_product_prescriptions` BIGINT COMMENT 'Total number of prescriptions written by the HCP for competing products in the same therapeutic area during the reporting period.',
    `data_classification` STRING COMMENT 'Classification level of the prescribing pattern data indicating sensitivity and access controls required.. Valid values are `confidential|internal`',
    `data_provider` STRING COMMENT 'Third-party prescription data provider that sourced this prescribing pattern data (e.g., IQVIA, Symphony Health).. Valid values are `IQVIA|Symphony Health|Surescripts|Other`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score assigned by the data provider indicating completeness and reliability of the prescribing data, ranging from 0.00 to 1.00.',
    `data_refresh_date` DATE COMMENT 'Date when the prescribing pattern data was last refreshed or updated by the data provider.',
    `data_source_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of the HCPs total prescribing activity captured by the data providers data sources.',
    `decile_classification` STRING COMMENT 'Decile classification of the HCP based on prescribing volume, where D1 represents the top 10% of prescribers and D10 the bottom 10%. [ENUM-REF-CANDIDATE: D1|D2|D3|D4|D5|D6|D7|D8|D9|D10 — 10 candidates stripped; promote to reference product]',
    `formulary_status` STRING COMMENT 'Predominant formulary status of the product for the HCPs patient population, indicating coverage and access restrictions.. Valid values are `preferred|formulary|non_formulary|restricted|prior_auth_required|unknown`',
    `generic_prescriptions` BIGINT COMMENT 'Number of generic prescriptions written by the HCP for the product during the reporting period.',
    `geography_level` STRING COMMENT 'Geographic granularity level at which the prescribing data is aggregated.. Valid values are `national|regional|state|territory|zip3|zip5`',
    `is_key_opinion_leader` BOOLEAN COMMENT 'Flag indicating whether the HCP is classified as a Key Opinion Leader in the therapeutic area.',
    `market_share_percent` DECIMAL(18,2) COMMENT 'HCPs prescribing market share for the product within the therapeutic area, expressed as a percentage.',
    `new_prescriptions_nrx` BIGINT COMMENT 'Number of new prescriptions (first-time prescriptions for a patient) written by the HCP for the product during the reporting period.',
    `patient_count_estimate` STRING COMMENT 'Estimated number of unique patients for whom the HCP prescribed the product during the reporting period. This is an aggregated estimate, not patient-level data.',
    `prescribing_channel` STRING COMMENT 'Primary distribution channel through which the HCPs prescriptions are fulfilled (retail pharmacy, specialty pharmacy, mail order, hospital).. Valid values are `retail|specialty|mail_order|hospital|mixed`',
    `prescribing_rank_national` STRING COMMENT 'National ranking of the HCP based on total prescriptions for the product, with 1 being the highest prescriber.',
    `prescribing_rank_regional` STRING COMMENT 'Regional ranking of the HCP based on total prescriptions for the product within their geographic territory.',
    `prescribing_trend` STRING COMMENT 'Directional trend of HCP prescribing behavior for the product compared to previous reporting periods.. Valid values are `increasing|stable|decreasing|new_prescriber|inactive`',
    `prior_authorization_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of prescriptions that required prior authorization approval from payers.',
    `projection_method` STRING COMMENT 'Method used to calculate prescribing volumes when complete data is not available (actual count, statistical projection, extrapolation, or predictive model).. Valid values are `actual|projected|extrapolated|modeled`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prescribing pattern record was first created in the data lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this prescribing pattern record was last updated in the data lakehouse.',
    `refill_prescriptions` BIGINT COMMENT 'Number of refill prescriptions written by the HCP for the product during the reporting period.',
    `reporting_period_end_date` DATE COMMENT 'End date of the time period for which prescribing data is aggregated.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the time period for which prescribing data is aggregated.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area or disease category for the prescribed product (e.g., Oncology, Immunology, Rare Diseases).',
    `total_prescriptions_trx` BIGINT COMMENT 'Total number of prescriptions written by the HCP for the product during the reporting period, including both new and refill prescriptions.',
    `total_units_prescribed` BIGINT COMMENT 'Total quantity of product units (tablets, vials, doses) prescribed by the HCP during the reporting period.',
    CONSTRAINT pk_prescribing_pattern PRIMARY KEY(`prescribing_pattern_id`)
) COMMENT 'Aggregated prescribing behavior data for HCPs by product, therapeutic area, and time period, sourced from third-party prescription data providers (IQVIA, Symphony Health). Captures total prescriptions (TRx), new prescriptions (NRx), market share, brand vs. generic split, competitive prescribing, and prescribing trend. Used for HCP targeting, segmentation, and commercial performance management. Not patient-level data — aggregated at HCP level.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` (
    `hcp_speaker_program_id` BIGINT COMMENT 'Unique identifier for the HCP speaker program record. Primary key for the speaker program entity.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Speaker programs are tactical execution vehicles for market access strategies, educating physicians on formulary positioning, PAP enrollment, and reimbursement pathways. Programs are deployed to suppo',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Speaker honoraria payments are processed through AP for payment execution, tax withholding, and audit trail. Essential for Sunshine Act reporting, budget variance analysis, and SOX compliance on promo',
    `contract_id` BIGINT COMMENT 'Reference number of the speaker bureau contract or agreement governing the relationship, terms, and compensation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Speaker programs are budgeted promotional activities requiring cost center allocation for expense tracking, budget variance analysis, and financial reporting. Standard pharma marketing expense managem',
    `inspection_readiness_id` BIGINT COMMENT 'Foreign key linking to compliance.inspection_readiness. Business justification: Speaker programs are high-risk promotional activities frequently inspected by FDA, OIG, and state attorneys general. Each program must maintain inspection readiness with compliant contracts, FMV docum',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Speaker programs are budgeted and tracked via therapeutic area or brand-specific internal orders for cost allocation, budget control, and ROI analysis. Essential for promotional spend tracking and var',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional enrolled in the speaker bureau or delivering the program event.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Speaker programs for patent-protected products track relevant patents for MLR approval of materials, ensuring presentation accuracy regarding patent status, and Sunshine Act product attribution when m',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Medical affairs or commercial training employees manage speaker programs including logistics, compliance oversight, and coordination. Required for speaker program management, compliance oversight, bud',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Speaker programs may cover pipeline/discovery stage assets at scientific congresses for educational purposes. Tracks scientific communication about early-stage programs, supporting thought leader enga',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Speaker programs are organized and budgeted by therapeutic area for compliance tracking, spend analysis, and promotional planning. Replaces denormalized therapeutic_area text with structured FK for fi',
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
    CONSTRAINT pk_hcp_speaker_program PRIMARY KEY(`hcp_speaker_program_id`)
) COMMENT 'Speaker bureau management and individual speaker program event records covering the full speaker lifecycle. Manages HCP enrollment in speaker bureau (speaker tier, therapeutic area, approved products, training completion, certification status, contract terms, honorarium rate, compliance certification), and individual program events (date, venue, format, audience size, spend, compliance approval, materials used). Tracks speaker training completion, programs delivered, speaker performance metrics, and generates Sunshine Act reportable transfers of value. Supports anti-kickback compliance monitoring for speaker fees and honoraria. Single source of truth for all speaker-related data. Managed in Veeva CRM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` (
    `hcp_advisory_board_id` BIGINT COMMENT 'Unique identifier for the advisory board participation record. Primary key for the HCP advisory board data product.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Advisory boards provide strategic input for market access planning, including value proposition development, HTA strategy, and payer messaging. Boards are convened to inform access strategy developmen',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Advisory board honoraria and travel reimbursements processed via AP for payment execution and compliance tracking. Required for Sunshine Act reporting, budget reconciliation, and financial audit trail',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Advisory boards are brand-specific strategic engagements for product development, launch planning, and lifecycle management. Brand linkage required for budget tracking, compliance reporting (Sunshine ',
    `contract_id` BIGINT COMMENT 'The unique identifier of the consulting agreement or contract executed with the HCP for advisory board participation. Links to contract management system for compliance audit trail.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Advisory boards are budgeted medical affairs activities requiring cost center allocation for expense tracking and budget management. Standard practice for medical affairs financial planning.',
    `inspection_readiness_id` BIGINT COMMENT 'Foreign key linking to compliance.inspection_readiness. Business justification: Advisory boards are scrutinized promotional activities requiring inspection readiness for FDA/OIG audits. Must demonstrate legitimate medical purpose, FMV compensation, appropriate participant selecti',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Advisory boards are project-based medical affairs activities tracked via internal orders for budget control, cost allocation to therapeutic areas or development programs, and financial reporting of me',
    `master_id` BIGINT COMMENT 'Foreign key reference to the healthcare professional who participated in the advisory board. Links to the HCP master data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Medical affairs employees (medical directors, therapeutic area leads) organize and manage advisory boards. Essential for advisory board planning, medical affairs activity tracking, budget management, ',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Advisory boards often convened for target-specific strategic guidance on druggability, competitive landscape, and clinical development strategy. Links expert input directly to target validation and pr',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Advisory boards provide strategic input on discovery projects including target validation, clinical development strategy, and go/no-go decisions. Essential for tracking external expert guidance that i',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Advisory boards are convened by therapeutic area for strategic pipeline input, market access strategy, and clinical development guidance. Essential for medical affairs planning and budget allocation b',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: Advisory boards frequently discuss specific trial protocols, endpoint selection, patient population definitions, and feasibility. Medical affairs and regulatory teams must track which trials were disc',
    `advisory_board_name` STRING COMMENT 'The official name or title of the advisory board or scientific advisory committee meeting.',
    `agenda_topics` STRING COMMENT 'Summary of the key topics, clinical questions, or strategic issues discussed during the advisory board meeting. Supports publication planning and medical strategy alignment.',
    `board_type` STRING COMMENT 'Classification of the advisory board format and purpose. Distinguishes between ongoing scientific advisory boards, one-time expert consultations, and specialized clinical or strategic advisory committees.. Valid values are `scientific_advisory_board|medical_advisory_board|clinical_advisory_board|strategic_advisory_board|ad_hoc_consultation|expert_panel`',
    `conflict_of_interest_disclosed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the HCP disclosed any conflicts of interest prior to advisory board participation. True if COI disclosure was completed, False otherwise. Required for compliance and publication ethics.',
    `contract_execution_date` DATE COMMENT 'The date on which the consulting contract with the HCP was fully executed by all parties. Establishes the legal basis for the engagement and payment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this advisory board participation record was first created in the system. Supports data lineage and audit trail requirements.',
    `follow_up_actions` STRING COMMENT 'Summary of agreed next steps, action items, or follow-up commitments resulting from the advisory board meeting. Supports execution tracking and strategic alignment.',
    `hcp_role` STRING COMMENT 'The specific role the HCP performed in the advisory board meeting. Distinguishes between leadership roles (chair, co-chair), general participation (member, consultant), and facilitation roles (speaker, moderator). Impacts honorarium calculation.. Valid values are `chair|co_chair|member|consultant|speaker|moderator`',
    `honorarium_amount` DECIMAL(18,2) COMMENT 'The consulting fee or honorarium paid to the HCP for their participation in the advisory board. Gross amount before tax withholding. Critical for Sunshine Act transparency reporting and anti-kickback compliance.',
    `honorarium_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the honorarium payment. Supports multi-currency operations and accurate financial reporting across global markets.. Valid values are `^[A-Z]{3}$`',
    `kol_tier` STRING COMMENT 'The strategic tier classification of the HCP as a Key Opinion Leader at the time of advisory board participation. Tier 1 represents highest influence and reach. Supports KOL engagement strategy and resource allocation.. Valid values are `tier_1|tier_2|tier_3|emerging|not_classified`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this advisory board participation record was most recently updated. Tracks data currency and change history for compliance and audit purposes.',
    `meal_accommodation_amount` DECIMAL(18,2) COMMENT 'The total value of meals and lodging provided to the HCP during the advisory board meeting. Reportable under Sunshine Act transparency requirements.',
    `meeting_city` STRING COMMENT 'The city where the advisory board meeting took place. Required for geographic analysis and regulatory transparency reporting.',
    `meeting_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the advisory board meeting was held. Supports multi-country compliance and regional engagement analysis.. Valid values are `^[A-Z]{3}$`',
    `meeting_date` DATE COMMENT 'The date on which the advisory board meeting took place. Used for tracking engagement timing and Sunshine Act reporting period assignment.',
    `meeting_end_time` TIMESTAMP COMMENT 'The precise timestamp when the advisory board meeting concluded. Used to calculate meeting duration and HCP time commitment.',
    `meeting_format` STRING COMMENT 'The delivery format of the advisory board meeting. Distinguishes between face-to-face meetings, virtual/remote participation, and hybrid models combining both.. Valid values are `in_person|virtual|hybrid`',
    `meeting_location` STRING COMMENT 'The physical location or venue where the advisory board meeting was held. For virtual meetings, may indicate platform or note as virtual. Supports Sunshine Act venue reporting.',
    `meeting_minutes_document_reference` STRING COMMENT 'Reference identifier to the official meeting minutes or summary document stored in the document management system (e.g., Veeva Vault). Provides audit trail and detailed record linkage.',
    `meeting_objectives` STRING COMMENT 'The stated business or scientific objectives for convening the advisory board. Documents the strategic rationale and expected outcomes from HCP engagement.',
    `meeting_start_time` TIMESTAMP COMMENT 'The precise timestamp when the advisory board meeting commenced. Supports detailed engagement tracking and time-based compliance reporting.',
    `participation_status` STRING COMMENT 'The actual participation outcome for the HCP. Distinguishes between confirmed attendance, cancellations, no-shows, and declined invitations. Impacts payment processing and engagement metrics.. Valid values are `attended|cancelled|no_show|declined`',
    `product_discussed` STRING COMMENT 'The investigational or marketed drug product that was the focus of the advisory board discussion. May reference INN, brand name, or development code.',
    `record_source_system` STRING COMMENT 'The name of the operational system from which this advisory board record originated (e.g., Veeva CRM, Salesforce Health Cloud). Supports data lineage and system-of-record identification.',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Boolean indicator of whether this advisory board participation and associated payments must be reported under the Physician Payments Sunshine Act. True if reportable, False if exempt or below threshold.',
    `sunshine_act_reporting_year` STRING COMMENT 'The calendar year in which this advisory board payment must be reported to CMS Open Payments database. Determined by payment date, not meeting date.',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The aggregate value of all payments and transfers of value to the HCP for this advisory board participation, including honorarium, travel, meals, and accommodations. Used for consolidated Sunshine Act reporting.',
    `travel_reimbursement_amount` DECIMAL(18,2) COMMENT 'The amount reimbursed to the HCP for travel expenses related to advisory board participation. Separate from honorarium. Must be reported under Sunshine Act if applicable.',
    CONSTRAINT pk_hcp_advisory_board PRIMARY KEY(`hcp_advisory_board_id`)
) COMMENT 'Advisory board and scientific advisory committee records capturing HCP participation in company-sponsored advisory activities. Captures board name, therapeutic area, meeting date, meeting format, HCP role (chair, member, consultant), honorarium paid, topics discussed, and medical affairs owner. Supports KOL engagement strategy, publication planning, and Sunshine Act reporting for consulting fees.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` (
    `med_info_request_id` BIGINT COMMENT 'Unique identifier for the medical information request. Primary key.',
    `compound_id` BIGINT COMMENT 'Reference to the investigational compound or active pharmaceutical ingredient (API) referenced in the request, if applicable.',
    `icsr_id` BIGINT COMMENT 'Reference to the individual case safety report (ICSR) or adverse event case created as a result of this medical information request.',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional who submitted the medical information request.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the drug product or compound that the medical information request pertains to.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Medical information specialists (employees) respond to HCP medical inquiries. Required for medical information response tracking, workload management, quality metrics, turnaround time analysis, and re',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Medical information requests are categorized and routed by therapeutic area for expert assignment, response time tracking, and trend analysis. Essential for medical affairs resource planning and pharm',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: Medical information requests from HCPs frequently reference specific clinical trials (efficacy data, safety profiles, inclusion/exclusion criteria, enrollment status). Regulatory requires traceability',
    `adverse_event_flag` BOOLEAN COMMENT 'Indicates whether the medical information request contained or led to the identification of a potential adverse event requiring pharmacovigilance follow-up.',
    `approval_date` DATE COMMENT 'Date when the medical information response was approved for delivery to the healthcare professional.',
    `approved_by` STRING COMMENT 'Name or identifier of the medical director or senior medical affairs professional who approved the medical information response before delivery.',
    `assigned_to` STRING COMMENT 'Name or identifier of the medical information specialist or medical affairs team member assigned to handle the request.',
    `congress_date` DATE COMMENT 'Date of the medical congress or scientific meeting where the request was received.',
    `congress_name` STRING COMMENT 'Name of the medical congress or scientific meeting where the request was received, if applicable.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the medical information request was escalated to senior medical affairs leadership or pharmacovigilance for adverse event (AE) follow-up.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the medical information request, such as potential adverse event, off-label inquiry requiring legal review, or complex clinical question.',
    `follow_up_date` DATE COMMENT 'Scheduled or actual date for follow-up contact with the healthcare professional regarding the medical information request.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up with the healthcare professional is required after the initial response.',
    `hcp_specialty` STRING COMMENT 'Medical specialty of the healthcare professional who submitted the request (e.g., oncology, cardiology, neurology).',
    `literature_references` STRING COMMENT 'Citations or references to published clinical literature, prescribing information, or regulatory documents used in the medical information response.',
    `off_label_inquiry_flag` BOOLEAN COMMENT 'Indicates whether the medical information request pertained to an off-label use of the product not covered by approved labeling.',
    `question_category` STRING COMMENT 'Classification of the medical information question type (clinical efficacy, safety and tolerability, dosing and administration, off-label use, pharmacokinetics, drug interaction, or contraindication). [ENUM-REF-CANDIDATE: clinical_efficacy|safety_tolerability|dosing_administration|off_label_use|pharmacokinetics|drug_interaction|contraindication — 7 candidates stripped; promote to reference product]',
    `question_text` STRING COMMENT 'Full text of the medical information question submitted by the healthcare professional.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this medical information request record was first created in the data system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this medical information request record was last updated in the data system.',
    `request_channel` STRING COMMENT 'Channel through which the medical information request was received (phone, email, congress, field interaction, web portal, or fax).. Valid values are `phone|email|congress|field|web_portal|fax`',
    `request_date` DATE COMMENT 'Date when the medical information request was received by the medical affairs or medical information team.',
    `request_number` STRING COMMENT 'Business identifier for the medical information request, externally visible and used for tracking and reference.. Valid values are `^MIR-[0-9]{8}$`',
    `request_priority` STRING COMMENT 'Priority level assigned to the medical information request based on urgency and clinical need.. Valid values are `routine|urgent|critical`',
    `request_status` STRING COMMENT 'Current lifecycle status of the medical information request (received, in review, pending approval, responded, closed, or escalated).. Valid values are `received|in_review|pending_approval|responded|closed|escalated`',
    `request_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the medical information request was logged in the system.',
    `requester_country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the healthcare professional who submitted the request is located.. Valid values are `^[A-Z]{3}$`',
    `response_date` DATE COMMENT 'Date when the medical information response was provided to the healthcare professional.',
    `response_text` STRING COMMENT 'Full text of the medical information response provided to the healthcare professional, including references to clinical data and approved labeling.',
    `response_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the medical information response was sent or delivered.',
    `response_turnaround_hours` DECIMAL(18,2) COMMENT 'Number of hours elapsed between request receipt and response delivery, used for service level agreement (SLA) tracking.',
    `source_system` STRING COMMENT 'Name of the source system from which the medical information request was captured (e.g., Veeva Vault MedComms, email system, call center platform).',
    CONSTRAINT pk_med_info_request PRIMARY KEY(`med_info_request_id`)
) COMMENT 'Medical information requests submitted by HCPs to the medical affairs or medical information team. Captures request channel (phone, email, congress, field), product or compound referenced, question category (clinical, safety, dosing, off-label), response provided, response date, HCP specialty, and escalation status. Supports pharmacovigilance signal detection (AE follow-up) and medical affairs reporting. Sourced from Veeva Vault MedComms.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the HCP contract record. Primary key for the contract entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: HCP contracts specify brand-specific services (speaker programs, advisory boards, consulting). Brand linkage essential for FMV compliance, budget allocation, Sunshine Act reporting, and brand promotio',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: HCP contracts consume budget allocations for medical affairs, clinical operations, and commercial activities. Essential for budget planning, variance tracking, commitment reporting, and ensuring contr',
    `employee_id` BIGINT COMMENT 'Reference to the compliance officer who approved this contract. Supports accountability and audit requirements.',
    `contract_legal_reviewer_employee_id` BIGINT COMMENT 'Reference to the legal counsel who reviewed this contract. Supports accountability and audit requirements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Contract costs (honoraria, consulting fees) must be allocated to cost centers for budget tracking, accrual management, and financial reporting. Standard pharma contract expense management.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: HCP contracts should link to finance accounts payable for HCP payment processing and financial tracking. This enables integrated HCP engagement and payment management with proper financial controls.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: HCP service contracts (consulting, advisory, speaking) are often charged to project-specific internal orders for cost allocation to clinical trials, brand campaigns, or therapeutic area programs. Crit',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Contracts must be executed by a specific legal entity with signing authority. Legal and compliance requirement for contract validity, liability management, and regulatory reporting.',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: HCP consulting contracts for licensed products must reference the licensing agreement to ensure compliance with licensor obligations (e.g., approval rights, payment allocation), royalty base calculati',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional who is party to this contract. Links to the HCP master data entity.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the internal employee responsible for managing this contract. Typically a medical affairs or commercial operations manager.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: HCP contracts for speaker bureaus, advisory boards, and consulting must be governed by specific compliance programs to ensure Sunshine Act reporting, FMV compliance, and regulatory oversight. Every HC',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: HCP contracts scope services by therapeutic area for fair market value determination, compliance review, and spend tracking. Required for Sunshine Act reporting and aggregate spend analysis by franchi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: HCPs providing paid services (consulting, speaking, advisory) are often set up as vendors in procurement systems for payment processing, compliance tracking, and vendor management. Standard pharma pra',
    `annual_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total compensation in USD that can be paid to the HCP under this contract in a calendar year. Enforces anti-kickback compliance and prevents excessive payments.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for this contract. Used for cost allocation and organizational reporting.',
    `compliance_approval_date` DATE COMMENT 'Date when the compliance department approved this contract. Required for audit trails and regulatory inspections.',
    `compliance_approval_status` STRING COMMENT 'Status of compliance review for this contract. Must be approved before contract execution and payment processing.. Valid values are `pending|approved|rejected|conditional`',
    `contract_number` STRING COMMENT 'Externally-visible unique business identifier for the contract. Used for legal reference, payment processing, and audit trails.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract. Controls whether payments can be processed and services can be rendered.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `contract_type` STRING COMMENT 'Classification of the contract based on the nature of services provided by the HCP. Determines applicable compliance rules and FMV benchmarks.. Valid values are `consulting|advisory_board|speaker_program|clinical_research|medical_education|key_opinion_leader`',
    `cost_center` STRING COMMENT 'SAP cost center code to which contract expenses are charged. Used for financial reporting and budget tracking.. Valid values are `^[0-9]{6,10}$`',
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

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` (
    `hcp_publication_id` BIGINT COMMENT 'Unique identifier for the HCP publication record. Primary key for the publication entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Publications mentioning company products require brand linkage for KOL identification, medical affairs monitoring, competitive intelligence, and brand strategy. Tracks scientific evidence supporting b',
    `trial_id` BIGINT COMMENT 'Clinical trial registry identifier (e.g., ClinicalTrials.gov NCT number) if the publication reports results from a registered clinical trial.',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional who authored or co-authored this publication. Links to the HCP master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Medical affairs employees track and analyze HCP publications for scientific intelligence and KOL profiling. Required for publication tracking workflows, KOL tier assessment, competitive intelligence, ',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Publications often focus on specific molecular targets; essential for KOL identification, competitive intelligence, and scientific landscape monitoring. Medical affairs tracks target-specific thought ',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: KOL publications citing company patents are tracked for lifecycle management, competitive intelligence, and thought leader assessment. Publications demonstrating patent relevance inform speaker bureau',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Publications are classified by therapeutic area for KOL mapping, scientific landscape analysis, and competitive intelligence. Critical for identifying thought leaders and tracking scientific discourse',
    `abstract_text` STRING COMMENT 'Full text of the publication abstract. Used for natural language processing, topic modeling, and competitive intelligence analysis.',
    `affiliation_at_publication` STRING COMMENT 'Institutional affiliation of the HCP as listed in the publication byline at the time of publication. May differ from current affiliation in HCP master data.',
    `author_order` STRING COMMENT 'Numeric position of the HCP in the author list (1 = first author, 2 = second author, etc.). First and last author positions typically indicate greater contribution and influence.',
    `citation_count` STRING COMMENT 'Number of times this publication has been cited by other peer-reviewed articles. Used to assess KOL influence and publication impact.',
    `company_product_mentioned` STRING COMMENT 'Name of the company product (brand name or INN) mentioned or studied in the publication. May be null if publication is not product-specific.',
    `company_sponsored_flag` BOOLEAN COMMENT 'Indicates whether the publication was sponsored, funded, or supported by the company. Critical for Sunshine Act transparency reporting and compliance.',
    `conflict_of_interest_disclosed` BOOLEAN COMMENT 'Indicates whether the HCP disclosed a conflict of interest or financial relationship with the company in the publication. Required for transparency and compliance.',
    `corresponding_author_flag` BOOLEAN COMMENT 'Indicates whether the HCP is the corresponding author for this publication. Corresponding authors are primary contacts and typically have leadership roles.',
    `country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the journal or conference location. Used for geographic analysis of KOL influence.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source system or database from which the publication record was ingested (e.g., PubMed, Scopus, Web of Science, manual entry).',
    `doi` STRING COMMENT 'Persistent digital identifier for the publication used for permanent linking and citation. Format: 10.xxxx/xxxxx.. Valid values are `^10.[0-9]{4,}/[-._;()/:A-Za-z0-9]+$`',
    `external_source_code` STRING COMMENT 'Unique identifier from the external source system. Used for deduplication and reconciliation with external databases.',
    `impact_factor` DECIMAL(18,2) COMMENT 'Journal Impact Factor (JIF) at the time of publication. Measures the average number of citations to articles published in the journal. Higher values indicate greater influence.',
    `journal_name` STRING COMMENT 'Name of the peer-reviewed journal, conference proceedings, or publication venue where the article was published.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or MeSH terms associated with the publication. Used for search, categorization, and topic analysis.',
    `kol_tier_at_publication` STRING COMMENT 'KOL tier classification of the HCP at the time of publication. Captures historical KOL status for longitudinal influence tracking.. Valid values are `tier 1|tier 2|tier 3|not classified`',
    `language` STRING COMMENT 'ISO 639-2 three-letter language code of the publication. Used for filtering and regional relevance assessment.. Valid values are `^[A-Z]{3}$`',
    `open_access_flag` BOOLEAN COMMENT 'Indicates whether the publication is available as open access (freely accessible to the public without subscription).',
    `peer_reviewed_flag` BOOLEAN COMMENT 'Indicates whether the publication underwent formal peer review before acceptance. Peer-reviewed publications carry higher scientific credibility.',
    `product_relevance` STRING COMMENT 'Assessment of how relevant this publication is to the companys marketed or pipeline products. Used for competitive intelligence and medical affairs strategy.. Valid values are `high|medium|low|none`',
    `publication_date` DATE COMMENT 'Date when the article was officially published or made available online. Format: yyyy-MM-dd.',
    `publication_status` STRING COMMENT 'Current lifecycle status of the publication. Tracks whether the article is officially published, pending, or has been retracted or corrected.. Valid values are `published|in press|preprint|retracted|corrected`',
    `publication_type` STRING COMMENT 'Classification of the publication based on its content and format. Determines the level of evidence and influence in medical affairs planning. [ENUM-REF-CANDIDATE: original research|review article|systematic review|meta-analysis|case report|editorial|commentary|letter to editor — 8 candidates stripped; promote to reference product]',
    `pubmed_number` STRING COMMENT 'Unique identifier assigned by the National Library of Medicine PubMed database. Used for citation tracking and literature searches.. Valid values are `^[0-9]{1,8}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this publication record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this publication record was last updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `title` STRING COMMENT 'Full title of the scientific publication as it appears in the journal or conference proceedings.',
    `url` STRING COMMENT 'Direct URL link to the full-text publication on the publishers website or repository.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_hcp_publication PRIMARY KEY(`hcp_publication_id`)
) COMMENT 'Scientific publications authored or co-authored by KOLs and HCPs relevant to the companys therapeutic areas. Captures publication title, journal name, publication date, PubMed ID, DOI, publication type (original research, review, case report, editorial), therapeutic area, product relevance, author order, and company-sponsored flag. Supports medical affairs publication planning, KOL influence mapping, and competitive intelligence.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` (
    `investigator_id` BIGINT COMMENT 'Unique identifier for the clinical trial investigator record. Primary key for the investigator data product.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Clinical investigator payments and site costs are budgeted at trial level for financial planning, commitment tracking, and variance analysis. Essential for clinical trial budget management and ensurin',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Clinical Research Associates (CRAs) and clinical managers (employees) manage investigator relationships and site oversight. Essential for investigator management, site monitoring assignments, clinical',
    `debarment_check_id` BIGINT COMMENT 'Foreign key linking to compliance.debarment_check. Business justification: Clinical trial investigators require mandatory FDA debarment and OIG exclusion screening per 21 CFR 312.68. Links investigator qualification to their screening record for GCP compliance, regulatory in',
    `master_id` BIGINT COMMENT 'Foreign key reference to the HCP master data product. Links the investigator record to the underlying healthcare professional identity.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Clinical operations organizational units manage investigator relationships and trial site oversight. Required for operational accountability, resource allocation, and performance management in clinica',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Clinical investigators named as inventors on patents arising from company-sponsored research require tracking for IP ownership verification, inventor compensation obligations, Sunshine Act reporting, ',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Investigators are qualified and tracked by therapeutic area expertise for clinical trial site selection, feasibility assessment, and investigator database management. Essential for clinical operations',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Clinical investigators are identified and qualified during discovery phase for future trial readiness. Tracks investigator pipeline from preclinical through IND-enabling studies, supporting seamless t',
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
    `secondary_therapeutic_area` STRING COMMENT 'Secondary therapeutic area of expertise for the investigator. Supports cross-functional trial assignments.',
    `serious_protocol_deviation_count` STRING COMMENT 'Number of serious protocol deviations reported for this investigator. Serious deviations may impact subject safety or data integrity.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether payments or transfers of value to this investigator must be reported under the Physician Payments Sunshine Act (Open Payments).',
    `total_subjects_enrolled` STRING COMMENT 'Cumulative number of subjects enrolled by this investigator across all trials. Key performance indicator for investigator productivity.',
    `total_trials_conducted` STRING COMMENT 'Total number of clinical trials the investigator has conducted as PI or sub-investigator. Performance metric for investigator selection.',
    CONSTRAINT pk_investigator PRIMARY KEY(`investigator_id`)
) COMMENT 'Clinical trial investigator records for HCPs serving as principal investigators (PIs) or sub-investigators on company-sponsored or investigator-initiated trials. Captures investigator role, GCP training status, CV on file, financial disclosure (Form FDA 3455), IRB approval status, site affiliation, therapeutic area expertise, enrollment performance metrics, and trial participation history. Provides the HCP-domain view of investigator identity and qualifications; clinical trial operational data (protocol, enrollment, visits) resides in the clinical domain. Supports regulatory submissions (Form FDA 1572) and clinical operations planning.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` (
    `engagement_id` BIGINT COMMENT 'Primary key for engagement',
    CONSTRAINT pk_engagement PRIMARY KEY(`engagement_id`)
) COMMENT 'This association product represents the operational relationship between healthcare professionals and pharmaceutical company employees (MSLs, medical directors, clinical scientists) in medical affairs field operations. It captures the ongoing professional engagement relationship including therapeutic area focus, interaction patterns, relationship strength metrics, and territory assignments. Each record links one HCP to one employee with attributes that exist only in the context of this professional engagement relationship.. Existence Justification: In pharmaceutical medical affairs operations, multiple employees (MSLs, medical directors, clinical scientists) simultaneously maintain distinct professional engagement relationships with the same HCP across different therapeutic areas, territories, and functional roles. Conversely, each employee manages ongoing relationships with multiple HCPs as part of their territory assignment. The business actively manages these relationships as operational entities with specific attributes (relationship type, therapeutic area focus, engagement frequency, strength scoring, territory assignment, primary contact designation) that belong to neither the HCP nor the employee alone but to the relationship itself.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` (
    `speaker_program_presentation_id` BIGINT COMMENT 'Unique identifier for this speaker program presentation record. Primary key.',
    `hcp_speaker_program_id` BIGINT COMMENT 'Foreign key linking to the HCP speaker program record that represents the speaker bureau enrollment and event',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to the medicinal product that was presented during this speaker program event',
    `approved_product_list` STRING COMMENT 'Comma-separated list of drug products the speaker is certified and approved to present on. Must align with training completion and medical expertise. [Moved from hcp_speaker_program: This comma-separated list should be decomposed into individual speaker-product relationships. Each approved product becomes a record in the association, eliminating the need for a denormalized list in the speaker program entity.]',
    `audience_size` STRING COMMENT 'Number of healthcare professionals who attended this specific product presentation. Used for reach metrics and compliance reporting.',
    `audience_type` STRING COMMENT 'Classification of the audience composition. Examples include physicians, pharmacists, nurses, or mixed healthcare professionals. [Moved from hcp_speaker_program: Audience type is specific to each speaker-product presentation event.]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this presentation record was created in the system.',
    `event_date` DATE COMMENT 'Date when the individual speaker program event was held. Principal business event timestamp for the program delivery. [Moved from hcp_speaker_program: Event date is specific to each speaker-product presentation combination. When a speaker presents on multiple products in the same event or presents on the same product multiple times, each presentation has its own date.]',
    `event_end_time` TIMESTAMP COMMENT 'Timestamp when the speaker program event concluded. Used for calculating event duration and compliance reporting. [Moved from hcp_speaker_program: End time is specific to each individual product presentation, not the overall speaker program enrollment.]',
    `event_format` STRING COMMENT 'Format of the speaker program event delivery. Determines logistics, compliance requirements, and audience engagement tracking. [Moved from hcp_speaker_program: Event format (in-person, virtual, hybrid) is specific to each speaker-product presentation.]. Valid values are `in_person|virtual|hybrid`',
    `event_start_time` TIMESTAMP COMMENT 'Timestamp when the speaker program event started. Used for detailed event tracking and compliance documentation. [Moved from hcp_speaker_program: Start time is specific to each individual product presentation, not the overall speaker program enrollment.]',
    `honorarium_paid` DECIMAL(18,2) COMMENT 'Actual honorarium payment amount for this specific product presentation. Required for Sunshine Act transfer of value reporting.',
    `materials_used` STRING COMMENT 'MLR-approved presentation materials and slide decks used for this specific product presentation. Required for compliance audit trail.',
    `mlr_approval_number` STRING COMMENT 'Medical, Legal, Regulatory approval number for the materials used in this specific product presentation. Required for promotional compliance.',
    `presentation_date` DATE COMMENT 'Date when the speaker presented on this specific medicinal product. Principal business event date for this presentation.',
    `speaker_performance_rating` STRING COMMENT 'Performance evaluation for this specific product presentation. Used for speaker tier management and future program planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this presentation record was last updated.',
    `venue` STRING COMMENT 'Location or facility where this specific product presentation was delivered. Includes venue name and address details.',
    `venue_address` STRING COMMENT 'Full street address of the venue where the speaker program event was held. Required for Sunshine Act geographic reporting. [Moved from hcp_speaker_program: Venue address is specific to each speaker-product presentation event.]',
    `venue_city` STRING COMMENT 'City where the speaker program event venue is located. Used for geographic analysis and compliance reporting. [Moved from hcp_speaker_program: Venue city is specific to each speaker-product presentation event.]',
    `venue_country_code` STRING COMMENT 'Three-letter ISO 3166 country code for the venue location. Supports international speaker programs and compliance reporting. [Moved from hcp_speaker_program: Venue country is specific to each speaker-product presentation event.]. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'Name of the location or facility where the speaker program event was held. Examples include hospital conference rooms, hotels, or virtual platforms. [Moved from hcp_speaker_program: Venue is specific to each speaker-product presentation event. Different products may be presented at different venues.]',
    `venue_state_province` STRING COMMENT 'State or province where the speaker program event venue is located. Required for Sunshine Act state-level reporting. [Moved from hcp_speaker_program: Venue state/province is specific to each speaker-product presentation event.]',
    CONSTRAINT pk_speaker_program_presentation PRIMARY KEY(`speaker_program_presentation_id`)
) COMMENT 'This association product represents the Event between hcp_speaker_program and medicinal_product. It captures individual speaker program events where an HCP presents on a specific medicinal product. Each record links one speaker program event to one medicinal product with attributes that exist only in the context of this specific presentation: venue details, audience metrics, honorarium paid, materials used, and compliance approvals. Supports Sunshine Act reporting and anti-kickback compliance monitoring.. Existence Justification: In pharmaceutical speaker bureau operations, HCPs are enrolled to present on multiple medicinal products, and each medicinal product is presented by multiple speakers across different events. The business actively manages individual speaker program presentations as distinct operational entities, tracking venue, audience, honorarium, performance ratings, and MLR-approved materials for each speaker-product-event combination. This is a true operational M:N relationship recognized as Speaker Program Presentations or Program Events in the business.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ADD CONSTRAINT `fk_hcp_license_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_affiliation_affiliated_hcp_physician_master_id` FOREIGN KEY (`affiliation_affiliated_hcp_physician_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ADD CONSTRAINT `fk_hcp_hcp_kol_profile_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`engagement`(`engagement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ADD CONSTRAINT `fk_hcp_consent_record_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ADD CONSTRAINT `fk_hcp_prescribing_pattern_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ADD CONSTRAINT `fk_hcp_med_info_request_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ADD CONSTRAINT `fk_hcp_hcp_publication_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ADD CONSTRAINT `fk_hcp_speaker_program_presentation_hcp_speaker_program_id` FOREIGN KEY (`hcp_speaker_program_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program`(`hcp_speaker_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`hcp` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `pharmaceuticals_ecm`.`hcp` SET TAGS ('dbx_domain' = 'hcp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Master Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `secondary_specialty` SET TAGS ('dbx_business_glossary_term' = 'Secondary Medical Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|not_accredited|pending|expired');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `specialty_focus` SET TAGS ('dbx_business_glossary_term' = 'Specialty Focus');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `contract_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Msl Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `hcp_kol_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Key Opinion Leader (KOL) Profile ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Owner Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `academic_rank` SET TAGS ('dbx_business_glossary_term' = 'Academic Rank');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `advisory_board_participation_count` SET TAGS ('dbx_business_glossary_term' = 'Advisory Board Participation Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `clinical_trial_investigator_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Investigator Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `compliance_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Clearance Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `compliance_clearance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Clearance Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `compliance_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Clearance Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `compliance_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|excluded|expired');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `conflict_of_interest_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Disclosure');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `conflict_of_interest_disclosure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `congress_speaking_count` SET TAGS ('dbx_business_glossary_term' = 'Congress Speaking Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `department_chair_flag` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `fellowship_institution` SET TAGS ('dbx_business_glossary_term' = 'Fellowship Institution');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `guideline_authorship_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Guideline Authorship Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `h_index` SET TAGS ('dbx_business_glossary_term' = 'H-Index');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `kol_status` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `kol_status` SET TAGS ('dbx_value_regex' = 'active|under_review|suspended|retired|deceased');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `kol_tier` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Tier Classification');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `kol_tier` SET TAGS ('dbx_value_regex' = 'national|regional|local|emerging|inactive');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `last_congress_speaking_date` SET TAGS ('dbx_business_glossary_term' = 'Last Congress Speaking Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `last_msl_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Medical Science Liaison (MSL) Interaction Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `last_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Last Publication Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `medical_school` SET TAGS ('dbx_business_glossary_term' = 'Medical School');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `medical_school` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `medical_school` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `msl_engagement_strategy` SET TAGS ('dbx_business_glossary_term' = 'Medical Science Liaison (MSL) Engagement Strategy');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `msl_engagement_strategy` SET TAGS ('dbx_value_regex' = 'high_priority|medium_priority|low_priority|monitor_only|do_not_contact');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `orcid_number` SET TAGS ('dbx_business_glossary_term' = 'Open Researcher and Contributor ID (ORCID)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `orcid_number` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}-d{4}-d{3}[0-9X]$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `peer_reviewed_publication_count` SET TAGS ('dbx_business_glossary_term' = 'Peer-Reviewed Publication Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `primary_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Primary Affiliation');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `principal_investigator_trial_count` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Trial Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `profile_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated By');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `scopus_author_number` SET TAGS ('dbx_business_glossary_term' = 'Scopus Author ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `secondary_therapeutic_areas` SET TAGS ('dbx_business_glossary_term' = 'Secondary Therapeutic Areas');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `society_leadership_flag` SET TAGS ('dbx_business_glossary_term' = 'Society Leadership Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `society_membership_list` SET TAGS ('dbx_business_glossary_term' = 'Professional Society Membership List');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `total_citation_count` SET TAGS ('dbx_business_glossary_term' = 'Total Citation Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ALTER COLUMN `total_msl_interaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Medical Science Liaison (MSL) Interaction Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` SET TAGS ('dbx_subdomain' = 'field_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `hcp_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'HCP Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Msl Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `adverse_event_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Reported Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `call_objective` SET TAGS ('dbx_business_glossary_term' = 'Call Objective');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'face_to_face|virtual|phone|email|congress|event');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `compliance_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Time');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_value_regex' = '^ENG-[0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'planned|completed|cancelled|no_show|rescheduled');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Engagement Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `hcp_feedback` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Feedback');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `key_message_delivered` SET TAGS ('dbx_business_glossary_term' = 'Key Message Delivered');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Engagement Location');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `materials_shared` SET TAGS ('dbx_business_glossary_term' = 'Materials Shared');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `medical_inquiry_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Inquiry Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `medical_inquiry_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `medical_inquiry_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Action');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Engagement Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|follow_up_required|no_interest');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `relationship_strength_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength Score');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `samples_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Samples Provided Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'veeva_crm|salesforce_health_cloud|manual_entry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Time');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `territory_assignment` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `transfer_of_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer of Value Amount');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `transfer_of_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `transfer_of_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Transfer of Value Currency');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ALTER COLUMN `transfer_of_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` SET TAGS ('dbx_subdomain' = 'field_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` SET TAGS ('dbx_subdomain' = 'field_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `privacy_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Obligation Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Restriction Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'dnc|no_see|legal_hold|compliance|channel');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `veeva_crm_sync_flag` SET TAGS ('dbx_business_glossary_term' = 'Veeva Customer Relationship Management (CRM) Sync Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `veeva_crm_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Veeva Customer Relationship Management (CRM) Sync Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `sunshine_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Transfer ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare & Medicaid Services (CMS) Submission ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Disclosure Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `third_party_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Recipient Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `third_party_recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ALTER COLUMN `third_party_recipient_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `prescribing_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Pattern ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `coverage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `market_formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Formulary Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `average_days_supply` SET TAGS ('dbx_business_glossary_term' = 'Average Days Supply');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `brand_prescriptions` SET TAGS ('dbx_business_glossary_term' = 'Brand Prescriptions');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `brand_vs_generic_ratio` SET TAGS ('dbx_business_glossary_term' = 'Brand vs Generic Ratio');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `competitive_product_prescriptions` SET TAGS ('dbx_business_glossary_term' = 'Competitive Product Prescriptions');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'confidential|internal');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `data_provider` SET TAGS ('dbx_business_glossary_term' = 'Data Provider');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `data_provider` SET TAGS ('dbx_value_regex' = 'IQVIA|Symphony Health|Surescripts|Other');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `data_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Data Refresh Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `data_source_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Data Source Coverage Percent');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `decile_classification` SET TAGS ('dbx_business_glossary_term' = 'Decile Classification');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'preferred|formulary|non_formulary|restricted|prior_auth_required|unknown');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `generic_prescriptions` SET TAGS ('dbx_business_glossary_term' = 'Generic Prescriptions');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `geography_level` SET TAGS ('dbx_business_glossary_term' = 'Geography Level');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `geography_level` SET TAGS ('dbx_value_regex' = 'national|regional|state|territory|zip3|zip5');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `is_key_opinion_leader` SET TAGS ('dbx_business_glossary_term' = 'Is Key Opinion Leader (KOL)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `market_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Market Share Percent');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `new_prescriptions_nrx` SET TAGS ('dbx_business_glossary_term' = 'New Prescriptions (NRx)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `patient_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Patient Count Estimate');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `prescribing_channel` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Channel');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `prescribing_channel` SET TAGS ('dbx_value_regex' = 'retail|specialty|mail_order|hospital|mixed');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `prescribing_rank_national` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Rank National');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `prescribing_rank_regional` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Rank Regional');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `prescribing_trend` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Trend');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `prescribing_trend` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|new_prescriber|inactive');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `prior_authorization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Rate Percent');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `projection_method` SET TAGS ('dbx_business_glossary_term' = 'Projection Method');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `projection_method` SET TAGS ('dbx_value_regex' = 'actual|projected|extrapolated|modeled');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `refill_prescriptions` SET TAGS ('dbx_business_glossary_term' = 'Refill Prescriptions');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `total_prescriptions_trx` SET TAGS ('dbx_business_glossary_term' = 'Total Prescriptions (TRx)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ALTER COLUMN `total_units_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Total Units Prescribed');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `hcp_speaker_program_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Speaker Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `inspection_readiness_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Readiness Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `audience_size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending_recertification|not_certified');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `compliance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_value_regex' = 'current|expired|pending|not_completed');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|training_required');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `honorarium_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `honorarium_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `honorarium_paid_usd` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Paid (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `honorarium_paid_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `honorarium_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Rate (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `honorarium_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `materials_used` SET TAGS ('dbx_business_glossary_term' = 'Materials Used');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `mlr_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Legal Regulatory (MLR) Approval Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `program_event_number` SET TAGS ('dbx_business_glossary_term' = 'Program Event Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `programs_delivered_count` SET TAGS ('dbx_business_glossary_term' = 'Programs Delivered Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `speaker_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Speaker Performance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `speaker_tier` SET TAGS ('dbx_business_glossary_term' = 'Speaker Tier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `speaker_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|regional|national|international');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `sunshine_act_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reported Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `total_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Spend (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `total_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ALTER COLUMN `training_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `hcp_advisory_board_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Advisory Board ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `inspection_readiness_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Readiness Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Owner Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `advisory_board_name` SET TAGS ('dbx_business_glossary_term' = 'Advisory Board Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `agenda_topics` SET TAGS ('dbx_business_glossary_term' = 'Agenda Topics');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `board_type` SET TAGS ('dbx_business_glossary_term' = 'Advisory Board Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `board_type` SET TAGS ('dbx_value_regex' = 'scientific_advisory_board|medical_advisory_board|clinical_advisory_board|strategic_advisory_board|ad_hoc_consultation|expert_panel');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `conflict_of_interest_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Disclosed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `contract_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `hcp_role` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Role');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `hcp_role` SET TAGS ('dbx_value_regex' = 'chair|co_chair|member|consultant|speaker|moderator');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `honorarium_amount` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Amount');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `honorarium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `honorarium_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `honorarium_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `kol_tier` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Tier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `kol_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|emerging|not_classified');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meal_accommodation_amount` SET TAGS ('dbx_business_glossary_term' = 'Meal and Accommodation Amount');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meal_accommodation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_city` SET TAGS ('dbx_business_glossary_term' = 'Meeting City');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_country_code` SET TAGS ('dbx_business_glossary_term' = 'Meeting Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_end_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting End Time');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_format` SET TAGS ('dbx_business_glossary_term' = 'Meeting Format');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_format` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_minutes_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Meeting Minutes Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_objectives` SET TAGS ('dbx_business_glossary_term' = 'Meeting Objectives');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `meeting_start_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting Start Time');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'attended|cancelled|no_show|declined');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `product_discussed` SET TAGS ('dbx_business_glossary_term' = 'Product Discussed');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `sunshine_act_reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reporting Year');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `travel_reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Travel Reimbursement Amount');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ALTER COLUMN `travel_reimbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `med_info_request_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Request ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `icsr_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Case ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responder Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `congress_date` SET TAGS ('dbx_business_glossary_term' = 'Congress Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `congress_name` SET TAGS ('dbx_business_glossary_term' = 'Congress Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `hcp_specialty` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `literature_references` SET TAGS ('dbx_business_glossary_term' = 'Literature References');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `off_label_inquiry_flag` SET TAGS ('dbx_business_glossary_term' = 'Off-Label Inquiry Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `question_category` SET TAGS ('dbx_business_glossary_term' = 'Question Category');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `question_text` SET TAGS ('dbx_business_glossary_term' = 'Question Text');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `question_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_value_regex' = 'phone|email|congress|field|web_portal|fax');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Request Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^MIR-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_priority` SET TAGS ('dbx_business_glossary_term' = 'Request Priority');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'received|in_review|pending_approval|responded|closed|escalated');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `requester_country_code` SET TAGS ('dbx_business_glossary_term' = 'Requester Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `requester_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `response_text` SET TAGS ('dbx_business_glossary_term' = 'Response Text');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `response_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `response_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Turnaround Hours');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Contract Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approver Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_legal_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_legal_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `contract_legal_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `hcp_publication_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Publication Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Analyst Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `abstract_text` SET TAGS ('dbx_business_glossary_term' = 'Publication Abstract Text');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `affiliation_at_publication` SET TAGS ('dbx_business_glossary_term' = 'HCP Affiliation at Publication');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `author_order` SET TAGS ('dbx_business_glossary_term' = 'Author Order Position');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `citation_count` SET TAGS ('dbx_business_glossary_term' = 'Citation Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `company_product_mentioned` SET TAGS ('dbx_business_glossary_term' = 'Company Product Mentioned');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `company_sponsored_flag` SET TAGS ('dbx_business_glossary_term' = 'Company Sponsored Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `conflict_of_interest_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Disclosed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `corresponding_author_flag` SET TAGS ('dbx_business_glossary_term' = 'Corresponding Author Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Publication Country');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `doi` SET TAGS ('dbx_value_regex' = '^10.[0-9]{4,}/[-._;()/:A-Za-z0-9]+$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `external_source_code` SET TAGS ('dbx_business_glossary_term' = 'External Source Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `impact_factor` SET TAGS ('dbx_business_glossary_term' = 'Journal Impact Factor');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `journal_name` SET TAGS ('dbx_business_glossary_term' = 'Journal Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Publication Keywords');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `kol_tier_at_publication` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Tier at Publication');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `kol_tier_at_publication` SET TAGS ('dbx_value_regex' = 'tier 1|tier 2|tier 3|not classified');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Publication Language');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `open_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Access Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `peer_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `product_relevance` SET TAGS ('dbx_business_glossary_term' = 'Product Relevance');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `product_relevance` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'published|in press|preprint|retracted|corrected');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `publication_type` SET TAGS ('dbx_business_glossary_term' = 'Publication Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `pubmed_number` SET TAGS ('dbx_business_glossary_term' = 'PubMed Identifier (PMID)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `pubmed_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Publication Title');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Publication URL');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ALTER COLUMN `url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` SET TAGS ('dbx_subdomain' = 'provider_registry');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Monitor Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `debarment_check_id` SET TAGS ('dbx_business_glossary_term' = 'Debarment Check Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `secondary_therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Secondary Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `serious_protocol_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Protocol Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `total_subjects_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Total Subjects Enrolled');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ALTER COLUMN `total_trials_conducted` SET TAGS ('dbx_business_glossary_term' = 'Total Trials Conducted');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` SET TAGS ('dbx_subdomain' = 'field_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` SET TAGS ('dbx_association_edges' = 'hcp.hcp_master,workforce.employee');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'engagement Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` SET TAGS ('dbx_association_edges' = 'hcp.hcp_speaker_program,product.medicinal_product');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `speaker_program_presentation_id` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Presentation ID');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `hcp_speaker_program_id` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Presentation - Hcp Speaker Program Id');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Presentation - Medicinal Product Id');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `approved_product_list` SET TAGS ('dbx_business_glossary_term' = 'Approved Product List');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `audience_size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `audience_type` SET TAGS ('dbx_business_glossary_term' = 'Audience Type');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `event_end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `event_format` SET TAGS ('dbx_business_glossary_term' = 'Event Format');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `event_format` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `event_start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `honorarium_paid` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Paid');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `materials_used` SET TAGS ('dbx_business_glossary_term' = 'Materials Used');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `mlr_approval_number` SET TAGS ('dbx_business_glossary_term' = 'MLR Approval Number');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `speaker_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Speaker Performance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue` SET TAGS ('dbx_business_glossary_term' = 'Venue');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue_address` SET TAGS ('dbx_business_glossary_term' = 'Venue Address');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Venue City');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_business_glossary_term' = 'Venue State or Province');
