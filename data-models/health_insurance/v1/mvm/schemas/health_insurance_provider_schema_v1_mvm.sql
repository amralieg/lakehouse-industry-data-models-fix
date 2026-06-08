-- Schema for Domain: provider | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`provider` COMMENT 'Authoritative domain for all healthcare providers — physicians, hospitals, clinics, ancillary providers, facilities, and DME suppliers. Owns NPI-based provider identity, specialty taxonomy codes, licensure, practice locations, participation status, and provider directory information. Supports provider directory accuracy mandates (CMS, NCQA) and serves as the SSOT for provider identity. Source system: Cactus or ProviderSource.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`provider_provider` (
    `provider_id` BIGINT COMMENT 'Unique identifier for the provider_provider data product (auto-inserted pre-linking).',
    `accreditation_program_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_program. Business justification: Accreditation Program tracking: each provider must be linked to the accreditation program that certifies it, required for network participation and compliance reporting.',
    `address_line1` STRING COMMENT 'Primary street address of the providers main practice location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `board_certification_summary_status` STRING COMMENT 'Overall completeness of board certification documentation.. Valid values are `complete|partial|missing`',
    `board_certifications` STRING COMMENT 'List of board certifications held by the provider.',
    `city` STRING COMMENT 'City of the providers primary practice location.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the providers location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the provider record was first created in the system.',
    `credentialing_status` STRING COMMENT 'Current status of the providers credentialing process.. Valid values are `credentialed|pending|revoked|suspended`',
    `cultural_competency_certifications` STRING COMMENT 'Certifications or training demonstrating cultural competency for language access.',
    `date_of_birth` DATE COMMENT 'Birth date of an individual provider; used for credentialing and compliance.',
    `dea_number` STRING COMMENT 'Drug Enforcement Administration registration number for prescribing controlled substances.',
    `effective_end_date` DATE COMMENT 'Date when the providers current status or network participation ends (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the providers current status or network participation became effective.',
    `email_address` STRING COMMENT 'Primary email address used for provider communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of an individual provider.',
    `gender` STRING COMMENT 'Gender of the individual provider as reported.. Valid values are `male|female|other|unknown`',
    `language_proficiency` STRING COMMENT 'Proficiency level for each language (e.g., fluent, conversational).',
    `languages_spoken` STRING COMMENT 'Comma‑separated list of languages the provider can communicate in.',
    `last_name` STRING COMMENT 'Family name of an individual provider.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp of the last verification of provider data against source registries.',
    `license_number` STRING COMMENT 'State‑issued professional license identifier.',
    `license_state` STRING COMMENT 'Two‑letter US state code where the professional license was issued.. Valid values are `^[A-Z]{2}$`',
    `malpractice_coverage_flag` BOOLEAN COMMENT 'Indicates whether the provider has active malpractice insurance coverage.',
    `network_participation_flag` BOOLEAN COMMENT 'True if the provider is currently part of any contracted network.',
    `npi` STRING COMMENT '10‑digit unique identifier assigned to health care providers by the National Plan and Provider Enumeration System.. Valid values are `^d{10}$`',
    `participation_status` STRING COMMENT 'Indicates the providers participation level in the plans network.. Valid values are `participating|non_participating|pending`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the provider.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the providers address.',
    `primary_specialty` STRING COMMENT 'Main clinical specialty of the provider, derived from taxonomy.',
    `provider_category` STRING COMMENT 'High‑level classification of the provider (e.g., physician, hospital, clinic, DME supplier, behavioral health, ancillary).. Valid values are `physician|hospital|clinic|dme_supplier|behavioral_health|ancillary`',
    `provider_name` STRING COMMENT 'Full legal name of the provider (individual name or organization name).',
    `provider_type` STRING COMMENT 'Indicates whether the provider record represents an individual practitioner or an organizational entity.. Valid values are `individual|organization`',
    `state` STRING COMMENT 'State of the providers primary practice location.',
    `status_flag` STRING COMMENT 'Operational status of the provider within the health plan.. Valid values are `active|inactive|suspended|terminated`',
    `taxonomy_code` STRING COMMENT 'Standard taxonomy code (e.g., from the AMA) that describes the providers specialty or service area.',
    `taxonomy_description` STRING COMMENT 'Human‑readable description of the taxonomy code.',
    `termination_date` DATE COMMENT 'Date the provider relationship was terminated, if applicable.',
    `tin_ein` STRING COMMENT 'Federal tax identifier for the provider organization or individual.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the provider record.',
    `upin` STRING COMMENT 'Legacy identifier for physicians used in Medicare billing.',
    `website_url` STRING COMMENT 'Public website URL for the provider or practice.',
    CONSTRAINT pk_provider_provider PRIMARY KEY(`provider_id`)
) COMMENT 'Core master entity representing all healthcare providers — physicians, hospitals, clinics, ancillary providers, facilities, DME suppliers, and behavioral health providers. Serves as the NPI-based SSOT for provider identity across the enterprise. Stores individual (Type 1 NPI) and organizational (Type 2 NPI) provider records sourced from Cactus or ProviderSource. Includes provider type, taxonomy code, primary specialty, DEA number, UPIN, TIN/EIN, gender, languages spoken (with proficiency), cultural competency certifications, contact information for key operational contacts (credentialing, billing, office manager), malpractice coverage status flag, board certification summary status, and provider status flags. Supports CMS provider directory accuracy mandates, NCQA credentialing standards, and CLAS standards for language access.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`specialty` (
    `specialty_id` BIGINT COMMENT 'Primary key for specialty',
    `adequacy_standard_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_standard. Business justification: Network adequacy compliance reporting requires mapping each provider specialty to the applicable regulatory adequacy standard (time/distance, provider-to-member ratio). Regulators and health plans use',
    `provider_id` BIGINT COMMENT 'Reference to the healthcare provider who holds this specialty designation. Links to the provider master entity.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients for this specialty. True if accepting; False if panel is closed. Used for provider directory accuracy.',
    `board_certified_flag` BOOLEAN COMMENT 'Indicates whether the provider is board certified in this specialty. True if certified by a recognized medical board; False otherwise.',
    `certification_date` DATE COMMENT 'The date on which the provider was initially certified by the board in this specialty. Format: yyyy-MM-dd.',
    `certification_expiration_date` DATE COMMENT 'The date on which the board certification expires and requires renewal. Null if certification does not expire or is lifetime. Format: yyyy-MM-dd.',
    `certification_number` STRING COMMENT 'The unique certification number or identifier issued by the certifying board for this specialty. Used for verification purposes.',
    `certifying_board_name` STRING COMMENT 'The name of the medical board or certifying organization that granted board certification for this specialty (e.g., American Board of Internal Medicine, American Board of Surgery). Null if not board certified.',
    `credentialing_effective_date` DATE COMMENT 'The date on which the providers credentialing for this specialty became effective within the health plans network. Format: yyyy-MM-dd.',
    `credentialing_end_date` DATE COMMENT 'The date on which the providers credentialing for this specialty ended or will end. Null if currently active with no planned end date. Format: yyyy-MM-dd.',
    `credentialing_review_date` DATE COMMENT 'The date of the most recent credentialing review or recredentialing for this specialty. NCQA requires recredentialing at least every three years. Format: yyyy-MM-dd.',
    `credentialing_status` STRING COMMENT 'The current credentialing status of the provider for this specific specialty within the health plans network. Active indicates the provider is credentialed and authorized to provide services in this specialty.. Valid values are `active|inactive|pending|suspended|expired|revoked`',
    `current_record_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the specialty record. True for the current record; False for historical versions. Supports slowly changing dimension (SCD) Type 2 historization.',
    `end_date` DATE COMMENT 'The date on which the provider stopped practicing in this specialty, if applicable. Null if the provider is still actively practicing in this specialty. Format: yyyy-MM-dd.',
    `fellowship_completed_flag` BOOLEAN COMMENT 'Indicates whether the provider completed a fellowship program in this specialty or subspecialty. True if fellowship training was completed; False otherwise.',
    `fellowship_completion_date` DATE COMMENT 'The date on which the provider completed the fellowship program. Format: yyyy-MM-dd. Null if no fellowship was completed.',
    `fellowship_program_name` STRING COMMENT 'The name of the fellowship program and institution where the provider completed subspecialty training. Null if no fellowship was completed.',
    `hedis_specialty_flag` BOOLEAN COMMENT 'Indicates whether this specialty is relevant for HEDIS measure attribution and quality reporting. True if the specialty is used in HEDIS measure calculations; False otherwise.',
    `network_adequacy_category` STRING COMMENT 'The network adequacy category or specialty grouping used for regulatory reporting and network adequacy analysis. Maps specialty to state-specific or CMS network adequacy standards.',
    `next_credentialing_review_date` DATE COMMENT 'The scheduled date for the next credentialing review or recredentialing for this specialty. Used for compliance tracking and proactive credentialing management. Format: yyyy-MM-dd.',
    `pcp_eligible_flag` BOOLEAN COMMENT 'Indicates whether this specialty qualifies the provider to serve as a Primary Care Provider (PCP) for member assignment. True for specialties such as Family Medicine, Internal Medicine, Pediatrics, and General Practice.',
    `recertification_cycle_years` STRING COMMENT 'The number of years in the recertification cycle (e.g., 10 years for most ABMS boards). Null if recertification is not required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the board certification requires periodic recertification or maintenance of certification (MOC). True if recertification is required; False if lifetime certification.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this specialty record was first created in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `record_effective_date` DATE COMMENT 'The date from which this version of the specialty record is effective for business purposes. Supports slowly changing dimension (SCD) Type 2 historization. Format: yyyy-MM-dd.',
    `record_end_date` DATE COMMENT 'The date on which this version of the specialty record ceased to be effective. Null for the current active record. Supports slowly changing dimension (SCD) Type 2 historization. Format: yyyy-MM-dd.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this specialty record was last updated in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `source_system` STRING COMMENT 'The name of the source system from which this specialty record originated (e.g., Cactus, ProviderSource, CAQH ProView). Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier for this specialty record in the source system. Used for data lineage, reconciliation, and troubleshooting.',
    `specialist_referral_required_flag` BOOLEAN COMMENT 'Indicates whether members require a referral from their PCP to see this provider in this specialty, based on plan type (e.g., HMO requires referrals; PPO typically does not). True if referral is required; False otherwise.',
    `specialty_category` STRING COMMENT 'High-level grouping of the specialty into major healthcare service categories for network adequacy and reporting purposes. [ENUM-REF-CANDIDATE: allopathic_osteopathic|dental|behavioral_health|chiropractic|podiatric|nursing|pharmacy|ancillary — 8 candidates stripped; promote to reference product]',
    `specialty_code` STRING COMMENT 'The National Uniform Claim Committee (NUCC) Health Care Provider Taxonomy Code representing the providers specialty classification. Ten-digit alphanumeric code with an X in the 11th position.. Valid values are `^[0-9]{10}X$`',
    `specialty_name` STRING COMMENT 'The human-readable name of the specialty (e.g., Cardiology, Orthopedic Surgery, Family Medicine). Corresponds to the specialty taxonomy code.',
    `specialty_type` STRING COMMENT 'Indicates whether this is the providers primary specialty, secondary specialty, or tertiary specialty. Primary specialty is the main area of practice; secondary and tertiary are additional areas of expertise.. Valid values are `primary|secondary|tertiary`',
    `start_date` DATE COMMENT 'The date on which the provider began practicing in this specialty. Used to calculate years of experience and for credentialing verification. Format: yyyy-MM-dd.',
    `subspecialty_code` STRING COMMENT 'Additional NUCC taxonomy code representing a subspecialty within the primary specialty (e.g., Interventional Cardiology within Cardiology). Null if no subspecialty designation.',
    `subspecialty_name` STRING COMMENT 'The human-readable name of the subspecialty, if applicable. Provides additional granularity beyond the primary specialty for network adequacy and member search.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether the provider offers telehealth or telemedicine services for this specialty. True if telehealth services are available; False otherwise. Important for provider directory accuracy.',
    `years_in_specialty` STRING COMMENT 'The number of years the provider has been practicing in this specialty. Calculated from the date the provider first began practicing in this specialty area.',
    CONSTRAINT pk_specialty PRIMARY KEY(`specialty_id`)
) COMMENT 'Tracks all specialty and sub-specialty designations for a provider, including primary and secondary specialties, NUCC taxonomy codes, board certification details, certification body, certification date, expiration date, and specialty-level credentialing status. A provider may hold multiple specialties across different taxonomies. Supports network adequacy analysis by specialty and HEDIS measure attribution.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`practice_location` (
    `practice_location_id` BIGINT COMMENT 'Unique identifier for the practice location. Primary key.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: A practice location is frequently operated by or affiliated with a medical group or group practice. practice_location currently stores medical_group_name as a denormalized STRING, which is the authori',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: Network adequacy geographic analysis requires knowing which service area each practice location falls within. Adequacy gap identification and regulatory filings depend on counting in-network providers',
    `provider_id` BIGINT COMMENT 'State-specific Medicaid provider identifier for this practice location. Required for Medicaid claims submission.',
    `provider_provider_id` BIGINT COMMENT 'Reference to the primary provider associated with this practice location. A provider may have multiple practice locations.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether this practice location is currently accepting new patients. Critical for member provider search and network adequacy.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the practice location meets ADA accessibility requirements.',
    `address_line_1` STRING COMMENT 'Primary street address of the practice location (street number and name).',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, building, or unit number.',
    `city` STRING COMMENT 'City name of the practice location.',
    `county_name` STRING COMMENT 'County name where the practice location is situated. Used for network adequacy geographic access analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this practice location record was first created in the system.',
    `directory_display_flag` BOOLEAN COMMENT 'Indicates whether this practice location should be displayed in the member-facing provider directory. May be false even if active (e.g., administrative locations).',
    `effective_date` DATE COMMENT 'Date when this practice location became active in the provider network.',
    `email_address` STRING COMMENT 'Primary email contact for the practice location for administrative and member communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the practice location used for prior authorization and medical records transmission.. Valid values are `^[0-9]{10}$`',
    `fips_code` STRING COMMENT '5-digit FIPS county code for geographic identification and network adequacy reporting.. Valid values are `^[0-9]{5}$`',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages spoken by staff at this practice location (e.g., English, Spanish, Mandarin). Supports member language access requirements.',
    `last_verified_date` DATE COMMENT 'Date when the practice location information was last verified for accuracy. CMS requires quarterly verification for provider directory data.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the practice location in decimal degrees. Used for time/distance network adequacy calculations.',
    `location_name` STRING COMMENT 'Business name or designation of the practice location (e.g., Main Street Family Medicine, Downtown Urgent Care Center).',
    `location_type` STRING COMMENT 'Classification of the practice location type indicating the care delivery setting.. Valid values are `office|hospital|clinic|urgent_care|telehealth_only|ambulatory_surgery_center`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the practice location in decimal degrees. Used for time/distance network adequacy calculations.',
    `npi` STRING COMMENT '10-digit National Provider Identifier for this practice location if it has a Type 2 (organizational) NPI. May be null if location uses only the providers individual NPI.. Valid values are `^[0-9]{10}$`',
    `office_hours` STRING COMMENT 'Operating hours of the practice location (e.g., Mon-Fri 8:00 AM - 5:00 PM, Sat 9:00 AM - 1:00 PM). Free-text field for member-facing display.',
    `parking_available_flag` BOOLEAN COMMENT 'Indicates whether on-site or nearby parking is available for patients.',
    `participation_status` STRING COMMENT 'Current participation status of this practice location in the provider network. Determines whether location appears in member-facing provider directory.. Valid values are `active|inactive|suspended|terminated|pending_credentialing`',
    `patient_age_maximum` STRING COMMENT 'Maximum patient age accepted at this practice location (e.g., 18 for pediatrics only). Null if no maximum restriction.',
    `patient_age_minimum` STRING COMMENT 'Minimum patient age accepted at this practice location (e.g., 0 for all ages, 18 for adults only). Null if no minimum restriction.',
    `patient_gender_restriction` STRING COMMENT 'Gender restriction for patients served at this location (e.g., female_only for womens health clinics).. Valid values are `all|male_only|female_only`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the practice location (10-digit format without formatting).. Valid values are `^[0-9]{10}$`',
    `public_transportation_access_flag` BOOLEAN COMMENT 'Indicates whether the practice location is accessible via public transportation.',
    `record_status` STRING COMMENT 'Current status of this practice location record in the data warehouse. Supports soft-delete and historical tracking.. Valid values are `active|inactive|deleted|archived`',
    `source_system` STRING COMMENT 'Name of the source system from which this practice location record originated (e.g., Cactus, ProviderSource, NPPES).',
    `state_code` STRING COMMENT 'Two-letter state abbreviation (e.g., CA, NY, TX).. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'Federal Tax Identification Number (EIN) for the practice location or medical group. Used for claims payment and 1099 reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `telehealth_available_flag` BOOLEAN COMMENT 'Indicates whether telehealth services are available at this practice location.',
    `termination_date` DATE COMMENT 'Date when this practice location was terminated from the provider network. Null if currently active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this practice location record was last modified.',
    `verification_method` STRING COMMENT 'Method used for the most recent verification of practice location information.. Valid values are `phone_verification|site_visit|provider_attestation|electronic_verification`',
    `wheelchair_accessible_flag` BOOLEAN COMMENT 'Indicates whether the practice location has wheelchair accessibility features (ramps, elevators, accessible restrooms).',
    `zip_code` STRING COMMENT '5-digit or ZIP+4 postal code for the practice location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_practice_location PRIMARY KEY(`practice_location_id`)
) COMMENT 'Represents a physical or virtual practice location where a provider delivers care. Captures address (street, city, state, ZIP+4), county, FIPS code, geolocation (lat/long), phone, fax, office hours, accessibility features (ADA compliance, wheelchair access), telehealth availability, accepting new patients flag by location, patient age/population restrictions, and location type (office, hospital, urgent care, telehealth-only). Supports CMS provider directory accuracy requirements, network adequacy geographic access standards (time/distance), and member-facing provider search. A provider may have multiple practice locations; each location may serve multiple providers.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`license` (
    `license_id` BIGINT COMMENT 'Primary key for license',
    `provider_id` BIGINT COMMENT 'Reference to the healthcare provider who holds this license. Links to the provider master entity.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Provider license management is governed by state medical board regulatory obligations and interstate compact requirements. Compliance teams track license compliance against specific regulatory obligat',
    `attestation_date` DATE COMMENT 'The date the provider attested to the accuracy and currency of this license information. Used for credentialing and recredentialing cycles.',
    `authorized_schedules` STRING COMMENT 'For DEA and CDS registrations, the controlled substance schedules the provider is authorized to prescribe (Schedule II, III, IV, V). Stored as comma-separated list. Critical for pharmacy benefit management and prior authorization workflows.',
    `compact_participation_flag` BOOLEAN COMMENT 'Indicates whether this license is part of an interstate licensure compact (e.g., Interstate Medical Licensure Compact, Nurse Licensure Compact). True if the license grants multi-state practice privileges; false otherwise.',
    `compact_privilege_states` STRING COMMENT 'Comma-separated list of state abbreviations where the provider has practice privileges under the interstate compact. Used for multi-state network adequacy and provider directory management.',
    `compact_type` STRING COMMENT 'The specific interstate licensure compact this license participates in. IMLC is Interstate Medical Licensure Compact for physicians. Populated only when compact_participation_flag is true. [ENUM-REF-CANDIDATE: imlc|nurse_licensure_compact|psychology_compact|physical_therapy_compact|ems_compact|counseling_compact|none — 7 candidates stripped; promote to reference product]',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'The number of continuing education or CME hours required per renewal cycle to maintain this license. Varies by state and license type.',
    `continuing_education_required_flag` BOOLEAN COMMENT 'Indicates whether continuing education (CE) or continuing medical education (CME) is required to maintain this license. True if CE/CME is mandatory for renewal; false otherwise.',
    `disciplinary_action_date` DATE COMMENT 'The date disciplinary action was taken against the license. Used for credentialing review timelines and risk assessment.',
    `disciplinary_action_details` STRING COMMENT 'Detailed description of any disciplinary actions, sanctions, or restrictions imposed by the licensing authority. Includes nature of violation, dates, and resolution. Populated only when disciplinary_action_flag is true.',
    `disciplinary_action_flag` BOOLEAN COMMENT 'Indicates whether any disciplinary action has been taken against this license by the issuing authority. True if disciplinary action exists; false otherwise. Critical for credentialing risk assessment.',
    `effective_date` DATE COMMENT 'The date the license becomes valid and the provider is authorized to practice under this credential. May differ from issue date for renewals or reinstatements.',
    `expiration_date` DATE COMMENT 'The date the license expires and is no longer valid unless renewed. Critical for credentialing compliance and provider directory accuracy. Null for licenses with no expiration.',
    `issue_date` DATE COMMENT 'The date the license or registration was originally issued by the licensing authority. Used to calculate license tenure and verify historical credentialing timelines.',
    `issuing_authority` STRING COMMENT 'The regulatory body or government agency that issued the license or registration. Examples include State Medical Board, State Board of Nursing, Drug Enforcement Administration (DEA), State Pharmacy Board, or Centers for Medicare and Medicaid Services (CMS).',
    `issuing_state` STRING COMMENT 'The U.S. state or territory that issued the license. Uses two-letter state abbreviation. Critical for multi-state licensure tracking and Interstate Medical Licensure Compact compliance. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|DC — 51 candidates stripped; promote to reference product]',
    `license_number` STRING COMMENT 'The unique license or registration number issued by the licensing authority. For DEA registrations, this is the DEA number; for state medical licenses, this is the state-issued license number.',
    `license_status` STRING COMMENT 'Current status of the license or registration in its lifecycle. Active indicates the license is valid and in good standing; suspended, revoked, or expired indicate the provider cannot practice under this credential. [ENUM-REF-CANDIDATE: active|inactive|suspended|revoked|expired|surrendered|pending_renewal|probation|restricted — 9 candidates stripped; promote to reference product]',
    `license_type` STRING COMMENT 'The category of professional license or registration. Includes state medical licenses (MD, DO), nursing licenses (RN, LPN, NP), DEA controlled substance registrations, state CDS permits, pharmacy licenses, and other professional certifications. [ENUM-REF-CANDIDATE: medical_license|nursing_license|dea_registration|cds_permit|pharmacy_license|dental_license|optometry_license|podiatry_license|chiropractic_license|physical_therapy_license|occupational_therapy_license|behavioral_health_license|advanced_practice_license|physician_assistant_license|other — 15 candidates stripped; promote to reference product]',
    `practice_restrictions` STRING COMMENT 'Any limitations or restrictions placed on the license by the issuing authority. May include supervision requirements, practice setting restrictions, or specific clinical limitations.',
    `primary_source_verification_date` DATE COMMENT 'The date the license was last verified directly with the issuing authority (primary source). NCQA requires PSV within 180 days of credentialing decision and every 36 months thereafter.',
    `primary_source_verification_method` STRING COMMENT 'The method used to verify the license with the primary source. Includes online state board portals, written correspondence, phone verification, third-party credentialing services, or automated API integration.. Valid values are `online_portal|written_correspondence|phone_verification|third_party_service|automated_api`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time this license record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `record_current_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the license record. True for the current record; false for historical versions. Supports Type 2 slowly changing dimension queries.',
    `record_effective_timestamp` TIMESTAMP COMMENT 'The date and time from which this version of the license record is effective for business reporting. Supports Type 2 slowly changing dimension tracking.',
    `record_end_timestamp` TIMESTAMP COMMENT 'The date and time when this version of the license record was superseded by a new version. Null for the current active record. Supports Type 2 slowly changing dimension tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time this license record was last modified in the data platform. Used for change tracking and audit purposes.',
    `renewal_cycle_months` STRING COMMENT 'The number of months between required renewals for this license type. Common values are 12, 24, or 36 months depending on state and license type.',
    `renewal_date` DATE COMMENT 'The date the license was last renewed. Used to track renewal cycles and ensure continuous licensure for credentialing purposes.',
    `scope_of_practice` STRING COMMENT 'Description of the clinical activities and services the provider is authorized to perform under this license. Varies by license type and state regulations. Used for state-specific scope-of-practice validation.',
    `source_system` STRING COMMENT 'The operational system of record from which this license data originated. Typically the Provider Management System (Cactus or ProviderSource) or credentialing platform.',
    `source_system_code` STRING COMMENT 'The unique identifier for this license record in the source operational system. Used for data lineage and reconciliation.',
    `telemedicine_authorized_flag` BOOLEAN COMMENT 'Indicates whether the provider is authorized to deliver telemedicine services under this license. True if telemedicine practice is permitted; false otherwise. Critical for virtual care network management.',
    `verification_source` STRING COMMENT 'The specific entity or system used to perform primary source verification. Examples include state medical board website, NPDB, third-party credentialing verification organization (CVO), or automated verification service.',
    `verification_url` STRING COMMENT 'The web address of the state licensing board or regulatory authority where the license can be verified online. Used for automated primary source verification workflows.',
    CONSTRAINT pk_license PRIMARY KEY(`license_id`)
) COMMENT 'Single source of truth for all professional licenses, certifications, and regulatory registrations held by a provider. Covers state medical licenses (MD, DO, NP, PA, RN, LCSW, LPC, etc.), DEA controlled substance registrations (including authorized schedules II-V and registration state), CDS (state-level controlled dangerous substance) permits, state pharmacy licenses, and other regulatory registrations. Stores license/registration type, issuing authority (state medical board, state nursing board, DEA, CMS, state pharmacy board), license or registration number, authorized schedules (for DEA/CDS), issue date, expiration date, renewal date, status (active, suspended, revoked, expired, surrendered, pending renewal), disciplinary action flags, disciplinary action details, and primary source verification (PSV) date and source. Supports NCQA credentialing standards for PSV, multi-state licensure tracking via Interstate Medical Licensure Compact, controlled substance prescribing authorization, pharmacy benefit management workflows, and state-specific scope-of-practice validation.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` (
    `provider_affiliation_id` BIGINT COMMENT 'Primary key for affiliation',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: affiliation captures organizational affiliations of individual providers including hospital affiliations and admitting privileges (admitting_privileges_flag is present on affiliation). The affiliation',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: affiliation should reference the medical group (group_practice) it belongs to; the existing column name does not match target PK naming, so a new FK column is added and the generic column removed.',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Provider affiliations (medical group memberships, IPA affiliations) are location-specific — a provider may be affiliated with a group at one practice location but not another. Adding practice_location',
    `provider_id` BIGINT COMMENT 'Reference to the individual provider (physician, nurse practitioner, or other healthcare professional) who holds this affiliation. Links to the provider master entity.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Provider affiliations in health insurance are often specialty-specific — a provider may be affiliated with a cardiology group for their cardiology specialty and a primary care IPA for their family med',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether the provider is accepting new patients through this affiliation. True indicates accepting new patients; False indicates not accepting new patients.',
    `admitting_privileges_flag` BOOLEAN COMMENT 'Indicates whether the provider has been granted admitting privileges at this specific facility. A provider may have privileges at a facility without full admitting rights (e.g., consulting-only). Belongs to the relationship, not to the provider or facility alone.',
    `affiliation_status` STRING COMMENT 'Current operational status of the providers appointment or affiliation at this facility. Drives provider directory inclusion, claims routing eligibility, and network adequacy reporting. Belongs to the relationship.',
    `affiliation_type` STRING COMMENT 'Categorical classification of the affiliation relationship. Indicates whether the provider is affiliated with a medical group, Independent Practice Association (IPA), Accountable Care Organization (ACO), health system, hospital, or other facility type.. Valid values are `medical_group|ipa|aco|health_system|hospital|facility`',
    `billing_npi` STRING COMMENT 'The National Provider Identifier (NPI) used for billing purposes in this affiliation context. May represent the organizational NPI (Type 2) of the affiliated entity.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this affiliation record was first created in the system. Used for audit trail and data lineage tracking.',
    `credentialing_verification_date` DATE COMMENT 'Date when the providers credentials were last verified specifically for this facility appointment. Distinct from the provider-level last_verified_timestamp; this is facility-specific verification. Belongs to the relationship.',
    `department_name` STRING COMMENT 'The name of the department, division, or service line within the affiliated organization where the provider practices. Examples include Cardiology, Emergency Medicine, Orthopedic Surgery, Primary Care.',
    `directory_display_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this affiliation should be displayed in the member-facing provider directory. True indicates the affiliation is publicly visible; False indicates it is for internal use only.',
    `end_date` DATE COMMENT 'Date when the providers medical staff appointment or privilege at this facility expires or was terminated. Nullable for active appointments with no set expiration. Belongs to the specific provider-facility relationship.',
    `last_updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that last updated this affiliation record. Supports audit and accountability requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this affiliation record was last modified. Used for audit trail and change tracking.',
    `medical_staff_category` STRING COMMENT 'The category of medical staff membership the provider holds at the affiliated hospital or facility. Categories include Active Staff, Courtesy Staff, Consulting Staff, Honorary Staff, Affiliate Staff, and Provisional Staff.. Valid values are `active|courtesy|consulting|honorary|affiliate|provisional`',
    `network_participation_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this affiliation makes the provider eligible for participation in the health plans provider network. True indicates network participation; False indicates non-participating affiliation.',
    `next_credentialing_due_date` DATE COMMENT 'The date by which the next credentialing verification for this affiliation is due. Supports proactive credentialing workflow management.',
    `notes` STRING COMMENT 'Free-text field for capturing additional notes, comments, or special instructions related to the provider affiliation. May include details about practice restrictions, scheduling notes, or administrative remarks.',
    `primary_affiliation_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this is the providers primary organizational affiliation. True indicates this is the main affiliation; False indicates a secondary or additional affiliation.',
    `role_title` STRING COMMENT 'The providers role or title within the affiliated organization. Examples include Staff Physician, Medical Director, Department Chair, Attending Physician, Consulting Physician.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this affiliation record in the source system. Used for traceability and reconciliation with upstream systems.',
    `source_system` STRING COMMENT 'The name of the source system from which this affiliation record originated. Examples include Cactus, ProviderSource, credentialing system, or manual entry.',
    `start_date` DATE COMMENT 'Date when the providers medical staff appointment or privilege at this facility became effective. Belongs to the specific provider-facility relationship.',
    `tin` STRING COMMENT 'The Tax Identification Number (TIN) or Employer Identification Number (EIN) under which the provider bills for services rendered through this affiliation. Used for claims routing and payment processing.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this affiliation record. Supports audit and accountability requirements.',
    CONSTRAINT pk_provider_affiliation PRIMARY KEY(`provider_affiliation_id`)
) COMMENT 'Captures the organizational affiliations of individual providers — medical group memberships, IPA affiliations, ACO participation, health system relationships, and hospital associations. Stores affiliation type, affiliated organization (group practice or facility reference), affiliation start and end dates, department, role, and active status. Supports provider directory accuracy, network configuration, claims routing logic, and understanding of provider-to-organization hierarchies. For hospital-based providers, captures the association with the facility where the provider practices.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`group_practice` (
    `group_practice_id` BIGINT COMMENT 'Primary key for group_practice',
    `provider_id` BIGINT COMMENT 'The state-assigned Medicaid provider identifier for the group practice, used for Medicaid claims submission.',
    `accepting_new_patients` BOOLEAN COMMENT 'Indicates whether the group practice is currently accepting new patients. Used for provider directory accuracy and member access.',
    `accessibility_accommodations` STRING COMMENT 'Description of accessibility accommodations available at the group practice (e.g., wheelchair access, hearing loop, accessible exam tables) to comply with ADA requirements.',
    `aco_name` STRING COMMENT 'The name of the ACO in which the group practice participates, if applicable.',
    `aco_participant` BOOLEAN COMMENT 'Indicates whether the group practice participates in an Accountable Care Organization (ACO) for value-based care arrangements.',
    `address_line_1` STRING COMMENT 'The primary street address line 1 of the group practices main location or headquarters.',
    `address_line_2` STRING COMMENT 'The primary street address line 2 (suite, floor, building) of the group practices main location.',
    `city` STRING COMMENT 'The city where the group practices primary location is situated.',
    `cms_certification_number` STRING COMMENT 'The CMS Certification Number (CCN) assigned to FQHC, RHC, or other certified facilities. Required for Medicare/Medicaid billing.',
    `county` STRING COMMENT 'The county in which the group practices primary location is located. Used for network adequacy and geographic access reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this group practice record was first created in the provider management system.',
    `credentialing_date` DATE COMMENT 'The date on which the group practice was initially credentialed and approved for network participation.',
    `credentialing_status` STRING COMMENT 'The current credentialing status of the group practice within the health plans credentialing process.. Valid values are `initial|recredentialing|approved|denied|expired`',
    `data_source_system` STRING COMMENT 'The name of the source system from which this group practice record originated (e.g., Cactus, ProviderSource, NPPES).',
    `doing_business_as_name` STRING COMMENT 'The trade name or DBA name under which the group practice operates, if different from the legal name.',
    `effective_date` DATE COMMENT 'The date on which the group practices participation in the health plan network became effective.',
    `email_address` STRING COMMENT 'The primary email address for administrative and contracting communications with the group practice.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'The fax number for the group practice, used for prior authorization and medical records transmission.. Valid values are `^+?[0-9]{10,15}$`',
    `group_name` STRING COMMENT 'The legal business name of the medical group, physician organization, or practice entity as registered with state authorities and CMS.',
    `group_npi` STRING COMMENT 'The 10-digit Type 2 NPI assigned to the group practice organization by CMS. This is the organizational NPI distinct from individual provider NPIs.. Valid values are `^[0-9]{10}$`',
    `group_size` STRING COMMENT 'The total number of individual providers (physicians, nurse practitioners, physician assistants) affiliated with and practicing under this group.',
    `group_type` STRING COMMENT 'Classification of the group practice organizational structure: solo practice (single physician), single specialty group, multi-specialty group, Independent Practice Association (IPA), Federally Qualified Health Center (FQHC), or Rural Health Clinic (RHC).. Valid values are `solo_practice|single_specialty_group|multi_specialty_group|ipa|fqhc|rhc`',
    `hospital_affiliation` STRING COMMENT 'The name of the primary hospital or health system with which the group practice is affiliated or has admitting privileges.',
    `language_services_offered` STRING COMMENT 'Comma-separated list of languages in which the group practice offers clinical services, used for provider directory cultural competency and member access.',
    `participation_status` STRING COMMENT 'The current participation status of the group practice in the health plans provider network. Active indicates the group is contracted and accepting members.. Valid values are `active|inactive|suspended|terminated|pending_credentialing`',
    `pcmh_recognized` BOOLEAN COMMENT 'Indicates whether the group practice has achieved NCQA Patient-Centered Medical Home (PCMH) recognition, qualifying for enhanced reimbursement and quality incentives.',
    `phone_number` STRING COMMENT 'The primary contact phone number for the group practice.. Valid values are `^+?[0-9]{10,15}$`',
    `primary_specialty` STRING COMMENT 'The primary medical specialty or service focus of the group practice (e.g., Family Medicine, Cardiology, Orthopedic Surgery, Multi-Specialty).',
    `recredentialing_due_date` DATE COMMENT 'The date by which the group practice must complete recredentialing to maintain network participation. NCQA requires recredentialing at least every 36 months.',
    `state` STRING COMMENT 'The two-letter state abbreviation for the group practices primary location.. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'The federal tax identification number (TIN/EIN) assigned to the group practice by the IRS. Used for claims payment and 1099 reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `taxonomy_code` STRING COMMENT 'The 10-character alphanumeric taxonomy code identifying the groups primary classification, specialty, and area of practice per the NUCC taxonomy.. Valid values are `^[0-9]{10}[X]$`',
    `telehealth_enabled` BOOLEAN COMMENT 'Indicates whether the group practice offers telehealth or telemedicine services to members.',
    `termination_date` DATE COMMENT 'The date on which the group practices participation in the health plan network was terminated or is scheduled to terminate. Null for active participants.',
    `termination_reason` STRING COMMENT 'The reason for termination of the group practices network participation (e.g., voluntary withdrawal, quality issues, credentialing failure, contract non-renewal).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this group practice record was last modified in the provider management system.',
    `website_url` STRING COMMENT 'The public website URL for the group practice, used in provider directory listings.',
    `zip_code` STRING COMMENT 'The 5-digit or 9-digit ZIP code for the group practices primary location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_group_practice PRIMARY KEY(`group_practice_id`)
) COMMENT 'Represents a medical group, physician organization, IPA, or multi-specialty group practice as a distinct business entity with its own Type 2 NPI and TIN. Stores group name, group NPI, TIN/EIN, group type (solo practice, group practice, IPA, FQHC, RHC), primary specialty, address, phone, CMS certification number, and group size. Serves as the organizational parent for individual provider affiliations and supports group-level contracting and network participation.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique identifier for the healthcare facility record. Primary key.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the facility is currently accepting new patients. Used in provider directory and network adequacy reporting.',
    `address_line_1` STRING COMMENT 'Primary street address of the facility physical location.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number.',
    `bed_count` STRING COMMENT 'Total number of licensed beds at the facility. Used for network adequacy calculations and capacity planning.',
    `ccn` STRING COMMENT 'Six-character alphanumeric identifier assigned by CMS to Medicare/Medicaid certified facilities. Also known as Provider Number.. Valid values are `^[0-9A-Z]{6}$`',
    `city` STRING COMMENT 'City where the facility is located.',
    `clia_number` STRING COMMENT 'Ten-character identifier issued by CMS for facilities performing laboratory testing. Format: 2-digit state code + 1 letter + 7 digits.. Valid values are `^[0-9]{2}[A-Z][0-9]{7}$`',
    `county_name` STRING COMMENT 'County where the facility is located. Used for network adequacy geographic analysis.',
    `credentialing_effective_date` DATE COMMENT 'Date when the current credentialing approval became effective.',
    `credentialing_expiration_date` DATE COMMENT 'Date when the current credentialing approval expires and recredentialing is required.',
    `credentialing_status` STRING COMMENT 'Current status of the facility credentialing process. Indicates whether the facility has passed credentialing review and is approved for network participation.. Valid values are `approved|pending|expired|suspended|denied`',
    `critical_access_hospital_flag` BOOLEAN COMMENT 'Indicates whether the facility is designated as a Critical Access Hospital under the Medicare Rural Hospital Flexibility Program.',
    `effective_date` DATE COMMENT 'Date when the facility record or current participation status became effective.',
    `email_address` STRING COMMENT 'Primary email address for facility communications and electronic correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_services_flag` BOOLEAN COMMENT 'Indicates whether the facility provides 24/7 emergency department services.',
    `facility_name` STRING COMMENT 'Legal name of the healthcare facility as registered with state and federal authorities.',
    `facility_type` STRING COMMENT 'Classification of the healthcare facility. Values: hospital (acute care hospital), snf (Skilled Nursing Facility), asc (Ambulatory Surgical Center), fqhc (Federally Qualified Health Center), rhc (Rural Health Clinic), behavioral_health (behavioral health facility). [ENUM-REF-CANDIDATE: hospital|snf|asc|fqhc|rhc|behavioral_health|home_health|hospice|dialysis_center|dme_supplier|ltac|irf|imaging_center — promote to reference product]. Valid values are `hospital|snf|asc|fqhc|rhc|behavioral_health`',
    `fax_number` STRING COMMENT 'Fax number for the facility, used for prior authorization and medical records transmission.. Valid values are `^+?[0-9]{10,15}$`',
    `medicaid_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified to participate in the Medicaid program.',
    `medicare_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified to participate in the Medicare program.',
    `network_tier` STRING COMMENT 'Tiering classification of the facility within the provider network. Tier 1 is preferred/lowest cost-sharing. Out_of_network indicates non-participating facility.. Valid values are `tier_1|tier_2|tier_3|out_of_network`',
    `npi` STRING COMMENT 'Type 2 NPI assigned to the facility by CMS. Ten-digit unique organizational identifier required for HIPAA transactions.. Valid values are `^[0-9]{10}$`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the facility. Values: for_profit (investor-owned), non_profit (tax-exempt), government (federal/state/local), tribal (Indian Health Service or tribal).. Valid values are `for_profit|non_profit|government|tribal`',
    `parent_organization_name` STRING COMMENT 'Name of the parent health system or organization that owns or operates the facility. Null if facility is independent.',
    `participation_status` STRING COMMENT 'Current status of the facility in the provider network. Indicates whether the facility is actively participating, suspended, or terminated.. Valid values are `active|inactive|suspended|terminated|pending`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the facility.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'Five or nine-digit ZIP code of the facility location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `quality_rating` DECIMAL(18,2) COMMENT 'Overall quality rating score for the facility on a scale of 1.00 to 5.00. Derived from CMS Star Ratings, HEDIS measures, or internal quality assessments.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was last updated in the data platform.',
    `source_system` STRING COMMENT 'Name of the source system from which this facility record originated (e.g., Cactus, ProviderSource).',
    `source_system_code` STRING COMMENT 'Unique identifier for this facility in the source system. Used for data lineage and reconciliation.',
    `state_code` STRING COMMENT 'Two-letter state abbreviation where the facility is located.. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) assigned by IRS. Used for claims payment and 1099 reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `teaching_hospital_flag` BOOLEAN COMMENT 'Indicates whether the facility is a teaching hospital affiliated with a medical school and residency programs.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether the facility offers telehealth or virtual care services.',
    `termination_date` DATE COMMENT 'Date when the facility participation was terminated or is scheduled to terminate. Null if currently active.',
    `trauma_level` STRING COMMENT 'Trauma center designation level assigned by state or American College of Surgeons. Level 1 is highest capability. Not_designated indicates facility is not a trauma center.. Valid values are `level_1|level_2|level_3|level_4|level_5|not_designated`',
    `website_url` STRING COMMENT 'Public website URL for the facility. Used in provider directory.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master record for healthcare facilities — hospitals, SNFs, ASCs, FQHCs, RHCs, behavioral health facilities, home health agencies, hospices, dialysis centers, and DME suppliers. Stores facility name, facility type, CMS certification number (CCN), Medicare/Medicaid certification status, accreditation body (Joint Commission, DNV, CIHQ), accreditation expiration, bed count, trauma level, teaching hospital status, critical access hospital designation, CLIA number, and facility NPI. Distinct from individual provider records; supports institutional claims (837I) routing, network adequacy facility-type analysis, and CMS Star Rating facility attribution. Serves as the organizational anchor for hospital privilege tracking.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`directory_entry` (
    `directory_entry_id` BIGINT COMMENT 'Primary key for directory_entry',
    `provider_directory_id` BIGINT COMMENT 'Unique identifier for the provider directory entry record. This is the primary key for the published directory entry, distinct from the internal provider master record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Member-facing provider directories must display network tier and cost-sharing at the benefit-package level (e.g., Gold vs. Bronze tier). Network adequacy reporting and CMS directory accuracy requireme',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: directory_entry represents the consumer-facing directory record for any participating entity — including hospitals, ASCs, SNFs, and other facilities. Currently directory_entry only has provider_id → p',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: A provider directory entry should reference the group practice the provider belongs to, as consumers searching for providers often search by medical group or IPA. The directory_entry already reference',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan for which this directory entry is published. A provider may have multiple directory entries across different plans.',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: directory_entry is the consumer-facing view of a providers participation at a specific practice location. It currently duplicates 11 address and contact fields that are authoritatively owned by pract',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Directory Publication Report requires contract details for each provider entry to determine network participation terms.',
    `provider_id` BIGINT COMMENT 'Reference to the internal provider master record. Links this published directory entry to the authoritative provider identity in the provider domain.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network in which this provider participates for this plan. Determines member access and cost-sharing tier.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: directory_entry contains specialty_display as a denormalized STRING representing the specialty shown in the consumer-facing directory. The specialty product is the authoritative source for specialty d',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients for this plan and network. Critical for directory accuracy and member access.',
    `accessibility_features` STRING COMMENT 'Description of accessibility features available at the practice location (wheelchair access, hearing loop, accessible parking). Supports ADA compliance and member access.',
    `attestation_method` STRING COMMENT 'Method used to verify the directory information with the provider. Documents the verification approach for audit and compliance purposes.. Valid values are `provider_portal|phone_verification|email_verification|site_visit|third_party_vendor`',
    `attestation_status` STRING COMMENT 'Status of the provider attestation or verification process for this directory entry. Tracks compliance with CMS directory accuracy requirements.. Valid values are `verified|pending_verification|failed_verification|not_verified`',
    `board_certifications` STRING COMMENT 'Comma-separated list of board certifications held by the provider. Demonstrates advanced training and specialty expertise.',
    `directory_display_name` STRING COMMENT 'Consumer-facing display name of the provider as it appears in the published directory. May differ from legal name for readability and member experience.',
    `directory_publication_date` DATE COMMENT 'Date when this directory entry was published or last updated in the member-facing provider directory. Required for CMS directory accuracy attestation.',
    `gender` STRING COMMENT 'Gender of the provider. Some members have preferences for provider gender, particularly for primary care and OB/GYN services.. Valid values are `male|female|non_binary|not_disclosed`',
    `graduation_year` STRING COMMENT 'Year the provider graduated from medical school or professional training program. Helps members assess provider experience.',
    `hospital_affiliation` STRING COMMENT 'Name of hospital(s) where the provider has admitting privileges or primary affiliation. Important for continuity of care and member decision-making.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages spoken by the provider or available at the practice location. Critical for member access and cultural competency.',
    `last_verified_date` DATE COMMENT 'Date when the directory information was last verified with the provider or practice. CMS and state DOI mandate regular verification cycles (typically 90 days).',
    `medical_school` STRING COMMENT 'Name of the medical school or professional training institution where the provider received their degree. Provides credential transparency for members.',
    `network_tier` STRING COMMENT 'Cost-sharing tier for this provider within the plan network. Determines member copay, coinsurance, and out-of-pocket costs.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|out_of_network`',
    `next_verification_due_date` DATE COMMENT 'Date by which the next directory verification must be completed to maintain compliance with CMS and state DOI accuracy mandates.',
    `npi` STRING COMMENT 'Ten-digit National Provider Identifier assigned by CMS. The authoritative unique identifier for healthcare providers in the United States.. Valid values are `^[0-9]{10}$`',
    `participation_effective_date` DATE COMMENT 'Date when the providers participation in this plan and network became effective. Determines when members can access the provider at in-network rates.',
    `participation_status` STRING COMMENT 'Current status of the providers participation in this specific plan and network. Determines whether the directory entry is published to members.. Valid values are `active|inactive|suspended|terminated|pending`',
    `participation_termination_date` DATE COMMENT 'Date when the providers participation in this plan and network ended or will end. Critical for member notification and continuity of care transitions.',
    `pcp_flag` BOOLEAN COMMENT 'Indicates whether this provider is eligible to serve as a Primary Care Provider (PCP) for plan members. Relevant for HMO and POS plans requiring PCP selection.',
    `practice_website_url` STRING COMMENT 'Website URL for the practice or provider. Published in directory to enable members to learn more about the provider and services offered.',
    `provider_type` STRING COMMENT 'High-level classification of the provider entity type. Determines directory presentation and search filtering options for members.. Valid values are `individual|group|facility|ancillary|dme_supplier|behavioral_health`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this directory entry record was first created in the data warehouse. Supports audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this directory entry record was last updated in the data warehouse. Tracks data freshness and change frequency.',
    `source_system` STRING COMMENT 'Name of the source system from which this directory entry was derived (e.g., Cactus, ProviderSource). Supports data lineage and troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier for this directory entry in the source system. Enables traceability and reconciliation with upstream provider management systems.',
    `telehealth_available_flag` BOOLEAN COMMENT 'Indicates whether the provider offers telehealth or virtual visit services for this plan. Increasingly important for member access and convenience.',
    `tin` STRING COMMENT 'Nine-digit Tax Identification Number (EIN or SSN) associated with the provider or practice for billing and contracting purposes.. Valid values are `^[0-9]{9}$`',
    CONSTRAINT pk_directory_entry PRIMARY KEY(`directory_entry_id`)
) COMMENT 'Published provider directory record representing the consumer-facing view of a providers participation in a specific health plan and network. Captures provider display name, accepting new patients status, languages spoken, telehealth availability, network tier, plan participation, directory publication date, last verified date, and directory accuracy attestation status. Supports CMS and state DOI provider directory accuracy mandates (no-surprise billing, network adequacy). Distinct from the internal provider master — this is the published, plan-specific directory entry.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` (
    `exclusion_screening_id` BIGINT COMMENT 'Unique identifier for the exclusion screening event record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: OIG/SAM exclusion screening applies to both individual providers AND healthcare facilities. CMS requires that health plans screen all participating entities — including hospitals, SNFs, ASCs, and othe',
    `fwa_case_id` BIGINT COMMENT 'Foreign key linking to compliance.fwa_case. Business justification: When exclusion screening identifies a sanctioned provider, an FWA case is opened per CMS program integrity protocols. Linking the screening result to the triggered FWA case supports fraud investigatio',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: OIG/SAM exclusion screenings must be performed against group practices and medical groups, not just individual providers and facilities. CMS requires that all entities receiving federal healthcare pay',
    `provider_id` BIGINT COMMENT 'Identifier of the provider being screened against exclusion lists.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: OIG/SAM exclusion screening is mandated by 42 CFR 1001 and CMS program integrity requirements. Compliance teams must link each screening activity to the specific regulatory obligation driving it for a',
    `audit_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this screening event has been flagged for audit review due to anomalies, policy violations, or regulatory examination requirements.',
    `audit_notes` STRING COMMENT 'Free-text notes documenting audit findings, reviewer comments, or regulatory examination references related to this screening event.',
    `cms_reporting_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this screening event must be included in CMS regulatory reporting submissions or program integrity audits.',
    `compliance_status` STRING COMMENT 'The compliance status of this screening event relative to regulatory requirements: compliant (on schedule), overdue (past due date), pending review (awaiting resolution), non-compliant (violation), or waived (exception granted).. Valid values are `Compliant|Overdue|Pending Review|Non-Compliant|Waived`',
    `data_source_version` STRING COMMENT 'The version or publication date of the exclusion list data source used for this screening, ensuring traceability to the specific list snapshot consulted.',
    `exclusion_effective_date` DATE COMMENT 'The date on which the exclusion became effective, as reported by the exclusion list source. Null if no match found.',
    `exclusion_end_date` DATE COMMENT 'The date on which the exclusion is scheduled to end or was lifted, if applicable. Null for indefinite exclusions or no match.',
    `exclusion_reason` STRING COMMENT 'The reason or statutory basis for the exclusion as reported by the exclusion list source (e.g., fraud, patient abuse, license revocation). Null if no match found.',
    `exclusion_type` STRING COMMENT 'The scope of the exclusion found: Federal (Medicare/Medicaid), State (state-specific Medicaid), Both (federal and state), or None (no exclusion).. Valid values are `Federal|State|Both|None`',
    `match_details` STRING COMMENT 'Detailed narrative or structured information about the match, including matched data elements, exclusion list entry identifiers, and any discrepancies requiring review.',
    `match_type` STRING COMMENT 'The type of match logic that triggered a positive or potential screening result, indicating which data elements matched the exclusion list entry.. Valid values are `Exact NPI Match|Name and DOB Match|Name and Address Match|Partial Match|No Match`',
    `next_screening_due_date` DATE COMMENT 'The date by which the next exclusion screening is required for this provider to maintain compliance with CMS monthly screening mandates.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier of the provider being screened, as assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `prior_screening_date` DATE COMMENT 'The date of the most recent prior exclusion screening for this provider, used to track screening cadence and compliance with monthly requirements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this exclusion screening record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this exclusion screening record was last modified or updated.',
    `resolution_action` STRING COMMENT 'The action taken by the health plan in response to the screening result: no action (clear result), provider termination, contract suspension, pending manual review, false positive confirmation, or waiver granted per policy.. Valid values are `No Action Required|Provider Terminated|Contract Suspended|Manual Review Pending|False Positive Confirmed|Waiver Granted`',
    `resolution_date` DATE COMMENT 'The date on which the resolution action was completed or the screening result was finalized. Null if resolution is still pending.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution process, including rationale for the action taken, supporting evidence reviewed, and any exceptions or waivers applied.',
    `screened_by_name` STRING COMMENT 'The full name of the individual or system process that performed the screening, for audit trail purposes.',
    `screening_date` DATE COMMENT 'The date on which the exclusion screening was performed.',
    `screening_frequency` STRING COMMENT 'The scheduled frequency or trigger for this screening event: monthly (CMS-required), quarterly, annual, ad hoc (event-driven), or initial credentialing.. Valid values are `Monthly|Quarterly|Annual|Ad Hoc|Initial Credentialing`',
    `screening_method` STRING COMMENT 'The method or channel used to perform the exclusion screening: automated batch process, manual lookup by staff, real-time API integration, or third-party vendor service.. Valid values are `Automated Batch|Manual Lookup|API Integration|Third-Party Vendor`',
    `screening_result` STRING COMMENT 'The outcome of the exclusion screening: Clear (no match), Match Found (confirmed exclusion), Potential Match (requires manual review), Inconclusive (insufficient data), or Error (screening system failure).. Valid values are `Clear|Match Found|Potential Match|Inconclusive|Error`',
    `screening_source` STRING COMMENT 'The authoritative exclusion list source(s) checked during this screening event (OIG List of Excluded Individuals and Entities, System for Award Management, state Medicaid exclusion lists, or General Services Administration Excluded Parties List System).. Valid values are `OIG LEIE|SAM.gov|State Medicaid Exclusion|GSA EPLS|Multiple Sources`',
    `screening_vendor` STRING COMMENT 'The name of the third-party vendor or service provider used to perform the exclusion screening, if applicable. Null for in-house screenings.',
    `source_system` STRING COMMENT 'The name of the source system or application that originated this exclusion screening record (e.g., Cactus, ProviderSource, or internal compliance platform).',
    `source_system_code` STRING COMMENT 'The unique identifier for this exclusion screening record in the source system, used for data lineage and reconciliation.',
    `state_reporting_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this screening event must be reported to state Department of Insurance or Medicaid agencies per state-specific requirements.',
    `vendor_transaction_reference` STRING COMMENT 'The unique transaction or reference identifier assigned by the third-party screening vendor for this screening event, used for vendor reconciliation and support.',
    CONSTRAINT pk_exclusion_screening PRIMARY KEY(`exclusion_screening_id`)
) COMMENT 'Tracks the periodic OIG/SAM exclusion screening events performed against the provider roster. Records screening date, screening source (OIG LEIE, SAM.gov, state Medicaid exclusion list), provider NPI screened, screening result (clear, match found, potential match), match details, resolution action, and screened by. Supports monthly CMS-required exclusion screening compliance, audit trail for regulatory examinations, and Medicaid/Medicare program integrity requirements.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`dea_registration` (
    `dea_registration_id` BIGINT COMMENT 'Primary key for dea_registration',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: DEA registrations can be issued to facilities (hospital pharmacies, clinics, ASCs) as well as individual providers. The dea_registration product currently links to provider_provider and practice_locat',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: DEA registrations are issued to a specific registrant at a specific practice address — the DEA number is location-specific, not just provider-specific. A provider with multiple practice locations may ',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: dea_registration must be linked to the core provider entity to avoid silo; provider_npi is redundant once provider_id is present.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: DEA registration is a federal regulatory obligation under 21 CFR governing controlled substance prescribing. Compliance teams must link DEA registrations to the specific regulatory obligation for CMS ',
    `controlled_substance_authorized_flag` BOOLEAN COMMENT 'True if the provider is authorized to prescribe controlled substances.',
    `current_record_flag` BOOLEAN COMMENT 'True if this row represents the current active registration for the provider.',
    `dea_number` STRING COMMENT 'Unique DEA registration number assigned to the provider for controlled substance prescribing.. Valid values are `^[A-Z]{2}d{7}$`',
    `expiration_date` DATE COMMENT 'Date the DEA registration expires unless renewed.',
    `issue_date` DATE COMMENT 'Date the DEA registration became effective.',
    `issuing_agency` STRING COMMENT 'Agency that issued the DEA registration (typically DEA).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DEA registration record.',
    `notes` STRING COMMENT 'Free-text field for any additional comments or remarks about the registration.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DEA registration record was first created in the system.',
    `record_end_date` DATE COMMENT 'Date the record became inactive (e.g., when registration was revoked).',
    `registration_state` STRING COMMENT 'Two-letter US state code where the DEA registration was issued. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `registration_status` STRING COMMENT 'Current lifecycle status of the DEA registration.. Valid values are `active|expired|revoked|surrendered|pending`',
    `registration_type` STRING COMMENT 'Indicates whether the registration is for an individual provider or an organization.. Valid values are `individual|organization`',
    `schedule_authorized` STRING COMMENT 'DEA schedule(s) the provider is authorized to prescribe (II, III, IV, V).. Valid values are `II|III|IV|V`',
    `source_system` STRING COMMENT 'Name of the source system that supplied the DEA registration data (e.g., ProviderSource, Cactus).',
    `source_system_code` STRING COMMENT 'Unique identifier of the DEA registration record in the source system.',
    `verification_date` DATE COMMENT 'Date the DEA registration information was last verified against the primary source.',
    CONSTRAINT pk_dea_registration PRIMARY KEY(`dea_registration_id`)
) COMMENT 'Tracks Drug Enforcement Administration (DEA) registration records for providers authorized to prescribe controlled substances. Stores DEA registration number, DEA schedules authorized (II, III, IV, V), registration state, issue date, expiration date, registration status (active, expired, revoked, surrendered), and primary source verification date. Required for NCQA credentialing standards for prescribing providers and supports pharmacy benefit management and prior authorization workflows.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` (
    `provider_network_participation_id` BIGINT COMMENT 'Primary key for the NetworkParticipation association',
    `facility_id` BIGINT COMMENT 'Foreign key linking to the facility',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Group practices (medical groups, IPAs, physician organizations) participate in provider networks as contracting entities, distinct from individual provider or facility participation. A group practice',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Network participation is location-specific in health insurance — a provider may participate in a network at some practice locations but not others. Adding practice_location_id to provider_network_part',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: Network participation is governed by a specific provider contract. Credentialing workflows, network adequacy audits, and directory accuracy require linking the operational network participation record',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: provider_network_participation is named for provider network participation broadly, yet currently only has facility_id for the participating entity. Individual physicians and non-facility providers al',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to the provider network',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Network participation in health insurance is often specialty-specific — a provider may participate in a network for their primary specialty but not for a secondary specialty. Adding specialty_id to pr',
    `effective_date` DATE COMMENT 'Date the facilitys participation became effective',
    `network_tier` STRING COMMENT 'Tier classification of the facility within the network (e.g., Tier 1, Tier 2)',
    `participation_status` STRING COMMENT 'Current in‑network or out‑of‑network status for the facility in this network',
    `termination_date` DATE COMMENT 'Date the facilitys participation ends or is scheduled to end',
    CONSTRAINT pk_provider_network_participation PRIMARY KEY(`provider_network_participation_id`)
) COMMENT 'Represents the contractual participation of a healthcare facility in a provider network. Each record links one facility to one network and stores attributes that describe the nature of that participation.. Existence Justification: A healthcare facility can belong to multiple provider networks simultaneously, and each provider network includes many facilities. The relationship is actively managed (contracts/agreements) and carries attributes such as participation status and effective/termination dates.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`provider`.`affiliation` (
    `affiliation_id` BIGINT COMMENT 'Primary key for affiliation',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: The affiliation product represents a Medical Staff Appointment between a healthcare facility and a provider. It requires a FK to facility to identify which facility the appointment is at. This FK is l',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: The affiliation product represents a Medical Staff Appointment between a healthcare facility and a provider. It requires a FK to provider_provider to identify which provider holds the appointment. Thi',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Medical Staff Appointments (affiliations) are often specialty-specific — a provider may hold a cardiology appointment at one hospital and a general medicine appointment at another. Adding specialty_id',
    CONSTRAINT pk_affiliation PRIMARY KEY(`affiliation_id`)
) COMMENT 'This association product represents the Medical Staff Appointment (contract/role) between a healthcare provider and a healthcare facility. It captures the operational credentialing relationship in which a provider is granted privileges at a specific facility, including the type of privileges, medical staff category, effective period, and credentialing verification status. Each record links one provider to one facility and carries attributes that exist only in the context of this specific provider-facility appointment. Supports NCQA credentialing standards, CMS provider directory accuracy mandates, and hospital privilege tracking.. Existence Justification: In healthcare, physicians and other providers hold medical staff privileges at multiple hospitals simultaneously, and each hospital credentials and grants privileges to many providers. This is a well-established operational business concept called medical staff appointment or hospital affiliation — actively managed by credentialing departments, with its own lifecycle (application, approval, expiration, renewal). The relationship carries substantial data (admitting privileges, medical staff category, effective dates, credentialing verification) that belongs to neither the provider nor the facility alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_provider_provider_id` FOREIGN KEY (`provider_provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ADD CONSTRAINT `fk_provider_license_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ADD CONSTRAINT `fk_provider_provider_affiliation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ADD CONSTRAINT `fk_provider_provider_affiliation_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ADD CONSTRAINT `fk_provider_provider_affiliation_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ADD CONSTRAINT `fk_provider_provider_affiliation_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ADD CONSTRAINT `fk_provider_provider_affiliation_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `health_insurance_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ADD CONSTRAINT `fk_provider_group_practice_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `health_insurance_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ADD CONSTRAINT `fk_provider_exclusion_screening_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ADD CONSTRAINT `fk_provider_exclusion_screening_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ADD CONSTRAINT `fk_provider_exclusion_screening_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `health_insurance_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `health_insurance_ecm`.`provider`.`specialty`(`specialty_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`provider` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `health_insurance_ecm`.`provider` SET TAGS ('dbx_domain' = 'provider');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for provider_provider');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Provider Address Line 1');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Provider Address Line 2');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `board_certification_summary_status` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Summary Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `board_certification_summary_status` SET TAGS ('dbx_value_regex' = 'complete|partial|missing');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `board_certifications` SET TAGS ('dbx_business_glossary_term' = 'Board Certifications');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Provider City');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Country Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending|revoked|suspended');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `cultural_competency_certifications` SET TAGS ('dbx_business_glossary_term' = 'Cultural Competency Certifications');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Provider Date of Birth');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `dea_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Provider Email Address');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Provider First Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Provider Gender');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `language_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency Level');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Last Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Provider License Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'Provider License State');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `malpractice_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Coverage Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `network_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^d{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'participating|non_participating|pending');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Provider Phone Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Postal Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `primary_specialty` SET TAGS ('dbx_business_glossary_term' = 'Primary Specialty');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `provider_category` SET TAGS ('dbx_business_glossary_term' = 'Provider Category');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `provider_category` SET TAGS ('dbx_value_regex' = 'physician|hospital|clinic|dme_supplier|behavioral_health|ancillary');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `provider_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `provider_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'individual|organization');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Provider State');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `status_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Status Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `status_flag` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `taxonomy_description` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Description');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `tin_ein` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number / Employer Identification Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `tin_ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `tin_ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `upin` SET TAGS ('dbx_business_glossary_term' = 'Unique Physician Identification Number (UPIN)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `upin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `upin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Provider Website URL');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `board_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Certified Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Expiration Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `certifying_board_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Board Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `credentialing_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specialty Credentialing Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `credentialing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Specialty Credentialing End Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `credentialing_review_date` SET TAGS ('dbx_business_glossary_term' = 'Specialty Credentialing Review Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Specialty Credentialing Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired|revoked');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `current_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Specialty Practice End Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `fellowship_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Fellowship Completed Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `fellowship_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Fellowship Completion Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_business_glossary_term' = 'Fellowship Program Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `hedis_specialty_flag` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Specialty Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `next_credentialing_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Specialty Credentialing Review Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `pcp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider (PCP) Eligible Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `recertification_cycle_years` SET TAGS ('dbx_business_glossary_term' = 'Recertification Cycle Years');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `record_end_date` SET TAGS ('dbx_business_glossary_term' = 'Record End Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `specialist_referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialist Referral Required Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `specialty_category` SET TAGS ('dbx_business_glossary_term' = 'Specialty Category');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Taxonomy Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `specialty_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10}X$');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Specialty Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `specialty_type` SET TAGS ('dbx_business_glossary_term' = 'Specialty Type Classification');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `specialty_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Specialty Practice Start Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `subspecialty_code` SET TAGS ('dbx_business_glossary_term' = 'Subspecialty Taxonomy Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `subspecialty_name` SET TAGS ('dbx_business_glossary_term' = 'Subspecialty Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ALTER COLUMN `years_in_specialty` SET TAGS ('dbx_business_glossary_term' = 'Years in Specialty');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Provider Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `provider_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `directory_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Display Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `fips_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `fips_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'office|hospital|clinic|urgent_care|telehealth_only|ambulatory_surgery_center');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `office_hours` SET TAGS ('dbx_business_glossary_term' = 'Office Hours');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `parking_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Parking Available Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending_credentialing');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `patient_age_maximum` SET TAGS ('dbx_business_glossary_term' = 'Patient Age Maximum');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `patient_age_minimum` SET TAGS ('dbx_business_glossary_term' = 'Patient Age Minimum');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `patient_gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender Restriction');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `patient_gender_restriction` SET TAGS ('dbx_value_regex' = 'all|male_only|female_only');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `patient_gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `patient_gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `public_transportation_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Transportation Access Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|archived');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `telehealth_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'phone_verification|site_visit|provider_attestation|electronic_verification');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `wheelchair_accessible_flag` SET TAGS ('dbx_business_glossary_term' = 'Wheelchair Accessible Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` SET TAGS ('dbx_subdomain' = 'credentialing_compliance');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `authorized_schedules` SET TAGS ('dbx_business_glossary_term' = 'Authorized Controlled Substance Schedules');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `compact_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Interstate Compact Participation Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `compact_privilege_states` SET TAGS ('dbx_business_glossary_term' = 'Compact Privilege States');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `compact_type` SET TAGS ('dbx_business_glossary_term' = 'Interstate Compact Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours Required');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `continuing_education_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Required Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `disciplinary_action_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `disciplinary_action_details` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Details');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `disciplinary_action_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `disciplinary_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `practice_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Practice Restrictions');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `primary_source_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verification (PSV) Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `primary_source_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verification (PSV) Method');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `primary_source_verification_method` SET TAGS ('dbx_value_regex' = 'online_portal|written_correspondence|phone_verification|third_party_service|automated_api');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `record_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Current Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `record_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `record_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record End Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Months');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `scope_of_practice` SET TAGS ('dbx_business_glossary_term' = 'Scope of Practice');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `telemedicine_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Telemedicine Authorized Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ALTER COLUMN `verification_url` SET TAGS ('dbx_business_glossary_term' = 'License Verification Uniform Resource Locator (URL)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` SET TAGS ('dbx_subdomain' = 'network_participation');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `provider_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `admitting_privileges_flag` SET TAGS ('dbx_business_glossary_term' = 'Admitting Privileges Indicator');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_value_regex' = 'medical_group|ipa|aco|health_system|hospital|facility');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `billing_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing National Provider Identifier (NPI)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `billing_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `credentialing_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Credentialing Verification Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `directory_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Display Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment End Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Category');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_value_regex' = 'active|courtesy|consulting|honorary|affiliate|provisional');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `network_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `next_credentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credentialing Due Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Notes');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `primary_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Affiliation Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Source Record Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `tin` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `tin` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `tin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_affiliation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'State Medicaid Provider Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `accepting_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `accessibility_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodations');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `aco_name` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `aco_participant` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participant Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 1');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 2');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number (CCN)');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Credentialing Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'initial|recredentialing|approved|denied|expired');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Legal Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `group_npi` SET TAGS ('dbx_business_glossary_term' = 'Group National Provider Identifier (NPI) - Type 2');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `group_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Group Size (Provider Count)');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `group_type` SET TAGS ('dbx_value_regex' = 'solo_practice|single_specialty_group|multi_specialty_group|ipa|fqhc|rhc');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `hospital_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Hospital Affiliation Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `language_services_offered` SET TAGS ('dbx_business_glossary_term' = 'Language Services Offered');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending_credentialing');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `pcmh_recognized` SET TAGS ('dbx_business_glossary_term' = 'Patient-Centered Medical Home (PCMH) Recognition Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `primary_specialty` SET TAGS ('dbx_business_glossary_term' = 'Primary Medical Specialty');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `recredentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN) / Employer Identification Number (EIN)');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Provider Taxonomy Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10}[X]$');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Services Enabled Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Termination Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` SET TAGS ('dbx_subdomain' = 'provider_identity');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Licensed Bed Count');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `ccn` SET TAGS ('dbx_business_glossary_term' = 'CMS Certification Number (CCN)');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `ccn` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{6}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `clia_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `clia_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}[A-Z][0-9]{7}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `credentialing_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'approved|pending|expired|suspended|denied');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `critical_access_hospital_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Access Hospital (CAH) Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `emergency_services_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'hospital|snf|asc|fqhc|rhc|behavioral_health');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `medicaid_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Certified Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `medicare_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicare Certified Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|out_of_network');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'for_profit|non_profit|government|tribal');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `parent_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating Score');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `teaching_hospital_flag` SET TAGS ('dbx_business_glossary_term' = 'Teaching Hospital Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Center Designation Level');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_designated');
ALTER TABLE `health_insurance_ecm`.`provider`.`facility` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` SET TAGS ('dbx_subdomain' = 'network_participation');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `directory_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Directory Entry Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `provider_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Entry ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `attestation_method` SET TAGS ('dbx_business_glossary_term' = 'Attestation Method');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `attestation_method` SET TAGS ('dbx_value_regex' = 'provider_portal|phone_verification|email_verification|site_visit|third_party_vendor');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `attestation_status` SET TAGS ('dbx_business_glossary_term' = 'Directory Attestation Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `attestation_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|failed_verification|not_verified');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `board_certifications` SET TAGS ('dbx_business_glossary_term' = 'Board Certifications');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `directory_display_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Display Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `directory_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Directory Publication Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Provider Gender');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|not_disclosed');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `hospital_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Hospital Affiliation');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `medical_school` SET TAGS ('dbx_business_glossary_term' = 'Medical School');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `medical_school` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `medical_school` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|out_of_network');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `participation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Participation Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `participation_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `pcp_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider (PCP) Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `practice_website_url` SET TAGS ('dbx_business_glossary_term' = 'Practice Website URL');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'individual|group|facility|ancillary|dme_supplier|behavioral_health');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `telehealth_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `tin` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `tin` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ALTER COLUMN `tin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` SET TAGS ('dbx_subdomain' = 'credentialing_compliance');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Screening ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `fwa_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fwa Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `cms_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Overdue|Pending Review|Non-Compliant|Waived');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `data_source_version` SET TAGS ('dbx_business_glossary_term' = 'Data Source Version');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion End Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_type` SET TAGS ('dbx_value_regex' = 'Federal|State|Both|None');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `match_details` SET TAGS ('dbx_business_glossary_term' = 'Match Details');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Match Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'Exact NPI Match|Name and DOB Match|Name and Address Match|Partial Match|No Match');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `next_screening_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Screening Due Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `prior_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Screening Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'No Action Required|Provider Terminated|Contract Suspended|Manual Review Pending|False Positive Confirmed|Waiver Granted');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screened_by_name` SET TAGS ('dbx_business_glossary_term' = 'Screened By Name');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_frequency` SET TAGS ('dbx_business_glossary_term' = 'Screening Frequency');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Annual|Ad Hoc|Initial Credentialing');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_value_regex' = 'Automated Batch|Manual Lookup|API Integration|Third-Party Vendor');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_value_regex' = 'Clear|Match Found|Potential Match|Inconclusive|Error');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_source` SET TAGS ('dbx_business_glossary_term' = 'Screening Source');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_source` SET TAGS ('dbx_value_regex' = 'OIG LEIE|SAM.gov|State Medicaid Exclusion|GSA EPLS|Multiple Sources');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `screening_vendor` SET TAGS ('dbx_business_glossary_term' = 'Screening Vendor');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `state_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'State Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ALTER COLUMN `vendor_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Transaction ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` SET TAGS ('dbx_subdomain' = 'credentialing_compliance');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Dea Registration Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `controlled_substance_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Authorization Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `current_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Number');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}d{7}$');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Expiration Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Issue Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Notes');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `record_end_date` SET TAGS ('dbx_business_glossary_term' = 'Record End Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `registration_state` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration State');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|surrendered|pending');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Type');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'individual|organization');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `schedule_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized DEA Schedule');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `schedule_authorized` SET TAGS ('dbx_value_regex' = 'II|III|IV|V');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verification Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` SET TAGS ('dbx_subdomain' = 'network_participation');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `provider_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Networkparticipation - Network Participation Id');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Networkparticipation - Facility Id');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Networkparticipation - Provider Network Id');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` SET TAGS ('dbx_subdomain' = 'network_participation');
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` SET TAGS ('dbx_association_edges' = 'provider.provider_provider,provider.facility');
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` ALTER COLUMN `affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'affiliation Identifier');
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`provider`.`affiliation` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
