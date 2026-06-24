-- Schema for Domain: beneficiary | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-06-23 02:07:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`beneficiary` COMMENT 'Source systems: Primero (CPIMS+/GBVIMS+), ProGres v4, SCOPE, Kobo Toolbox, CommCare. Beneficiary registration, case management, and protection. Systems of record: UNHCR proGres v4, Primero (child protection), Kobo Toolbox, SCOPE (WFP).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` (
    `registrant_id` BIGINT COMMENT 'Unique surrogate identifier for each registrant record in the beneficiary domain. Serves as the primary key and identity anchor for all beneficiary-domain transactions across CommCare, KoboToolbox, and interoperability mappings to UNHCR proGres v4, WFP SCOPE, and RAIS.',
    `country_id` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the registrants nationality. Used for protection status determination, IDP/refugee classification, and donor reporting disaggregation.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Registrants are enrolled under a specific country offices operational mandate. Country office-level beneficiary count reporting for donor compliance, registration status tracking, and protection case',
    `deduplication_master_registrant_id` BIGINT COMMENT 'The beneficiary_id of the authoritative master record when this registrant has been identified as a duplicate. Null for unique records. Enables lineage tracing from duplicate to canonical record for audit and reporting.',
    `household_id` BIGINT COMMENT 'Identifier linking this registrant to their household unit. Enables household-level aggregation for NFI distribution, WASH targeting, and food security assessments. Household head registrant carries the authoritative household record.',
    `primary_registrant_country_id` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 code for the registrants country of origin. Distinct from nationality for stateless persons and IDPs. Used for displacement tracking, protection analysis, and OCHA SitRep reporting.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Beneficiary registration occurs at specific field sites (health posts, distribution points, registration centers). Essential for geographic program planning, site-level performance reporting, and link',
    `age_years` STRING COMMENT 'Registrants age in whole years at the time of registration. Stored explicitly to support age-band analytics and program eligibility checks when date_of_birth is estimated or unavailable. Derived from date_of_birth where known; otherwise entered directly.',
    `completeness_score` DECIMAL(18,2) COMMENT 'Percentage score (0–100) reflecting the completeness of the registrants registration profile based on mandatory and recommended fields populated. Used for data quality monitoring, field staff performance tracking, and MEL data quality assessments.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the registrant or their legal guardian. Required for GDPR compliance audit trails and CHS accountability reporting.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the registrant (or legal guardian for minors) has provided informed consent for data collection, storage, and use per organizational data protection policy and applicable regulations. Mandatory for all registrations per CHS Commitment 4.',
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
    `poc_category` STRING COMMENT 'UNHCR-aligned classification of the registrants protection status as a Person of Concern (PoC). Drives protection programming, legal aid eligibility, and UNHCR/OCHA statistical reporting. [ENUM-REF-CANDIDATE: refugee|idp|returnee|stateless|asylum_seeker|host_community|other — promote to reference product]',
    `preferred_language_code` STRING COMMENT 'ISO 639 language code for the registrants preferred communication language. Used to assign appropriate interpreters, translated materials, and language-appropriate PSS services. Supports CHS Commitment 4 on accessible communication.. Valid values are `^[a-z]{2,3}$`',
    `protection_flag` BOOLEAN COMMENT 'Master protection concern flag indicating the registrant has one or more active protection risks (GBV, UASC, trafficking, detention risk, etc.). Triggers protection case management workflow and restricts data sharing per CHS data protection principles.',
    `re_registration_count` STRING COMMENT 'Number of times this registrant has been re-registered in the system (e.g., after displacement, camp relocation, or annual verification cycles). Supports re-registration tracking and historical registration event analysis.',
    `registration_date` DATE COMMENT 'The date on which the registrant was first formally registered into the beneficiary system. Used as the baseline date for program enrollment timelines, cohort analysis, and compliance reporting to donors (USAID BHA, DFID).',
    `registration_modality` DOUBLE COMMENT 'The channel or method through which the registrant was enrolled. Distinguishes in-person field registration, mobile data collection (KoboToolbox/CommCare), remote registration (phone/online), and self-registration kiosks. Informs data quality scoring and verification requirements.',
    `registration_source_system` DOUBLE COMMENT 'The operational system of record from which this registrant record originated. Supports data lineage, deduplication across systems, and interoperability mapping to UNHCR proGres v4, WFP SCOPE, and RAIS.',
    `registration_status` DOUBLE COMMENT 'Current lifecycle status of the registrant record. Controls eligibility for program services, NFI distributions, and case management workflows. Duplicate status is set by the deduplication process; departed indicates the individual has left the program area.',
    `registration_tool` DOUBLE COMMENT 'The specific data collection tool or form used to capture the registration. Distinguishes KoboToolbox survey forms, CommCare mobile case forms, paper-based forms, and direct system entry. Informs data quality and field validation rules.',
    `registration_type` DOUBLE COMMENT 'Classifies the registrant as an individual, household head, household member, or community-level registration. Determines the unit of analysis for program targeting, NFI distribution, and beneficiary counting methodologies.',
    `sex` STRING COMMENT 'Biological sex of the registrant as recorded at registration. Used for DAC-compliant gender disaggregation in MEL reporting, GBV protection screening, and SPHERE-aligned needs assessments.. Valid values are `male|female|other|unknown`',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating source system (e.g., CommCare case_id, KoboToolbox submission UUID, proGres v4 individual_id). Enables bidirectional traceability and re-synchronization with operational systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this registrant record in the data platform. Used for incremental data processing, change data capture, and audit trail compliance.',
    `verification_document_number` STRING COMMENT 'The document number from the identity verification document presented at registration (e.g., national ID number, passport number, UNHCR card number). Stored encrypted; used for deduplication and re-registration identity matching.',
    `verification_document_type` STRING COMMENT 'Type of identity verification document presented at registration. Used for identity assurance scoring, fraud prevention, and compliance with donor KYB (Know Your Beneficiary) requirements. Community attestation applies where formal documents are unavailable.. Valid values are `national_id|passport|unhcr_card|birth_certificate|community_attestation|none`',
    `vulnerability_category` STRING COMMENT 'Categorical classification of the registrants vulnerability level derived from the vulnerability_score. Drives program targeting decisions, priority service access, and donor reporting on most-vulnerable population coverage.. Valid values are `critical|high|medium|low`',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Composite vulnerability index score calculated from the needs assessment, capturing food insecurity, protection risks, health status, and displacement severity. Used for program prioritization, targeting, and MEL outcome tracking. Score range and methodology defined per program LogFrame.',
    CONSTRAINT pk_registrant PRIMARY KEY(`registrant_id`)
) COMMENT 'Core master entity for every individual registered as a beneficiary or person of concern (PoC). Stores biographic data (name, date of birth, sex, nationality), unique beneficiary ID, registration source system (CommCare, KoboToolbox), protection flags, deduplication status, and full registration metadata including registration date, location, modality (in-person, mobile, remote), registration tool, registering staff, verification documents presented, completeness score, and deduplication check results. Supports re-registration tracking with historical registration events. Serves as the single identity anchor for all beneficiary-domain transactions. Interoperable with UNHCR proGres v4 individual records, WFP SCOPE beneficiary records, and RAIS case records via standard beneficiary ID mapping. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`household` (
    `household_id` BIGINT COMMENT 'Unique system-generated identifier for the household record. Primary key for the household master entity in the beneficiary domain. Role: MASTER_AGREEMENT — a household registration is a long-running binding container linking individuals to service delivery.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Households are registered and managed under a specific country offices mandate. Country office-level household reporting for donor accountability, HRP progress, and operational oversight is a standar',
    `intervention_id` BIGINT COMMENT 'Reference to the programme under which this household was registered and is receiving services. Links to the programme master product in the Program domain for LogFrame, Theory of Change, and donor grant alignment.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Households are registered and served at specific field locations. Critical for household-level service delivery tracking, geographic targeting analysis, and site-based program planning. Standard pract',
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
    `registration_number` DOUBLE COMMENT 'Externally-known unique alphanumeric code assigned to the household at point of registration. Used across field operations, NFI distribution lists, WASH assessments, and food security programming as the primary cross-system reference. Corresponds to the SCOPE household token or proGres case number.',
    `registration_status` DOUBLE COMMENT 'Current lifecycle state of the household registration. Active indicates the household is enrolled and eligible for services. Suspended indicates a temporary hold pending verification. Closed indicates the household has exited programming. Drives eligibility checks in CommCare and Microsoft Dynamics 365 case management.',
    `registration_type` DOUBLE COMMENT 'Classification of the registration event that created or last updated this household record. Distinguishes initial intake from periodic re-verification exercises required by UNHCR and WFP programme cycles.',
    `sanitation_facility_type` STRING COMMENT 'Classification of the households primary sanitation facility. Core WASH indicator for SPHERE minimum standards, OCHA WASH cluster reporting, and WHO/UNICEF Joint Monitoring Programme (JMP) SDG 6 tracking. [ENUM-REF-CANDIDATE: flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none — promote to reference product]. Valid values are `flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none`',
    `shelter_ownership` STRING COMMENT 'Tenure status of the households current shelter. Distinguishes owned, rented, informal/squatter, organisation-provided, or communal arrangements. Used for durable solutions planning, land rights programming, and UNHCR shelter vulnerability assessments.. Valid values are `owned|rented|informal|provided_by_org|communal`',
    `shelter_type` STRING COMMENT 'Classification of the households current shelter situation. Used for SPHERE shelter standard compliance assessments, NFI kit targeting (shelter kits vs. core relief items), and OCHA shelter cluster reporting. [ENUM-REF-CANDIDATE: permanent|semi-permanent|temporary|makeshift|collective_centre|host_family|none — promote to reference product]',
    `size` STRING COMMENT 'Total count of individuals residing in the household at the time of last registration or update. Used for NFI distribution quantity calculations, food ration sizing, WASH facility planning, and WFP SCOPE entitlement computation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the household record. Used for incremental data pipeline processing, change data capture in the Databricks Lakehouse silver layer, and audit trail compliance.',
    `vulnerability_category` STRING COMMENT 'Categorical classification of household vulnerability derived from the vulnerability score or direct assessment. Used for programme targeting tiers, priority service delivery sequencing, and donor reporting on most-vulnerable population reach.. Valid values are `low|medium|high|critical`',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Composite numeric score representing the households overall vulnerability level, calculated from a standardised vulnerability assessment tool (e.g., Proxy Means Test, Household Economy Analysis). Used for priority targeting, programme tiering, and MEL outcome baseline establishment. Score range and methodology defined per programme.',
    `water_source_type` STRING COMMENT 'Classification of the households primary drinking water source. Core WASH (Water, Sanitation and Hygiene) indicator required for SPHERE minimum standards compliance, OCHA WASH cluster reporting, and DHIS2 WASH indicator tracking. [ENUM-REF-CANDIDATE: piped|borehole|protected_spring|unprotected_spring|surface_water|trucked|rainwater — promote to reference product]',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Master record for a household unit as the primary unit of registration and service delivery in humanitarian contexts. Captures household composition count, head-of-household reference (FK to registrant), geographic location, community/settlement reference, shelter type, displacement status, and household-level vulnerability indicators. Links individual registrants to their household grouping via household_member association for NFI distribution, WASH assessments, and food security programming. Supports WFP SCOPE household registration and UNHCR proGres family composition interoperability. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` (
    `household_member_id` BIGINT COMMENT 'Unique surrogate identifier for each household member association record in the beneficiary domain. Primary key for this entity.',
    `case_record_id` BIGINT COMMENT 'Reference to the CommCare or Microsoft Dynamics 365 case management record associated with this household member. Used for case follow-up, service delivery tracking, and MEL (Monitoring Evaluation and Learning) outcome measurement.',
    `household_id` BIGINT COMMENT 'Reference to the household to which this individual belongs. Links the member record to the household registration unit for NFI distribution sizing and vulnerability scoring.',
    `country_id` BIGINT COMMENT 'ISO 3166-1 alpha-3 country code representing the nationality of the household member. Used for IDP (Internally Displaced Person) and PoC (Person of Concern) classification, cross-border program eligibility, and UNHCR reporting.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Household members are registered at specific project sites. Site-level demographic reporting (age, sex, disability breakdown) for program targeting and site capacity planning requires this link. house',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary registration record for this household member. Links to the beneficiary master record captured in CommCare or KoboToolbox.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Household member disaggregation (sex, age, disability, displacement status) feeds directly into indicator result disaggregation per reporting period. MEL teams require period-bound member records to c',
    `age_estimated` BOOLEAN COMMENT 'Indicates whether the recorded age or date of birth is an estimate rather than a verified value. Common in humanitarian field contexts where documentation is unavailable. Affects data quality scoring for MEL reporting.',
    `age_years` STRING COMMENT 'Recorded or estimated age of the household member in years at time of registration. Used when exact date of birth is unknown, which is common in humanitarian contexts. Supports age-band disaggregation for NFI sizing and program targeting.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from this household member or their legal guardian. Required for GDPR compliance audit trails and CHS (Core Humanitarian Standard) accountability reporting.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether this household member (or their guardian) has provided informed consent for data collection, storage, and use in program delivery. Mandatory per CHS (Core Humanitarian Standard) and GDPR data protection requirements.',
    `consent_withdrawal_date` DATE COMMENT 'Date on which this household member or their guardian withdrew consent for data processing. Triggers data anonymisation or deletion workflows per GDPR Article 17 right to erasure.',
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
    `notes` STRING COMMENT 'Free-text field for field staff to record additional observations, special circumstances, or case notes relevant to this household members situation. Classified as confidential due to potential sensitivity of recorded information.',
    `pregnant_or_lactating` BOOLEAN COMMENT 'Indicates whether this household member is currently pregnant or lactating. Used for nutrition program targeting (e.g., SAM/GAM treatment), supplementary feeding eligibility, and SPHERE maternal health standards compliance.',
    `primary_language_code` STRING COMMENT 'ISO 639-1/639-2 language code for the primary language spoken by this household member. Used for communication planning, interpreter assignment, and ensuring informed consent is obtained in the members language per CHS (Core Humanitarian Standard).. Valid values are `^[a-z]{2,3}$`',
    `protection_concern_flag` BOOLEAN COMMENT 'Indicates whether this household member has an active protection concern (e.g., GBV risk, child protection issue, trafficking risk). Triggers case escalation in CommCare and referral to protection cluster. Stored as restricted due to sensitivity.',
    `registration_date` DATE COMMENT 'Date on which this household member was formally registered in the beneficiary management system (CommCare or KoboToolbox). Establishes the start of the individuals program eligibility timeline.',
    `registration_location_code` DOUBLE COMMENT 'Code identifying the geographic location (camp, settlement, community, or administrative unit) where this household member was registered. Used for geographic disaggregation in MEL reporting and GIS (Geographic Information System) mapping.',
    `relationship_to_head` STRING COMMENT 'Describes the kinship or social relationship of this member to the designated head of household. Used for dependency ratio calculations, vulnerability scoring, and NFI distribution entitlement. [ENUM-REF-CANDIDATE: head|spouse|child|parent|sibling|dependent|other_relative|non_relative — promote to reference product]',
    `school_enrollment_status` STRING COMMENT 'Current school enrollment status for household members of school age. Used for education program targeting, out-of-school children identification, and SDG 4 indicator tracking in DHIS2.. Valid values are `enrolled|not_enrolled|dropout|graduated|not_applicable`',
    `sex` STRING COMMENT 'Biological sex of the household member as recorded at registration. Used for gender disaggregation in MEL reporting, GBV (Gender-Based Violence) program targeting, and SPHERE/DAC (Development Assistance Committee) compliance reporting.. Valid values are `male|female|intersex|prefer_not_to_say`',
    `unaccompanied_minor` BOOLEAN COMMENT 'Indicates whether this household member is an unaccompanied or separated child (UASC). Triggers child protection protocols, case management escalation in CommCare, and mandatory reporting to child protection clusters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this household member association record was last modified. Used for change tracking, data synchronisation between CommCare/KoboToolbox and the lakehouse, and audit compliance.',
    `verification_date` DATE COMMENT 'Date on which the identity and eligibility verification was completed for this household member. Used for audit trails and determining when re-verification is due.',
    `verification_status` STRING COMMENT 'Status of identity and eligibility verification for this household member. verified indicates documentation has been reviewed and confirmed; rejected indicates the member failed verification and is ineligible for program benefits.. Valid values are `unverified|pending|verified|rejected`',
    `vulnerability_category` STRING COMMENT 'Primary vulnerability classification for this household member, used for program targeting, priority distribution, and MEL (Monitoring Evaluation and Learning) disaggregation. GBV (Gender-Based Violence) survivors and unaccompanied minors receive heightened protection protocols. [ENUM-REF-CANDIDATE: child_under_5|unaccompanied_minor|pregnant_lactating|elderly|gbv_survivor|disability|chronic_illness|other — promote to reference product]',
    CONSTRAINT pk_household_member PRIMARY KEY(`household_member_id`)
) COMMENT 'Association entity linking an individual registrant to their household. Captures role (head, spouse, child, dependent, elderly), relationship to head-of-household, membership start/end dates, and demographic attributes relevant to household composition analysis. Enables NFI distribution sizing, dependency ratio calculations, and vulnerability scoring at household level. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` (
    `vulnerability_profile_id` BIGINT COMMENT 'Unique system-generated identifier for the vulnerability profile record. Primary key for this entity.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Vulnerability assessments are conducted by field volunteers; tracking the assessor is required for data quality audits, reassessment accountability, and CHS/Sphere compliance reporting. Distinct from ',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: NGO vulnerability reassessment schedules and targeting criteria are component-specific (e.g., nutrition component triggers MUAC-based profiling; protection component triggers GBV risk profiling). Comp',
    `country_id` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where the beneficiary is located. Used for multi-country program management, IATI reporting, and donor country-level disaggregation.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Vulnerability profiles are managed under a country offices program framework. Country office-level vulnerability tier reporting for program targeting decisions and donor accountability requires this ',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to mel.data_collection_tool. Business justification: Vulnerability profiles are generated using specific MEL-managed assessment tools. MEL data quality protocols require knowing which tool version produced each profile. assessment_tool is a denormaliz',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Vulnerability profiles are assessed in the context of a specific emergency. Emergency-level vulnerability analysis for targeting and resource allocation in humanitarian response planning (HRP, flash a',
    `household_id` BIGINT COMMENT 'Reference to the household unit associated with this vulnerability profile. Enables household-level aggregation and targeting for program interventions.',
    `intervention_id` BIGINT COMMENT 'Reference to the primary humanitarian or development program under which this vulnerability profile was generated or is being used for targeting. Links the profile to program-specific eligibility criteria and Theory of Change (ToC) outcomes.',
    `previous_profile_vulnerability_profile_id` BIGINT COMMENT 'Reference to the immediately preceding vulnerability profile record for this registrant, enabling longitudinal tracking of vulnerability changes over time. Populated when profile_status is superseded or when a new profile replaces an existing one.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Vulnerability assessments are conducted at specific project sites. Site-level vulnerability analysis for program targeting, resource allocation, and site-specific intervention design is a core NGO pla',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary or household head registered in the beneficiary registry. Links this vulnerability profile to the specific Person of Concern (PoC) or Internally Displaced Person (IDP) record.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Vulnerability reassessments are scheduled per MEL reporting cycle. NGOs track which reporting period triggered each profile for donor indicator disaggregation and trend analysis across periods. A MEL ',
    `target_population_id` BIGINT COMMENT 'Foreign key linking to program.target_population. Business justification: Vulnerability profiles are evaluated against program target population inclusion/exclusion criteria for eligibility screening and beneficiary selection. This link enables automated eligibility determi',
    `assessment_date` DATE COMMENT 'Date on which the most recent vulnerability assessment was conducted that materially changed or established this profile. Used for timeliness tracking and MEL reporting cycles.',
    `children_under5_count` STRING COMMENT 'Number of children under 5 years of age in the household. Children under 5 are the primary target group for acute malnutrition screening (MUAC), vaccination campaigns, and early childhood development programs. Used for nutrition and child protection program sizing.',
    `chronic_illness_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has one or more documented chronic illnesses (e.g., HIV/AIDS, tuberculosis, diabetes, hypertension) that increase vulnerability and require sustained health service access. Drives health program targeting and DHIS2 health indicator reporting.',
    `chronic_illness_type` STRING COMMENT 'Coded description of the primary chronic illness condition affecting the beneficiary (e.g., HIV_AIDS, tuberculosis, diabetes, hypertension, malnutrition_chronic). Populated only when chronic_illness_flag is True. Aligned with ICD-11 coding where applicable.',
    `composite_vulnerability_score` DECIMAL(18,2) COMMENT 'Aggregated multi-dimensional vulnerability score derived from weighted combination of food insecurity (IPC phase), protection risk, disability, nutritional status, displacement category, and other assessed indicators. Used for program targeting, beneficiary prioritization, and Results-Based Management (RBM) reporting. Score range typically 0.00–100.00.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the beneficiary or their legal guardian. Required for data protection compliance and audit trail purposes.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or their legal guardian prior to data collection and vulnerability profiling. Mandatory for compliance with data protection regulations and CHS accountability standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Business justification: UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org, recipient-country); Sphere Handbook 2018; CHS Alliance Core Humanitarian Standard',
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
) COMMENT 'Structured vulnerability assessment record for a registrant or household capturing multi-dimensional vulnerability indicators including food insecurity score (IPC phase classification), protection risk level, disability classification (Washington Group questions), chronic illness flags, GAM/SAM nutritional status (MUAC measurement), GBV exposure flag, displacement category (IDP, refugee, returnee), and composite vulnerability score used for program targeting and prioritization. Distinct from needs_assessment which captures point-in-time sector-specific assessment findings — vulnerability_profile represents the beneficiarys current consolidated vulnerability state derived from multiple assessment inputs. Updated when new assessment data materially changes vulnerability classification. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` (
    `needs_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each needs assessment record. Primary key for the needs_assessment data product within the beneficiary domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Needs assessments are conducted under specific partnership agreements that define scope, methodology, and reporting obligations. This link enables compliance verification, quality assurance reviews, a',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Needs assessments identify specific commodity requirements (NFI kits, food baskets, WASH items, shelter materials) for beneficiaries. Essential for humanitarian needs-based procurement planning and Sp',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Sector-specific needs assessments (shelter, nutrition, WASH, protection) are scoped to program components. Component-level assessment aggregation drives component design, budget justification, and don',
    `country_id` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where the assessment was conducted (e.g., SOM, SSD, HTI). Used for IATI reporting, donor country-level aggregation, and cross-country comparative analysis.',
    `data_collection_tool_id` BIGINT COMMENT 'The unique identifier of the data collection instrument used to conduct this assessment. For KoboToolbox, this is the form UID (e.g., aXmK3p9QrT). For CommCare, this is the module ID. Enables traceability back to the specific questionnaire version and supports data quality audits.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Needs assessments are conducted in response to a specific emergency. Emergency-level needs analysis for flash appeal planning, HRP sector response design, and rapid assessment reporting requires this ',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Volunteers conduct needs assessments in many NGO operations (household surveys, vulnerability assessments, rapid assessments). Standard practice for community-based data collection. Required for track',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Needs assessments are conducted by field teams. Field team-level assessment quality, coverage, and data quality reporting requires knowing which team conducted each assessment. beneficiary_needs_asses',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Donor compliance reporting requires knowing which needs assessments were conducted under a specific fund. Fund managers track assessment coverage and methodology per fund for donor narrative reports a',
    `household_id` BIGINT COMMENT 'Reference to the household unit that is the subject of this assessment when assessment_level is household. Nullable when assessment_level is individual or community.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this needs assessment was commissioned. Links the assessment to the programs Theory of Change (ToC) and LogFrame targeting criteria.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partners conduct needs assessments in their operational areas under consortium or sub-award arrangements. Tracking the assessing partner is required for data quality oversight, capacity assessment val',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Needs assessments are conducted at specific project sites. Site-level needs analysis for program design, resource allocation, and site-specific intervention planning is a core NGO operational process.',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary (IDP, PoC, GBV survivor, or other target population member) who is the subject of this assessment when assessment_level is individual. Nullable when assessment_level is household or community.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Needs assessments are conducted within specific MEL reporting cycles. Linking to reporting_period enables aggregation of assessment results into indicator results per period for donor reporting. MEL t',
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
    `supervisor_validation_notes` STRING COMMENT 'Free-text notes entered by the supervising data manager or MEL officer during the assessment review and validation process. Documents reasons for rejection, data quality concerns, or approval rationale. Populated when assessment_status transitions to validated or rejected.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this needs assessment record was most recently modified in the data platform. Tracks post-ingestion corrections, validation status changes, and supervisor note additions. Required for Silver layer change data capture (CDC) processing.',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when the assessment record was validated or rejected by the supervising staff member. Distinct from assessment_date (field event) and created_timestamp (record creation). Used for SLA monitoring of data quality review turnaround.',
    `vulnerability_category` STRING COMMENT 'Categorical classification of the assessed subjects vulnerability level derived from the overall_vulnerability_score and program-specific thresholds. Used for beneficiary targeting, prioritization, and service referral decisions. critical triggers immediate case management escalation.. Valid values are `critical|high|medium|low|not_vulnerable`',
    `wash_score` DECIMAL(18,2) COMMENT 'Numeric score for the Water, Sanitation and Hygiene (WASH) sector assessment findings. Null if WASH was not included in sectors_assessed. Scored against SPHERE minimum standards for water access, sanitation facilities, and hygiene promotion.',
    CONSTRAINT pk_needs_assessment PRIMARY KEY(`needs_assessment_id`)
) COMMENT 'Transactional record of a formal needs assessment conducted for an individual beneficiary, household, or community to determine eligibility, vulnerability level, and appropriate service referrals. Captures assessment date, assessment level (individual, household, community), assessment type (initial registration assessment, periodic reassessment, post-crisis rapid assessment, sector-specific deep assessment), sectors assessed (WASH, nutrition, shelter, protection, livelihoods, education), assessment tool identifier (KoboToolbox form ID, CommCare module), field enumerator, geographic coordinates, and scored findings per sector. Owned by beneficiary domain as it determines beneficiary status and targeting — distinct from MEL post-distribution monitoring which measures program effectiveness. Assessment findings feed into vulnerability_profile updates when they materially change vulnerability classification. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero. [SSOT: authoritative single source of truth; mel.mel_needs_assessment defers to this entity.] SSOT: canonical single source of truth for group beneficiary.beneficiary_needs_assessment__mel.mel_needs_assessment. [SSOT] Single source of truth for the beneficiary_needs_assessment/mel_needs_assessment concept; mel.mel_needs_assessment is the secondary/aligned view. [SSOT: canonical source of truth for this concept; dependent alias is mel.mel_needs_assessment.]';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique system-generated identifier for each consent record. Primary key for the consent_record data product within the beneficiary domain.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: GDPR and CHS compliance require knowing which volunteer collected informed consent. consent_record has gdpr_applicable and chs_compliance_flag attributes signaling this regulatory need. Auditors and d',
    `component_id` BIGINT COMMENT 'Reference to the humanitarian or development program for which consent is being obtained. Enables program-level consent tracking and MEL reporting.',
    `country_id` BIGINT COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the country where consent was collected (e.g., SOM for Somalia, SSD for South Sudan). Supports multi-country program reporting and regulatory compliance.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Consent records are managed under a country offices data protection framework. Country office-level GDPR/data protection compliance reporting, consent expiry monitoring, and data retention policy enf',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to mel.data_collection_tool. Business justification: Consent records are tied to specific data collection tools — the tools consent_mechanism and ethical_review_status govern what consent is required. NGO data protection compliance (GDPR, CHS) requires',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: consent_record currently only links to registrant_id for individual consent. In humanitarian operations (Primero, ProGres v4), consent is often obtained at the household level, particularly for data s',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: GDPR and CHS data protection compliance requires knowing which implementing partner collected each consent record. Partner-level consent audits are a regulatory requirement; this FK enables data prote',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Consent is obtained at a specific project site/registration point. Site-level consent compliance auditing (GDPR, CHS standards) requires knowing where consent was obtained. consent_record.collection_l',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary (individual, household head, or community representative) whose consent is being recorded. Links to the beneficiary master record in CommCare or KoboToolbox.',
    `biometric_enrollment_permitted` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to biometric data enrollment (fingerprint, iris scan, facial recognition) for identity verification and deduplication purposes. True = biometric enrollment permitted; False = not permitted.',
    `chs_compliance_flag` BOOLEAN COMMENT 'Indicates whether this consent record meets all requirements of the Core Humanitarian Standard (CHS) Commitment 4 on accountability to affected populations. True = CHS compliant; False = non-compliant or pending review. Used in CHS certification audits.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was most recently modified. Tracks consent status changes, withdrawals, and verification updates for audit trail and data governance purposes.',
    `verification_date` DATE COMMENT 'The date on which a supervisor or quality assurance officer verified that the consent was properly informed and documented. Populated only when informed_consent_verified is True.',
    `withdrawal_date` DATE COMMENT 'The date on which the beneficiary formally withdrew their previously given consent. Populated only when consent_status is withdrawn. Triggers downstream data deletion or anonymization workflows per GDPR right to erasure.',
    `withdrawal_reason` STRING COMMENT 'Free-text description of the reason provided by the beneficiary or their representative for withdrawing consent. Populated only when consent_status is withdrawn. Used for accountability reporting and program improvement.',
    `witness_name` STRING COMMENT 'Full name of the field staff member or community witness who witnessed the consent process. Required for verbal and thumbprint consent methods to ensure accountability and legal validity.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Formal consent management record capturing a beneficiarys informed consent for data collection, storage, sharing, and program participation. Stores consent type (data processing, photography, case referral, biometric enrollment), consent status (given, withdrawn, pending), consent date, consent method (verbal, written, digital), language of consent, witness details, and CHS (Core Humanitarian Standard) accountability compliance flags. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` (
    `case_record_id` BIGINT COMMENT 'Unique surrogate identifier for the longitudinal case management record within the beneficiary domain. Primary key for all case-level joins and lineage tracking.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Case management services are authorized and funded under specific partnership agreements. Linking case_record to the agreement enables financial accountability, HACT compliance audits, and donor repor',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Case management operations require tracking which volunteer is assigned as case worker for each case record. This drives caseload management reports, supervision accountability, and CHS compliance aud',
    `award_id` BIGINT COMMENT 'Reference to the donor grant funding the program under which this case is managed. Required for donor accountability reporting, BvA tracking, and compliance with grant conditions (e.g., USAID BHA, CERF, DFID).',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Nutrition/health case management: case records for SAM/MAM cases prescribe a specific therapeutic commodity (e.g., RUTF, RUSF). Linking case_record to commodity enables stock forecasting from caseload',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Case management caseloads are tracked per program component (protection component, PSS component, legal aid component). Component-level caseload reporting is required for donor reporting and component',
    `country_office_id` BIGINT COMMENT 'Reference to the geographic location (camp, settlement, district, or facility) where the case is being managed. Supports GIS-based field operations mapping and geographic disaggregation in MEL reporting.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Protection cases (GBV, child protection, IDP) are opened in the context of a specific emergency. Emergency-level case load reporting for cluster coordination, sitrep protection figures, and humanitari',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Case records are managed and followed up by specific field teams. Field team-level case load reporting, supervision requirements, and performance reviews depend on knowing which team manages each case',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this case is managed (e.g., GBV response, child protection, nutrition, PSS, livelihoods).',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Case management services are frequently delivered by partner organizations under sub-awards or consortium agreements. Tracking which partner manages each case is essential for performance monitoring, ',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Case management services (protection, health, psychosocial support) are delivered at specific field facilities. Required for service delivery reporting, referral pathway management, and site-level cas',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary (Person of Concern / IDP / GBV survivor) who is the subject of this case record. Core party linkage for the case.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Case records (protection, GBV, nutrition) feed into protection sector indicators per reporting period. NGO MEL teams need to know which reporting period a case was opened/closed in to calculate period',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: NGO implementing partners manage protection cases under specific subawards. Subaward monitoring reports require case-level traceability to the subaward covering that partners scope. case_record has a',
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
) COMMENT 'Longitudinal case management record for an individual beneficiary requiring structured follow-up. Captures case type (protection, GBV, child protection, PSS, nutrition, health, livelihoods), status (open, in-progress, on-hold, closed), priority level, assigned caseworker, opening/closing dates, referral pathway, outcome classification, and case narrative. Primary operational entity for CommCare case management workflows. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique identifier for the referral transaction. Primary key for the referral data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Formal referral pathways between organizations are governed by partnership agreements that define service obligations and confidentiality terms. Linking referral to the agreement enables compliance tr',
    `case_record_id` BIGINT COMMENT 'Identifier of the case management record associated with this referral, if applicable.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Referral pathway management tracks which program component receives and delivers the referred service. Component-level referral acceptance and completion rates are standard case management KPIs report',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Referrals are managed and tracked by a country office for inter-agency coordination reporting and accountability. Country office-level referral pathway analysis and completion rate reporting is a stan',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Referrals in emergency response contexts are linked to the triggering emergency for emergency-specific service pathway reporting and cluster coordination. Emergency-level referral outcome tracking is ',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Referrals are executed and followed up by field teams. Field team-level referral completion tracking, follow-up rate reporting, and performance management requires knowing which team is responsible fo',
    `intervention_id` BIGINT COMMENT 'Identifier of the specific program within the referring organization that is making the referral.',
    `partner_org_id` BIGINT COMMENT 'Identifier of the organization or partner that is initiating and submitting the referral.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Referrals specify destination field facilities for service delivery. Core to protection and health referral pathway management, inter-agency coordination, and service accessibility analysis. Role-pref',
    `receiving_organization_partner_org_id` BIGINT COMMENT 'Identifier of the organization or service provider that is receiving and expected to act on the referral.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Community volunteers identify and refer beneficiaries to specialized services (health, protection, legal aid). Critical for community-based protection, health outreach, and early identification progra',
    `registrant_id` BIGINT COMMENT 'Identifier of the beneficiary being referred to another service provider or program.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Referral completion rates and outcomes are tracked as protection/case management indicators per reporting period. MEL teams aggregate referral data per period for donor indicator results. This link en',
    `acceptance_date` DATE COMMENT 'Date when the receiving organization formally accepted the referral and committed to providing services.',
    `beneficiary_satisfaction_rating` STRING COMMENT 'Numeric rating provided by the beneficiary indicating their satisfaction with the referral process and services received, typically on a scale of 1-5.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the referral was cancelled before completion, including beneficiary circumstances or organizational constraints.',
    `referral_category` STRING COMMENT 'Primary service category or sector for which the beneficiary is being referred. Aligned with humanitarian cluster system and Sphere standards. [ENUM-REF-CANDIDATE: health|protection|shelter|wash|nutrition|education|livelihoods|psychosocial|legal|other — 10 candidates stripped; promote to reference product]',
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
    `receiving_service_type` STRING COMMENT 'Specific type of service or program that the beneficiary is being referred to at the receiving organization.',
    `referral_date` DATE COMMENT 'The date when the referral was initiated and submitted to the receiving organization or service provider.',
    `referral_number` STRING COMMENT 'Human-readable business identifier for the referral, used for tracking and communication across organizations.. Valid values are `^REF-[0-9]{8}$`',
    `referral_status` STRING COMMENT 'Current lifecycle status of the referral indicating whether it has been accepted, is being processed, completed, or declined by the receiving organization.. Valid values are `pending|accepted|in_progress|completed|declined|cancelled`',
    `referral_type` STRING COMMENT 'Classification of the referral based on organizational scope and urgency. Internal referrals are within the same organization, external are to partner organizations, emergency referrals require immediate action.. Valid values are `internal|external|emergency|routine|urgent`',
    `referring_staff_contact` STRING COMMENT 'Phone number or email address of the referring staff member for coordination and follow-up communication.',
    `referring_staff_name` STRING COMMENT 'Full name of the staff member who initiated the referral, for contact and follow-up purposes.',
    `service_delivery_date` DATE COMMENT 'Date when the service was actually delivered to the beneficiary by the receiving organization.',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Transactional record of a formal referral of a beneficiary from one service provider, program, or organization to another. Captures referral date, referring organization, receiving organization or service, referral reason, referral type (internal, external, emergency), referral status (pending, accepted, completed, declined), follow-up date, and outcome. Supports inter-agency coordination, GBV referral pathways, and protection case management. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` (
    `registration_event_id` BIGINT COMMENT 'Unique identifier for the beneficiary registration event. Primary key for the registration event record.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Registration events are conducted under a country offices operational mandate. Country office-level registration reporting (completeness scores, biometric capture rates, deduplication results) is a s',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to mel.data_collection_tool. Business justification: Registration events use specific MEL-managed data collection tools (KoboToolbox, CommCare, ODK). MEL data quality audits require knowing which tool version was used per registration event. registrati',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Mass registration events are triggered by and linked to a specific emergency. Emergency-level registration tracking (how many registered per emergency, registration completeness) is essential for flas',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Registration events are conducted by specific field teams. Field team-level registration performance reporting (completeness scores, biometric capture rates, daily registration throughput) requires kn',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: registration_event has household_registration (BOOLEAN) indicating whether the event was a household-level registration, but no FK to the household record. In UNHCR ProGres v4 and SCOPE, registration ',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this registration was conducted.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Registration events are conducted by implementing partners. The existing registering_organization plain-text field is a denormalization. A proper FK to partner_org enables data quality audits, dedup',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Registration events are held at specific field sites. Direct business relationship for event management, site capacity planning, and registration campaign tracking. Replaces denormalized location name',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Field registration is executed by volunteers; linking the registration event to the specific volunteer enables data quality audits, registration completeness tracking, and volunteer performance report',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary who was registered or re-registered in this event.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Registration events are the primary source for output indicator # individuals registered per period. Linking registration_event to reporting_period enables direct period-based aggregation for indica',
    `biometric_captured` BOOLEAN COMMENT 'Indicates whether biometric data (fingerprint, iris scan, facial recognition) was captured during this registration event.',
    `biometric_type` STRING COMMENT 'Type of biometric data captured during registration: fingerprint, iris scan, facial recognition, or none.. Valid values are `fingerprint|iris_scan|facial_recognition|none`',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the beneficiary.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for data collection and processing was obtained from the beneficiary during registration.',
    `consent_type` STRING COMMENT 'Type of consent obtained: verbal, written, digital signature, or guardian consent (for minors or vulnerable individuals).. Valid values are `verbal|written|digital_signature|guardian_consent`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration event record was first created in the data system.',
    `data_quality_flag` BOOLEAN COMMENT 'Assessment of the overall data quality for this registration event: high, medium, low, or needs review.',
    `data_source_system` STRING COMMENT 'Name of the source system or application from which this registration event data was extracted (e.g., CommCare, KoboToolbox, UNHCR PRIMES).',
    `deduplication_check_performed` BOOLEAN COMMENT 'Indicates whether a deduplication check was performed during registration to prevent duplicate beneficiary records.',
    `deduplication_method` STRING COMMENT 'Method used for deduplication check: biometric matching, demographic matching, document number verification, manual review, or none.. Valid values are `biometric|demographic|document_number|manual_review|none`',
    `duplicate_found` BOOLEAN COMMENT 'Indicates whether a potential duplicate beneficiary record was identified during the deduplication check.',
    `duplicate_resolution_status` STRING COMMENT 'Status of duplicate resolution: no duplicate found, duplicate confirmed and merged, duplicate resolved, or pending manual review.. Valid values are `no_duplicate|duplicate_confirmed|duplicate_resolved|pending_review`',
    `household_head` BOOLEAN COMMENT 'Indicates whether the registered beneficiary is designated as the head of household for program purposes.',
    `household_registration` BOOLEAN COMMENT 'Indicates whether this registration event was part of a household-level registration (true) or individual-only registration (false).',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter was used during the registration session due to language barriers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration event record was last updated or modified in the data system.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether the beneficiary requires referral to specialized services (protection, health, psychosocial support) based on registration screening.',
    `referral_type` STRING COMMENT 'Type of referral service required: protection, health, psychosocial support (PSS), legal aid, livelihood, education, or other specialized services. [ENUM-REF-CANDIDATE: protection|health|pss|legal_aid|livelihood|education|nutrition|wash|shelter|none — promote to reference product]',
    `registration_completeness_score` DECIMAL(18,2) COMMENT 'Percentage score (0-100) indicating the completeness of data captured during registration based on required and optional fields.',
    `registration_date` DATE COMMENT 'The date on which the beneficiary registration or re-registration event occurred.',
    `registration_language` DOUBLE COMMENT 'ISO 639-3 three-letter language code indicating the language used during the registration interview or data collection.',
    `registration_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the registration location in decimal degrees format.',
    `registration_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the registration location in decimal degrees format.',
    `registration_modality` DOUBLE COMMENT 'The modality or method through which the registration was conducted: in-person at center, mobile outreach, remote digital, phone interview, or community-based registration.',
    `registration_notes` DOUBLE COMMENT 'Free-text field for registering staff to capture additional observations, special circumstances, or contextual information about the registration event.',
    `registration_number` DOUBLE COMMENT 'Externally visible unique registration number assigned to the beneficiary during this event. Format: Country-Year-Sequence (e.g., SYR-2024-000123).',
    `registration_status` DOUBLE COMMENT 'Current status of the registration event in the workflow: draft, pending verification, verified, approved, rejected, or incomplete.',
    `registration_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the registration session was initiated, including time zone information.',
    `registration_type` DOUBLE COMMENT 'Type of registration event: initial registration, re-registration, profile update, verification visit, or biometric enrollment.',
    `verification_document_number` STRING COMMENT 'The document number or identifier from the verification document presented during registration.',
    `verification_document_type` STRING COMMENT 'Type of identity or verification document presented during registration (e.g., national ID, passport, birth certificate, ration card, IDP card). [ENUM-REF-CANDIDATE: national_id|passport|birth_certificate|ration_card|idp_card|refugee_certificate|voter_id|driver_license|none — promote to reference product]',
    `vulnerability_assessment_conducted` BOOLEAN COMMENT 'Indicates whether a vulnerability or needs assessment was conducted as part of this registration event.',
    CONSTRAINT pk_registration_event PRIMARY KEY(`registration_event_id`)
) COMMENT 'Transactional record of a beneficiary registration or re-registration event capturing the specific registration session details. Stores registration date, registration location, registration modality (in-person, mobile, remote), registration tool (KoboToolbox, CommCare, paper), registering staff, verification documents presented, registration completeness score, and any deduplication checks performed. Provides full audit trail of how and when a beneficiary entered the system. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` (
    `enrollment_id` BIGINT COMMENT 'Unique identifier for this enrollment record. Primary key for the enrollment association.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Partnership agreements define the authorized scope and terms for service delivery. Linking enrollment to the governing agreement enables compliance verification, donor audit trails, and financial acco',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Donor reporting requires beneficiary enrollment counts per award. NGO program officers track which award funds each enrollment for compliance and financial reporting. enrollment has component_id but n',
    `component_id` BIGINT COMMENT 'Foreign key to program.component. Identifies the program component in which the beneficiary is enrolled.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Enrollments are managed under a country offices program budget and accountability framework. Country office-level enrollment reporting for donor compliance, program oversight, and HRP progress measur',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Program enrollments in emergency response contexts are linked to the triggering emergency. Emergency-level enrollment tracking for HRP progress reporting and flash appeal beneficiary coverage measurem',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: enrollment currently links registrant_id to component_id for individual program enrollment. In humanitarian operations, program enrollment often occurs at the household level (e.g., cash transfer prog',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partner performance reviews and donor reporting require knowing which implementing partner delivered each program enrollment. No existing FK covers this. Essential for partner accountability reporting',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Enrollments in program components occur at specific project sites. Site-level enrollment tracking for program monitoring, capacity planning, and site utilization reporting is a core NGO operational re',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to the beneficiary registrant participating in this component enrollment',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Enrollments into program components are the primary source for output indicators (# enrolled per period). Linking enrollment to reporting_period enables direct aggregation for indicator_result calcula',
    `attendance_rate` DECIMAL(18,2) COMMENT 'Percentage of scheduled component activities or sessions that the registrant attended. Calculated as (sessions_attended / sessions_scheduled) * 100. Used for engagement monitoring, outcome correlation analysis, and donor reporting on program participation quality. Explicitly identified in detection phase.',
    `completion_date` DATE COMMENT 'The date on which the registrant completed or exited this component enrollment. Null for active enrollments. Used for outcome tracking, retention analysis, and donor reporting on program completion rates. Explicitly identified in detection phase.',
    `consent_for_component` BOOLEAN COMMENT 'Indicates whether the registrant (or guardian) provided informed consent specifically for participation in this component. Some components (e.g., health screening, psychosocial support) require additional consent beyond general registration consent.',
    `created_at` TIMESTAMP COMMENT 'System timestamp when this enrollment record was created in the database. Used for audit trail and data lineage.',
    `enrollment_date` DATE COMMENT 'The date on which the registrant was formally enrolled into this program component. Used for cohort analysis, eligibility determination, and donor reporting on enrollment timelines. Explicitly identified in detection phase as enrollment_date.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of this enrollment record. Controls eligibility for component-specific services and activities. Values: enrolled (registered but not yet active), active (currently participating), suspended (temporarily paused), completed (successfully finished component), withdrawn (voluntarily left), exited (administratively removed). Explicitly identified in detection phase as enrollment_status.',
    `exit_reason` STRING COMMENT 'Classification of the reason for enrollment termination or exit. Used for attrition analysis, program improvement, and donor reporting on retention and completion. Values include: completed (successfully finished), relocated (moved out of service area), deceased, ineligible (no longer meets criteria), voluntary-withdrawal, lost-to-follow-up, program-closure, other. Null for active enrollments. Explicitly identified in detection phase.',
    `referral_source` STRING COMMENT 'Source of referral into this component enrollment (self-referral, community health worker, partner organization, internal program referral, vulnerability assessment). Used for referral pathway analysis and partnership coordination.',
    `service_delivery_modality` STRING COMMENT 'The method or channel through which this components services are delivered to the registrant. Distinguishes in-person group sessions, mobile outreach, remote/digital delivery, hybrid approaches, cash transfers, vouchers, or direct provision of goods/services. Critical for modality-disaggregated MEL reporting required by donors. Explicitly identified in detection phase.',
    `updated_at` TIMESTAMP COMMENT 'System timestamp when this enrollment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_enrollment PRIMARY KEY(`enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between a registrant and a program component. It captures the operational record of a beneficiarys participation in a specific component of a program intervention, including enrollment lifecycle, service delivery tracking, and component-specific outcome data required for donor reporting and MEL frameworks. Each record links one registrant to one component with attributes that exist only in the context of this enrollment relationship.. Existence Justification: In NGO operations, a single beneficiary registrant participates in multiple program components simultaneously or over time (e.g., a child receives nutrition screening, education support, and WASH services as separate component enrollments). Conversely, each program component serves multiple registrants. The enrollment relationship is actively managed by program staff who track enrollment dates, participation status, attendance, service delivery modality, and exit reasons for each registrant-component pairing. This enrollment data is essential for component-level reach reporting, disaggregated MEL indicators, and donor logframe reporting. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` (
    `entitlement_id` BIGINT COMMENT 'Unique surrogate identifier for each beneficiary-commodity entitlement record',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Partnership agreements govern the terms, modalities, and funding ceilings for entitlement delivery. Linking entitlement to the agreement enables financial accountability reporting, HACT compliance, an',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Financial accountability requires knowing which donor award funds each entitlement package. Donor reporting and audit compliance demand traceability from award obligations to individual beneficiary en',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to the humanitarian commodity that the beneficiary is entitled to receive',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Entitlements are defined and managed at the component level (cash transfer component, food distribution component, NFI component). Component-level entitlement aggregation drives distribution planning,',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Entitlements fall under a country offices program budget and financial accountability framework. Country office-level entitlement value and coverage reporting for donor financial accountability and b',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: Entitlement fulfillment tracking: NGOs link entitlements to the distribution plan that operationalizes delivery. This enables reporting on what percentage of entitled beneficiaries are covered by an a',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Entitlements are created in response to a specific emergency. Emergency-level entitlement value and beneficiary coverage reporting for flash appeal financial tracking and emergency response accountabi',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Donor fund restriction compliance reporting requires tracing each entitlement (transfer value, commodity allocation) to its funding source. Finance and donor reporting teams run entitlements charged ',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: entitlement currently links to registrant_id for individual-level entitlements. In WFP SCOPE and UNHCR CVA operations, entitlements are frequently defined at the household level (e.g., household food ',
    `intervention_id` BIGINT COMMENT 'Identifier of the humanitarian program or intervention under which this entitlement is granted (e.g., General Food Distribution, Blanket Supplementary Feeding, Emergency NFI Distribution). Links entitlement to funding source and program reporting.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Implementing partners are responsible for delivering commodity/cash entitlements. Tracking the delivering partner per entitlement is essential for partner performance reviews, financial accountability',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Entitlements are issued and redeemed at specific project sites. Site-level entitlement tracking for distribution planning, pipeline management, and site capacity reporting is a core NGO supply chain a',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to the beneficiary registrant who holds this commodity entitlement',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Entitlements (food, cash, NFI) are the basis for output indicators (# receiving assistance per period). Donor reporting requires entitlement counts per reporting period. Linking entitlement to reporti',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Entitlement fulfillment: each entitlement designates the issuing warehouse responsible for commodity dispensing. NGO supply chain operations require knowing which warehouse holds stock against which e',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this entitlement record was created in the system. Used for audit trail and entitlement history tracking.',
    `end_date` DATE COMMENT 'The date on which this entitlement expires or is scheduled to end. Null indicates ongoing entitlement subject to program continuation. Used for entitlement lifecycle management and program phase-out planning.',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of this entitlement record. Controls whether the beneficiary is currently eligible to receive this commodity in distribution operations.',
    `frequency` STRING COMMENT 'The frequency at which the beneficiary is entitled to receive this commodity (e.g., monthly food ration, one-time NFI kit, weekly fresh food distribution). Drives distribution cycle planning.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this entitlement record. Used for change tracking and synchronization.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the commodity that the beneficiary is entitled to receive per distribution cycle, expressed in the commoditys standard unit of measure. Used for ration calculation and distribution planning.',
    `special_dietary_requirement` STRING COMMENT 'Free-text description of any special dietary requirements, restrictions, or substitutions applicable to this beneficiary-commodity entitlement (e.g., halal, kosher, allergen-free, therapeutic food for MAM/SAM cases). Used for commodity substitution and specialized ration planning.',
    `start_date` DATE COMMENT 'The date from which this entitlement becomes active and the beneficiary is eligible to receive the commodity. Used for entitlement verification and distribution eligibility checks.',
    `transfer_currency_code` STRING COMMENT 'Business justification: ISO 4217 currency codes',
    `transfer_modality` STRING COMMENT 'CVA transfer modality enum: cash / voucher / in-kind / hybrid (distinct from HACT cash-to-IPs).',
    `transfer_value_amount` DECIMAL(18,2) COMMENT 'Business justification: UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org, recipient-country); Sphere Handbook 2018; CHS Alliance Core Humanitarian Standard',
    `vulnerability_based_adjustment` DECIMAL(18,2) COMMENT 'Multiplier or adjustment factor applied to the base entitlement quantity based on the beneficiarys vulnerability category, protection status, or special needs (e.g., 1.5x for pregnant/lactating women, 2.0x for severely malnourished children). Applied during ration calculation.',
    `vulnerability_category` STRING COMMENT 'Business justification: UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org, recipient-country); Sphere Handbook 2018; CHS Alliance Core Humanitarian Standard',
    CONSTRAINT pk_entitlement PRIMARY KEY(`entitlement_id`)
) COMMENT 'This association product represents the entitlement relationship between registrant and commodity. It captures the humanitarian assistance entitlement rules that define which commodities each beneficiary is entitled to receive, in what quantities, at what frequency, and for what duration. Each record links one registrant to one commodity with entitlement-specific parameters including quantity per distribution cycle, distribution frequency, entitlement validity period, vulnerability-based adjustments, and special dietary requirements. This is the operational SSOT for ration planning, distribution planning, and beneficiary entitlement verification in food security and NFI distribution programs.. Existence Justification: In humanitarian operations, beneficiaries are entitled to receive multiple commodities simultaneously as part of their assistance package (e.g., a monthly food basket includes rice, oil, beans, salt, and a household receives multiple NFI items like blankets, jerry cans, soap). Each commodity is entitled to thousands of beneficiaries across the program. The entitlement relationship is an operational business entity actively managed by program officers, carrying specific data about quantity per distribution cycle, frequency, validity period, vulnerability-based adjustments, and special dietary requirements that belong to neither the beneficiary nor the commodity alone. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_deduplication_master_registrant_id` FOREIGN KEY (`deduplication_master_registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_previous_profile_vulnerability_profile_id` FOREIGN KEY (`previous_profile_vulnerability_profile_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile`(`vulnerability_profile_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`beneficiary` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`beneficiary` SET TAGS ('dbx_domain' = 'beneficiary');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_master_registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Master Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_master_registrant_id` SET TAGS ('dbx_relationship' = 'self_reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_master_registrant_id` SET TAGS ('dbx_hierarchy_self_reference' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_master_registrant_id` SET TAGS ('dbx_self_reference' = 'hierarchy');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_master_registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_master_registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_master_registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `household_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `household_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `primary_registrant_country_id` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `primary_registrant_country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `primary_registrant_country_id` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `primary_registrant_country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `primary_registrant_country_id` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `project_site_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Age in Years');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `age_years` SET TAGS ('dbx_standard_reference' = 'UNHCR registration standards; Sphere beneficiary data minimum');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `age_years` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Registration Completeness Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `completeness_score` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `completeness_score` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Given Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `consent_given` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `consent_given` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_dob'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_standard_reference' = 'UNHCR registration standards; Sphere beneficiary data minimum');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_value_regex' = 'pending|unique|duplicate|merged|flagged');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_business_glossary_term' = 'Disability Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name (Surname)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES naming conventions; ISO/IEC 5218');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name (First Name)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES naming conventions; ISO/IEC 5218');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_business_glossary_term' = 'Disability Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Survivor Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_standard_reference' = 'IASC GBV Guidelines 2015; GBV IMS classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman (PLW) Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_standard_reference' = 'WHO/UNICEF MUAC classification (GAM/SAM thresholds per Sphere 2018)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `poc_category` SET TAGS ('dbx_business_glossary_term' = 'Person of Concern (PoC) Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `poc_category` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `poc_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PoC categories (refugees');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `poc_category` SET TAGS ('dbx_IDPs' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `poc_category` SET TAGS ('dbx_stateless' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `poc_category` SET TAGS ('dbx_asylum_seekers_per_1951_Convention)' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code (ISO 639)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_standard_reference' = 'ISO 639-1/639-3 language codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR Protection standards; GPC Protection Mainstreaming toolkit');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `re_registration_count` SET TAGS ('dbx_business_glossary_term' = 'Re-Registration Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `re_registration_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `re_registration_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_modality` SET TAGS ('dbx_business_glossary_term' = 'Registration Modality');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_modality` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_modality` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_source_system` SET TAGS ('dbx_business_glossary_term' = 'Registration Source System');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_source_system` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_source_system` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_tool` SET TAGS ('dbx_business_glossary_term' = 'Registration Tool');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_tool` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_tool` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_'pii_identifier'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_standard_reference' = 'IASC Gender with Age Marker (GAM); SADD disaggregation');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_value_regex' = 'national_id|passport|unhcr_card|birth_certificate|community_attestation|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_standard_reference' = 'Vulnerability Assessment Framework (VAF); UNHCR vulnerability criteria');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Programme ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `intervention_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `project_site_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name (Region/Province)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_['pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_standard_reference' = 'OCHA Common Operational Datasets (COD); ISO 3166-2');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name (District/County)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_['pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_standard_reference' = 'OCHA Common Operational Datasets (COD); ISO 3166-2');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_business_glossary_term' = 'CommCare Case ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `current_country` SET TAGS ('dbx_business_glossary_term' = 'Current Country of Residence (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `current_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `current_country` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `current_country` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `deregistration_date` SET TAGS ('dbx_business_glossary_term' = 'Household Deregistration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `deregistration_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `deregistration_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_date` SET TAGS ('dbx_business_glossary_term' = 'Displacement Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_date` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|stateless|asylum_seeker');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PoC categories (refugees');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_IDPs' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_stateless' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_asylum_seekers_per_1951_Convention)' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `elderly_count` SET TAGS ('dbx_business_glossary_term' = 'Elderly Member Count (60+)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `elderly_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `elderly_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Programme Exit Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `exit_reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `exit_reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `female_count` SET TAGS ('dbx_business_glossary_term' = 'Female Member Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `female_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `female_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `food_security_status` SET TAGS ('dbx_business_glossary_term' = 'Food Security Status (IPC Phase)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `food_security_status` SET TAGS ('dbx_value_regex' = 'food_secure|mildly_insecure|moderately_insecure|severely_insecure');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `food_security_status` SET TAGS ('dbx_standard_reference' = 'IPC/CH classification; WFP CARI methodology');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Risk Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_standard_reference' = 'IASC GBV Guidelines 2015; GBV IMS classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_standard_reference' = 'OCHA Common Operational Datasets (COD); ISO 3166-2');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_standard_reference' = 'OCHA Common Operational Datasets (COD); ISO 3166-2');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_pregnant_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman Present Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_pregnant_lactating` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_pregnant_lactating` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_pregnant_lactating` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied or Separated Child (UASC) Present Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_unaccompanied_minor` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_unaccompanied_minor` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `kobo_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'KoboToolbox Submission ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `kobo_submission_reference` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `kobo_submission_reference` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Needs Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `male_count` SET TAGS ('dbx_business_glossary_term' = 'Male Member Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `male_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `male_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Household Case Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `pwd_count` SET TAGS ('dbx_business_glossary_term' = 'Persons with Disabilities (PWD) Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `pwd_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `pwd_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `sanitation_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Facility Type (WASH)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `sanitation_facility_type` SET TAGS ('dbx_value_regex' = 'flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `sanitation_facility_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `sanitation_facility_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_business_glossary_term' = 'Shelter Ownership Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_value_regex' = 'owned|rented|informal|provided_by_org|communal');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_type` SET TAGS ('dbx_business_glossary_term' = 'Shelter Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_type` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Household Size (Total Members)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `size` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `size` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Household Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Household Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_standard_reference' = 'Vulnerability Assessment Framework (VAF); UNHCR vulnerability criteria');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Water Source Type (WASH)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `water_source_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `water_source_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_business_glossary_term' = 'Household Member ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `case_record_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `case_record_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_estimated` SET TAGS ('dbx_business_glossary_term' = 'Age Estimated Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_estimated` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_estimated` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_estimated` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Age in Years');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_years` SET TAGS ('dbx_standard_reference' = 'UNHCR registration standards; Sphere beneficiary data minimum');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_years` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_given` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_given` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_withdrawal_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_withdrawal_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'kobo_survey|commcare_mobile|paper_form|fgd|kii|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_dob'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_standard_reference' = 'UNHCR registration standards; Sphere beneficiary data minimum');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PoC categories (refugees');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_IDPs' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_stateless' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_asylum_seekers_per_1951_Convention)' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `education_level` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `education_level` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES naming conventions; ISO/IEC 5218');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_standard_reference' = 'IASC Gender with Age Marker (GAM); SADD disaggregation');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES naming conventions; ISO/IEC 5218');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_business_glossary_term' = 'Is Female-Headed Household Member Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_head_of_household` SET TAGS ('dbx_business_glossary_term' = 'Is Head of Household Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_head_of_household` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_head_of_household` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_head_of_household` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_value_regex' = 'employed|self_employed|unemployed|student|unable_to_work|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_business_glossary_term' = 'Household Member Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_value_regex' = '^HHM-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_code` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_business_glossary_term' = 'Household Member Role');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_value_regex' = 'head|spouse|child|dependent|elderly|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Household Membership End Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_business_glossary_term' = 'Household Membership End Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_value_regex' = 'deceased|transferred_household|relocated|voluntary_exit|administrative_closure|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Household Membership Start Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Household Membership Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|transferred|deceased|departed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'MUAC Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_assessment_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_assessment_date` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_assessment_date` SET TAGS ('dbx_standard_reference' = 'WHO/UNICEF MUAC classification (GAM/SAM thresholds per Sphere 2018)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_standard_reference' = 'WHO/UNICEF MUAC classification (GAM/SAM thresholds per Sphere 2018)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Member Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_standard_reference' = 'ISO 639-1/639-3 language codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR Protection standards; GPC Protection Mainstreaming toolkit');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Location Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `relationship_to_head` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Head of Household');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `relationship_to_head` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `relationship_to_head` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `school_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'School Enrollment Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `school_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|dropout|graduated|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `school_enrollment_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `school_enrollment_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|intersex|prefer_not_to_say');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_'pii_identifier'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_standard_reference' = 'IASC Gender with Age Marker (GAM); SADD disaggregation');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|rejected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_id` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `household_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `household_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `intervention_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Vulnerability Profile ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_relationship' = 'self_reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_hierarchy_self_reference' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_self_reference' = 'hierarchy');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `target_population_id` SET TAGS ('dbx_business_glossary_term' = 'Target Population Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `assessment_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `assessment_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Illness Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_business_glossary_term' = 'Chronic Illness Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `composite_vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `composite_vulnerability_score` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `composite_vulnerability_score` SET TAGS ('dbx_standard_reference' = 'Vulnerability Assessment Framework (VAF); UNHCR vulnerability criteria');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `composite_vulnerability_score` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Inter-Agency Data Sharing Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_business_glossary_term' = 'Disability Classification (Washington Group Questions)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_business_glossary_term' = 'Disability Severity Level (Washington Group Questions)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_value_regex' = 'no_difficulty|some_difficulty|a_lot_of_difficulty|cannot_do');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_business_glossary_term' = 'Displacement Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_value_regex' = 'IDP|refugee|returnee|stateless|asylum_seeker|host_community');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PoC categories (refugees');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_IDPs' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_stateless' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_asylum_seekers_per_1951_Convention)' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `elderly_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Elderly Household Member Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `elderly_member_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `elderly_member_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `elderly_member_flag` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `female_headed_household_flag` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `female_headed_household_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `female_headed_household_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `female_headed_household_flag` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Exposure Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_standard_reference' = 'IASC GBV Guidelines 2015; GBV IMS classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{2,10}(-[A-Z0-9]{2,10})?$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_business_glossary_term' = 'Integrated Food Security Phase Classification (IPC) Phase');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_standard_reference' = 'IPC/CH Acute Food Insecurity Classification (IPC Technical Manual v3.1)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_value_regex' = 'none|disrupted|partial|stable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Measurement (mm)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_standard_reference' = 'WHO/UNICEF MUAC classification (GAM/SAM thresholds per Sphere 2018)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reassessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Status (GAM/SAM Classification)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_value_regex' = 'SAM|MAM|normal|overweight');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman (PLW) Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^VP-[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_source` SET TAGS ('dbx_business_glossary_term' = 'Profile Source');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_source` SET TAGS ('dbx_value_regex' = 'initial_registration|periodic_reassessment|post_distribution_monitoring|emergency_screening|referral|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_source` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_source` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|archived|pending_review|superseded|draft');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Protection Risk Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_standard_reference' = 'UNHCR Protection standards; GPC Protection Mainstreaming toolkit');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Need Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_business_glossary_term' = 'Shelter Adequacy Classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_value_regex' = 'adequate|inadequate|none|transitional');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Tier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_standard_reference' = 'Vulnerability Assessment Framework (VAF); UNHCR vulnerability criteria');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `wash_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Access Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `wash_access_flag` SET TAGS ('dbx_standard_reference' = 'WHO/UNICEF JMP WASH indicators; Sphere WASH minimum standards');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` SET TAGS ('dbx_subdomain' = 'case_services');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `needs_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Needs Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `needs_assessment_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `commodity_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `commodity_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `household_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `household_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_['pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_standard_reference' = 'OCHA Common Operational Datasets (COD); ISO 3166-2');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_['pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_standard_reference' = 'OCHA Common Operational Datasets (COD); ISO 3166-2');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Assessment Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_level` SET TAGS ('dbx_value_regex' = 'individual|household|community');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_level` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_level` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_value_regex' = '^NA-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|validated|rejected|archived');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Version');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_tool_version` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_tool_version` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial_registration|periodic_reassessment|post_crisis_rapid|sector_specific_deep');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'verbal|written|proxy');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'face_to_face|remote_phone|fgd|kii|observation|secondary_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|stateless|non_displaced');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PoC categories (refugees');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_IDPs' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_stateless' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_asylum_seekers_per_1951_Convention)' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `education_score` SET TAGS ('dbx_business_glossary_term' = 'Education Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `education_score` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `education_score` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `enumerator_notes` SET TAGS ('dbx_business_glossary_term' = 'Field Enumerator Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `enumerator_notes` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `enumerator_notes` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `female_headed_household` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `female_headed_household` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `female_headed_household` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `female_headed_household` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Risk Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_standard_reference' = 'IASC GBV Guidelines 2015; GBV IMS classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (Meters)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `livelihoods_score` SET TAGS ('dbx_business_glossary_term' = 'Livelihoods Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `livelihoods_score` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `livelihoods_score` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Measurement (mm)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_standard_reference' = 'WHO/UNICEF MUAC classification (GAM/SAM thresholds per Sphere 2018)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `nutrition_score` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `nutrition_score` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `nutrition_score` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `overall_vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `overall_vulnerability_score` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `overall_vulnerability_score` SET TAGS ('dbx_standard_reference' = 'Vulnerability Assessment Framework (VAF); UNHCR vulnerability criteria');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `overall_vulnerability_score` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_business_glossary_term' = 'Persons with Disability Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `protection_score` SET TAGS ('dbx_business_glossary_term' = 'Protection Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `protection_score` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `protection_score` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `protection_score` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `protection_score` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `referral_recommended` SET TAGS ('dbx_business_glossary_term' = 'Service Referral Recommended');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `referral_recommended` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `referral_recommended` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `referral_sectors` SET TAGS ('dbx_business_glossary_term' = 'Referral Sectors');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `referral_sectors` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `referral_sectors` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `sectors_assessed` SET TAGS ('dbx_business_glossary_term' = 'Sectors Assessed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `sectors_assessed` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `sectors_assessed` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `shelter_score` SET TAGS ('dbx_business_glossary_term' = 'Shelter Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `shelter_score` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `shelter_score` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `shelter_score` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `source_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Submission ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `source_submission_reference` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `source_submission_reference` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `supervisor_validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Validation Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `supervisor_validation_notes` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `supervisor_validation_notes` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_vulnerable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `wash_score` SET TAGS ('dbx_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ALTER COLUMN `wash_score` SET TAGS ('dbx_standard_reference' = 'WHO/UNICEF JMP WASH indicators; Sphere WASH minimum standards');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` SET TAGS ('dbx_subdomain' = 'case_services');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Collecting Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `component_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `component_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enrollment Permitted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_'pii_biometric'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_standard_reference' = 'UNHCR BIMS (Biometric Identity Management System); ISO/IEC 19795');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `chs_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `chs_compliance_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `chs_compliance_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2,3})?$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'verbal|written|digital|thumbprint|proxy');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_value_regex' = '^CNS-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'given|withdrawn|pending|expired|refused');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'data_processing|photography_media|case_referral|biometric_enrollment|program_participation|research_survey');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Data Scope');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_scope` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_scope` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective From Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `form_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Attachment Reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `form_attachment_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `form_attachment_reference` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `form_attachment_reference` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'GDPR Applicable Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `informed_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Verified Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `informed_consent_verified` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `informed_consent_verified` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `is_proxy_consent` SET TAGS ('dbx_business_glossary_term' = 'Is Proxy Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `is_proxy_consent` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `is_proxy_consent` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `is_proxy_consent` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `is_proxy_consent` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `photography_permitted` SET TAGS ('dbx_business_glossary_term' = 'Photography and Media Use Permitted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `photography_permitted` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `photography_permitted` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `photography_permitted` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `photography_permitted` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_business_glossary_term' = 'Proxy Consent Giver Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_business_glossary_term' = 'Proxy Relationship to Beneficiary');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_permitted` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Permitted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_permitted` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_permitted` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Restrictions');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_restrictions` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_restrictions` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Witness Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` SET TAGS ('dbx_subdomain' = 'case_services');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `award_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `country_office_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Service Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_business_glossary_term' = 'Case Narrative');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^CASE-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_plan_developed` SET TAGS ('dbx_business_glossary_term' = 'Case Plan Developed Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_plan_developed` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_plan_developed` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_business_glossary_term' = 'Case Stage');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_value_regex' = 'intake|assessment|planning|intervention|monitoring|closure');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|on_hold|closed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `close_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `close_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `closure_reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `closure_reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_business_glossary_term' = 'CommCare Case ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'commcare_mobile|kobo_form|paper_form|phone_interview|fgd|kii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_child_case` SET TAGS ('dbx_business_glossary_term' = 'Child Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_child_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_child_case` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_child_case` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_gbv_case` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_gbv_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_gbv_case` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_gbv_case` SET TAGS ('dbx_standard_reference' = 'IASC GBV Guidelines 2015; GBV IMS classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_idp_case` SET TAGS ('dbx_business_glossary_term' = 'Internally Displaced Person (IDP) Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_idp_case` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_idp_case` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `last_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Last Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `last_followup_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `last_followup_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `legal_aid_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Aid Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `legal_aid_required` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `legal_aid_required` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_standard_reference' = 'WHO/UNICEF MUAC classification (GAM/SAM thresholds per Sphere 2018)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `next_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `next_followup_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `next_followup_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_value_regex' = 'sam|mam|normal|at_risk');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `on_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'On-Hold Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `on_hold_reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `on_hold_reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `open_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `open_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `outcome_classification` SET TAGS ('dbx_business_glossary_term' = 'Case Outcome Classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `outcome_classification` SET TAGS ('dbx_value_regex' = 'goal_achieved|partially_achieved|not_achieved|lost_to_followup|referred_out|deceased');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `outcome_classification` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `outcome_classification` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `presenting_issue` SET TAGS ('dbx_business_glossary_term' = 'Presenting Issue');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `presenting_issue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `presenting_issue` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `presenting_issue` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Case Priority Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Protection Risk Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_value_regex' = 'extreme|high|medium|low|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_standard_reference' = 'UNHCR Protection standards; GPC Protection Mainstreaming toolkit');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `pss_session_count` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Session Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `pss_session_count` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `pss_session_count` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `pss_session_count` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_destination` SET TAGS ('dbx_business_glossary_term' = 'Referral Destination');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_destination` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_destination` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_source` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_source` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan In Place Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `service_modality` SET TAGS ('dbx_business_glossary_term' = 'Service Modality');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `service_modality` SET TAGS ('dbx_value_regex' = 'in_person|remote|mobile_outreach|group_session|home_visit');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `service_modality` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `service_modality` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `supervisor_review_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `supervisor_review_required` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `supervisor_review_required` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_standard_reference' = 'Vulnerability Assessment Framework (VAF); UNHCR vulnerability criteria');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` SET TAGS ('dbx_subdomain' = 'case_services');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `case_record_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `case_record_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `intervention_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Organization Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `project_site_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_organization_partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Organization Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_organization_partner_org_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_organization_partner_org_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `beneficiary_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Satisfaction Rating');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `beneficiary_satisfaction_rating` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `beneficiary_satisfaction_rating` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `beneficiary_satisfaction_rating` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_category` SET TAGS ('dbx_business_glossary_term' = 'Referral Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_category` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `completion_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `completion_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|sensitive|highly_sensitive');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `data_source_system` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `data_source_system` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `decline_reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `decline_reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `expected_response_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Response Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `expected_response_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `expected_response_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `feedback_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Feedback Received Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `feedback_received_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `feedback_received_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `gbv_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `gbv_case_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `gbv_case_flag` SET TAGS ('dbx_standard_reference' = 'IASC GBV Guidelines 2015; GBV IMS classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Referral Outcome');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome_category` SET TAGS ('dbx_business_glossary_term' = 'Outcome Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome_category` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|unsuccessful|beneficiary_declined|service_unavailable|lost_to_follow_up');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome_category` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR Protection standards; GPC Protection Mainstreaming toolkit');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_service_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Service Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_service_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_service_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|in_progress|completed|declined|cancelled');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'internal|external|emergency|routine|urgent');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff Contact Information');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_'pii_phone'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_'pii_staff']' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff Member Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `service_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `service_delivery_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `service_delivery_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `intervention_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `project_site_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Registering Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_business_glossary_term' = 'Biometric Captured Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_'pii_biometric'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_standard_reference' = 'UNHCR BIMS (Biometric Identity Management System); ISO/IEC 19795');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_business_glossary_term' = 'Biometric Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_value_regex' = 'fingerprint|iris_scan|facial_recognition|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_'pii_biometric'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_'pii_beneficiary_protected'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_'pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_'pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_'uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_standard_reference' = 'UNHCR BIMS (Biometric Identity Management System); ISO/IEC 19795');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'verbal|written|digital_signature|guardian_consent');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_type` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_type_corrected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_check_performed` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Check Performed Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_check_performed` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_check_performed` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_method` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_method` SET TAGS ('dbx_value_regex' = 'biometric|demographic|document_number|manual_review|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_method` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_method` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_found` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Found Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_found` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_found` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Resolution Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_resolution_status` SET TAGS ('dbx_value_regex' = 'no_duplicate|duplicate_confirmed|duplicate_resolved|pending_review');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_resolution_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_resolution_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_head` SET TAGS ('dbx_business_glossary_term' = 'Household Head Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_head` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_head` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_head` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_registration` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_registration` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_registration` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_registration` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `referral_required` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `referral_required` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `referral_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `referral_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Registration Completeness Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_completeness_score` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_completeness_score` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_language` SET TAGS ('dbx_business_glossary_term' = 'Registration Language');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_language` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_language` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_language` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_business_glossary_term' = 'Registration Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_business_glossary_term' = 'Registration Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_pii_class' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_uc_tag' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_modality` SET TAGS ('dbx_business_glossary_term' = 'Registration Modality');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_modality` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_modality` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_notes` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_notes` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_number` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_number` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_number` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_pii_beneficiary_protected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `vulnerability_assessment_conducted` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Assessment Conducted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `vulnerability_assessment_conducted` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `vulnerability_assessment_conducted` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `vulnerability_assessment_conducted` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `vulnerability_assessment_conducted` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` SET TAGS ('dbx_subdomain' = 'program_entitlement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `component_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `component_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Registrant Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `attendance_rate` SET TAGS ('dbx_business_glossary_term' = 'Attendance Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `attendance_rate` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `attendance_rate` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `consent_for_component` SET TAGS ('dbx_business_glossary_term' = 'Component-Specific Consent');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `consent_for_component` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `consent_for_component` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `created_at` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `created_at` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `exit_reason` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `exit_reason` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `referral_source` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `referral_source` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `service_delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Modality');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `service_delivery_modality` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `service_delivery_modality` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `updated_at` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `updated_at` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` SET TAGS ('dbx_subdomain' = 'program_entitlement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Record Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement - Commodity Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `intervention_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement - Registrant Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `registrant_id` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `created_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `created_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement End Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `end_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `end_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `frequency` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `frequency` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Quantity');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `quantity` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `quantity` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `special_dietary_requirement` SET TAGS ('dbx_business_glossary_term' = 'Special Dietary Requirement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `special_dietary_requirement` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `special_dietary_requirement` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Start Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `start_date` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `start_date` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_currency_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_currency_code` SET TAGS ('dbx_standard_reference' = 'ISO 4217 currency codes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_modality` SET TAGS ('dbx_enum' = 'cash');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_modality` SET TAGS ('dbx_voucher' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_modality` SET TAGS ('dbx_in_kind' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_modality` SET TAGS ('dbx_hybrid' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_modality` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_modality` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_value_amount` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `transfer_value_amount` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_based_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Adjustment Factor');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_based_adjustment` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_based_adjustment` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_based_adjustment` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_based_adjustment` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_standard_reference' = 'UNHCR PRIMES/proGres v4; IATI Activity Standard v2.03 (participating-org');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_recipient_country);_Sphere_Handbook_2018;_CHS_Alliance_Core_Humanitarian_Standard' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_pii_classification' = 'pii_beneficiary_protected');
