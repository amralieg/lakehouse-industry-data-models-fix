-- Schema for Domain: beneficiary | Business: Ngo | Version: v1_mvm
-- Generated on: 2026-05-07 03:36:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ngo_ecm`.`beneficiary` COMMENT 'Single source of truth for all individuals, households, and communities served by humanitarian and development programs. Owns beneficiary identity, registration, vulnerability profiling, needs assessments, consent management, and case management. Covers IDPs, PoCs (Persons of Concern), GBV survivors, and all target populations tracked in CommCare and KoboToolbox.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`registrant` (
    `registrant_id` BIGINT COMMENT 'Unique surrogate identifier for each registrant record in the beneficiary domain. Serves as the primary key and identity anchor for all beneficiary-domain transactions across CommCare, KoboToolbox, and interoperability mappings to UNHCR proGres v4, WFP SCOPE, and RAIS.',
    `deduplication_master_registrant_id` BIGINT COMMENT 'The beneficiary_id of the authoritative master record when this registrant has been identified as a duplicate. Null for unique records. Enables lineage tracing from duplicate to canonical record for audit and reporting.',
    `household_id` BIGINT COMMENT 'Identifier linking this registrant to their household unit. Enables household-level aggregation for NFI distribution, WASH targeting, and food security assessments. Household head registrant carries the authoritative household record.',
    `intervention_id` BIGINT COMMENT 'Externally-known unique beneficiary identifier assigned at registration, used for cross-system interoperability with UNHCR proGres v4, WFP SCOPE, and RAIS case records. Printed on beneficiary cards and referenced in all program transactions.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Beneficiary registration occurs at specific field sites (health posts, distribution points, registration centers). Essential for geographic program planning, site-level performance reporting, and link',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Nonprofits must screen beneficiaries against OFAC, UN, EU sanctions lists before providing assistance per donor compliance requirements (USAID, FCDO, EU). Mandatory regulatory process for counter-terr',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or community health worker who conducted the registration. Used for accountability, data quality audits, and field staff performance monitoring. Links to workforce.staff_member.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Individual beneficiaries collect assistance from assigned warehouses/distribution points. Critical for voucher programs, individual assistance, and beneficiary notification systems. Enables proximity-',
    `age_years` STRING COMMENT 'Registrants age in whole years at the time of registration. Stored explicitly to support age-band analytics and program eligibility checks when date_of_birth is estimated or unavailable. Derived from date_of_birth where known; otherwise entered directly.',
    `completeness_score` DECIMAL(18,2) COMMENT 'Percentage score (0–100) reflecting the completeness of the registrants registration profile based on mandatory and recommended fields populated. Used for data quality monitoring, field staff performance tracking, and MEL data quality assessments.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the registrant or their legal guardian. Required for GDPR compliance audit trails and CHS accountability reporting.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the registrant (or legal guardian for minors) has provided informed consent for data collection, storage, and use per organizational data protection policy and applicable regulations. Mandatory for all registrations per CHS Commitment 4.',
    `country_of_origin_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code for the registrants country of origin. Distinct from nationality for stateless persons and IDPs. Used for displacement tracking, protection analysis, and OCHA SitRep reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registrant record was first created in the data platform (Silver Layer). Serves as the audit trail anchor for data lineage, GDPR data retention calculations, and compliance reporting.',
    `date_of_birth` DATE COMMENT 'The registrants date of birth in yyyy-MM-dd format. Used for age calculation, vulnerability profiling, child protection flags, and eligibility determination for age-targeted programs (e.g., SAM/GAM nutrition screening, PSS services).',
    `deduplication_status` STRING COMMENT 'Current status of the deduplication check for this registrant record. Duplicate records are suppressed from active program counts. Merged indicates the record was consolidated with a master record. Supports USAID and DFID double-counting prevention requirements.. Valid values are `pending|unique|duplicate|merged|flagged`',
    `disability_type` STRING COMMENT 'Classification of the registrants disability type per Washington Group Short Set categories. Used for targeted accommodation planning, assistive device provision, and inclusive program design. Only populated when has_disability is True. [ENUM-REF-CANDIDATE: mobility|vision|hearing|cognitive|psychosocial|multiple|other — 7 candidates stripped; promote to reference product]',
    `family_name` STRING COMMENT 'The registrants family name or surname as recorded at registration. Combined with given_name for full identity display and deduplication matching.',
    `given_name` STRING COMMENT 'The registrants given name (first name) as recorded at registration. Used for identity verification, case management, and beneficiary communication.',
    `has_disability` BOOLEAN COMMENT 'Indicates whether the registrant has a reported disability. Used for inclusive programming, accessibility accommodations, and Washington Group Short Set disaggregation in MEL reporting per IASC disability inclusion guidelines.',
    `is_gbv_survivor` BOOLEAN COMMENT 'Indicates whether the registrant has been identified as a Gender-Based Violence (GBV) survivor. Triggers GBV case management referral, PSS services, and safe space access. Stored with highest data protection classification per GBV information management principles.',
    `is_pregnant_or_lactating` BOOLEAN COMMENT 'Indicates whether the registrant is a pregnant or lactating woman (PLW). Triggers priority access to nutrition programs (SAM/GAM treatment, supplementary feeding), antenatal care referrals, and PLW-specific NFI kits.',
    `is_unaccompanied_minor` BOOLEAN COMMENT 'Indicates whether the registrant is an unaccompanied or separated child (UASC). Triggers child protection protocols, best-interest assessments, and mandatory referral to child protection case management per UNHCR/UNICEF UASC guidelines.',
    `last_verification_date` DATE COMMENT 'Date of the most recent identity or liveness verification for this registrant. Used to flag records requiring re-verification per program cycle requirements and to support active beneficiary count accuracy for donor reporting.',
    `muac_cm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in centimetres recorded at registration or nutrition screening. Used to classify acute malnutrition status (SAM: <11.5cm, MAM: 11.5–12.5cm) per Sphere/WHO nutrition protocols. Applicable for children 6–59 months and PLW.',
    `nationality_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the registrants nationality. Used for protection status determination, IDP/refugee classification, and donor reporting disaggregation.. Valid values are `^[A-Z]{3}$`',
    `poc_category` STRING COMMENT 'UNHCR-aligned classification of the registrants protection status as a Person of Concern (PoC). Drives protection programming, legal aid eligibility, and UNHCR/OCHA statistical reporting. [ENUM-REF-CANDIDATE: refugee|idp|returnee|stateless|asylum_seeker|host_community|other — promote to reference product]',
    `preferred_language_code` STRING COMMENT 'ISO 639 language code for the registrants preferred communication language. Used to assign appropriate interpreters, translated materials, and language-appropriate PSS services. Supports CHS Commitment 4 on accessible communication.. Valid values are `^[a-z]{2,3}$`',
    `protection_flag` BOOLEAN COMMENT 'Master protection concern flag indicating the registrant has one or more active protection risks (GBV, UASC, trafficking, detention risk, etc.). Triggers protection case management workflow and restricts data sharing per CHS data protection principles.',
    `re_registration_count` STRING COMMENT 'Number of times this registrant has been re-registered in the system (e.g., after displacement, camp relocation, or annual verification cycles). Supports re-registration tracking and historical registration event analysis.',
    `registration_date` DATE COMMENT 'The date on which the registrant was first formally registered into the beneficiary system. Used as the baseline date for program enrollment timelines, cohort analysis, and compliance reporting to donors (USAID BHA, DFID).',
    `registration_modality` STRING COMMENT 'The channel or method through which the registrant was enrolled. Distinguishes in-person field registration, mobile data collection (KoboToolbox/CommCare), remote registration (phone/online), and self-registration kiosks. Informs data quality scoring and verification requirements.. Valid values are `in_person|mobile|remote|self_registration`',
    `registration_source_system` STRING COMMENT 'The operational system of record from which this registrant record originated. Supports data lineage, deduplication across systems, and interoperability mapping to UNHCR proGres v4, WFP SCOPE, and RAIS.. Valid values are `commcare|kobotoolbox|progres_v4|wfp_scope|rais|manual`',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registrant record. Controls eligibility for program services, NFI distributions, and case management workflows. Duplicate status is set by the deduplication process; departed indicates the individual has left the program area.. Valid values are `active|inactive|deceased|departed|duplicate|suspended`',
    `registration_tool` STRING COMMENT 'The specific data collection tool or form used to capture the registration. Distinguishes KoboToolbox survey forms, CommCare mobile case forms, paper-based forms, and direct system entry. Informs data quality and field validation rules.. Valid values are `kobotoolbox|commcare|paper_form|progres_v4|scope|other`',
    `registration_type` STRING COMMENT 'Classifies the registrant as an individual, household head, household member, or community-level registration. Determines the unit of analysis for program targeting, NFI distribution, and beneficiary counting methodologies.. Valid values are `individual|household_head|household_member|community`',
    `sex` STRING COMMENT 'Biological sex of the registrant as recorded at registration. Used for DAC-compliant gender disaggregation in MEL reporting, GBV protection screening, and SPHERE-aligned needs assessments.. Valid values are `male|female|other|unknown`',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating source system (e.g., CommCare case_id, KoboToolbox submission UUID, proGres v4 individual_id). Enables bidirectional traceability and re-synchronization with operational systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this registrant record in the data platform. Used for incremental data processing, change data capture, and audit trail compliance.',
    `verification_document_number` STRING COMMENT 'The document number from the identity verification document presented at registration (e.g., national ID number, passport number, UNHCR card number). Stored encrypted; used for deduplication and re-registration identity matching.',
    `verification_document_type` STRING COMMENT 'Type of identity verification document presented at registration. Used for identity assurance scoring, fraud prevention, and compliance with donor KYB (Know Your Beneficiary) requirements. Community attestation applies where formal documents are unavailable.. Valid values are `national_id|passport|unhcr_card|birth_certificate|community_attestation|none`',
    `vulnerability_category` STRING COMMENT 'Categorical classification of the registrants vulnerability level derived from the vulnerability_score. Drives program targeting decisions, priority service access, and donor reporting on most-vulnerable population coverage.. Valid values are `critical|high|medium|low`',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Composite vulnerability index score calculated from the needs assessment, capturing food insecurity, protection risks, health status, and displacement severity. Used for program prioritization, targeting, and MEL outcome tracking. Score range and methodology defined per program LogFrame.',
    CONSTRAINT pk_registrant PRIMARY KEY(`registrant_id`)
) COMMENT 'Core master entity for every individual registered as a beneficiary or person of concern (PoC). Stores biographic data (name, date of birth, sex, nationality), unique beneficiary ID, registration source system (CommCare, KoboToolbox), protection flags, deduplication status, and full registration metadata including registration date, location, modality (in-person, mobile, remote), registration tool, registering staff, verification documents presented, completeness score, and deduplication check results. Supports re-registration tracking with historical registration events. Serves as the single identity anchor for all beneficiary-domain transactions. Interoperable with UNHCR proGres v4 individual records, WFP SCOPE beneficiary records, and RAIS case records via standard beneficiary ID mapping.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`household` (
    `household_id` BIGINT COMMENT 'Unique system-generated identifier for the household record. Primary key for the household master entity in the beneficiary domain. Role: MASTER_AGREEMENT — a household registration is a long-running binding container linking individuals to service delivery.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Donor reporting requires tracking which award funds each households assistance package. NGOs report beneficiaries reached per award to donors; a direct household→award link enables this without tra',
    `community_id` BIGINT COMMENT 'Reference to the community or settlement record where the household is located. Supports geographic aggregation for WASH assessments, food security cluster reporting, and GIS-based programme planning via Humanitarian OpenStreetMap.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Households are registered in the context of specific emergencies (e.g., flood response registration drive). Emergency-level household registration counts are a core humanitarian metric for flash appea',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Household registration: volunteers conduct household registrations in the field. Tracking the enumerating volunteer per household is standard for data quality audits, supervision accountability, and r',
    `intervention_id` BIGINT COMMENT 'Reference to the programme under which this household was registered and is receiving services. Links to the programme master product in the Program domain for LogFrame, Theory of Change, and donor grant alignment.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Households are registered and served at specific field locations. Critical for household-level service delivery tracking, geographic targeting analysis, and site-based program planning. Standard pract',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff or volunteer who conducted the household registration or most recent needs assessment. Used for data quality audits, enumerator performance tracking, and MEAL accountability reviews.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Subaward compliance requires tracking how many households receive services under each subaward for financial accountability and monitoring. NGOs must verify subaward deliverables (households served) a',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Households are assigned to specific warehouses/distribution points for assistance collection based on geographic proximity. Essential for last-mile distribution planning, beneficiary mobilization, and',
    `admin1_name` STRING COMMENT 'Name of the first-level administrative division (region, province, or state) where the household is located. Aligns with OCHA Common Operational Datasets (CODs) administrative boundary layer 1 for GIS mapping and cluster reporting.',
    `admin2_name` STRING COMMENT 'Name of the second-level administrative division (district, county, or department) where the household is located. Used for sub-national programme targeting, cluster coordination, and DHIS2 geographic disaggregation.',
    `children_under5_count` STRING COMMENT 'Number of children aged 0–4 years in the household. Critical for nutrition programme targeting (Global Acute Malnutrition / Severe Acute Malnutrition screening), UNICEF child protection reporting, and SPHERE minimum standards for child-specific NFI distributions.',
    `commcare_case_reference` STRING COMMENT 'Unique case identifier from CommCare mobile case management system for this household. Enables bidirectional synchronisation between the lakehouse silver layer and CommCare for community health worker follow-up, beneficiary tracking, and case status updates.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the head of household. Required for GDPR data processing records, CHS accountability documentation, and audit trails for data protection compliance reviews.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for data collection and processing was obtained from the head of household at the time of registration. Mandatory for GDPR compliance, CHS Commitment 4 accountability, and HAP Standard data protection requirements.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the households country of origin or habitual residence prior to displacement. Required for UNHCR refugee population statistics, OCHA Humanitarian Response Plan disaggregation, and IATI geographic coding.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the system. Serves as the audit trail creation marker for data governance, GDPR data processing records, and silver layer lineage tracking in the Databricks Lakehouse.',
    `current_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the household is currently residing. Used for cross-border programme coordination, OCHA SitRep geographic disaggregation, and IATI location reporting.. Valid values are `^[A-Z]{3}$`',
    `deregistration_date` DATE COMMENT 'Calendar date on which the household exited or was closed from the programme. Nullable for active households. Used to calculate programme duration, exit analysis, and MEL outcome tracking. Corresponds to the effective-until date of the household registration agreement.',
    `displacement_date` DATE COMMENT 'Date on which the household was displaced from their place of habitual residence. Used for durable solutions planning, return and reintegration programming, and UNHCR proGres displacement history tracking.',
    `displacement_status` STRING COMMENT 'Classification of the households displacement situation. Internally Displaced Person (IDP), refugee, returnee, host community, stateless, or asylum seeker. Determines eligibility for specific UNHCR, OCHA, and WFP programme streams and drives proGres v4 population group assignment. [ENUM-REF-CANDIDATE: idp|refugee|returnee|host_community|stateless|asylum_seeker — promote to reference product]. Valid values are `idp|refugee|returnee|host_community|stateless|asylum_seeker`',
    `elderly_count` STRING COMMENT 'Number of household members aged 60 years or older. Used for vulnerability scoring, priority targeting in food security and health programmes, and age-disaggregated donor reporting per OCHA and IASC standards.',
    `exit_reason` STRING COMMENT 'Reason for the households exit or closure from the programme. Used for MEL outcome analysis, durable solutions tracking, and donor reporting on programme completion rates. Nullable for active households. [ENUM-REF-CANDIDATE: graduated|relocated|deceased|voluntary_withdrawal|ineligible|duplicate|lost_to_followup — promote to reference product]',
    `female_count` STRING COMMENT 'Number of female individuals in the household. Required for sex-disaggregated reporting to OCHA, USAID, and DFID donors. Supports gender analysis in MEL frameworks and IASC gender marker compliance.',
    `food_security_status` STRING COMMENT 'Household-level food security classification based on the Integrated Food Security Phase Classification (IPC) or Household Food Insecurity Access Scale (HFIAS). Drives WFP food assistance targeting, cash transfer programme eligibility, and OCHA food security cluster reporting.. Valid values are `food_secure|mildly_insecure|moderately_insecure|severely_insecure`',
    `gbv_risk_flag` BOOLEAN COMMENT 'Indicates whether the household has been identified as at elevated risk of or affected by Gender-Based Violence (GBV). Classified restricted due to sensitivity. Triggers referral to GBV case management, PSS (Psychosocial Support) services, and safe space programming. Access strictly controlled per GBV information management protocols.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the households physical location in decimal degrees (WGS84). Captured via KoboToolbox GPS widget during field registration. Used for GIS mapping, proximity analysis, and Humanitarian OpenStreetMap integration. Classified confidential as precise location of vulnerable individuals.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the households physical location in decimal degrees (WGS84). Captured via KoboToolbox GPS widget during field registration. Used for GIS mapping, proximity analysis, and Humanitarian OpenStreetMap integration. Classified confidential as precise location of vulnerable individuals.',
    `has_pregnant_lactating` BOOLEAN COMMENT 'Indicates whether the household includes at least one pregnant or lactating woman (PLW). Critical flag for nutrition programme targeting (supplementary feeding, micronutrient supplementation), SPHERE nutrition standards compliance, and UNICEF/WFP PLW-specific assistance eligibility.',
    `has_unaccompanied_minor` BOOLEAN COMMENT 'Indicates whether the household includes an unaccompanied or separated child (UASC). Triggers child protection case management protocols in CommCare, UNHCR UASC registration procedures, and UNICEF child protection programme referrals.',
    `is_female_headed` BOOLEAN COMMENT 'Indicates whether the household is headed by a woman. Key targeting criterion for GBV (Gender-Based Violence) prevention programmes, womens economic empowerment initiatives, and IASC gender marker reporting. Required for USAID gender equality disaggregation.',
    `kobo_submission_reference` STRING COMMENT 'Unique identifier of the KoboToolbox form submission that created or last updated this household record. Enables traceability back to the original field data collection form for data quality audits, MEAL verification, and source system reconciliation.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent household-level needs assessment or vulnerability re-assessment conducted. Used to identify households overdue for reassessment, track MEL data currency, and ensure programme targeting reflects current conditions per MEAL cycle requirements.',
    `male_count` STRING COMMENT 'Number of male individuals in the household. Required for sex-disaggregated reporting to OCHA, USAID, and DFID donors. Supports gender analysis in MEL frameworks and IASC gender marker compliance.',
    `notes` STRING COMMENT 'Free-text field for field staff to record contextual observations, special circumstances, or case management notes about the household that do not fit structured fields. Classified confidential due to potential sensitivity of recorded information. Supports CommCare case notes and KoboToolbox open-text responses.',
    `pwd_count` STRING COMMENT 'Number of household members with a physical, sensory, intellectual, or psychosocial disability. Required for IASC disability inclusion reporting, Washington Group Short Set disaggregation, and inclusive programming compliance under the CRPD.',
    `registration_date` DATE COMMENT 'Calendar date on which the household was first formally registered into the programme. Serves as the effective start date of the household agreement with the organisation. Used for cohort analysis, programme duration calculations, and donor reporting.',
    `registration_number` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the household at point of registration. Used across field operations, NFI distribution lists, WASH assessments, and food security programming as the primary cross-system reference. Corresponds to the SCOPE household token or proGres case number.',
    `registration_status` STRING COMMENT 'Current lifecycle state of the household registration. Active indicates the household is enrolled and eligible for services. Suspended indicates a temporary hold pending verification. Closed indicates the household has exited programming. Drives eligibility checks in CommCare and Microsoft Dynamics 365 case management.. Valid values are `active|suspended|closed|pending_verification|archived`',
    `registration_type` STRING COMMENT 'Classification of the registration event that created or last updated this household record. Distinguishes initial intake from periodic re-verification exercises required by UNHCR and WFP programme cycles.. Valid values are `initial|re-registration|update|verification`',
    `sanitation_facility_type` STRING COMMENT 'Classification of the households primary sanitation facility. Core WASH indicator for SPHERE minimum standards, OCHA WASH cluster reporting, and WHO/UNICEF Joint Monitoring Programme (JMP) SDG 6 tracking. [ENUM-REF-CANDIDATE: flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none — promote to reference product]. Valid values are `flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none`',
    `shelter_ownership` STRING COMMENT 'Tenure status of the households current shelter. Distinguishes owned, rented, informal/squatter, organisation-provided, or communal arrangements. Used for durable solutions planning, land rights programming, and UNHCR shelter vulnerability assessments.. Valid values are `owned|rented|informal|provided_by_org|communal`',
    `shelter_type` STRING COMMENT 'Classification of the households current shelter situation. Used for SPHERE shelter standard compliance assessments, NFI kit targeting (shelter kits vs. core relief items), and OCHA shelter cluster reporting. [ENUM-REF-CANDIDATE: permanent|semi-permanent|temporary|makeshift|collective_centre|host_family|none — promote to reference product]',
    `size` STRING COMMENT 'Total count of individuals residing in the household at the time of last registration or update. Used for NFI distribution quantity calculations, food ration sizing, WASH facility planning, and WFP SCOPE entitlement computation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the household record. Used for incremental data pipeline processing, change data capture in the Databricks Lakehouse silver layer, and audit trail compliance.',
    `vulnerability_category` STRING COMMENT 'Categorical classification of household vulnerability derived from the vulnerability score or direct assessment. Used for programme targeting tiers, priority service delivery sequencing, and donor reporting on most-vulnerable population reach.. Valid values are `low|medium|high|critical`',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Composite numeric score representing the households overall vulnerability level, calculated from a standardised vulnerability assessment tool (e.g., Proxy Means Test, Household Economy Analysis). Used for priority targeting, programme tiering, and MEL outcome baseline establishment. Score range and methodology defined per programme.',
    `water_source_type` STRING COMMENT 'Classification of the households primary drinking water source. Core WASH (Water, Sanitation and Hygiene) indicator required for SPHERE minimum standards compliance, OCHA WASH cluster reporting, and DHIS2 WASH indicator tracking. [ENUM-REF-CANDIDATE: piped|borehole|protected_spring|unprotected_spring|surface_water|trucked|rainwater — promote to reference product]',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Master record for a household unit as the primary unit of registration and service delivery in humanitarian contexts. Captures household composition count, head-of-household reference (FK to registrant), geographic location, community/settlement reference, shelter type, displacement status, and household-level vulnerability indicators. Links individual registrants to their household grouping via household_member association for NFI distribution, WASH assessments, and food security programming. Supports WFP SCOPE household registration and UNHCR proGres family composition interoperability.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`household_member` (
    `household_member_id` BIGINT COMMENT 'Unique surrogate identifier for each household member association record in the beneficiary domain. Primary key for this entity.',
    `case_record_id` BIGINT COMMENT 'Reference to the CommCare or Microsoft Dynamics 365 case management record associated with this household member. Used for case follow-up, service delivery tracking, and MEL (Monitoring Evaluation and Learning) outcome measurement.',
    `household_id` BIGINT COMMENT 'Reference to the household to which this individual belongs. Links the member record to the household registration unit for NFI distribution sizing and vulnerability scoring.',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: NGO program reach reporting requires tracking which intervention each household member is enrolled in. Disaggregated beneficiary counts (by sex, age, disability) per intervention are mandatory for don',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary registration record for this household member. Links to the beneficiary master record captured in CommCare or KoboToolbox.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the field enumerator or data collector who registered this household member. Used for data quality audits, enumerator performance monitoring, and traceability of field data in KoboToolbox and CommCare.',
    `age_estimated` BOOLEAN COMMENT 'Indicates whether the recorded age or date of birth is an estimate rather than a verified value. Common in humanitarian field contexts where documentation is unavailable. Affects data quality scoring for MEL reporting.',
    `age_years` STRING COMMENT 'Recorded or estimated age of the household member in years at time of registration. Used when exact date of birth is unknown, which is common in humanitarian contexts. Supports age-band disaggregation for NFI sizing and program targeting.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from this household member or their legal guardian. Required for GDPR compliance audit trails and CHS (Core Humanitarian Standard) accountability reporting.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether this household member (or their guardian) has provided informed consent for data collection, storage, and use in program delivery. Mandatory per CHS (Core Humanitarian Standard) and GDPR data protection requirements.',
    `consent_withdrawal_date` DATE COMMENT 'Date on which this household member or their guardian withdrew consent for data processing. Triggers data anonymisation or deletion workflows per GDPR Article 17 right to erasure.',
    `country_of_origin_code` STRING COMMENT 'ISO 3166-1 alpha-3 code for the country from which the household member originates. Distinct from nationality; used for refugee and IDP classification, UNHCR PoC (Person of Concern) reporting, and cross-border displacement analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this household member association record was first created in the system. Used for audit trails, data lineage, and MEL (Monitoring Evaluation and Learning) data quality reporting.',
    `data_collection_method` STRING COMMENT 'Method used to collect this household members registration data. FGD (Focus Group Discussion), KII (Key Informant Interview), KoboToolbox survey, or CommCare mobile form. Used for data quality assessment and MEL methodology documentation.. Valid values are `kobo_survey|commcare_mobile|paper_form|fgd|kii|other`',
    `date_of_birth` DATE COMMENT 'Date of birth of the household member. Used to calculate age for program eligibility (e.g., child nutrition programs, elderly support), dependency ratio, and demographic disaggregation in MEL reporting.',
    `disability_status` STRING COMMENT 'Recorded disability classification for the household member using the Washington Group Short Set framework. Used for inclusive programming, NFI adaptation, and SPHERE accessibility compliance reporting. [ENUM-REF-CANDIDATE: none|physical|sensory|cognitive|psychosocial|multiple|prefer_not_to_say — 7 candidates stripped; promote to reference product]',
    `displacement_status` STRING COMMENT 'Classification of the household members displacement situation. IDP (Internally Displaced Person), refugee, returnee, or host community member. Drives program eligibility, UNHCR PoC (Person of Concern) reporting, and OCHA SitRep (Situation Report) disaggregation. [ENUM-REF-CANDIDATE: idp|refugee|returnee|host_community|stateless|asylum_seeker|other — 7 candidates stripped; promote to reference product]',
    `education_level` STRING COMMENT 'Highest level of education attained by this household member. Used for livelihood program targeting, literacy-based service adaptation, and SDG (Sustainable Development Goal) 4 education indicator reporting. [ENUM-REF-CANDIDATE: none|primary_incomplete|primary_complete|secondary_incomplete|secondary_complete|tertiary|vocational|other — promote to reference product]',
    `family_name` STRING COMMENT 'Surname or family name of the household member as recorded during beneficiary registration. Combined with given_name for full identity verification.',
    `gender_identity` STRING COMMENT 'Self-identified gender of the household member, captured where programmatically relevant (e.g., GBV programs, PSS (Psychosocial Support) services). Distinct from biological sex. Collected only with informed consent per data protection standards.',
    `given_name` STRING COMMENT 'First or given name of the household member as recorded during beneficiary registration. Used for identity verification during distributions and case management follow-up.',
    `is_female_headed` BOOLEAN COMMENT 'Indicates whether this member is the head of a female-headed household. Used for gender-disaggregated reporting, targeted programming for female-headed households, and DAC (Development Assistance Committee) gender marker compliance.',
    `is_head_of_household` BOOLEAN COMMENT 'Indicates whether this member is the designated head of household. Only one member per household should have this flag set to true. Used for primary contact identification, distribution authorization, and household-level reporting.',
    `livelihood_status` STRING COMMENT 'Current livelihood or employment status of the household member. Used for economic vulnerability assessment, cash transfer program eligibility, and livelihoods program targeting.. Valid values are `employed|self_employed|unemployed|student|unable_to_work|not_applicable`',
    `member_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this household member association, used in field operations, PDM (Post-Distribution Monitoring) forms, and inter-agency data sharing.. Valid values are `^HHM-[A-Z0-9]{6,12}$`',
    `member_role` STRING COMMENT 'Functional role of this individual within the household structure, used for program targeting, NFI kit sizing, and household vulnerability profiling. Distinct from relationship_to_head which captures kinship; this captures programmatic classification.. Valid values are `head|spouse|child|dependent|elderly|other`',
    `membership_end_date` DATE COMMENT 'Date on which this individuals membership in the household ended, due to departure, transfer, death, or administrative closure. Null if membership is currently active.',
    `membership_end_reason` STRING COMMENT 'Reason code explaining why this individuals household membership ended. Required for attrition analysis, household composition tracking, and MEL (Monitoring Evaluation and Learning) reporting.. Valid values are `deceased|transferred_household|relocated|voluntary_exit|administrative_closure|other`',
    `membership_start_date` DATE COMMENT 'Date on which this individual formally joined or was registered as a member of the household. Used to determine eligibility windows for program benefits and historical household composition analysis.',
    `membership_status` STRING COMMENT 'Current lifecycle status of this individuals membership in the household. Drives eligibility for household-level distributions and services. transferred indicates movement to another household; departed indicates voluntary exit.. Valid values are `active|inactive|transferred|deceased|departed`',
    `muac_assessment_date` DATE COMMENT 'Date on which the MUAC (Mid-Upper Arm Circumference) measurement was recorded for this household member. Used to determine recency of nutritional screening and trigger follow-up assessments per SPHERE protocols.',
    `muac_cm` DECIMAL(18,2) COMMENT 'MUAC (Mid-Upper Arm Circumference) measurement in centimetres recorded for this household member. Primary screening indicator for acute malnutrition (SAM/GAM). Values below 11.5cm indicate SAM (Severe Acute Malnutrition); 11.5–12.5cm indicate MAM (Moderate Acute Malnutrition).',
    `nationality_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the nationality of the household member. Used for IDP (Internally Displaced Person) and PoC (Person of Concern) classification, cross-border program eligibility, and UNHCR reporting.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for field staff to record additional observations, special circumstances, or case notes relevant to this household members situation. Classified as confidential due to potential sensitivity of recorded information.',
    `pregnant_or_lactating` BOOLEAN COMMENT 'Indicates whether this household member is currently pregnant or lactating. Used for nutrition program targeting (e.g., SAM/GAM treatment), supplementary feeding eligibility, and SPHERE maternal health standards compliance.',
    `primary_language_code` STRING COMMENT 'ISO 639-1/639-2 language code for the primary language spoken by this household member. Used for communication planning, interpreter assignment, and ensuring informed consent is obtained in the members language per CHS (Core Humanitarian Standard).. Valid values are `^[a-z]{2,3}$`',
    `protection_concern_flag` BOOLEAN COMMENT 'Indicates whether this household member has an active protection concern (e.g., GBV risk, child protection issue, trafficking risk). Triggers case escalation in CommCare and referral to protection cluster. Stored as restricted due to sensitivity.',
    `registration_date` DATE COMMENT 'Date on which this household member was formally registered in the beneficiary management system (CommCare or KoboToolbox). Establishes the start of the individuals program eligibility timeline.',
    `registration_location_code` STRING COMMENT 'Code identifying the geographic location (camp, settlement, community, or administrative unit) where this household member was registered. Used for geographic disaggregation in MEL reporting and GIS (Geographic Information System) mapping.. Valid values are `^[A-Z]{2,3}-[A-Z0-9]{3,10}$`',
    `relationship_to_head` STRING COMMENT 'Describes the kinship or social relationship of this member to the designated head of household. Used for dependency ratio calculations, vulnerability scoring, and NFI distribution entitlement. [ENUM-REF-CANDIDATE: head|spouse|child|parent|sibling|dependent|other_relative|non_relative — promote to reference product]',
    `school_enrollment_status` STRING COMMENT 'Current school enrollment status for household members of school age. Used for education program targeting, out-of-school children identification, and SDG 4 indicator tracking in DHIS2.. Valid values are `enrolled|not_enrolled|dropout|graduated|not_applicable`',
    `sex` STRING COMMENT 'Biological sex of the household member as recorded at registration. Used for gender disaggregation in MEL reporting, GBV (Gender-Based Violence) program targeting, and SPHERE/DAC (Development Assistance Committee) compliance reporting.. Valid values are `male|female|intersex|prefer_not_to_say`',
    `unaccompanied_minor` BOOLEAN COMMENT 'Indicates whether this household member is an unaccompanied or separated child (UASC). Triggers child protection protocols, case management escalation in CommCare, and mandatory reporting to child protection clusters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this household member association record was last modified. Used for change tracking, data synchronisation between CommCare/KoboToolbox and the lakehouse, and audit compliance.',
    `verification_date` DATE COMMENT 'Date on which the identity and eligibility verification was completed for this household member. Used for audit trails and determining when re-verification is due.',
    `verification_status` STRING COMMENT 'Status of identity and eligibility verification for this household member. verified indicates documentation has been reviewed and confirmed; rejected indicates the member failed verification and is ineligible for program benefits.. Valid values are `unverified|pending|verified|rejected`',
    `vulnerability_category` STRING COMMENT 'Primary vulnerability classification for this household member, used for program targeting, priority distribution, and MEL (Monitoring Evaluation and Learning) disaggregation. GBV (Gender-Based Violence) survivors and unaccompanied minors receive heightened protection protocols. [ENUM-REF-CANDIDATE: child_under_5|unaccompanied_minor|pregnant_lactating|elderly|gbv_survivor|disability|chronic_illness|other — promote to reference product]',
    CONSTRAINT pk_household_member PRIMARY KEY(`household_member_id`)
) COMMENT 'Association entity linking an individual registrant to their household. Captures role (head, spouse, child, dependent, elderly), relationship to head-of-household, membership start/end dates, and demographic attributes relevant to household composition analysis. Enables NFI distribution sizing, dependency ratio calculations, and vulnerability scoring at household level.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` (
    `vulnerability_profile_id` BIGINT COMMENT 'Unique system-generated identifier for the vulnerability profile record. Primary key for this entity.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Vulnerability assessment quality assurance: trained volunteers (community health volunteers, enumerators) conduct vulnerability assessments. Tracking the assessing volunteer per profile is required fo',
    `community_id` BIGINT COMMENT 'Foreign key linking to beneficiary.community. Business justification: Vulnerability profiles in humanitarian programs are conducted not only for individuals and households but also at the community level (e.g., community vulnerability assessments for IPC phase classific',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Vulnerability assessment methodologies and scoring criteria are mandated by donor requirements (WFP VAM methodology, UNHCR vulnerability criteria, ECHO targeting standards). Linking vulnerability_prof',
    `household_id` BIGINT COMMENT 'Reference to the household unit associated with this vulnerability profile. Enables household-level aggregation and targeting for program interventions.',
    `intervention_id` BIGINT COMMENT 'Reference to the primary humanitarian or development program under which this vulnerability profile was generated or is being used for targeting. Links the profile to program-specific eligibility criteria and Theory of Change (ToC) outcomes.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Vulnerability profiles are assessed and owned by field org units. Aggregate vulnerability reporting by org unit (country office, field team) is a standard NGO program management and donor reporting re',
    `previous_profile_vulnerability_profile_id` BIGINT COMMENT 'Reference to the immediately preceding vulnerability profile record for this registrant, enabling longitudinal tracking of vulnerability changes over time. Populated when profile_status is superseded or when a new profile replaces an existing one.',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary or household head registered in the beneficiary registry. Links this vulnerability profile to the specific Person of Concern (PoC) or Internally Displaced Person (IDP) record.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Periodic vulnerability reassessment tracking: Vulnerability profiles are reassessed at MEL-defined intervals (baseline, midline, endline). Linking to reporting_period enables MEL teams to identify whi',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or field worker who conducted the vulnerability assessment. Used for quality assurance, accountability, and inter-rater reliability analysis in MEL processes.',
    `assessment_date` DATE COMMENT 'Date on which the most recent vulnerability assessment was conducted that materially changed or established this profile. Used for timeliness tracking and MEL reporting cycles.',
    `children_under5_count` STRING COMMENT 'Number of children under 5 years of age in the household. Children under 5 are the primary target group for acute malnutrition screening (MUAC), vaccination campaigns, and early childhood development programs. Used for nutrition and child protection program sizing.',
    `chronic_illness_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has one or more documented chronic illnesses (e.g., HIV/AIDS, tuberculosis, diabetes, hypertension) that increase vulnerability and require sustained health service access. Drives health program targeting and DHIS2 health indicator reporting.',
    `chronic_illness_type` STRING COMMENT 'Coded description of the primary chronic illness condition affecting the beneficiary (e.g., HIV_AIDS, tuberculosis, diabetes, hypertension, malnutrition_chronic). Populated only when chronic_illness_flag is True. Aligned with ICD-11 coding where applicable.',
    `composite_vulnerability_score` DECIMAL(18,2) COMMENT 'Aggregated multi-dimensional vulnerability score derived from weighted combination of food insecurity (IPC phase), protection risk, disability, nutritional status, displacement category, and other assessed indicators. Used for program targeting, beneficiary prioritization, and Results-Based Management (RBM) reporting. Score range typically 0.00–100.00.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the beneficiary or their legal guardian. Required for data protection compliance and audit trail purposes.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or their legal guardian prior to data collection and vulnerability profiling. Mandatory for compliance with data protection regulations and CHS accountability standards.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where the beneficiary is located. Used for multi-country program management, IATI reporting, and donor country-level disaggregation.. Valid values are `^[A-Z]{3}$`',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to their vulnerability data being shared with partner organizations and inter-agency coordination bodies (e.g., UNHCR, OCHA clusters). Governs data sharing under inter-agency data sharing agreements.',
    `disability_classification` STRING COMMENT 'Functional difficulty domain identified using the Washington Group Short Set on Functioning (WG-SS) questions. Captures the primary domain of disability: seeing, hearing, mobility, cognition, self-care, or communication. Used for inclusive programming and disability-disaggregated reporting per CRPD. [ENUM-REF-CANDIDATE: none|seeing|hearing|mobility|cognition|self_care|communication|multiple — promote to reference product]',
    `disability_severity` STRING COMMENT 'Severity of functional difficulty as measured by the Washington Group Short Set (WG-SS) response scale: no difficulty, some difficulty, a lot of difficulty, or cannot do at all. Used alongside disability_classification for disaggregated disability reporting.. Valid values are `no_difficulty|some_difficulty|a_lot_of_difficulty|cannot_do`',
    `displacement_category` STRING COMMENT 'Classification of the beneficiarys displacement status per UNHCR definitions. Internally Displaced Person (IDP) refers to those displaced within their country; refugee refers to those who have crossed international borders; returnee refers to those who have returned to their place of origin. Drives program eligibility and UNHCR/OCHA reporting.. Valid values are `IDP|refugee|returnee|stateless|asylum_seeker|host_community`',
    `elderly_member_flag` BOOLEAN COMMENT 'Indicates whether the household includes one or more elderly members (typically aged 60+). Elderly individuals are a recognized vulnerable group requiring targeted assistance per SPHERE and IASC age and disability inclusion guidelines.',
    `female_headed_household_flag` BOOLEAN COMMENT 'Indicates whether the household is headed by a woman. Female-headed households are recognized as a priority vulnerability category in humanitarian programming due to heightened protection risks and reduced access to resources. Used for gender-disaggregated reporting.',
    `gbv_exposure_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has been identified as a survivor or at-risk individual for Gender-Based Violence (GBV). Triggers referral to GBV case management services and specialized support programs. Handled with strict confidentiality per GBV information management protocols.',
    `geographic_area_code` STRING COMMENT 'Standardized code identifying the geographic area (admin level 2 or 3) where the beneficiary is located at the time of assessment. Used for geographic targeting, GIS mapping, and OCHA cluster reporting. Aligned with OCHA Common Operational Datasets (COD) administrative boundary codes.. Valid values are `^[A-Z]{2,3}-[A-Z0-9]{2,10}(-[A-Z0-9]{2,10})?$`',
    `ipc_phase` STRING COMMENT 'Food insecurity severity classification using the Integrated Food Security Phase Classification (IPC) scale: 1=Minimal, 2=Stressed, 3=Crisis, 4=Emergency, 5=Famine/Catastrophe. Used for food assistance targeting and donor reporting to BHA/USAID.',
    `livelihood_status` STRING COMMENT 'Assessment of the beneficiary households livelihood and income-generating capacity. none indicates complete loss of livelihood; disrupted indicates significant reduction; partial indicates some income sources remain; stable indicates adequate livelihood. Used for cash and voucher assistance (CVA) targeting.. Valid values are `none|disrupted|partial|stable`',
    `muac_mm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in millimetres, used as the primary anthropometric indicator for acute malnutrition screening in children under 5 and pregnant/lactating women. Thresholds: <115mm = SAM, 115–124mm = MAM, ≥125mm = normal. Collected via KoboToolbox or CommCare field surveys.',
    `next_reassessment_date` DATE COMMENT 'Scheduled date for the next vulnerability reassessment to ensure the profile reflects the beneficiarys current vulnerability state. Drives field operations scheduling and MEL monitoring cycles. Typically set based on program-specific reassessment frequency protocols.',
    `notes` STRING COMMENT 'Free-text field for field officers to record contextual observations, qualitative vulnerability factors, or case-specific notes that are not captured by structured indicators. Handled as confidential due to potential sensitivity of content.',
    `nutritional_status` STRING COMMENT 'Nutritional status classification based on anthropometric screening. Severe Acute Malnutrition (SAM) indicates MUAC < 115mm or WHZ < -3; Moderate Acute Malnutrition (MAM) indicates MUAC 115–124mm or WHZ -2 to -3; normal indicates adequate nutritional status. Used for therapeutic feeding program targeting and Global Acute Malnutrition (GAM) rate reporting.. Valid values are `SAM|MAM|normal|overweight`',
    `pregnant_lactating_flag` BOOLEAN COMMENT 'Indicates whether the household includes a pregnant or lactating woman (PLW). PLWs are a priority group for nutrition programming (supplementary feeding), antenatal care, and maternal health services. Used for CMAM and nutrition program targeting.',
    `profile_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this vulnerability profile record, used in field operations, donor reporting, and inter-agency data sharing (e.g., VP-SOM-000123456).. Valid values are `^VP-[A-Z]{2,4}-[0-9]{6,10}$`',
    `profile_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vulnerability profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `profile_source` STRING COMMENT 'Indicates the operational process or event that triggered the creation or update of this vulnerability profile. post_distribution_monitoring refers to Post-Distribution Monitoring (PDM) assessments; emergency_screening refers to rapid assessments during acute crises. Used for MEL data quality analysis.. Valid values are `initial_registration|periodic_reassessment|post_distribution_monitoring|emergency_screening|referral|other`',
    `profile_status` STRING COMMENT 'Current lifecycle state of the vulnerability profile record. active indicates the current consolidated vulnerability state; superseded indicates a newer profile has replaced this one; pending_review indicates awaiting validation by a protection or MEL officer.. Valid values are `active|archived|pending_review|superseded|draft`',
    `profile_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vulnerability profile was last modified, reflecting the most recent update to any vulnerability indicator. Triggers downstream re-targeting and prioritization workflows.',
    `protection_risk_level` STRING COMMENT 'Assessed level of protection risk for the individual or household, encompassing threats of violence, exploitation, abuse, and discrimination. Classified by a trained protection officer. Drives case prioritization and referral pathways per UNHCR Protection Framework.. Valid values are `critical|high|medium|low|none`',
    `pss_need_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has been assessed as requiring Psychosocial Support (PSS) services, including mental health support, trauma counselling, or community-based psychosocial activities. Triggers referral to PSS programming.',
    `shelter_adequacy` STRING COMMENT 'Assessment of the beneficiarys shelter situation against SPHERE minimum standards. none indicates no shelter; inadequate indicates shelter below minimum standards; transitional indicates temporary/emergency shelter; adequate indicates shelter meeting minimum standards. Drives NFI and shelter program targeting.. Valid values are `adequate|inadequate|none|transitional`',
    `unaccompanied_minor_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary is an unaccompanied or separated child (UASC) — a child under 18 separated from both parents and other relatives and not being cared for by a responsible adult. Triggers child protection case management and family tracing and reunification (FTR) services.',
    `vulnerability_tier` STRING COMMENT 'Categorical tier derived from the composite vulnerability score, used for operational targeting and prioritization decisions. critical indicates immediate life-saving intervention required; high indicates priority program enrollment; medium and low indicate standard program eligibility. Distinct from composite_vulnerability_score which is the numeric value.. Valid values are `critical|high|medium|low`',
    `wash_access_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary household has adequate access to safe water, sanitation, and hygiene (WASH) facilities meeting SPHERE minimum standards. False indicates a WASH vulnerability requiring intervention. Used for WASH sector targeting and OCHA cluster reporting.',
    CONSTRAINT pk_vulnerability_profile PRIMARY KEY(`vulnerability_profile_id`)
) COMMENT 'Structured vulnerability assessment record for a registrant or household capturing multi-dimensional vulnerability indicators including food insecurity score (IPC phase classification), protection risk level, disability classification (Washington Group questions), chronic illness flags, GAM/SAM nutritional status (MUAC measurement), GBV exposure flag, displacement category (IDP, refugee, returnee), and composite vulnerability score used for program targeting and prioritization. Distinct from needs_assessment which captures point-in-time sector-specific assessment findings — vulnerability_profile represents the beneficiarys current consolidated vulnerability state derived from multiple assessment inputs. Updated when new assessment data materially changes vulnerability classification.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` (
    `needs_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each needs assessment record. Primary key for the needs_assessment data product within the beneficiary domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Needs assessments are funded and scoped under specific partnership agreements; donor reporting requires attributing assessment coverage and methodology to the governing agreement. Partner performance ',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Needs assessments are conducted by staff in specific positions (Nutrition Officer, Protection Officer, WASH Engineer). Linking to position enables assessment quality analysis by position type and staf',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Needs assessments identify specific commodity requirements (NFI kits, food baskets, WASH items, shelter materials) for beneficiaries. Essential for humanitarian needs-based procurement planning and Sp',
    `community_id` BIGINT COMMENT 'Reference to the community or settlement unit that is the subject of this assessment when assessment_level is community. Nullable when assessment_level is individual or household.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Needs assessments in NGOs are commissioned by specific program components to inform component-level design and targeting decisions. Component-level aggregation of assessment findings is required for c',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: When internal reviews or audits identify needs assessment quality issues (sampling bias, incomplete data, targeting errors), corrective action plans document remediation measures. Essential for qualit',
    `data_collection_tool_id` BIGINT COMMENT 'The unique identifier of the data collection instrument used to conduct this assessment. For KoboToolbox, this is the form UID (e.g., aXmK3p9QrT). For CommCare, this is the module ID. Enables traceability back to the specific questionnaire version and supports data quality audits.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Needs assessments are frequently mandated by specific donor requirements (baseline assessments before program start, specific assessment tools, minimum sample sizes). Linking to donor_requirement enab',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Needs assessments are triggered by and scoped to specific emergencies (e.g., flood rapid assessment). Linking to emergency enables flash appeal and HRP needs analysis by emergency. No existing emergen',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Volunteers conduct needs assessments in many NGO operations (household surveys, vulnerability assessments, rapid assessments). Standard practice for community-based data collection. Required for track',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Field teams conduct needs assessments; supervisors need team-level assessment quality assurance and workload tracking. enumerator_volunteer_id covers individual enumerators but not the deploying field',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: Needs assessments are funded by specific grants; donor financial reporting requires tracking assessment activity costs against the grant budget. NGO finance officers report assessment expenditure per ',
    `household_id` BIGINT COMMENT 'Reference to the household unit that is the subject of this assessment when assessment_level is household. Nullable when assessment_level is individual or community.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this needs assessment was commissioned. Links the assessment to the programs Theory of Change (ToC) and LogFrame targeting criteria.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Needs assessments are conducted by field teams under specific org units. Linking enables organizational aggregation of assessment findings for program planning, budget allocation, and donor reporting ',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partners conduct needs assessments in their operational areas under consortium or sub-award arrangements. Tracking the assessing partner is required for data quality oversight, capacity assessment val',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or volunteer who conducted the field assessment. Used for quality assurance, inter-rater reliability checks, and enumerator performance monitoring.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Needs assessments are conducted at specific project sites. Field coordinators filter assessments by site for program targeting and HRP reporting. No existing project_site_id on this product; admin1_na',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary (IDP, PoC, GBV survivor, or other target population member) who is the subject of this assessment when assessment_level is individual. Nullable when assessment_level is household or community.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Baseline/midline/endline needs assessment alignment: NGO MEL frameworks require needs assessments to be explicitly tied to reporting periods (baseline, midline, endline) for longitudinal tracking of v',
    `vulnerability_profile_id` BIGINT COMMENT 'Foreign key linking to beneficiary.vulnerability_profile. Business justification: Needs assessments are often conducted in direct reference to an existing vulnerability profile, or they generate/update a vulnerability profile. Linking beneficiary_needs_assessment to vulnerability_p',
    `admin1_name` STRING COMMENT 'Name of the first-level administrative division (e.g., province, state, region) where the assessment was conducted. Sourced from OCHA Common Operational Datasets (CODs) administrative boundary reference. Used for geographic aggregation in SitReps and donor reports.',
    `admin2_name` STRING COMMENT 'Name of the second-level administrative division (e.g., district, county, department) where the assessment was conducted. Sourced from OCHA CODs. Enables sub-national geographic disaggregation for targeting and cluster coordination reporting.',
    `assessment_date` DATE COMMENT 'The calendar date on which the needs assessment was physically conducted in the field. This is the principal real-world event date, distinct from the record submission or validation timestamps. Used for temporal targeting analysis and periodic reassessment scheduling.',
    `assessment_level` STRING COMMENT 'The unit of analysis at which this needs assessment was conducted. individual targets a single beneficiary (e.g., GBV survivor, SAM case); household targets a family unit; community targets a settlement or geographic cluster. Determines which of beneficiary_id, household_id, or community_id is populated.. Valid values are `individual|household|community`',
    `assessment_reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this needs assessment, used in field reports, SitReps, and donor communications. Format: NA-{COUNTRY}-{YEAR}-{SEQUENCE}. Sourced from KoboToolbox or CommCare submission ID.. Valid values are `^NA-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `assessment_status` STRING COMMENT 'Current workflow lifecycle state of the needs assessment record. draft indicates field data entry in progress; submitted indicates enumerator submission pending review; validated indicates supervisor-approved and usable for targeting; rejected indicates data quality failure requiring re-assessment.. Valid values are `draft|submitted|under_review|validated|rejected|archived`',
    `assessment_tool_version` STRING COMMENT 'Version number or deployment date of the assessment tool/form used. Critical for longitudinal comparability — when a KoboToolbox form or CommCare module is updated, findings from different versions may not be directly comparable without version-aware analysis.',
    `assessment_type` STRING COMMENT 'Classification of the assessments purpose and methodology. initial_registration is conducted at first beneficiary contact; periodic_reassessment is a scheduled follow-up to update vulnerability status; post_crisis_rapid is an emergency rapid assessment following a shock event; sector_specific_deep is an in-depth assessment for a single sector (e.g., nutrition MUAC screening, WASH facility survey).. Valid values are `initial_registration|periodic_reassessment|post_crisis_rapid|sector_specific_deep`',
    `children_under5_count` STRING COMMENT 'Number of children under 5 years of age in the assessed household. Key vulnerability indicator for nutrition (SAM/GAM screening), WASH (diarrhoea risk), and child protection programming. Required for UNICEF and WFP programme targeting.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or household head prior to conducting the assessment. Mandatory per CHS Commitment 4 (Accountability to Affected Populations) and GDPR Article 6 for data processing lawfulness. Must be TRUE for the record to be validated.',
    `consent_type` STRING COMMENT 'The form of informed consent obtained. verbal is spoken consent recorded by enumerator; written is signed consent form; proxy is consent given by a guardian or community leader on behalf of a vulnerable individual (e.g., child, person with disability). Relevant for legal compliance and data protection audits.. Valid values are `verbal|written|proxy`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where the assessment was conducted (e.g., SOM, SSD, HTI). Used for IATI reporting, donor country-level aggregation, and cross-country comparative analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this needs assessment record was first created in the data platform (Silver layer ingestion timestamp). Distinct from assessment_date (field event date). Used for data pipeline monitoring and audit trail compliance.',
    `data_collection_method` STRING COMMENT 'The primary method used to gather assessment data. face_to_face is direct in-person interview; remote_phone is telephone-based; fgd is a Focus Group Discussion (FGD); kii is a Key Informant Interview (KII); observation is direct field observation without interview; secondary_data is derived from existing records. Affects data quality weighting in vulnerability scoring.. Valid values are `face_to_face|remote_phone|fgd|kii|observation|secondary_data`',
    `displacement_status` STRING COMMENT 'The displacement classification of the assessed individual or household at the time of assessment. idp = Internally Displaced Person (IDP); refugee = person with international protection status; returnee = person returning to place of origin; host_community = non-displaced community member hosting displaced persons. Critical for UNHCR/OCHA population movement tracking.. Valid values are `idp|refugee|returnee|host_community|stateless|non_displaced`',
    `education_score` DECIMAL(18,2) COMMENT 'Numeric score for the education sector assessment findings. Null if education was not included in sectors_assessed. Covers school access, enrollment barriers, learning environment safety, and teacher availability against SPHERE/INEE minimum standards.',
    `enumerator_notes` STRING COMMENT 'Free-text qualitative observations recorded by the field enumerator during the assessment. Captures contextual information not covered by structured questions (e.g., security constraints, access limitations, observed conditions). Used by supervisors during validation review.',
    `female_headed_household` BOOLEAN COMMENT 'Indicates whether the assessed household is headed by a female. Female-headed households are a standard vulnerability marker in humanitarian targeting criteria and are required for gender disaggregation in donor reports (USAID, DFID/FCDO, UN Women standards).',
    `gbv_risk_flag` BOOLEAN COMMENT 'Indicates whether the assessment identified elevated Gender-Based Violence (GBV) risk for the assessed individual or household. When TRUE, triggers referral to GBV case management pathway and PSS services. Classified as restricted PHI due to extreme sensitivity of GBV disclosure data.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated GPS accuracy in meters at the time of coordinate capture, as reported by the mobile device. KoboToolbox and CommCare record this automatically. Values above 30 meters may indicate unreliable location data and trigger data quality flags.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the assessment location captured by the field enumerators device via KoboToolbox or CommCare GPS capture. Used for GIS mapping, cluster analysis, and geographic targeting in humanitarian response planning.',
    `livelihoods_score` DECIMAL(18,2) COMMENT 'Numeric score for the livelihoods sector assessment findings. Null if livelihoods was not included in sectors_assessed. Covers income sources, asset ownership, market access, and economic vulnerability indicators.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the assessment location captured by the field enumerators device. Used alongside latitude for GIS mapping, spatial clustering, and geographic targeting in humanitarian response planning.',
    `muac_mm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in millimetres for children under 5 or pregnant/lactating women, used to screen for acute malnutrition. MUAC < 115mm indicates SAM; 115–125mm indicates MAM. Classified as PHI as it is a direct health measurement linked to an individual. Null if not applicable to assessment subject.',
    `nutrition_score` DECIMAL(18,2) COMMENT 'Numeric score for the nutrition sector assessment findings. Null if nutrition was not included in sectors_assessed. Incorporates Global Acute Malnutrition (GAM) and Severe Acute Malnutrition (SAM) indicators where applicable. Feeds into DHIS2 nutrition indicator tracking.',
    `overall_vulnerability_score` DECIMAL(18,2) COMMENT 'Composite numeric score representing the assessed subjects overall vulnerability level, calculated from sector-specific findings using the programs scoring methodology (e.g., 0–100 scale). Feeds into vulnerability_profile updates when the score materially changes vulnerability classification. This is a raw assessment output, not a derived KPI.',
    `persons_with_disability_count` STRING COMMENT 'Number of household members with a physical, sensory, intellectual, or psychosocial disability. Required for disability-inclusive programming per IASC Guidelines on Inclusion of Persons with Disabilities in Humanitarian Action and CRPD compliance reporting.',
    `protection_score` DECIMAL(18,2) COMMENT 'Numeric score for the protection sector assessment findings. Null if protection was not included in sectors_assessed. Covers GBV risk, child protection, housing land and property rights, and documentation status. Sensitive findings are handled per GBV information management protocols.',
    `referral_recommended` BOOLEAN COMMENT 'Indicates whether the assessment findings recommend referral of the beneficiary or household to one or more service providers or program interventions. When TRUE, a referral pathway is initiated in CommCare case management. Drives downstream case management workflow.',
    `referral_sectors` STRING COMMENT 'Pipe-delimited list of sectors to which the beneficiary or household is being referred based on assessment findings (e.g., nutrition|PSS|WASH). Populated only when referral_recommended is TRUE. Drives service pathway activation in CommCare and Microsoft Dynamics 365 case management.',
    `sectors_assessed` STRING COMMENT 'Pipe-delimited list of humanitarian/development sectors covered in this assessment (e.g., WASH|nutrition|shelter|protection|livelihoods|education). Sectors align with IASC cluster system. Determines which sector-specific scored findings fields are populated. [ENUM-REF-CANDIDATE: WASH|nutrition|shelter|protection|livelihoods|education|health|food_security|NFI|PSS — promote to reference product]',
    `shelter_score` DECIMAL(18,2) COMMENT 'Numeric score for the shelter sector assessment findings. Null if shelter was not included in sectors_assessed. Assessed against SPHERE minimum standards for covered living space, structural safety, and thermal comfort.',
    `source_submission_reference` STRING COMMENT 'The native submission or case ID from the originating source system (KoboToolbox submission UUID or CommCare case ID). Enables exact record traceability back to the source system for data reconciliation, duplicate detection, and audit purposes.',
    `source_system` STRING COMMENT 'The operational system of record from which this assessment record originated. Enables data lineage tracking and source-specific quality rules in the Silver layer. KoboToolbox for field survey submissions; CommCare for mobile case management assessments; manual_entry for paper-based data entry.. Valid values are `KoboToolbox|CommCare|manual_entry|DHIS2|ODK`',
    `supervisor_validation_notes` STRING COMMENT 'Free-text notes entered by the supervising data manager or MEL officer during the assessment review and validation process. Documents reasons for rejection, data quality concerns, or approval rationale. Populated when assessment_status transitions to validated or rejected.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this needs assessment record was most recently modified in the data platform. Tracks post-ingestion corrections, validation status changes, and supervisor note additions. Required for Silver layer change data capture (CDC) processing.',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when the assessment record was validated or rejected by the supervising staff member. Distinct from assessment_date (field event) and created_timestamp (record creation). Used for SLA monitoring of data quality review turnaround.',
    `vulnerability_category` STRING COMMENT 'Categorical classification of the assessed subjects vulnerability level derived from the overall_vulnerability_score and program-specific thresholds. Used for beneficiary targeting, prioritization, and service referral decisions. critical triggers immediate case management escalation.. Valid values are `critical|high|medium|low|not_vulnerable`',
    `wash_score` DECIMAL(18,2) COMMENT 'Numeric score for the Water, Sanitation and Hygiene (WASH) sector assessment findings. Null if WASH was not included in sectors_assessed. Scored against SPHERE minimum standards for water access, sanitation facilities, and hygiene promotion.',
    CONSTRAINT pk_needs_assessment PRIMARY KEY(`needs_assessment_id`)
) COMMENT 'Transactional record of a formal needs assessment conducted for an individual beneficiary, household, or community to determine eligibility, vulnerability level, and appropriate service referrals. Captures assessment date, assessment level (individual, household, community), assessment type (initial registration assessment, periodic reassessment, post-crisis rapid assessment, sector-specific deep assessment), sectors assessed (WASH, nutrition, shelter, protection, livelihoods, education), assessment tool identifier (KoboToolbox form ID, CommCare module), field enumerator, geographic coordinates, and scored findings per sector. Owned by beneficiary domain as it determines beneficiary status and targeting — distinct from MEL post-distribution monitoring which measures program effectiveness. Assessment findings feed into vulnerability_profile updates when they materially change vulnerability classification.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique system-generated identifier for each consent record. Primary key for the consent_record data product within the beneficiary domain.',
    `case_record_id` BIGINT COMMENT 'Foreign key linking to beneficiary.case_record. Business justification: In humanitarian case management, consent is often obtained specifically for a case (e.g., consent to share GBV case information with a referral partner, consent for psychosocial support sessions). Lin',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Data protection frameworks (GDPR, CHS Standard 7) require tracking which implementing partner collected beneficiary consent. Consent audits and data-sharing compliance reviews depend on knowing the co',
    `component_id` BIGINT COMMENT 'Reference to the humanitarian or development program for which consent is being obtained. Enables program-level consent tracking and MEL reporting.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Informed consent collection: volunteers collect consent from beneficiaries in the field. Tracking the volunteer who obtained consent is required for GDPR/data protection compliance audits and consent ',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Specific donor agreements mandate consent collection standards (GDPR for EU donors, safeguarding protocols, data sharing permissions). Consent records demonstrate fulfillment of these contractual comp',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Consent collection must comply with specific governance policies (data protection policy, GDPR policy, photography/biometric policy). Linking consent_record to the governing governance_policy ensures ',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: In humanitarian programs, consent is frequently obtained at the household level (e.g., household head consenting on behalf of the unit) in addition to individual registrant consent. Adding household_i',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Consent violations (unauthorized data sharing, biometric data misuse, photography without consent) constitute compliance incidents. Linking consent_record to compliance_incident enables tracing which ',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or field worker who witnessed the consent process. Links to the workforce staff_member record for accountability and audit trail purposes.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Data protection compliance (GDPR, CHS) requires knowing the exact site where consent was obtained. collection_location is a plain text field insufficient for compliance audits. Country offices need si',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary (individual, household head, or community representative) whose consent is being recorded. Links to the beneficiary master record in CommCare or KoboToolbox.',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Consent collection requirements are jurisdiction-specific based on statutory registration (GDPR in EU-registered operations, national data protection laws). Linking consent_record to the statutory_reg',
    `biometric_enrollment_permitted` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to biometric data enrollment (fingerprint, iris scan, facial recognition) for identity verification and deduplication purposes. True = biometric enrollment permitted; False = not permitted.',
    `chs_compliance_flag` BOOLEAN COMMENT 'Indicates whether this consent record meets all requirements of the Core Humanitarian Standard (CHS) Commitment 4 on accountability to affected populations. True = CHS compliant; False = non-compliant or pending review. Used in CHS certification audits.',
    `collection_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the country where consent was collected (e.g., SOM for Somalia, SSD for South Sudan). Supports multi-country program reporting and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `collection_location` STRING COMMENT 'Name or description of the physical location where consent was collected (e.g., registration site name, health facility, IDP camp name, community center). Supports geographic analysis and field operations reporting.',
    `consent_date` DATE COMMENT 'The calendar date on which the beneficiary provided, withdrew, or refused consent. This is the principal real-world event date for the consent transaction, distinct from the record creation timestamp.',
    `consent_form_version` STRING COMMENT 'Version identifier of the consent form template used at the time of consent collection (e.g., v1.0, v2.3). Enables tracking of which version of the consent language and terms the beneficiary agreed to, critical for compliance audits.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `consent_language` STRING COMMENT 'ISO 639-1 or ISO 639-3 language code representing the language in which consent was communicated and obtained. Ensures accountability that consent was given in the beneficiarys understood language (e.g., ar for Arabic, fr for French, so for Somali). Critical for CHS accountability compliance.. Valid values are `^[a-z]{2,3}(-[A-Z]{2,3})?$`',
    `consent_method` STRING COMMENT 'The method by which consent was obtained from the beneficiary. verbal for spoken agreement (audio-recorded or witnessed); written for signed paper form; digital for electronic signature or mobile app confirmation; thumbprint for biometric ink impression; proxy for consent given by a guardian or authorized representative on behalf of a minor or incapacitated individual.. Valid values are `verbal|written|digital|thumbprint|proxy`',
    `consent_reference_number` STRING COMMENT 'Externally-known unique alphanumeric reference code assigned to this consent record, used in field operations, case referrals, and compliance reporting. Format: CNS-[COUNTRY]-[YEAR]-[SEQUENCE].. Valid values are `^CNS-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent record. given indicates active informed consent; withdrawn indicates the beneficiary has revoked consent; pending indicates consent is awaited; expired indicates the consent period has lapsed; refused indicates explicit refusal.. Valid values are `given|withdrawn|pending|expired|refused`',
    `consent_type` STRING COMMENT 'Classification of the specific type of consent being recorded. Covers data processing consent (GDPR/privacy), photography and media use, inter-agency case referral, biometric enrollment, program participation, and research/survey participation. [ENUM-REF-CANDIDATE: data_processing|photography_media|case_referral|biometric_enrollment|program_participation|research_survey — promote to reference product]. Valid values are `data_processing|photography_media|case_referral|biometric_enrollment|program_participation|research_survey`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was first created in the system. Audit trail field supporting data lineage, compliance reporting, and GDPR accountability obligations.',
    `data_retention_period_days` STRING COMMENT 'The number of days for which the beneficiarys data may be retained under this consent, as agreed at the time of consent collection. Drives automated data retention and deletion workflows. Aligned with GDPR storage limitation principle.',
    `data_scope` STRING COMMENT 'Description of the specific data elements, activities, or purposes covered by this consent record (e.g., collection and storage of household survey data, sharing of case data with UNHCR for referral). Defines the boundaries of what the beneficiary has consented to.',
    `digital_signature_reference` STRING COMMENT 'Reference identifier or hash of the digital signature captured when consent_method is digital. Links to the secure digital signature storage system. Not the signature itself — a reference token for audit trail purposes.',
    `effective_from_date` DATE COMMENT 'The date from which the consent becomes legally and operationally binding. May differ from consent_date if there is a processing delay or a future-dated consent arrangement.',
    `expiry_date` DATE COMMENT 'The date on which the consent expires and must be renewed. Nullable for open-ended consents. Supports automated consent renewal workflows and compliance with data retention policies.',
    `form_attachment_reference` STRING COMMENT 'File path, URL, or document management system reference to the scanned or digital copy of the signed consent form. Enables retrieval of the original consent document for audit and legal purposes.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether the EU General Data Protection Regulation (GDPR) applies to this consent record based on the beneficiarys location, the organizations jurisdiction, or the data controllers domicile. True = GDPR applies; False = GDPR does not apply.',
    `informed_consent_verified` BOOLEAN COMMENT 'Indicates whether a supervisor or quality assurance officer has verified that the consent was truly informed (i.e., the beneficiary understood the purpose, scope, and their rights before consenting). True = verified; False = pending verification.',
    `is_proxy_consent` BOOLEAN COMMENT 'Indicates whether consent was given by a proxy (guardian, parent, or authorized representative) on behalf of a minor, elderly, or incapacitated beneficiary. True = proxy consent; False = direct consent from the beneficiary.',
    `notes` STRING COMMENT 'Free-text field for additional contextual notes about the consent process, any special circumstances, beneficiary concerns raised, or follow-up actions required. Used by field staff and MEL officers for qualitative documentation.',
    `photography_permitted` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to being photographed or filmed for organizational communications, donor reporting, or advocacy purposes. True = photography/media use permitted; False = not permitted.',
    `proxy_name` STRING COMMENT 'Full name of the proxy individual (guardian, parent, or authorized representative) who provided consent on behalf of the beneficiary. Populated only when is_proxy_consent is True.',
    `proxy_relationship` STRING COMMENT 'The relationship of the proxy consent giver to the beneficiary (e.g., parent, guardian, legal representative). Populated only when is_proxy_consent is True. [ENUM-REF-CANDIDATE: parent|guardian|spouse|sibling|community_leader|legal_representative|other — promote to reference product]',
    `sharing_permitted` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to their data being shared with third-party organizations (e.g., partner NGOs, UN agencies, government bodies). True = sharing permitted; False = sharing not permitted. Critical for inter-agency data sharing compliance.',
    `sharing_restrictions` STRING COMMENT 'Free-text description of any specific restrictions or conditions placed by the beneficiary on data sharing (e.g., not to be shared with government authorities, only for health program purposes). Populated when sharing_permitted is True but with conditions.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this consent record in the originating operational system (CommCare case ID, KoboToolbox submission UUID, Dynamics 365 record ID). Enables traceability and reconciliation between the lakehouse silver layer and source systems.',
    `source_system` STRING COMMENT 'The operational system of record from which this consent record was captured or ingested (e.g., CommCare for mobile case management, KoboToolbox for field surveys, Dynamics 365 for case management, Salesforce for constituent tracking, or manual for paper-based entry).. Valid values are `CommCare|KoboToolbox|Dynamics365|Salesforce|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was most recently modified. Tracks consent status changes, withdrawals, and verification updates for audit trail and data governance purposes.',
    `verification_date` DATE COMMENT 'The date on which a supervisor or quality assurance officer verified that the consent was properly informed and documented. Populated only when informed_consent_verified is True.',
    `withdrawal_date` DATE COMMENT 'The date on which the beneficiary formally withdrew their previously given consent. Populated only when consent_status is withdrawn. Triggers downstream data deletion or anonymization workflows per GDPR right to erasure.',
    `withdrawal_reason` STRING COMMENT 'Free-text description of the reason provided by the beneficiary or their representative for withdrawing consent. Populated only when consent_status is withdrawn. Used for accountability reporting and program improvement.',
    `witness_name` STRING COMMENT 'Full name of the field staff member or community witness who witnessed the consent process. Required for verbal and thumbprint consent methods to ensure accountability and legal validity.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Formal consent management record capturing a beneficiarys informed consent for data collection, storage, sharing, and program participation. Stores consent type (data processing, photography, case referral, biometric enrollment), consent status (given, withdrawn, pending), consent date, consent method (verbal, written, digital), language of consent, witness details, and CHS (Core Humanitarian Standard) accountability compliance flags.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`case_record` (
    `case_record_id` BIGINT COMMENT 'Unique surrogate identifier for the longitudinal case management record within the beneficiary domain. Primary key for all case-level joins and lineage tracking.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Donor reporting and case management accountability require knowing which partnership agreement governs each case — agreement scope, reporting obligations, and funding ceiling apply per case. Partner p',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Case management: community case workers and protection volunteers are assigned to support cases alongside staff. Tracking the assigned volunteer per case is required for caseload management, supervisi',
    `award_id` BIGINT COMMENT 'Reference to the donor grant funding the program under which this case is managed. Required for donor accountability reporting, BvA tracking, and compliance with grant conditions (e.g., USAID BHA, CERF, DFID).',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Case management systems in NGOs attribute cases to specific program components (e.g., GBV sub-component, PSS component, legal aid component) for budget tracking, caseload reporting per component, and ',
    `country_office_id` BIGINT COMMENT 'Reference to the geographic location (camp, settlement, district, or facility) where the case is being managed. Supports GIS-based field operations mapping and geographic disaggregation in MEL reporting.',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Case-driven distribution: protection, nutrition, and health case records directly trigger distribution orders (e.g., therapeutic food for SAM cases, dignity kits for GBV cases). NGO case managers need',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor requirements mandate specific case management protocols (GBV response standards, child protection procedures, PSS session minimums). Linking case_record to the governing donor_requirement enable',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Cases are opened in response to specific emergencies (conflict displacement, natural disaster). Emergency-level case load reporting is required for OCHA cluster coordination and donor sitreps. No exis',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Case management procedures must follow specific governance policies (child protection policy, GBV case management policy, data protection policy). Linking case_record to the governing governance_polic',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: Grant compliance reporting requires tracking which grant budget funds case management activities. Direct link enables case-level expenditure attribution for donor financial reports without multi-table',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: Case records in humanitarian case management frequently cover entire households, not just individual registrants. Adding household_id to case_record enables household-level case reporting, aggregation',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Case management systems track compliance incidents (fraud, safeguarding, misconduct allegations) that trigger beneficiary case records. Essential for safeguarding workflows and incident response docum',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this case is managed (e.g., GBV response, child protection, nutrition, PSS, livelihoods).',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Case records are managed within specific org units (country offices, field teams). Enables caseload reporting by organizational unit, supervision chain management, and budget attribution to cost cente',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Case management services are frequently delivered by partner organizations under sub-awards or consortium agreements. Tracking which partner manages each case is essential for performance monitoring, ',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: NGO case management formally allocates cases to POSITIONS for supervision, handover, and caseload reporting. Donor reports and cluster coordination require caseload counts by position type (e.g., GBV ',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Case management services (protection, health, psychosocial support) are delivered at specific field facilities. Required for service delivery reporting, referral pathway management, and site-level cas',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary (Person of Concern / IDP / GBV survivor) who is the subject of this case record. Core party linkage for the case.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or community health worker assigned as the primary caseworker responsible for managing and following up on this case.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Subaward monitoring requires knowing which cases are implemented under each subaward. NGOs must report case-level service delivery to prime recipients per subaward agreement. case_record has partner_o',
    `case_narrative` STRING COMMENT 'Free-text longitudinal narrative documenting the beneficiarys situation, interventions provided, progress notes, and caseworker observations. Contains sensitive personal and protection information. Restricted access per data protection protocols.',
    `case_number` STRING COMMENT 'Human-readable, externally-known unique case reference code assigned at registration. Used in field communications, referral letters, and donor/compliance reporting. Format: CASE-{PROGRAM_CODE}-{YEAR}-{SEQUENCE}.. Valid values are `^CASE-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `case_plan_developed` BOOLEAN COMMENT 'Indicates whether a formal individualized case plan has been developed and documented for this beneficiary. A case plan is a mandatory element of structured case management per IASC standards.',
    `case_stage` STRING COMMENT 'Current stage within the structured case management workflow cycle (intake → assessment → planning → intervention → monitoring → closure). Distinct from case_status; represents the process phase rather than the operational state.. Valid values are `intake|assessment|planning|intervention|monitoring|closure`',
    `case_status` STRING COMMENT 'Current lifecycle state of the case record within the CommCare case management workflow. Drives operational dashboards, caseload reporting, and MEL tracking.. Valid values are `open|in_progress|on_hold|closed|cancelled`',
    `case_type` STRING COMMENT 'Classification of the case by humanitarian sector or service modality. Drives workflow routing, referral pathways, and MEL indicator disaggregation. [ENUM-REF-CANDIDATE: protection|gbv|child_protection|pss|nutrition|health|livelihoods — promote to reference product]',
    `close_date` DATE COMMENT 'Calendar date on which the case was formally closed. Null if the case remains open or in-progress. Used to calculate case duration and throughput metrics.',
    `closure_reason` STRING COMMENT 'Standardized reason for case closure. Used for caseload quality analysis, MEL outcome disaggregation, and donor accountability reporting. [ENUM-REF-CANDIDATE: services_completed|voluntary_withdrawal|lost_to_followup|transferred|deceased|duplicate|other — promote to reference product]',
    `commcare_case_reference` STRING COMMENT 'Source system case identifier from CommCare mobile case management platform. Used for data lineage, reconciliation, and integration with field data collection workflows.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the beneficiary or legal guardian. Required for data protection compliance and audit trail.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary (or guardian) prior to case registration and data collection, in compliance with data protection and humanitarian accountability standards.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the case record was first created in the data platform. Used for audit trail, data lineage, and compliance with GDPR and OMB Uniform Guidance record-keeping requirements.',
    `data_collection_method` STRING COMMENT 'Method used to collect and register case data (e.g., CommCare mobile form, KoboToolbox survey, paper form, phone interview, FGD, KII). Used for data quality assessment and ICT4D performance monitoring. [ENUM-REF-CANDIDATE: commcare_mobile|kobo_form|paper_form|phone_interview|fgd|kii — promote to reference product]. Valid values are `commcare_mobile|kobo_form|paper_form|phone_interview|fgd|kii`',
    `is_child_case` BOOLEAN COMMENT 'Indicates whether the beneficiary is a child (under 18 years of age). Triggers child protection protocols, guardian consent requirements, and UNICEF/child protection cluster reporting obligations.',
    `is_gbv_case` BOOLEAN COMMENT 'Indicates whether this case involves Gender-Based Violence (GBV). Enables secure, disaggregated GBV caseload reporting while maintaining strict data protection protocols per IASC GBV guidelines.',
    `is_idp_case` BOOLEAN COMMENT 'Indicates whether the beneficiary is an Internally Displaced Person (IDP). Used for OCHA displacement tracking, Cluster reporting, and disaggregated humanitarian response analysis.',
    `last_followup_date` DATE COMMENT 'Date of the most recent caseworker interaction or follow-up visit recorded for this case. Used to identify inactive cases and trigger escalation workflows.',
    `legal_aid_required` BOOLEAN COMMENT 'Indicates whether the beneficiary requires legal aid services as part of the case management plan (e.g., documentation, asylum claims, GBV legal redress). Triggers referral to legal service providers.',
    `muac_cm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in centimetres recorded at case intake for nutrition cases. Used to classify Severe Acute Malnutrition (SAM) and Global Acute Malnutrition (GAM) per SPHERE/WHO thresholds. Applicable to nutrition case types only.',
    `next_followup_date` DATE COMMENT 'Scheduled date for the next planned caseworker interaction or home visit. Drives field scheduling and caseload management in CommCare.',
    `nutrition_status` STRING COMMENT 'Classified nutritional status of the beneficiary based on MUAC and/or weight-for-height z-score. SAM = Severe Acute Malnutrition; MAM = Moderate Acute Malnutrition. Drives therapeutic feeding program enrollment and DHIS2 health indicator reporting.. Valid values are `sam|mam|normal|at_risk`',
    `on_hold_reason` STRING COMMENT 'Free-text or coded reason explaining why the case has been placed on hold (e.g., beneficiary unreachable, security access constraints, awaiting referral response). Populated only when case_status = on_hold.',
    `open_date` DATE COMMENT 'Calendar date on which the case was formally opened and registered in the case management system. Used for caseload aging analysis and response time measurement.',
    `outcome_classification` STRING COMMENT 'Standardized classification of the case result at closure. Used for MEL outcome reporting, donor accountability, and Theory of Change (ToC) validation. [ENUM-REF-CANDIDATE: goal_achieved|partially_achieved|not_achieved|lost_to_followup|referred_out|deceased — promote to reference product]. Valid values are `goal_achieved|partially_achieved|not_achieved|lost_to_followup|referred_out|deceased`',
    `presenting_issue` STRING COMMENT 'Primary issue or need presented by the beneficiary at case intake, as documented by the caseworker (e.g., acute malnutrition, GBV incident, displacement, lack of shelter, psychosocial distress).',
    `priority_level` STRING COMMENT 'Urgency classification assigned to the case based on vulnerability assessment, protection risk, or medical severity. Determines response time SLAs and caseworker allocation.. Valid values are `critical|high|medium|low`',
    `protection_risk_level` STRING COMMENT 'Assessed level of protection risk for the beneficiary at the time of case opening, based on IASC protection risk analysis. Drives escalation protocols and inter-agency coordination.. Valid values are `extreme|high|medium|low|none`',
    `pss_session_count` STRING COMMENT 'Number of Psychosocial Support (PSS) sessions attended by the beneficiary under this case. Used for MEL output tracking, minimum dose compliance, and donor reporting on PSS program reach.',
    `referral_date` DATE COMMENT 'Date on which the beneficiary was referred to an external service or organization. Used to measure referral response time and inter-agency coordination effectiveness.',
    `referral_destination` STRING COMMENT 'Name or code of the organization, facility, or service to which the beneficiary was referred out from this case (e.g., health clinic, legal aid, shelter). Supports inter-agency referral pathway tracking.',
    `referral_source` STRING COMMENT 'Channel or entity through which the beneficiary was referred into this case. Used for referral pathway analysis and community outreach effectiveness reporting. [ENUM-REF-CANDIDATE: self_referral|community_referral|health_facility|partner_org|government|hotline|other — promote to reference product]',
    `safety_plan_in_place` BOOLEAN COMMENT 'Indicates whether a formal safety plan has been developed and agreed with the beneficiary, particularly for GBV and protection cases. Required element of minimum case management standards.',
    `service_modality` STRING COMMENT 'Mode of service delivery used for this case (e.g., in-person clinic visit, remote counselling, mobile outreach, group PSS session, home visit). Used for operational planning and cost analysis.. Valid values are `in_person|remote|mobile_outreach|group_session|home_visit`',
    `supervisor_review_required` BOOLEAN COMMENT 'Indicates whether this case has been flagged for mandatory supervisory review, typically due to critical priority, complex protection risk, or escalation trigger. Supports quality assurance and safeguarding protocols.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the case record. Used for change detection, incremental data loading in the Databricks Silver layer, and audit compliance.',
    `vulnerability_score` STRING COMMENT 'Composite numeric score derived from the beneficiary needs assessment, reflecting overall vulnerability level (e.g., 0–100 scale). Used for prioritization, targeting, and MEL disaggregation. Higher scores indicate greater vulnerability.',
    CONSTRAINT pk_case_record PRIMARY KEY(`case_record_id`)
) COMMENT 'Longitudinal case management record for an individual beneficiary requiring structured follow-up. Captures case type (protection, GBV, child protection, PSS, nutrition, health, livelihoods), status (open, in-progress, on-hold, closed), priority level, assigned caseworker, opening/closing dates, referral pathway, outcome classification, and case narrative. Primary operational entity for CommCare case management workflows.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`case_action` (
    `case_action_id` BIGINT COMMENT 'Unique system-generated identifier for each case action record within the beneficiary case management system. Primary key for the case_action data product.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Activity-based costing and donor financial reporting require linking case actions (PSS sessions, legal aid, distributions) to the budget lines they consume. NGO finance teams track action-level expend',
    `case_record_id` BIGINT COMMENT 'Reference to the parent beneficiary case to which this action belongs. Links the action to the overarching case record for the individual, household, or community being served.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Case actions document specific items provided during interventions (dignity kits for GBV survivors, hygiene supplies, emergency NFI). Critical for case management audit trails, protection monitoring, ',
    `component_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this case action is being delivered. Enables program-level aggregation of service delivery activities.',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Case actions recording commodity provision (NFI kits, food parcels, hygiene kits) must reference the specific distribution order that fulfilled them. This links case management activity to supply chai',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: A specific case action (field visit, service delivery, PSS session) may directly trigger a compliance incident (safeguarding breach, fraud, misconduct). NGO compliance investigators need to trace whic',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Individual case actions (counseling sessions, referrals, service delivery) are often executed by partner staff. Tracking the implementing partner per action enables activity-based costing, partner per',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Program design and staffing decisions require analysis of which position types perform which case action types (e.g., PSS sessions by PSS Officer, legal aid by Legal Officer). This link enables action',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Individual case actions (counseling sessions, health consultations, legal aid) occur at field sites. Essential for activity-based reporting, service utilization analysis, and site performance monitori',
    `registrant_id` BIGINT COMMENT 'Reference to the primary beneficiary (individual, household head, or community representative) who is the subject of this case action. Enables direct beneficiary-level reporting without joining through the case.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or case worker responsible for executing this case action. Supports workload management, supervision, and accountability tracking.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Case management actions are frequently performed by trained volunteers (community health workers, protection monitors, PSS facilitators). Essential for tracking who delivered services, accountability,',
    `action_category` STRING COMMENT 'Humanitarian sector or thematic category under which this action falls, aligned with OCHA cluster system and IATI sector codes. Enables cross-sector analysis and cluster reporting. [ENUM-REF-CANDIDATE: protection|health|nutrition|wash|shelter|education|livelihoods|psychosocial|food_security|cash_and_voucher — promote to reference product]',
    `action_date` DATE COMMENT 'The actual calendar date on which the case action was performed or delivered in the field. This is the principal real-world event date used for MEL reporting, PDM analysis, and donor reporting.',
    `action_outcome` STRING COMMENT 'The result or outcome of the case action as assessed by the case worker at the time of completion. Used for MEL indicator tracking, Results-Based Management (RBM) reporting, and LogFrame output measurement.. Valid values are `successful|partially_successful|unsuccessful|pending|referred_out`',
    `action_reference_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to this case action for use in field reports, SitReps, and donor reporting. Follows the format CA-YYYY-NNNNNN.. Valid values are `^CA-[0-9]{4}-[0-9]{6}$`',
    `action_status` STRING COMMENT 'Current lifecycle status of the case action, tracking progression from planning through completion or cancellation. Used for workload management and case progress monitoring.. Valid values are `planned|in_progress|completed|cancelled|missed|rescheduled`',
    `action_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the case action was recorded or submitted in the system, including timezone offset. Used for audit trails, data quality checks, and real-time field monitoring.',
    `action_type` STRING COMMENT 'Classification of the type of intervention or activity performed during this case action. Drives workflow routing, reporting disaggregation, and MEL indicator tracking. [ENUM-REF-CANDIDATE: home_visit|counseling_session|referral|service_provision|follow_up_call|group_session|needs_assessment|distribution|medical_consultation|legal_aid|psychosocial_support|community_mobilization — promote to reference product]. Valid values are `home_visit|counseling_session|referral|service_provision|follow_up_call|group_session`',
    `admin_level1_code` STRING COMMENT 'ISO 3166-2 or OCHA P-Code for the first administrative division (e.g., state, province, region) where the action was conducted. Used for geographic disaggregation in donor and cluster reports.',
    `admin_level2_code` STRING COMMENT 'OCHA P-Code for the second administrative division (e.g., district, county, woreda) where the action was conducted. Enables sub-national geographic disaggregation for MEL and cluster reporting.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary prior to conducting this case action, in compliance with data protection and humanitarian accountability standards.',
    `consent_type` STRING COMMENT 'Method by which informed consent was obtained from the beneficiary for this case action. Supports accountability and protection mainstreaming requirements.. Valid values are `verbal|written|digital|proxy|not_required`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the country where the case action was conducted. Required for multi-country INGO operations and IATI reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this case action record was first created in the system. Used for audit trail, data lineage, and Silver Layer ingestion tracking.',
    `data_collection_method` STRING COMMENT 'Method used to collect data for this case action. FGD = Focus Group Discussion, KII = Key Informant Interview. Supports data quality assessment and ICT4D (Information and Communication Technology for Development) tracking.. Valid values are `mobile_app|paper_form|phone_interview|direct_observation|fgd|kii`',
    `duration_minutes` STRING COMMENT 'Duration in minutes of the case action or intervention session. Used for workload analysis, staff time tracking, and service intensity measurement in MEL frameworks.',
    `escalation_reason` STRING COMMENT 'Free-text description of the reason this case action was escalated to a higher authority or inter-agency body. Confidential case management information.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this case action has triggered an escalation to a supervisor, protection officer, or inter-agency coordination body due to severity, risk, or unresolved needs.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up action is required after this case action. When true, next_action_due_date must be populated. Drives automated task creation in CommCare and Dynamics 365.',
    `follow_up_type` STRING COMMENT 'Type of follow-up action planned for this case after the current action is completed. Used to pre-populate the next case action record and support case worker scheduling.. Valid values are `home_visit|phone_call|facility_visit|group_session|referral_follow_up`',
    `is_sensitive_case` BOOLEAN COMMENT 'Indicates whether this case action relates to a sensitive protection case such as GBV, child protection, or trafficking. Triggers enhanced data access controls and confidentiality protocols.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the location where the case action was conducted, captured via mobile device GPS. Enables GIS mapping and geographic analysis of service delivery.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the location where the case action was conducted, captured via mobile device GPS. Enables GIS mapping and geographic analysis of service delivery.',
    `muac_measurement_mm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in millimetres recorded during a nutrition screening action. Used to classify Global Acute Malnutrition (GAM) and Severe Acute Malnutrition (SAM) status per SPHERE standards.',
    `next_action_due_date` DATE COMMENT 'The date by which the next follow-up action or intervention for this case must be completed. Drives case worker task queues and escalation alerts in CommCare and Dynamics 365.',
    `nutrition_status` STRING COMMENT 'Nutritional status classification of the beneficiary as assessed during this action, based on MUAC or weight-for-height z-score. SAM = Severe Acute Malnutrition, MAM = Moderate Acute Malnutrition, per SPHERE and WHO standards.. Valid values are `sam|mam|normal|not_assessed`',
    `outcome_notes` STRING COMMENT 'Free-text narrative describing the outcome of the case action, observations made during the visit or session, and any contextual information relevant to case progress. Confidential case management information.',
    `protection_concern_type` STRING COMMENT 'Specific protection concern category associated with this case action, used for disaggregated protection cluster reporting. Confidential and access-restricted. [ENUM-REF-CANDIDATE: gbv|child_protection|trafficking|idp_displacement|statelessness|forced_recruitment|detention|none — promote to reference product]. Valid values are `gbv|child_protection|trafficking|idp_displacement|statelessness|none`',
    `pss_session_number` STRING COMMENT 'Sequential session number for Psychosocial Support (PSS) interventions, tracking the beneficiarys progression through a structured PSS program. Applicable when action_type is counseling_session.',
    `referral_destination` STRING COMMENT 'Name or identifier of the organization, facility, or service to which the beneficiary was referred during this action. Applicable when action_type is referral. Supports referral pathway tracking and inter-agency coordination.',
    `referral_reason` STRING COMMENT 'Description of the reason the beneficiary was referred to another service or organization. Confidential case management information used for inter-agency coordination and case continuity.',
    `scheduled_date` DATE COMMENT 'The originally planned date on which this case action was scheduled to occur. Compared against action_date to measure timeliness and adherence to case plans.',
    `service_items_provided` STRING COMMENT 'Description of specific Non-Food Items (NFIs), services, or assistance items provided to the beneficiary during this action (e.g., hygiene kit, food ration, cash transfer amount). Used for distribution tracking and PDM.',
    `source_record_reference` STRING COMMENT 'The native record identifier from the originating operational system (CommCare case_id, KoboToolbox submission_id, or Dynamics 365 activityid). Enables traceability back to the source system for reconciliation.',
    `source_system` STRING COMMENT 'Operational system of record from which this case action record originated. Supports data lineage, deduplication, and integration quality monitoring in the Databricks Silver Layer.. Valid values are `commcare|kobotoolbox|dynamics365|manual_entry`',
    `supervisor_review_date` DATE COMMENT 'Date on which a supervisor reviewed and validated this case action record. Populated when supervisor_reviewed is true.',
    `supervisor_reviewed` BOOLEAN COMMENT 'Indicates whether a supervisor or team leader has reviewed and validated this case action record. Supports quality assurance, accountability, and CHS compliance verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this case action record was last modified in the system. Used for change data capture, audit trails, and incremental Silver Layer processing.',
    CONSTRAINT pk_case_action PRIMARY KEY(`case_action_id`)
) COMMENT 'Transactional log of individual actions, interventions, and follow-up activities taken within a beneficiary case. Captures action type (home visit, counseling session, referral, service provision, follow-up call), action date, action outcome, responsible staff or volunteer, next action due date, and action notes. Enables case progress tracking and workload management for case workers.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique identifier for the referral transaction. Primary key for the referral data product.',
    `case_action_id` BIGINT COMMENT 'Foreign key linking to beneficiary.case_action. Business justification: Referrals in humanitarian case management are typically the outcome of a specific case action (e.g., a home visit action that identifies the need for a referral to a health facility). Linking referral',
    `case_record_id` BIGINT COMMENT 'Identifier of the case management record associated with this referral, if applicable.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Referrals in NGO case management are made from and to specific program components (e.g., nutrition component refers to health component). Component-level referral tracking is required for inter-compon',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor requirements mandate specific referral pathways and protocols (USAID ADS 303 GBV referral standards, UNHCR protection referral requirements). Linking referral to the governing donor_requirement ',
    `intervention_id` BIGINT COMMENT 'Identifier of the specific program within the referring organization that is making the referral.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Referrals are processed by specific org units. Linking enables referral pathway analysis by organizational unit, used in protection cluster coordination, inter-agency referral reporting, and donor nar',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Referrals specify destination field facilities for service delivery. Core to protection and health referral pathway management, inter-agency coordination, and service accessibility analysis. Role-pref',
    `partner_org_id` BIGINT COMMENT 'Identifier of the organization or service provider that is receiving and expected to act on the referral.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member at the receiving organization who is assigned to handle this referral.',
    `referral_partner_org_id` BIGINT COMMENT 'Identifier of the organization or partner that is initiating and submitting the referral.',
    `referral_staff_member_id` BIGINT COMMENT 'Identifier of the staff member or case worker who initiated the referral on behalf of the beneficiary.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Community volunteers identify and refer beneficiaries to specialized services (health, protection, legal aid). Critical for community-based protection, health outreach, and early identification progra',
    `registrant_id` BIGINT COMMENT 'Identifier of the beneficiary being referred to another service provider or program.',
    `acceptance_date` DATE COMMENT 'Date when the receiving organization formally accepted the referral and committed to providing services.',
    `beneficiary_satisfaction_rating` STRING COMMENT 'Numeric rating provided by the beneficiary indicating their satisfaction with the referral process and services received, typically on a scale of 1-5.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the referral was cancelled before completion, including beneficiary circumstances or organizational constraints.',
    `completion_date` DATE COMMENT 'Date when the referral was marked as completed, indicating that all required services have been delivered and documented.',
    `confidentiality_level` STRING COMMENT 'Classification of the sensitivity of the referral case, particularly important for Gender-Based Violence (GBV) and protection cases requiring special handling.. Valid values are `standard|sensitive|highly_sensitive`',
    `consent_date` DATE COMMENT 'Date when informed consent was obtained from the beneficiary for the referral and information sharing.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or their guardian before making the referral, in compliance with protection and data privacy standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this referral record originated, such as CommCare, KoboToolbox, or Microsoft Dynamics 365.',
    `decline_reason` STRING COMMENT 'Explanation provided when a referral is declined by the receiving organization or rejected by the beneficiary.',
    `expected_response_date` DATE COMMENT 'Target date by which the receiving organization is expected to acknowledge or respond to the referral.',
    `feedback_received_flag` BOOLEAN COMMENT 'Indicates whether feedback was received from the beneficiary regarding their satisfaction with the referral process and services received.',
    `follow_up_completed_flag` BOOLEAN COMMENT 'Indicates whether the scheduled follow-up with the beneficiary or receiving organization has been completed.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up contact with the beneficiary or receiving organization to verify service delivery and outcome.',
    `gbv_case_flag` BOOLEAN COMMENT 'Indicates whether this referral is related to a Gender-Based Violence (GBV) case, requiring adherence to specialized GBV referral pathways and confidentiality protocols.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context about the referral that may be relevant for case management and coordination.',
    `outcome` STRING COMMENT 'Detailed description of the outcome of the referral, including services provided, beneficiary response, and any follow-up actions required.',
    `outcome_category` STRING COMMENT 'Standardized classification of the referral outcome for reporting and analysis purposes.. Valid values are `successful|partially_successful|unsuccessful|beneficiary_declined|service_unavailable|lost_to_follow_up`',
    `priority_level` STRING COMMENT 'Urgency classification of the referral indicating how quickly the beneficiary needs to receive services.. Valid values are `low|medium|high|critical`',
    `protection_concern_flag` BOOLEAN COMMENT 'Indicates whether the referral involves protection concerns such as child protection, trafficking, exploitation, or other safeguarding issues.',
    `reason` STRING COMMENT 'Detailed explanation of why the beneficiary is being referred, including specific needs, conditions, or circumstances that necessitate the referral.',
    `receiving_organization_name` STRING COMMENT 'Name of the organization or service provider receiving the referral, for tracking and reporting purposes.',
    `receiving_service_type` STRING COMMENT 'Specific type of service or program that the beneficiary is being referred to at the receiving organization.',
    `receiving_staff_name` STRING COMMENT 'Full name of the staff member at the receiving organization who accepted or is processing the referral.',
    `referral_category` STRING COMMENT 'Primary service category or sector for which the beneficiary is being referred. Aligned with humanitarian cluster system and Sphere standards. [ENUM-REF-CANDIDATE: health|protection|shelter|wash|nutrition|education|livelihoods|psychosocial|legal|other — 10 candidates stripped; promote to reference product]',
    `referral_date` DATE COMMENT 'The date when the referral was initiated and submitted to the receiving organization or service provider.',
    `referral_number` STRING COMMENT 'Human-readable business identifier for the referral, used for tracking and communication across organizations.. Valid values are `^REF-[0-9]{8}$`',
    `referral_status` STRING COMMENT 'Current lifecycle status of the referral indicating whether it has been accepted, is being processed, completed, or declined by the receiving organization.. Valid values are `pending|accepted|in_progress|completed|declined|cancelled`',
    `referral_type` STRING COMMENT 'Classification of the referral based on organizational scope and urgency. Internal referrals are within the same organization, external are to partner organizations, emergency referrals require immediate action.. Valid values are `internal|external|emergency|routine|urgent`',
    `referring_staff_contact` STRING COMMENT 'Phone number or email address of the referring staff member for coordination and follow-up communication.',
    `referring_staff_name` STRING COMMENT 'Full name of the staff member who initiated the referral, for contact and follow-up purposes.',
    `service_delivery_date` DATE COMMENT 'Date when the service was actually delivered to the beneficiary by the receiving organization.',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Transactional record of a formal referral of a beneficiary from one service provider, program, or organization to another. Captures referral date, referring organization, receiving organization or service, referral reason, referral type (internal, external, emergency), referral status (pending, accepted, completed, declined), follow-up date, and outcome. Supports inter-agency coordination, GBV referral pathways, and protection case management.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`protection_flag` (
    `protection_flag_id` BIGINT COMMENT 'Unique identifier for the protection flag record. Primary key.',
    `case_record_id` BIGINT COMMENT 'Reference to the case management record if this flag is part of an active case. Links to CommCare case management system.',
    `country_office_id` BIGINT COMMENT 'Reference to the geographic location where the protection concern was identified. Links to field operations location master.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Protection incidents trigger mandatory donor reporting requirements (USAID ADS 303, ECHO protection reporting, UNHCR incident reporting). Linking protection_flag to the specific donor_requirement mand',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Protection flags raised during emergencies must be tracked against the emergency for GBV/protection cluster reporting to OCHA and donors. Emergency-level protection flag counts are a standard humanita',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Protection flags must be handled per specific governance policies (safeguarding policy, GBV response policy, whistleblower policy). Linking protection_flag to the governing governance_policy ensures p',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: Protection concerns in humanitarian contexts frequently apply at the household level (e.g., GBV risk for a female-headed household, child protection concerns affecting all household members). Adding h',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Protection concerns (GBV, child abuse, exploitation, SEA) trigger formal compliance incidents requiring investigation per safeguarding policies. Essential for linking beneficiary protection flags to o',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this protection flag is being managed and tracked.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Protection flags are managed by protection teams within org units. Linking enables protection incident reporting by org unit for cluster coordination, safeguarding compliance reporting, and donor acco',
    `staff_member_id` BIGINT COMMENT 'Reference to the protection officer or case worker currently responsible for managing this protection flag and coordinating response.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Protection flags are identified at specific project sites; field protection officers need site-level protection dashboards for cluster reporting. protection_flag already links to country_office but no',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary or household associated with this protection flag. Links to the beneficiary master record.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Protection monitoring: volunteers (community protection monitors) identify and report protection flags. Tracking the reporting volunteer is required for accountability, supervision, and protection inc',
    `confidentiality_level` STRING COMMENT 'Data classification level for this protection flag record. Most protection flags are Restricted due to sensitive nature of protection concerns.. Valid values are `Restricted|Confidential|Internal|Public`',
    `consent_date` DATE COMMENT 'Date when informed consent was obtained from the beneficiary or guardian for protection case management.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or guardian for recording and managing this protection flag.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protection flag record was first created in the system. Audit trail field for data governance.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this protection flag record originated. Typically CommCare, KoboToolbox, or partner case management systems.',
    `escalation_date` DATE COMMENT 'Date when the protection flag was escalated to higher authority or specialized protection services.',
    `escalation_reason` STRING COMMENT 'Explanation of why the protection flag required escalation, including severity factors or complexity of the case.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this protection flag requires escalation to senior management, specialized protection teams, or external authorities.',
    `external_reference_code` STRING COMMENT 'External identifier from the source system or partner organization. Used for cross-system reconciliation and data integration.',
    `flag_code` STRING COMMENT 'Standardized code identifying the protection flag type. Used for system integration and reporting aggregation.. Valid values are `^[A-Z]{3,6}$`',
    `flag_date` DATE COMMENT 'Date when the protection concern was first identified or flagged. Represents the business event timestamp for this protection record.',
    `flag_severity` STRING COMMENT 'Severity level of the protection concern indicating urgency of response and level of risk to the beneficiary.. Valid values are `Critical|High|Medium|Low`',
    `flag_status` STRING COMMENT 'Current lifecycle status of the protection flag indicating whether it requires active intervention, ongoing monitoring, or has been resolved.. Valid values are `Active|Monitoring|Resolved|Closed|Escalated|Referred`',
    `flag_type` STRING COMMENT 'Category of protection concern. GBV (Gender-Based Violence), SGBV (Sexual and Gender-Based Violence), UASC (Unaccompanied and Separated Children). [ENUM-REF-CANDIDATE: GBV Risk|Child Protection|SGBV Survivor|Unaccompanied Minor|UASC|Trafficking Risk|Forced Recruitment|Disability Protection|Elderly at Risk|Medical Vulnerability — 10 candidates stripped; promote to reference product]',
    `flagging_source` STRING COMMENT 'Name of the organization, program, or system that originally flagged this protection concern. May reference partner organizations or internal programs.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether ongoing follow-up monitoring or case management is required for this protection flag.',
    `identification_method` STRING COMMENT 'Method or channel through which the protection concern was identified. FGD (Focus Group Discussion), KII (Key Informant Interview). [ENUM-REF-CANDIDATE: Field Assessment|Community Referral|Self-Reported|Partner Organization|Health Screening|Household Survey|Focus Group Discussion|Key Informant Interview — 8 candidates stripped; promote to reference product]',
    `immediate_needs` STRING COMMENT 'Description of immediate protection needs or interventions required to address the flagged concern. Used for rapid response planning.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this protection flag is currently active and requires ongoing attention. Derived from flag_status but provided for simplified querying.',
    `last_follow_up_date` DATE COMMENT 'Date of the most recent follow-up visit or assessment conducted for this protection flag.',
    `legal_action_required` BOOLEAN COMMENT 'Indicates whether the protection concern requires legal intervention, law enforcement involvement, or judicial proceedings.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this protection flag record was last modified. Audit trail field for data governance and change tracking.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next follow-up visit or assessment to monitor the protection concern and beneficiary status.',
    `notes` STRING COMMENT 'Additional case notes, observations, or contextual information related to the protection flag. Contains sensitive case management details.',
    `pss_provided` BOOLEAN COMMENT 'Indicates whether Psychosocial Support (PSS) services have been provided to the beneficiary as part of protection response.',
    `referral_date` DATE COMMENT 'Date when the referral to specialized protection services was made.',
    `referral_made` BOOLEAN COMMENT 'Indicates whether the beneficiary has been referred to specialized protection services or partner organizations for support.',
    `referral_organization` STRING COMMENT 'Name of the organization or service provider to which the beneficiary was referred for specialized protection support.',
    `reporting_period` STRING COMMENT 'Reporting period during which this protection flag was active or recorded. Format: YYYY-QN for quarterly or YYYY-MM for monthly reporting.. Valid values are `^d{4}-Q[1-4]$|^d{4}-d{2}$`',
    `resolution_date` DATE COMMENT 'Date when the protection concern was resolved or the flag was closed. Null if the flag is still active or under monitoring.',
    `resolution_notes` STRING COMMENT 'Narrative description of how the protection concern was resolved, interventions provided, and outcomes achieved.',
    `risk_description` STRING COMMENT 'Detailed narrative description of the specific protection risk or concern. Contains sensitive information about the nature of the threat or vulnerability.',
    CONSTRAINT pk_protection_flag PRIMARY KEY(`protection_flag_id`)
) COMMENT 'Master record of active protection concerns and risk flags associated with a beneficiary or household. Captures flag type (GBV risk, child protection, SGBV survivor, unaccompanied minor, UASC, trafficking risk, forced recruitment), flag severity, flag date, flagging source, current status (active, resolved, monitoring), assigned protection officer, and confidentiality classification. Enables protection mainstreaming across all program sectors.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`document_record` (
    `document_record_id` BIGINT COMMENT 'Unique identifier for the document record. Primary key for the document_record product.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Document capture chain-of-custody: volunteers capture beneficiary identity documents during field registration. Tracking the capturing volunteer is required for data quality audits, GDPR compliance, a',
    `case_record_id` BIGINT COMMENT 'Foreign key linking to beneficiary.case_record. Business justification: Identity and legal documents are frequently collected and managed within the context of a specific case (e.g., birth certificates collected during a child protection case, legal documents for a GBV su',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor requirements mandate specific document verification standards (identity verification, legal status, eligibility documentation). Links document records to the compliance requirements they fulfill',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Forged identity documents, fraudulent verification records, or document misuse are direct evidence in compliance incidents. NGO fraud investigators need to link specific document records to compliance',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this document was collected or verified.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Identity documents are captured at specific project sites; field verification compliance audits require site-level document capture tracking. registration_location_code is a plain text field. Site-lev',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary who owns or is associated with this document.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who performed the document verification.',
    `capture_device_code` STRING COMMENT 'Unique identifier of the mobile device, scanner, or workstation used to capture the document. Supports audit trail and data quality tracking.',
    `capture_method` STRING COMMENT 'The method used to capture the document information into the system (e.g., mobile scan via KoboToolbox, flatbed scanner, photograph, manual data entry).. Valid values are `mobile_scan|flatbed_scan|photograph|manual_entry|digital_upload`',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity of the document and the access controls required. Aligns with organizational data governance policies.. Valid values are `public|internal|confidential|restricted`',
    `consent_date` DATE COMMENT 'The date on which the beneficiary provided consent for document collection and processing. Format: yyyy-MM-dd.',
    `consent_method` STRING COMMENT 'The method by which consent was obtained from the beneficiary (e.g., written signature, verbal consent recorded, digital signature, biometric confirmation).. Valid values are `written|verbal|digital_signature|biometric|proxy`',
    `consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary provided informed consent for the collection, storage, and use of this document. True if consent was obtained.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this document record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and data lineage.',
    `data_sharing_consent` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary consented to sharing this document with partner organizations or coordination bodies. True if sharing consent was obtained.',
    `document_condition` STRING COMMENT 'Physical condition of the document at the time of registration or verification. Impacts reliability for identity verification.. Valid values are `excellent|good|fair|poor|damaged|illegible`',
    `document_image_reference` STRING COMMENT 'File path, URL, or storage reference to the scanned or photographed image of the document. Used for audit and verification purposes.',
    `document_language_code` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code indicating the primary language in which the document is written.. Valid values are `^[a-z]{2,3}$`',
    `document_number` STRING COMMENT 'The unique alphanumeric identifier printed on the document by the issuing authority. Used for identity verification and legal status determination.',
    `document_type` STRING COMMENT 'Classification of the identity or legal document. Common types include UNHCR registration certificates, national ID cards, birth certificates, marriage certificates, asylum seeker cards, and travel documents.. Valid values are `unhcr_registration|national_id|birth_certificate|marriage_certificate|asylum_seeker_card|travel_document`',
    `expiry_date` DATE COMMENT 'The date on which the document expires and is no longer valid for legal or identification purposes. Nullable for documents without expiration (e.g., birth certificates). Format: yyyy-MM-dd.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems, partner organizations, or coordination platforms (e.g., UNHCR proGres ID, OCHA reference number) to cross-reference this document.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this document record is currently active and valid for use in program operations. False if the record has been superseded, invalidated, or archived.',
    `is_primary_identity_document` BOOLEAN COMMENT 'Boolean flag indicating whether this document is the primary identity document for the beneficiary. True if this is the main document used for identity verification.',
    `issue_date` DATE COMMENT 'The date on which the document was officially issued by the authority. Format: yyyy-MM-dd.',
    `issuing_authority` STRING COMMENT 'The government agency, international organization, or official body that issued the document (e.g., Ministry of Interior, UNHCR, National Registration Bureau).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country or territory where the document was issued.. Valid values are `^[A-Z]{3}$`',
    `legal_status_indicator` STRING COMMENT 'The legal status of the beneficiary as evidenced by this document. Supports protection case management and eligibility determination for humanitarian assistance. [ENUM-REF-CANDIDATE: refugee|asylum_seeker|idp|stateless|citizen|resident|undocumented — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this document record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional observations, comments, or context about the document that do not fit into structured fields. Used by case workers and protection officers.',
    `registration_location_code` STRING COMMENT 'Code or identifier of the field location, camp, or registration center where the document was recorded into the system.',
    `retention_period_days` STRING COMMENT 'The number of days for which this document record must be retained according to organizational policy, donor requirements, or legal obligations. After this period, the record may be archived or deleted.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this document record in the source operational system. Supports data lineage and reconciliation.',
    `source_system` STRING COMMENT 'Name or identifier of the operational system from which this document record originated (e.g., CommCare, KoboToolbox, Salesforce Nonprofit Cloud).',
    `verification_date` DATE COMMENT 'The date on which the document was last verified by authorized staff. Format: yyyy-MM-dd.',
    `verification_method` STRING COMMENT 'The method or process used to verify the authenticity of the document (e.g., visual inspection, biometric matching, confirmation with issuing authority).. Valid values are `visual_inspection|biometric_match|authority_confirmation|third_party_validation|digital_verification`',
    `verification_status` STRING COMMENT 'Current verification state of the document. Indicates whether the document has been authenticated by program staff or partner organizations.. Valid values are `verified|pending|unverified|expired|invalid|under_review`',
    CONSTRAINT pk_document_record PRIMARY KEY(`document_record_id`)
) COMMENT 'Master record of identity and legal documents associated with a beneficiary, including UNHCR registration certificates, national ID cards, birth certificates, marriage certificates, asylum seeker cards, and travel documents. Captures document type, document number, issuing authority, issue date, expiry date, verification status, and document image reference. Supports identity verification, legal status determination, and protection documentation.';

CREATE OR REPLACE TABLE `ngo_ecm`.`beneficiary`.`community` (
    `community_id` BIGINT COMMENT 'Unique identifier for the community, settlement, camp, or geographic area registered as a collective beneficiary unit. Primary key for the community entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO community-level financial reporting requires knowing which cost center funds operations in each community. Program finance officers allocate costs by geographic community unit, and cost centers of',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Field teams are assigned to serve specific communities; field managers need community-to-team assignment for coverage planning, supervision, and community engagement reporting. No existing field_team_',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: NGO geographic targeting and community-level program planning requires linking communities to the interventions operating within them. Community-level intervention mapping is essential for coverage an',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Community engagement: NGOs assign a volunteer as the community liaison/focal point per community for mobilization and outreach. This link is essential for community-level volunteer coverage reporting ',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Communities are served by specific field offices/org units. This link enables reporting on which org unit is responsible for which communities — essential for field coordination, budget allocation, pr',
    `parent_community_id` BIGINT COMMENT 'Self-referencing FK on community (parent_community_id)',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: In consortium and area-based approaches, partners are assigned responsibility for specific communities or geographic zones. Tracking the lead partner per community enables coordination, avoids duplica',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Communities fall within specific project site catchment areas; field planners need to know which communities each site serves for coverage analysis and resource allocation. No existing project_site_id',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or enumerator who registered the community in the system. Used for data quality accountability and field operations management.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Each community is served by a designated last-mile distribution warehouse (catchment area assignment). NGO logisticians use this link for warehouse capacity planning, last-mile delivery routing, and c',
    `access_constraint_level` STRING COMMENT 'Level of operational access constraints affecting the community due to security incidents, administrative restrictions, natural barriers, or conflict dynamics. No constraint: full access. Low: minor delays. Medium: significant restrictions. High: severely constrained. No access: inaccessible. Used for operational planning and risk management.. Valid values are `no_constraint|low|medium|high|no_access`',
    `active_program_count` STRING COMMENT 'Number of active humanitarian or development programs currently operating in the community. Used for coordination, gap analysis, and 3W (Who does What Where) reporting.',
    `admin1_code` STRING COMMENT 'First-level administrative division code (province, state, governorate) where the community is located. Aligns with OCHA Common Operational Dataset Administrative Boundaries (COD-AB) P-codes for standardized geographic reporting.',
    `admin1_name` STRING COMMENT 'Name of the first-level administrative division (province, state, governorate) where the community is located. Human-readable complement to admin1_code.',
    `admin2_code` STRING COMMENT 'Second-level administrative division code (district, county, department) where the community is located. Aligns with OCHA COD-AB P-codes for standardized geographic reporting.',
    `admin2_name` STRING COMMENT 'Name of the second-level administrative division (district, county, department) where the community is located. Human-readable complement to admin2_code.',
    `admin3_code` STRING COMMENT 'Third-level administrative division code (sub-district, municipality) where the community is located. Aligns with OCHA COD-AB P-codes where available.',
    `admin3_name` STRING COMMENT 'Name of the third-level administrative division (sub-district, municipality) where the community is located. Human-readable complement to admin3_code.',
    `admin4_code` STRING COMMENT 'Fourth-level administrative division code (village, neighborhood, locality) where the community is located. Aligns with OCHA COD-AB P-codes where available.',
    `admin4_name` STRING COMMENT 'Name of the fourth-level administrative division (village, neighborhood, locality) where the community is located. Human-readable complement to admin4_code.',
    `community_code` STRING COMMENT 'Externally-known unique business identifier or code for the community, used in field operations, 3W (Who does What Where) reporting, and inter-agency coordination. May align with OCHA P-codes or agency-specific community identifiers.',
    `community_name` STRING COMMENT 'Official or commonly-used name of the community, settlement, camp, or geographic area. This is the primary human-readable identifier used in field reports, SitReps (Situation Reports), and beneficiary communications.',
    `community_status` STRING COMMENT 'Current lifecycle status of the community registration. Active: community is currently served by programs. Inactive: temporarily not served. Closed: community no longer exists or is no longer a target. Planned: community identified for future programming. Suspended: operations temporarily halted due to access constraints or security incidents.. Valid values are `active|inactive|closed|planned|suspended`',
    `consent_date` DATE COMMENT 'Date when community consent was obtained for data collection and program activities. Used for consent tracking and compliance documentation.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from community leadership or representatives for data collection, program implementation, and data sharing. True if consent obtained, False otherwise. Supports CHS (Core Humanitarian Standard) accountability commitments and GDPR compliance where applicable.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code where the community is located. Used for country-level aggregation, compliance reporting, and IATI (International Aid Transparency Initiative) transparency reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this community record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the community has consented to sharing of community-level data with partner organizations, clusters, or coordination bodies. True if data sharing permitted, False otherwise. Supports inter-agency coordination while respecting community preferences.',
    `displacement_status` STRING COMMENT 'Classification of the community based on displacement dynamics. Host community: existing community hosting displaced populations. IDP settlement: community primarily composed of Internally Displaced Persons. Refugee camp: formal refugee settlement. Returnee community: community of returned displaced persons. Mixed: combination of host and displaced populations.. Valid values are `host_community|idp_settlement|refugee_camp|returnee_community|mixed`',
    `estimated_population` STRING COMMENT 'Estimated total number of individuals residing in or associated with the community. This is the principal quantitative measurement for the community resource, used for needs calculations, resource allocation, and coverage reporting.',
    `gbv_risk_level` STRING COMMENT 'Assessment of GBV risk level in the community based on safety audits, incident reports, and vulnerability indicators. Used for GBV prevention programming, safe space establishment, and referral pathway planning.. Valid values are `low|medium|high|critical`',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Accuracy of the GPS coordinates in meters. Indicates the precision of the latitude and longitude measurements, important for field data quality assessment and spatial analysis reliability.',
    `health_facility_distance_km` DECIMAL(18,2) COMMENT 'Distance in kilometers from the community to the nearest functional health facility. Used for health access analysis, referral planning, and mobile health outreach prioritization.',
    `household_count` STRING COMMENT 'Estimated or verified number of households within the community. Used for household-level targeting and distribution planning in WASH, shelter, and NFI (Non-Food Item) programs.',
    `ipc_phase` STRING COMMENT 'IPC acute food insecurity phase classification for the community. Phase 1: Minimal/None. Phase 2: Stressed. Phase 3: Crisis. Phase 4: Emergency. Phase 5: Catastrophe/Famine. Used for food security targeting and early warning.. Valid values are `phase_1|phase_2|phase_3|phase_4|phase_5`',
    `last_assessment_date` DATE COMMENT 'Date of the most recent needs assessment or monitoring visit conducted in the community. Used to track data currency and schedule follow-up assessments.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the community centroid or primary access point. Used for GIS (Geographic Information System) mapping, spatial analysis, and proximity-based service planning.',
    `leader_contact` STRING COMMENT 'Primary contact information (phone number or other communication channel) for the community leader or representative. Used for coordination, consultation, and feedback mechanisms. Classified as confidential PII.',
    `leader_name` STRING COMMENT 'Name of the primary community leader, elder, or representative. Used for community engagement, consultation, and accountability mechanisms. Classified as confidential to protect community leadership in sensitive contexts.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the community centroid or primary access point. Used for GIS mapping, spatial analysis, and proximity-based service planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this community record was last modified. Used for audit trail, change tracking, and data currency assessment.',
    `notes` STRING COMMENT 'Free-text field for additional contextual information, operational notes, or special considerations about the community. Used for qualitative context that does not fit structured fields.',
    `primary_language_code` STRING COMMENT 'ISO 639-3 three-letter code for the primary language spoken in the community. Used for communication planning, translation needs, and culturally appropriate programming.. Valid values are `^[a-z]{3}$`',
    `protection_concern_flag` BOOLEAN COMMENT 'Indicates whether the community has been flagged for protection concerns such as GBV (Gender-Based Violence) risk, child protection issues, or other safety and security threats. True if protection concerns exist, False otherwise. Used for protection mainstreaming and specialized protection interventions.',
    `registration_date` DATE COMMENT 'Date when the community was first registered in the system as a collective beneficiary unit for area-based programming. This is the principal business event timestamp for the community entity.',
    `registration_source` STRING COMMENT 'Source system or tool used to register the community (e.g., KoboToolbox, CommCare, DHIS2, manual field assessment). Used for data lineage tracking and quality assessment.',
    `sanitation_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of households in the community with access to adequate sanitation facilities (latrines, toilets) meeting Sphere minimum standards (1 toilet per 20 people). Used for WASH gap analysis and intervention planning.',
    `settlement_type` STRING COMMENT 'Classification of the community or settlement type. Formal camp: officially designated refugee or IDP (Internally Displaced Person) camp. Informal settlement: spontaneous or unplanned settlement. Host community: existing community hosting displaced populations. Collective center: shared facility (school, warehouse) used for temporary shelter. Transit site: temporary waypoint for displaced populations. Urban area: city or town neighborhood.. Valid values are `formal_camp|informal_settlement|host_community|collective_center|transit_site|urban_area`',
    `vulnerability_category` STRING COMMENT 'Categorical classification of community vulnerability level derived from vulnerability_score. Critical: immediate life-saving assistance required. High: urgent multi-sectoral needs. Medium: moderate needs requiring monitoring. Low: stable with minimal humanitarian needs. Used for targeting and resource allocation decisions.. Valid values are `critical|high|medium|low`',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Composite vulnerability score for the community based on multi-sectoral needs assessment indicators (WASH, shelter, food security, protection, health). Higher scores indicate greater vulnerability and higher priority for humanitarian assistance. Scoring methodology aligns with agency-specific vulnerability assessment frameworks.',
    `water_access_flag` BOOLEAN COMMENT 'Indicates whether the community has adequate access to safe water sources according to Sphere minimum standards (15 liters per person per day within 500 meters). True if adequate access exists, False otherwise. Used for WASH (Water Sanitation and Hygiene) needs prioritization.',
    CONSTRAINT pk_community PRIMARY KEY(`community_id`)
) COMMENT 'Master record for a community, settlement, camp, or geographic area registered as a collective beneficiary unit for area-based humanitarian programming. Captures community name, geographic coordinates, administrative boundaries (admin1-admin4), settlement type (formal camp, informal settlement, host community, collective center, transit site), estimated population, community leadership contacts, community-level vulnerability indicators (access to water, sanitation coverage, health facility proximity), registration date, and active program associations. Enables community-based targeting for WASH, shelter, food security, and livelihoods interventions where the unit of assistance is the community rather than individual or household. Supports OCHA Common Operational Dataset (COD) alignment and 3W (Who does What Where) reporting.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_deduplication_master_registrant_id` FOREIGN KEY (`deduplication_master_registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `ngo_ecm`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_previous_profile_vulnerability_profile_id` FOREIGN KEY (`previous_profile_vulnerability_profile_id`) REFERENCES `ngo_ecm`.`beneficiary`.`vulnerability_profile`(`vulnerability_profile_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_vulnerability_profile_id` FOREIGN KEY (`vulnerability_profile_id`) REFERENCES `ngo_ecm`.`beneficiary`.`vulnerability_profile`(`vulnerability_profile_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `ngo_ecm`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `ngo_ecm`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_case_action_id` FOREIGN KEY (`case_action_id`) REFERENCES `ngo_ecm`.`beneficiary`.`case_action`(`case_action_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `ngo_ecm`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `ngo_ecm`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `ngo_ecm`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_parent_community_id` FOREIGN KEY (`parent_community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);

-- ========= TAGS =========
ALTER SCHEMA `ngo_ecm`.`beneficiary` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `ngo_ecm`.`beneficiary` SET TAGS ('dbx_domain' = 'beneficiary');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` SET TAGS ('dbx_subdomain' = 'beneficiary_registration');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_master_registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Master Record ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `intervention_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `intervention_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Registering Staff Member ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Age in Years');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Registration Completeness Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Given Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_value_regex' = 'pending|unique|duplicate|merged|flagged');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_business_glossary_term' = 'Disability Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name (Surname)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name (First Name)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_business_glossary_term' = 'Disability Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Survivor Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman (PLW) Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `nationality_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `poc_category` SET TAGS ('dbx_business_glossary_term' = 'Person of Concern (PoC) Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code (ISO 639)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `re_registration_count` SET TAGS ('dbx_business_glossary_term' = 'Re-Registration Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_modality` SET TAGS ('dbx_business_glossary_term' = 'Registration Modality');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_modality` SET TAGS ('dbx_value_regex' = 'in_person|mobile|remote|self_registration');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_source_system` SET TAGS ('dbx_business_glossary_term' = 'Registration Source System');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_source_system` SET TAGS ('dbx_value_regex' = 'commcare|kobotoolbox|progres_v4|wfp_scope|rais|manual');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|departed|duplicate|suspended');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_tool` SET TAGS ('dbx_business_glossary_term' = 'Registration Tool');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_tool` SET TAGS ('dbx_value_regex' = 'kobotoolbox|commcare|paper_form|progres_v4|scope|other');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'individual|household_head|household_member|community');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Sex');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Number');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_value_regex' = 'national_id|passport|unhcr_card|birth_certificate|community_attestation|none');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` SET TAGS ('dbx_subdomain' = 'beneficiary_registration');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community / Settlement ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Programme ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator / Field Staff ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name (Region/Province)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name (District/County)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_business_glossary_term' = 'CommCare Case ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166-1 Alpha-3)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `current_country` SET TAGS ('dbx_business_glossary_term' = 'Current Country of Residence (ISO 3166-1 Alpha-3)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `current_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `deregistration_date` SET TAGS ('dbx_business_glossary_term' = 'Household Deregistration Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `displacement_date` SET TAGS ('dbx_business_glossary_term' = 'Displacement Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|stateless|asylum_seeker');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `elderly_count` SET TAGS ('dbx_business_glossary_term' = 'Elderly Member Count (60+)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Programme Exit Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `female_count` SET TAGS ('dbx_business_glossary_term' = 'Female Member Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `food_security_status` SET TAGS ('dbx_business_glossary_term' = 'Food Security Status (IPC Phase)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `food_security_status` SET TAGS ('dbx_value_regex' = 'food_secure|mildly_insecure|moderately_insecure|severely_insecure');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Risk Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude Coordinate');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude Coordinate');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `has_pregnant_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman Present Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `has_unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied or Separated Child (UASC) Present Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `kobo_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'KoboToolbox Submission ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Needs Assessment Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `male_count` SET TAGS ('dbx_business_glossary_term' = 'Male Member Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Household Case Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `pwd_count` SET TAGS ('dbx_business_glossary_term' = 'Persons with Disabilities (PWD) Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Number');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_verification|archived');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'initial|re-registration|update|verification');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `sanitation_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Facility Type (WASH)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `sanitation_facility_type` SET TAGS ('dbx_value_regex' = 'flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_business_glossary_term' = 'Shelter Ownership Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_value_regex' = 'owned|rented|informal|provided_by_org|communal');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `shelter_type` SET TAGS ('dbx_business_glossary_term' = 'Shelter Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Household Size (Total Members)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Household Vulnerability Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Household Vulnerability Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Water Source Type (WASH)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` SET TAGS ('dbx_subdomain' = 'beneficiary_registration');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_business_glossary_term' = 'Household Member ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `age_estimated` SET TAGS ('dbx_business_glossary_term' = 'Age Estimated Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Age in Years');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `consent_withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'kobo_survey|commcare_mobile|paper_form|fgd|kii|other');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_business_glossary_term' = 'Is Female-Headed Household Member Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `is_head_of_household` SET TAGS ('dbx_business_glossary_term' = 'Is Head of Household Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_value_regex' = 'employed|self_employed|unemployed|student|unable_to_work|not_applicable');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_business_glossary_term' = 'Household Member Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_value_regex' = '^HHM-[A-Z0-9]{6,12}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_business_glossary_term' = 'Household Member Role');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_value_regex' = 'head|spouse|child|dependent|elderly|other');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Household Membership End Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_business_glossary_term' = 'Household Membership End Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_value_regex' = 'deceased|transferred_household|relocated|voluntary_exit|administrative_closure|other');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Household Membership Start Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Household Membership Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|transferred|deceased|departed');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `muac_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'MUAC Assessment Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Member Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Location Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{3,10}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `relationship_to_head` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Head of Household');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `school_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'School Enrollment Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `school_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|dropout|graduated|not_applicable');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Sex');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|intersex|prefer_not_to_say');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|rejected');
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` SET TAGS ('dbx_subdomain' = 'beneficiary_registration');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Assessing Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Vulnerability Profile ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assessed By Staff ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Illness Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_business_glossary_term' = 'Chronic Illness Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `composite_vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Vulnerability Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Inter-Agency Data Sharing Consent Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_business_glossary_term' = 'Disability Classification (Washington Group Questions)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_business_glossary_term' = 'Disability Severity Level (Washington Group Questions)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_value_regex' = 'no_difficulty|some_difficulty|a_lot_of_difficulty|cannot_do');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_business_glossary_term' = 'Displacement Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_value_regex' = 'IDP|refugee|returnee|stateless|asylum_seeker|host_community');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `elderly_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Elderly Household Member Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `female_headed_household_flag` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Exposure Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{2,10}(-[A-Z0-9]{2,10})?$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_business_glossary_term' = 'Integrated Food Security Phase Classification (IPC) Phase');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_value_regex' = 'none|disrupted|partial|stable');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Measurement (mm)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reassessment Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Status (GAM/SAM Classification)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_value_regex' = 'SAM|MAM|normal|overweight');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman (PLW) Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^VP-[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_source` SET TAGS ('dbx_business_glossary_term' = 'Profile Source');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_source` SET TAGS ('dbx_value_regex' = 'initial_registration|periodic_reassessment|post_distribution_monitoring|emergency_screening|referral|other');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|archived|pending_review|superseded|draft');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Protection Risk Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Need Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_business_glossary_term' = 'Shelter Adequacy Classification');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_value_regex' = 'adequate|inadequate|none|transitional');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Tier');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `wash_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Access Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `needs_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Needs Assessment ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Position Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Identifier');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Field Enumerator ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Assessment Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_level` SET TAGS ('dbx_value_regex' = 'individual|household|community');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_value_regex' = '^NA-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|validated|rejected|archived');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Version');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial_registration|periodic_reassessment|post_crisis_rapid|sector_specific_deep');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'verbal|written|proxy');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'face_to_face|remote_phone|fgd|kii|observation|secondary_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|stateless|non_displaced');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `education_score` SET TAGS ('dbx_business_glossary_term' = 'Education Sector Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `enumerator_notes` SET TAGS ('dbx_business_glossary_term' = 'Field Enumerator Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `female_headed_household` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Risk Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (Meters)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `livelihoods_score` SET TAGS ('dbx_business_glossary_term' = 'Livelihoods Sector Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Measurement (mm)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `nutrition_score` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Sector Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `overall_vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Vulnerability Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_business_glossary_term' = 'Persons with Disability Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `protection_score` SET TAGS ('dbx_business_glossary_term' = 'Protection Sector Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `referral_recommended` SET TAGS ('dbx_business_glossary_term' = 'Service Referral Recommended');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `referral_sectors` SET TAGS ('dbx_business_glossary_term' = 'Referral Sectors');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `sectors_assessed` SET TAGS ('dbx_business_glossary_term' = 'Sectors Assessed');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `shelter_score` SET TAGS ('dbx_business_glossary_term' = 'Shelter Sector Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `source_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Submission ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'KoboToolbox|CommCare|manual_entry|DHIS2|ODK');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `supervisor_validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Validation Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_vulnerable');
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ALTER COLUMN `wash_score` SET TAGS ('dbx_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Sector Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Collecting Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Witness Staff Member ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enrollment Permitted Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `chs_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliance Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `collection_country_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Country Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `collection_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `collection_location` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Location');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2,3})?$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'verbal|written|digital|thumbprint|proxy');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_value_regex' = '^CNS-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'given|withdrawn|pending|expired|refused');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'data_processing|photography_media|case_referral|biometric_enrollment|program_participation|research_survey');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `data_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Data Scope');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective From Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `form_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Attachment Reference');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `form_attachment_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'GDPR Applicable Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `informed_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Verified Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `is_proxy_consent` SET TAGS ('dbx_business_glossary_term' = 'Is Proxy Consent Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `photography_permitted` SET TAGS ('dbx_business_glossary_term' = 'Photography and Media Use Permitted Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_business_glossary_term' = 'Proxy Consent Giver Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_business_glossary_term' = 'Proxy Relationship to Beneficiary');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_permitted` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Permitted Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Restrictions');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'CommCare|KoboToolbox|Dynamics365|Salesforce|manual');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Witness Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Service Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Caseworker ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_business_glossary_term' = 'Case Narrative');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^CASE-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_plan_developed` SET TAGS ('dbx_business_glossary_term' = 'Case Plan Developed Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_business_glossary_term' = 'Case Stage');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_value_regex' = 'intake|assessment|planning|intervention|monitoring|closure');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|on_hold|closed|cancelled');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_business_glossary_term' = 'CommCare Case ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'commcare_mobile|kobo_form|paper_form|phone_interview|fgd|kii');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `is_child_case` SET TAGS ('dbx_business_glossary_term' = 'Child Case Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `is_child_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `is_gbv_case` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Case Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `is_gbv_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `is_idp_case` SET TAGS ('dbx_business_glossary_term' = 'Internally Displaced Person (IDP) Case Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `last_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Last Follow-Up Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `legal_aid_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Aid Required Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `next_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_value_regex' = 'sam|mam|normal|at_risk');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `on_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'On-Hold Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `outcome_classification` SET TAGS ('dbx_business_glossary_term' = 'Case Outcome Classification');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `outcome_classification` SET TAGS ('dbx_value_regex' = 'goal_achieved|partially_achieved|not_achieved|lost_to_followup|referred_out|deceased');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `presenting_issue` SET TAGS ('dbx_business_glossary_term' = 'Presenting Issue');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `presenting_issue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Case Priority Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Protection Risk Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_value_regex' = 'extreme|high|medium|low|none');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `pss_session_count` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Session Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `referral_destination` SET TAGS ('dbx_business_glossary_term' = 'Referral Destination');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan In Place Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `service_modality` SET TAGS ('dbx_business_glossary_term' = 'Service Modality');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `service_modality` SET TAGS ('dbx_value_regex' = 'in_person|remote|mobile_outreach|group_session|home_visit');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `supervisor_review_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Required Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `case_action_id` SET TAGS ('dbx_business_glossary_term' = 'Case Action ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_category` SET TAGS ('dbx_business_glossary_term' = 'Case Action Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Case Action Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_outcome` SET TAGS ('dbx_business_glossary_term' = 'Case Action Outcome');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_outcome` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|unsuccessful|pending|referred_out');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Case Action Reference Number');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Case Action Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|missed|rescheduled');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Action Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Case Action Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'home_visit|counseling_session|referral|service_provision|follow_up_call|group_session');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `admin_level1_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `admin_level2_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'verbal|written|digital|proxy|not_required');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'mobile_app|paper_form|phone_interview|direct_observation|fgd|kii');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Action Duration (Minutes)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `follow_up_type` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `follow_up_type` SET TAGS ('dbx_value_regex' = 'home_visit|phone_call|facility_visit|group_session|referral_follow_up');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `is_sensitive_case` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Case Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Action GPS Latitude');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Action GPS Longitude');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `muac_measurement_mm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Measurement (mm)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `muac_measurement_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Status Classification');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_value_regex' = 'sam|mam|normal|not_assessed');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Action Outcome Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `protection_concern_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `protection_concern_type` SET TAGS ('dbx_value_regex' = 'gbv|child_protection|trafficking|idp_displacement|statelessness|none');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `protection_concern_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `pss_session_number` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Session Number');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `referral_destination` SET TAGS ('dbx_business_glossary_term' = 'Referral Destination');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `referral_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `referral_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Action Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `service_items_provided` SET TAGS ('dbx_business_glossary_term' = 'Service Items Provided');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'commcare|kobotoolbox|dynamics365|manual_entry');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `supervisor_review_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `supervisor_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Reviewed Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `case_action_id` SET TAGS ('dbx_business_glossary_term' = 'Case Action Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Program Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Organization Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Staff Member Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Organization Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff Member Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `beneficiary_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Satisfaction Rating');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|sensitive|highly_sensitive');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `expected_response_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Response Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `feedback_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Feedback Received Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `gbv_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Case Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Referral Outcome');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `outcome_category` SET TAGS ('dbx_business_glossary_term' = 'Outcome Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `outcome_category` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|unsuccessful|beneficiary_declined|service_unavailable|lost_to_follow_up');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `receiving_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Organization Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `receiving_service_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Service Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `receiving_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Staff Member Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `receiving_staff_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_category` SET TAGS ('dbx_business_glossary_term' = 'Referral Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{8}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|in_progress|completed|declined|cancelled');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'internal|external|emergency|routine|urgent');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff Contact Information');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff Member Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ALTER COLUMN `service_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `protection_flag_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Protection Officer ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Restricted|Confidential|Internal|Public');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flag_code` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flag_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flag_date` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flag_severity` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Severity');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flag_severity` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flag_status` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flag_status` SET TAGS ('dbx_value_regex' = 'Active|Monitoring|Resolved|Closed|Escalated|Referred');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flag_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `flagging_source` SET TAGS ('dbx_business_glossary_term' = 'Flagging Source');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Required');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `identification_method` SET TAGS ('dbx_business_glossary_term' = 'Identification Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `immediate_needs` SET TAGS ('dbx_business_glossary_term' = 'Immediate Needs');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `immediate_needs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `last_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Last Follow-up Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `legal_action_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Required');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-up Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `pss_provided` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Provided');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `referral_made` SET TAGS ('dbx_business_glossary_term' = 'Referral Made');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `referral_organization` SET TAGS ('dbx_business_glossary_term' = 'Referral Organization');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^d{4}-Q[1-4]$|^d{4}-d{2}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ALTER COLUMN `risk_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` SET TAGS ('dbx_subdomain' = 'beneficiary_registration');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_record_id` SET TAGS ('dbx_business_glossary_term' = 'Document Record Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Capturing Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Staff Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `capture_device_code` SET TAGS ('dbx_business_glossary_term' = 'Capture Device Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `capture_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `capture_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `capture_method` SET TAGS ('dbx_business_glossary_term' = 'Capture Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `capture_method` SET TAGS ('dbx_value_regex' = 'mobile_scan|flatbed_scan|photograph|manual_entry|digital_upload');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|digital_signature|biometric|proxy');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_condition` SET TAGS ('dbx_business_glossary_term' = 'Document Condition');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|damaged|illegible');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_image_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Image Reference');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_image_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_language_code` SET TAGS ('dbx_business_glossary_term' = 'Document Language Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'unhcr_registration|national_id|birth_certificate|marriage_certificate|asylum_seeker_card|travel_document');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `is_primary_identity_document` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identity Document Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `legal_status_indicator` SET TAGS ('dbx_business_glossary_term' = 'Legal Status Indicator');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Location Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Days');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'visual_inspection|biometric_match|authority_confirmation|third_party_validation|digital_verification');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|unverified|expired|invalid|under_review');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` SET TAGS ('dbx_subdomain' = 'beneficiary_registration');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Liaison Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `parent_community_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Staff Identifier (ID)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `access_constraint_level` SET TAGS ('dbx_business_glossary_term' = 'Access Constraint Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `access_constraint_level` SET TAGS ('dbx_value_regex' = 'no_constraint|low|medium|high|no_access');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `active_program_count` SET TAGS ('dbx_business_glossary_term' = 'Active Program Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `admin1_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `admin1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `admin2_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `admin2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `admin3_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 3 Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `admin3_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 3 Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `admin4_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 4 Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `admin4_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 4 Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `community_code` SET TAGS ('dbx_business_glossary_term' = 'Community Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `community_name` SET TAGS ('dbx_business_glossary_term' = 'Community Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `community_status` SET TAGS ('dbx_business_glossary_term' = 'Community Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `community_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|planned|suspended');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'host_community|idp_settlement|refugee_camp|returnee_community|mixed');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `estimated_population` SET TAGS ('dbx_business_glossary_term' = 'Estimated Population');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `gbv_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Risk Level');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `gbv_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Accuracy in Meters');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `health_facility_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Health Facility Distance in Kilometers (km)');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `health_facility_distance_km` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `health_facility_distance_km` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_business_glossary_term' = 'Integrated Food Security Phase Classification (IPC) Phase');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_value_regex' = 'phase_1|phase_2|phase_3|phase_4|phase_5');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `leader_contact` SET TAGS ('dbx_business_glossary_term' = 'Community Leader Contact');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `leader_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `leader_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `leader_name` SET TAGS ('dbx_business_glossary_term' = 'Community Leader Name');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `leader_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Community Notes');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Community Registration Date');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `sanitation_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Coverage Percentage');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'formal_camp|informal_settlement|host_community|collective_center|transit_site|urban_area');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Community Vulnerability Category');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Community Vulnerability Score');
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ALTER COLUMN `water_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Access Flag');
