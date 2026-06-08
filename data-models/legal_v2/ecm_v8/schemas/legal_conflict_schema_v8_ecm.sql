-- Schema for Domain: conflict | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`conflict` COMMENT 'Manages new business intake, conflict-of-interest screening, ethical wall configuration, and clearance workflows required before any matter may be opened. Integrates Intapp Conflicts as the system of record. Enforces ABA Rule 1.7/1.9/1.10 conflict rules, lateral hire screening, and relationship mapping to protect LPP and firm ethics obligations.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`conflict`.`check` (
    `check_id` BIGINT COMMENT 'Unique identifier for the conflict-of-interest screening request. Primary key sourced from Intapp Conflicts system.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Conflict checks for new clients trigger AML/KYC program requirements (client due diligence). Conflict clearance is gated on completion of KYC checks per AML program. Links check to AML program.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the ethics partner or conflicts committee member assigned to provide oversight and final approval on complex or escalated conflict matters.',
    `check_supervising_partner_timekeeper_id` BIGINT COMMENT 'Reference to the supervising partner who will oversee the matter if the conflict check is cleared, often required for approval in lateral hire or sensitive matter scenarios.',
    `check_timekeeper_id` BIGINT COMMENT 'Reference to the individual (typically a partner, business development professional, or lateral hire candidate) who initiated the conflict check request.',
    `conflict_exception_id` BIGINT COMMENT 'Foreign key linking to conflict.exception. Business justification: Links conflict checks processed under exception frameworks. Some conflict checks may be fast-tracked or have modified screening scope under pre-approved exceptions. This FK enables tracking which chec',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Conflict checks routinely screen specific IP assets during lateral hire screening (candidate prosecuted Patent X at prior firm) and new client intake (prospect owns trademark portfolio Y). Essential f',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict checks apply practice-area-specific rules and sensitivity thresholds. Automated conflict screening systems filter rule sets by practice area. Essential for routing checks to appropriate ethic',
    `primary_reviewer_timekeeper_id` BIGINT COMMENT 'Reference to the primary conflicts analyst or attorney assigned to review and analyze the conflict check.',
    `profile_id` BIGINT COMMENT 'Reference to the existing client entity involved in the conflict check, if the check relates to an existing client relationship.',
    `prospect_id` BIGINT COMMENT 'Reference to the prospective client entity being screened for conflicts during new business intake.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Conflict checks identifying material risks (adverse relationships, ethical concerns, waiver requirements) trigger risk register entries for ongoing monitoring. Standard conflict-to-risk escalation wor',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Regulatory changes (new conflict rules) trigger updates to conflict check workflows and screening scope. Regulatory change management includes impact assessment on conflict procedures. Links check to ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Conflict checks must verify compliance with specific regulatory obligations (SRA rules, ABA ethics rules). Clearance workflow references applicable obligations to determine waiver requirements and eth',
    `request_id` BIGINT COMMENT 'Reference to the new business intake request that triggered this conflict check, if applicable.',
    `training_programme_id` BIGINT COMMENT 'Foreign key linking to compliance.training_programme. Business justification: Conflict check process is a mandatory training topic for all fee-earners. Compliance training programmes include conflict identification and clearance procedures. Links check process to training progr',
    `actual_turnaround_hours` DECIMAL(18,2) COMMENT 'Actual elapsed time in hours from submission to final disposition, used for Service Level Agreement (SLA) compliance monitoring and process improvement.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict check was assigned to the primary reviewer for analysis.',
    `check_number` STRING COMMENT 'Business-facing unique identifier for the conflict check request, typically displayed to users and referenced in communications.',
    `check_type` STRING COMMENT 'Classification of the conflict check based on the triggering event and applicable American Bar Association (ABA) Model Rules of Professional Conduct. ABA Rule 1.7 addresses concurrent conflicts of interest with current clients, Rule 1.9 addresses conflicts with former clients, and Rule 1.10 addresses imputed disqualification within the firm.. Valid values are `aba_rule_1_7_current_client|aba_rule_1_9_former_client|aba_rule_1_10_imputed_disqualification|lateral_hire|matter_opening|new_business_intake`',
    `clearance_status` STRING COMMENT 'Current lifecycle status of the conflict check indicating whether the matter or engagement has been cleared to proceed, rejected due to conflicts, or is pending further review.. Valid values are `cleared|rejected|pending_review|conditional_clearance|escalated|withdrawn`',
    `cleared_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict check received final clearance approval, allowing the matter or engagement to proceed.',
    `client_waiver_obtained` BOOLEAN COMMENT 'Indicates whether the required client waiver has been obtained and documented in accordance with professional conduct rules.',
    `client_waiver_required` BOOLEAN COMMENT 'Indicates whether informed consent and waiver from affected clients is required to proceed with the engagement despite identified conflicts.',
    `conflict_description` STRING COMMENT 'Detailed narrative description of the identified conflicts, including parties involved, nature of the conflict, and potential risks to Legal Professional Privilege (LPP) and firm ethics obligations.',
    `conflict_severity` STRING COMMENT 'Assessment of the severity or risk level of identified conflicts, used to prioritize review and determine escalation requirements.. Valid values are `none|low|medium|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this conflict check record was first created in the system.',
    `disposition` STRING COMMENT 'Final outcome of the conflict check process, including any conditions or mitigation measures such as ethical wall implementation or client waiver requirements.. Valid values are `approved|rejected|conditional_approval|waived|ethical_wall_required|withdrawn`',
    `ethical_wall_required` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) must be established to mitigate conflicts and protect Legal Professional Privilege (LPP) and client confidentiality.',
    `ethics_partner_disposition` STRING COMMENT 'Final recommendation or decision rendered by the ethics partner regarding clearance of the conflict check.. Valid values are `approved|rejected|conditional_approval|escalated|pending`',
    `ethics_partner_name` STRING COMMENT 'Full name of the ethics partner responsible for final review and approval authority.',
    `mitigation_measures` STRING COMMENT 'Description of measures implemented to mitigate identified conflicts, such as ethical walls, client waivers, or engagement scope limitations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this conflict check record was last modified or updated.',
    `primary_reviewer_disposition` STRING COMMENT 'Recommendation or decision rendered by the primary reviewer regarding clearance of the conflict check.. Valid values are `approved|rejected|conditional_approval|escalated|pending`',
    `primary_reviewer_name` STRING COMMENT 'Full name of the primary reviewer assigned to conduct the conflict analysis.',
    `priority_level` STRING COMMENT 'Priority classification assigned to the conflict check based on business urgency, client expectations, or strategic importance.. Valid values are `urgent|high|normal|low`',
    `rejected_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict check was formally rejected due to unresolvable conflicts or failure to obtain required waivers.',
    `requestor_email` STRING COMMENT 'Email address of the conflict check requestor for communication and notification purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the individual who submitted the conflict check request.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the primary reviewer completed their analysis and rendered a disposition.',
    `reviewer_notes` STRING COMMENT 'Internal notes and analysis documented by the conflicts review team during the screening and clearance process.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the conflict check was completed within the target Service Level Agreement (SLA) timeframe.',
    `sla_target_hours` STRING COMMENT 'Target number of hours within which the conflict check should be completed, based on firm Service Level Agreement (SLA) policies and priority level.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict check request was submitted into the Intapp Conflicts system.',
    `supervising_partner_disposition` STRING COMMENT 'Recommendation or decision rendered by the supervising partner regarding acceptance of the engagement subject to conflict clearance.. Valid values are `approved|rejected|conditional_approval|escalated|pending`',
    `supervising_partner_name` STRING COMMENT 'Full name of the supervising partner who will manage the engagement if approved.',
    `triggering_event` STRING COMMENT 'Detailed description of the business event that initiated the conflict check, such as new matter intake, lateral hire onboarding, merger or acquisition activity, or client relationship change.',
    `waiver_obtained_date` DATE COMMENT 'Date on which the client waiver was formally obtained and documented.',
    CONSTRAINT pk_check PRIMARY KEY(`check_id`)
) COMMENT 'Core transactional record of each conflict-of-interest screening request initiated during new business intake or lateral hire onboarding. Captures the check type (ABA Rule 1.7 current client, Rule 1.9 former client, Rule 1.10 imputed disqualification, lateral hire), the triggering event, requestor, assigned reviewer(s) and their roles, clearance status, and disposition. Reviewer assignments (primary reviewer, ethics partner, supervising partner) with their individual disposition recommendations are tracked directly on this record. This is the primary operational entity of the conflict domain and the system-of-record entry sourced from Intapp Conflicts.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`conflict`.`conflict_party` (
    `conflict_party_id` BIGINT COMMENT 'Unique identifier for the conflict party record. Primary key for the conflict party registry. This is the system-generated identifier used internally for conflict search indexing and relationship mapping.',
    `aml_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_risk_assessment. Business justification: Conflict party data (jurisdiction, entity type, PEP status) feeds into firm-wide AML risk assessments. AML risk assessment aggregates conflict party risk indicators. Links party to AML risk assessment',
    `individual_id` BIGINT COMMENT 'Foreign key linking to client.individual. Business justification: Lateral hire screening and individual client intake conflict checks require linking conflict parties to individual client records. Business process: when candidates disclose prior matters or when scre',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Conflict clearance workflow requires linking conflict parties to client organisations for adverse representation checks, corporate hierarchy conflict analysis, and relationship mapping. When screening',
    `timekeeper_id` BIGINT COMMENT 'The identifier of the user who created this party record in the conflict system. Used for audit trail and accountability. May reference a user ID from the firms identity management system.',
    `reputational_risk_id` BIGINT COMMENT 'Foreign key linking to risk.reputational_risk. Business justification: Parties flagged in conflict checks (adverse media, PEP status, sanctions hits) trigger reputational risk assessments. Standard reputational due diligence workflow on counterparties and adverse parties',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Parties in conflict checks must be screened against sanctions lists before matter opening. Automated sanctions screening is triggered when new parties are added to conflict database. Links party recor',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to risk.sanctions_screening. Business justification: Parties identified in conflict checks must undergo sanctions screening per AML/KYC regulatory requirements. Links conflict party records to their sanctions screening results for compliance audit trail',
    `adverse_media_flag` BOOLEAN COMMENT 'Indicates whether adverse media (negative news coverage related to financial crime, corruption, fraud, or other reputational risk) has been identified for this party during due diligence. True indicates adverse media found, requiring risk assessment and potential escalation. False indicates no adverse media identified. Part of enhanced due diligence for high-risk parties.',
    `aml_risk_rating` STRING COMMENT 'The assessed AML (Anti-Money Laundering) risk level for this party based on jurisdiction, industry, ownership structure, and sanctions screening. Low indicates minimal risk; medium indicates moderate risk requiring standard due diligence; high indicates elevated risk requiring enhanced due diligence and senior approval; prohibited indicates the party is on a sanctions list or otherwise barred from engagement. AML risk rating influences matter acceptance decisions and ongoing monitoring requirements.. Valid values are `low|medium|high|prohibited`',
    `ccpa_subject_flag` BOOLEAN COMMENT 'Indicates whether this party is a consumer under CCPA (California resident). True indicates CCPA applies, requiring compliance with consumer rights (right to know, right to delete, right to opt-out of sale). False indicates CCPA does not apply. Used to enforce data governance policies for California-based parties.',
    `conflict_search_indexed_flag` BOOLEAN COMMENT 'Indicates whether this party record has been indexed in the conflict search engine and is available for conflict checking. True indicates the party is searchable; false indicates indexing is pending or failed. Used to ensure data quality and completeness of the conflict search universe.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this party record was first created in the conflict system. Part of the audit trail for data lineage and compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_residency_jurisdiction` STRING COMMENT 'The jurisdiction in which this partys data must be stored and processed to comply with data protection regulations. For EU/UK natural persons, this must be an EU/UK region per GDPR Article 44-50 (cross-border data transfers). For parties in other jurisdictions, this reflects applicable data localization laws. Critical for multi-jurisdictional firms to ensure compliant data storage and processing.',
    `entity_type` STRING COMMENT 'The legal form of the party. Individual represents a natural person; corporation represents a for-profit incorporated entity; partnership represents a general or limited partnership; trust represents a fiduciary arrangement; government represents a public sector entity; nonprofit represents a tax-exempt organization; LLC (Limited Liability Company) represents a hybrid entity structure. Entity type affects KYC/AML requirements and conflict analysis scope. [ENUM-REF-CANDIDATE: individual|corporation|partnership|trust|government|nonprofit|llc — 7 candidates stripped; promote to reference product]',
    `external_party_reference` STRING COMMENT 'An external reference identifier for this party, such as a client-provided reference number, a court case number, or a third-party system identifier. Used for cross-referencing with external systems and documents. Optional field for additional context.',
    `gdpr_subject_flag` BOOLEAN COMMENT 'Indicates whether this party is a data subject under GDPR (EU/UK natural person or entity operating in EU/UK). True indicates GDPR applies, requiring compliance with data subject rights (access, rectification, erasure, portability) and cross-border transfer restrictions. False indicates GDPR does not apply. Used to enforce data governance policies and access controls.',
    `identifier_type` STRING COMMENT 'The type of official identifier associated with this party. Tax_id represents a tax identification number (EIN, SSN, VAT); company_registration represents a corporate registry number; passport represents a passport number; national_id represents a government-issued ID; duns_number represents a Dun & Bradstreet identifier; LEI (Legal Entity Identifier) represents an ISO 17442 identifier for financial entities. Used in conjunction with party_identifier_value for KYC/AML verification.. Valid values are `tax_id|company_registration|passport|national_id|duns_number|lei`',
    `identifier_value` DECIMAL(18,2) COMMENT 'The actual identifier value corresponding to the party_identifier_type. For example, the EIN number, company registration number, passport number, or LEI code. This field is restricted due to PII sensitivity and is used for definitive party matching and KYC/AML verification. Must be encrypted at rest and subject to access controls per firm data governance policy.',
    `industry_sector` STRING COMMENT 'The primary industry or business sector in which the party operates. Examples include financial services, healthcare, technology, energy, manufacturing, real estate, etc. Used for conflict analysis (industry-specific conflicts), business development segmentation, and risk assessment. May follow standard industry classification systems such as NAICS or SIC codes.',
    `jurisdiction_of_incorporation` STRING COMMENT 'The legal jurisdiction where the entity is incorporated, registered, or domiciled. For corporations and LLCs, this is the state or country of incorporation. For individuals, this is the country of citizenship or primary residence. For trusts, this is the jurisdiction governing the trust instrument. Critical for determining applicable conflict rules, data residency requirements under GDPR, and regulatory compliance obligations.',
    `jurisdiction_of_primary_operations` STRING COMMENT 'The primary geographic jurisdiction where the party conducts business operations or resides. May differ from jurisdiction of incorporation for multinational entities. Used for conflict analysis when parties operate across multiple jurisdictions and for assessing cross-border data transfer requirements.',
    `kyc_completion_date` DATE COMMENT 'The date on which KYC verification was successfully completed for this party. Used to track KYC currency and trigger periodic re-verification per firm policy (typically annually or biennially). Null if KYC has not been completed.',
    `kyc_status` STRING COMMENT 'The current status of KYC (Know Your Client) verification for this party. Not_started indicates KYC has not been initiated; in_progress indicates verification is underway; completed indicates successful verification; failed indicates KYC checks did not pass; expired indicates previously completed KYC has lapsed and requires renewal; waived indicates KYC was not required per firm policy. KYC completion is typically required before a matter can be opened for a new client per AML regulations.. Valid values are `not_started|in_progress|completed|failed|expired|waived`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this party record was most recently modified. Part of the audit trail for data lineage and compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `name_variant_1` STRING COMMENT 'First alternate name or alias for the party. Used to capture DBA (Doing Business As) names, trade names, former legal names, or common abbreviations. Critical for comprehensive conflict search coverage to ensure all name variations are indexed.',
    `name_variant_2` STRING COMMENT 'Second alternate name or alias for the party. Captures additional name variations such as translated names, historical names, or subsidiary brand names to ensure thorough conflict screening.',
    `name_variant_3` STRING COMMENT 'Third alternate name or alias for the party. Provides additional name variant coverage for complex entities with multiple operating names or jurisdictional variations.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the party, such as special conflict considerations, relationship history, or due diligence findings. Confidential due to potential inclusion of sensitive business information or attorney work product. Used by conflict analysts and intake teams for decision-making.',
    `parent_entity_name` STRING COMMENT 'The name of the ultimate parent entity or controlling organization for this party, if applicable. Used to map corporate hierarchies and identify related-party conflicts. For example, a subsidiarys parent corporation or a trusts settlor. Critical for conflict analysis when representation of one entity in a corporate family may conflict with representation of another entity in the same family.',
    `party_name` STRING COMMENT 'The primary legal name of the party as it appears in official records. For individuals, this is the full legal name; for organizations, this is the registered legal entity name. This is the primary searchable field in conflict checks and must match incorporation documents, government registrations, or identity documents.',
    `party_status` STRING COMMENT 'The current lifecycle status of the party in the conflict system. Active indicates the party is current and searchable; inactive indicates the party is no longer active but retained for historical conflict checks; merged indicates the entity has been acquired or merged into another entity; dissolved indicates a legal entity has been formally dissolved; deceased indicates an individual has died. Inactive, merged, dissolved, and deceased parties remain in the conflict index for historical conflict analysis per ABA Rule 1.9 (former client conflicts).. Valid values are `active|inactive|merged|dissolved|deceased`',
    `pep_status` BOOLEAN COMMENT 'Indicates whether this party is classified as a Politically Exposed Person (PEP) — an individual who holds or has held a prominent public function (government official, senior executive of state-owned enterprise, etc.). True indicates PEP status, which triggers enhanced due diligence requirements under AML regulations. False indicates non-PEP status.',
    `record_version` STRING COMMENT 'The version number of this party record, incremented with each modification. Used for optimistic locking and change tracking. Starts at 1 when the record is created.',
    `role_classification` STRING COMMENT 'The role this party plays in conflict analysis. Client indicates a current or former client of the firm; adverse_party indicates an opposing party in litigation or transaction; related_entity indicates a corporate affiliate, subsidiary, or parent; guarantor indicates a party providing financial backing; beneficial_owner indicates the ultimate controlling individual; witness indicates a party who may provide testimony. This classification drives conflict rule application per ABA Model Rules 1.7, 1.9, and 1.10.. Valid values are `client|adverse_party|related_entity|guarantor|beneficial_owner|witness`',
    `sanctions_screening_date` DATE COMMENT 'The date on which the most recent sanctions screening was performed for this party. Used to ensure screening currency and trigger periodic re-screening per firm policy. Null if screening has not been performed.',
    `sanctions_screening_status` STRING COMMENT 'The result of screening this party against global sanctions lists (OFAC, UN, EU, etc.). Not_screened indicates screening has not been performed; clear indicates no matches found; match_found indicates a potential hit requiring investigation; under_review indicates a match is being evaluated by compliance. Sanctions screening is mandatory before matter opening per AML regulations.. Valid values are `not_screened|clear|match_found|under_review`',
    `source_system` STRING COMMENT 'The system of record from which this party record originated. Intapp_conflicts indicates the party was created in the conflict system; elite_3e indicates the party was imported from the practice management system; crm indicates the party was imported from the CRM system; manual_entry indicates the party was manually created by a user; lateral_hire_screening indicates the party was added during lateral attorney conflict screening. Used for data lineage and troubleshooting.. Valid values are `intapp_conflicts|elite_3e|crm|manual_entry|lateral_hire_screening`',
    `source_system_party_reference` STRING COMMENT 'The unique identifier for this party in the source system (e.g., the client ID in Elite 3E, the account ID in CRM). Used for cross-system reconciliation and data lineage tracking. Null if the party was created directly in the conflict system.',
    `ultimate_beneficial_owner_name` STRING COMMENT 'The name of the ultimate beneficial owner (UBO) — the natural person(s) who ultimately own or control the entity, typically defined as owning 25% or more of the entity or exercising control through other means. Required for KYC/AML compliance and for identifying individual-level conflicts when representing corporate entities. Restricted due to PII sensitivity.',
    CONSTRAINT pk_conflict_party PRIMARY KEY(`conflict_party_id`)
) COMMENT 'Master registry of all parties — clients, adverse parties, related entities, individuals, and corporate affiliates — indexed in the conflict search universe. Each party record captures name variants, role classification (client, adverse, related entity, guarantor, beneficial owner), entity type (individual, corporation, government, trust, partnership), jurisdiction of incorporation or domicile, KYC/AML flags, and active/inactive status. Serves as the searchable party index used by every conflict check. Distinct from the client domains client record: this product owns the conflict-specific party classification and search indexing; a party here may or may not be a firm client. For multi-jurisdictional firms, party records are subject to data residency requirements — GDPR-regulated party data (EU/UK natural persons) must be stored and processed within compliant regions, with appropriate cross-border transfer mechanisms documented.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`conflict`.`search_execution` (
    `search_execution_id` BIGINT COMMENT 'Primary key for search_execution',
    `check_id` BIGINT COMMENT 'Foreign key reference to the parent conflict check that spawned this search execution. One conflict check may generate multiple search executions (one per party searched).',
    `timekeeper_id` BIGINT COMMENT 'Foreign key reference to the user (typically a conflicts analyst, intake coordinator, or attorney) who initiated this search execution. Required for audit and accountability.',
    `error_message` STRING COMMENT 'Detailed error or exception message if the search execution failed or timed out. Null for successful executions. Used for troubleshooting and system monitoring.',
    `ethical_wall_consideration_flag` BOOLEAN COMMENT 'Indicates whether this search execution considered existing ethical walls (information barriers) in the conflict analysis. When true, conflicts may be waivable if an effective ethical wall can be established per ABA Rule 1.10.',
    `exact_match_count` STRING COMMENT 'The number of hits that were exact string matches (case-insensitive). Subset of total hit_count. Exact matches typically require immediate escalation.',
    `fuzzy_match_applied` BOOLEAN COMMENT 'Indicates whether fuzzy matching algorithms were applied to capture approximate string matches, accounting for typos, abbreviations, and minor variations.',
    `fuzzy_match_count` STRING COMMENT 'The number of hits that were fuzzy matches (approximate string similarity). Subset of total hit_count. Requires review to determine relevance.',
    `fuzzy_match_threshold` DECIMAL(18,2) COMMENT 'The similarity threshold percentage (0-100) used for fuzzy matching. Higher values require closer matches. Typically set between 70-90% depending on firm policy.',
    `hit_count` STRING COMMENT 'The total number of potential conflict matches returned by this search execution. A hit count of zero indicates no conflicts found; non-zero requires human review.',
    `include_former_names_flag` BOOLEAN COMMENT 'Indicates whether the search included historical names and aliases (e.g., maiden names, previous corporate names, DBA names). Essential for comprehensive conflict detection.',
    `include_subsidiaries_flag` BOOLEAN COMMENT 'Indicates whether the search included subsidiary and affiliate entities of the searched organization. Critical for corporate family conflict detection.',
    `industry_filter` STRING COMMENT 'Optional industry sector filter applied to narrow the search scope to specific client industries (e.g., Financial Services, Healthcare, Technology). May contain comma-separated industry codes.',
    `jurisdiction_filter` STRING COMMENT 'Optional geographic or legal jurisdiction filter applied to narrow the search scope. May contain comma-separated jurisdiction codes (e.g., USA, GBR, DEU) or state/province codes.',
    `lateral_hire_screen_flag` BOOLEAN COMMENT 'Indicates whether this search was executed as part of a lateral hire screening process. Lateral hire searches require broader scope to identify conflicts the incoming attorney may bring from their previous firm.',
    `phonetic_match_count` STRING COMMENT 'The number of hits that were phonetic matches (sound-alike names). Subset of total hit_count. Requires review to determine if they represent the same entity.',
    `phonetic_variant_applied` BOOLEAN COMMENT 'Indicates whether phonetic matching algorithms (e.g., Soundex, Metaphone) were applied to capture names that sound similar but are spelled differently.',
    `practice_area_filter` STRING COMMENT 'Optional practice area filter applied to narrow the search scope to specific legal practice areas (e.g., M&A, IP, Litigation). May contain comma-separated practice area codes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this search execution record was first created in the conflict system. Typically identical or very close to search_execution_timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this search execution record was last modified. Updates may occur if search results are re-analyzed or if additional metadata is appended.',
    `relationship_depth` STRING COMMENT 'The number of relationship hops traversed during the search. Depth of 1 searches direct relationships; depth of 2+ searches related entities (e.g., subsidiaries, affiliates, beneficial owners). Higher depth increases search comprehensiveness but also processing time.',
    `search_algorithm_version` STRING COMMENT 'The version identifier of the conflict search algorithm used for this execution. Enables audit trail and reproducibility when algorithms are updated or tuned.',
    `search_duration_milliseconds` STRING COMMENT 'The elapsed time in milliseconds from search initiation to result return. Used for performance monitoring and system optimization.',
    `search_execution_timestamp` TIMESTAMP COMMENT 'The precise date and time when this search was executed in the conflict system. Critical for audit trail and establishing the temporal context of conflict clearance.',
    `search_parent_check` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Each search execution belongs to exactly one conflict check. This is the header-to-line relationship that enables reconstructing the full search scope of a check.',
    `search_result_hash` STRING COMMENT 'Cryptographic hash of the search result set. Enables detection of result changes if the same search is re-executed later, supporting audit and change tracking.',
    `search_scope` STRING COMMENT 'Defines the population of records searched. Determines whether the search covers only current clients, includes former clients (for ABA Rule 1.9 successive representation conflicts), adverse parties, or all parties in the system.. Valid values are `current_clients|former_clients|adverse_parties|all_parties|lateral_hire_screen`',
    `search_status` STRING COMMENT 'The outcome status of the search execution. Completed indicates successful execution; failed/timeout/cancelled indicate technical issues requiring retry or escalation.. Valid values are `completed|failed|timeout|cancelled`',
    `search_string` STRING COMMENT 'The exact name or entity string submitted for conflict search. This is the raw input text used to query the conflict database for potential matches.',
    `search_type` STRING COMMENT 'The category of entity being searched. Determines which conflict rules and matching algorithms are applied.. Valid values are `individual|organization|matter|related_party|adverse_party|beneficial_owner`',
    `source_system_code` STRING COMMENT 'The unique identifier of this search execution record in the source system (Intapp Conflicts). Used for data lineage and reconciliation between the lakehouse and the operational system.',
    `to_conflict_check` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Every search execution is spawned by a specific conflict check — this is the core parent-child relationship in the screening workflow. Without this FK, you cannot reconstruct which searches belong to ',
    CONSTRAINT pk_search_execution PRIMARY KEY(`search_execution_id`)
) COMMENT 'Transactional record of each individual name or entity search executed within a conflict check. Captures the search string, phonetic and fuzzy-match variants applied, search algorithm version, number of hits returned, and the timestamp of execution. One conflict_check may spawn multiple search_execution records (one per party searched). Sourced from Intapp Conflicts search audit log. Note: the logical primary key is conflict_search_id; the physical PK conflict_conflict_search_id reflects the platform naming convention (domain prefix + product-derived name).';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`search_hit` (
    `search_hit_id` BIGINT COMMENT 'Primary key for search_hit',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to compliance.dpia. Business justification: Conflict search hits involving special category data (e.g., health information in medical malpractice matters) may trigger DPIA requirements. DPO reviews conflict hits for special category data proces',
    `ethical_wall_id` BIGINT COMMENT 'Reference to the ethical wall configuration established to address this conflict. Null if no ethical wall is required.',
    `conflict_party_id` BIGINT COMMENT 'Reference to the party record that matched the search criteria. Links to the intake_party product.',
    `judge_id` BIGINT COMMENT 'Foreign key linking to court.judge. Business justification: Conflict hits may identify prior appearances before the same judge. Real process: judicial relationship tracking for recusal analysis and strategic litigation planning. New attribute needed; no existi',
    `matched_conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — Each search hit references the matched party record from the conflict party index. Critical for resolving what entity was matched.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Search hits identify conflicts arising from prior representation on specific IP assets (firm prosecuted Patent A for Client X, now adverse party in litigation). Critical for IP conflict analysis and c',
    `matter_id` BIGINT COMMENT 'Reference to the matter or engagement where the conflicting relationship was found. May be null if the hit is based on party relationship only.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict hits are triaged and assessed based on practice area to determine severity and route to specialized reviewers. Practice area context drives conflict severity scoring and determines which ethi',
    `search_execution_id` BIGINT COMMENT 'Reference to the parent conflict search that generated this hit. Links to the conflict_search product.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the attorney who was responsible for the historical matter. Used for personal conflict assessment and ethical wall configuration.',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links each conflict hit to the specific rule it potentially violates. search_hit currently has conflict_severity and initial_assessment but no reference to which rule is triggered. This FK enables rul',
    `to_search_execution_id` BIGINT COMMENT 'FK to conflict.search_execution.search_execution_id — Each hit is produced by a specific search execution. This is the fundamental lineage link from hit back to the search that produced it.',
    `assessment_notes` STRING COMMENT 'Free-text notes recorded by the reviewing attorney explaining the rationale for the initial assessment. Critical for audit trail and ethics compliance.',
    `conflict_severity` STRING COMMENT 'System-assigned severity level based on relationship type, matter status, and match confidence. High severity requires partner-level review.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this conflict hit record was first created in the system. Used for audit trail and SLA tracking.',
    `escalated_to_partner` BOOLEAN COMMENT 'Indicates whether this conflict hit has been escalated to a partner for senior-level review. Required for high-severity conflicts.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict hit was escalated to partner review. Null if not escalated.',
    `ethical_wall_required` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) must be established to mitigate the conflict under ABA Rule 1.10. Common for lateral hire conflicts.',
    `hit_matched_party` BIGINT COMMENT 'FK to conflict.party.party_id — Each search hit identifies a matched party from the party index. This FK enables navigating from a hit to the full party record for review.',
    `hit_sequence_number` STRING COMMENT 'Sequential ordering of this hit within the parent conflict search results. Used for display and review prioritization.',
    `hit_source_record_reference` STRING COMMENT 'The unique identifier of the source record in the originating system. Used for drill-back and data reconciliation.',
    `hit_source_system` STRING COMMENT 'The system or database that provided the data for this conflict hit. Used for data lineage and quality assessment.. Valid values are `intapp_conflicts|elite_3e|imanage|external_database|manual_entry`',
    `initial_assessment` STRING COMMENT 'The reviewing attorneys initial assessment of the conflict hit. Drives the clearance workflow and escalation path.. Valid values are `potential_conflict|no_conflict|waivable|requires_review|false_positive`',
    `is_false_positive` BOOLEAN COMMENT 'Indicates whether this conflict hit has been determined to be a false positive (e.g., name collision, unrelated entity). Used for machine learning model training.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this conflict hit record was last updated. Used for change tracking and audit trail.',
    `lpp_risk_flag` BOOLEAN COMMENT 'Indicates whether this conflict hit presents a risk to Legal Professional Privilege (attorney-client privilege). High-risk hits require senior partner review.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence score (0.00 to 100.00) indicating the likelihood that the matched party is the same entity as the search subject. Based on name similarity, identifier matching, and relationship graph analysis.',
    `match_method` STRING COMMENT 'The matching technique that surfaced this hit (exact name match, fuzzy name match, identifier match, corporate family relationship, etc.). Used for quality assessment and false-positive filtering. [ENUM-REF-CANDIDATE: exact_name|fuzzy_name|identifier|alias|corporate_family|address|email|phone — 8 candidates stripped; promote to reference product]',
    `matched_client_name` STRING COMMENT 'The name of the client on the historical matter where the conflict was found. Critical for assessing current vs. former client conflicts under ABA Rule 1.9.',
    `matched_matter_description` STRING COMMENT 'Brief description of the historical matter where the conflict was identified. Provides context for conflict reviewers.',
    `matched_party_name` STRING COMMENT 'The name of the party as recorded in the historical matter or party index. Denormalized for display and review efficiency.',
    `matter_close_date` DATE COMMENT 'The date the historical matter was closed. Null if the matter is still active. Used to distinguish current vs. former client conflicts.',
    `matter_open_date` DATE COMMENT 'The date the historical matter was opened. Used to determine recency and relevance of the conflict.',
    `matter_status` STRING COMMENT 'Current status of the historical matter where the conflict was identified. Active matters present higher conflict risk.. Valid values are `open|closed|suspended|archived`',
    `relationship_role` STRING COMMENT 'Specific role the matched party played in the historical matter (e.g., plaintiff, defendant, guarantor, shareholder). Provides context for conflict assessment.',
    `relationship_type` STRING COMMENT 'Classification of the relationship that triggered the conflict hit. Determines the severity and nature of the potential conflict under ABA Rules 1.7 and 1.9. [ENUM-REF-CANDIDATE: current_client|former_client|adverse_party|related_entity|co_party|witness|expert|opposing_counsel — 8 candidates stripped; promote to reference product]',
    `requires_waiver` BOOLEAN COMMENT 'Indicates whether this conflict hit requires a formal conflict waiver from the affected client(s) under ABA Rule 1.7. Drives waiver workflow.',
    `resolution_status` STRING COMMENT 'Current resolution status of the conflict hit within the clearance workflow. Drives matter opening approval.. Valid values are `pending|cleared|declined|waived|ethical_wall_established`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict hit was resolved (cleared, declined, or waived). Null if still pending.',
    `responsible_attorney_name` STRING COMMENT 'Name of the attorney who was responsible for the historical matter. Denormalized for display and conflict review.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict hit was reviewed by the attorney. Used for SLA tracking and compliance reporting.',
    `reviewed_by_attorney_name` STRING COMMENT 'Name of the attorney who performed the initial review. Denormalized for display and reporting.',
    `substantially_related_matter` BOOLEAN COMMENT 'Indicates whether the historical matter is substantially related to the proposed new matter under ABA Rule 1.9. Substantially related matters create a presumption of conflict.',
    `waiver_date` DATE COMMENT 'Date on which the conflict waiver was obtained. Null if no waiver is required or if waiver has not yet been obtained.',
    `waiver_obtained` BOOLEAN COMMENT 'Indicates whether a formal conflict waiver has been obtained from the affected client(s). Required before matter opening can proceed.',
    CONSTRAINT pk_search_hit PRIMARY KEY(`search_hit_id`)
) COMMENT 'Each potential conflict match surfaced by a conflict search against the party index and matter history. Records the matched party, the matter or engagement where the relationship was found, the relationship type (current client, former client, adverse party, related entity), the match confidence score, and the reviewing attorneys initial assessment (potential conflict, no conflict, waivable). Central to the conflict clearance workflow. Note: the logical primary key is conflict_hit_id; the physical PK conflict_conflict_hit_id reflects the platform naming convention.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`conflict`.`clearance` (
    `clearance_id` BIGINT COMMENT 'Unique identifier for the conflict clearance decision record. Primary key. Inferred role: TRANSACTION_HEADER (clearance is a discrete business event with a clear lifecycle: requested, reviewed, cleared/declined/deferred).',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Clearances for high-risk clients require enhanced due diligence per AML program. Clearance conditions include AML program compliance verification. Links clearance to AML program.',
    `check_id` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Each clearance decision is the terminal outcome of a conflict check. One-to-one or one-to-many relationship that gates matter opening.',
    `timekeeper_id` BIGINT COMMENT 'The system user ID of the person who created this clearance record, typically the conflicts analyst or intake coordinator who initiated the clearance workflow.',
    `clearance_last_modified_by_user_timekeeper_id` BIGINT COMMENT 'The system user ID of the person who last modified this clearance record, typically the authorizing partner, conflicts counsel, or conflicts analyst.',
    `clearance_responsible_party_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (partner, associate, or conflicts counsel) responsible for monitoring compliance with clearance conditions and conducting periodic reviews.',
    `clearance_reviewing_counsel_timekeeper_id` BIGINT COMMENT 'Reference to the conflicts counsel or ethics officer who conducted the detailed conflict review and prepared the clearance recommendation.',
    `clearance_timekeeper_id` BIGINT COMMENT 'Reference to the partner or general counsel who authorized the clearance decision. Typically the conflicts partner, managing partner, or practice group leader with authority to approve new matters.',
    `conflict_exception_id` BIGINT COMMENT 'Foreign key linking to conflict.exception. Business justification: Links clearances granted under pre-approved exception frameworks. Some clearances are fast-tracked or granted with modified requirements under standing exceptions (e.g., pre-approved client categories',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Clearance decisions are reviewed in indemnity claims to assess whether conflicts were properly managed. Claims investigation includes clearance file review to establish negligence or proper process. L',
    `intake_fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.fee_arrangement. Business justification: Clearances with conditions (scope restrictions, ethical walls, client waivers) directly constrain fee arrangement terms and billing scope. Linking clearance to the resulting fee arrangement enables co',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_asset. Business justification: Clearance decisions cite firm guidance documents, ethical wall protocols, waiver templates, and conflict resolution precedents. Essential for documenting basis of clearance decision and ensuring consi',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Conflicts counsel frequently attach or reference engagement letters, scope limitation memos, or client correspondence when granting conditional clearances. This FK enables audit trail of the controlli',
    `matter_id` BIGINT COMMENT 'Reference to the matter record in Elite 3E that was opened following clearance approval. Null if matter has not yet been opened or clearance was denied.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Clearances often impose practice-area-specific scope restrictions and conditions. Ethical walls and engagement limitations are designed with practice area boundaries. Essential for clearance condition',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Conflict clearances with conditions, ethical walls, or scope restrictions generate risk register entries for ongoing monitoring and periodic review. Standard conditional clearance risk tracking proces',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Clearances granted in error or without proper waiver may be recorded as regulatory breaches. Post-matter review identifies clearance failures for breach reporting to SRA/regulators. Links clearance to',
    `request_id` BIGINT COMMENT 'Reference to the new business intake request that requires clearance before matter opening.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Clearances impose asset-specific scope restrictions (approved for Trademark B prosecution but not Patent C due to adverse representation). Enables granular conflict management in IP portfolios with pa',
    `retainer_id` BIGINT COMMENT 'Foreign key linking to billing.retainer. Business justification: Retainers are frequently required as a condition of conflict clearance for new clients or high-risk matters. Linking clearance to the retainer that satisfies clearance conditions supports matter intak',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links clearance decisions to the formal conflict rule they are based on. clearance currently has conflict_rule_basis (STRING) which is a free-text description. This FK normalizes to the authoritative ',
    `search_execution_id` BIGINT COMMENT 'Reference to the conflict search that triggered this clearance workflow. Links to the upstream conflict check process.',
    `adverse_party_identified_flag` BOOLEAN COMMENT 'Boolean indicator whether an adverse party (opposing party in litigation or transaction) has been identified that creates a conflict with an existing client. True if adverse party conflict exists; False otherwise.',
    `clearance_number` STRING COMMENT 'Business-facing unique identifier for the clearance decision, typically formatted as CLR-YYYY-NNNNNN. Used in correspondence and audit trails.',
    `clearance_status` STRING COMMENT 'Current lifecycle state of the clearance decision. Pending Review: awaiting partner review; Cleared: no conflict, matter may open; Cleared with Conditions: approved subject to ethical wall or other restrictions; Declined - Conflict Identified: conflict exists and cannot be waived; Deferred Pending Waiver: conflict exists but client waiver is being sought; Withdrawn: intake request was withdrawn before clearance completed.. Valid values are `pending_review|cleared|cleared_with_conditions|declined_conflict_identified|deferred_pending_waiver|withdrawn`',
    `client_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the client must be formally notified of the conflict and provide informed consent as a condition of clearance. True if client notification and consent are required; False otherwise.',
    `client_waiver_obtained_flag` BOOLEAN COMMENT 'Boolean indicator whether informed written consent (waiver) has been obtained from all affected clients. True if all required waivers are on file; False if waivers are pending or not obtained.',
    `condition_due_date` DATE COMMENT 'The date by which all clearance conditions must be fulfilled before the matter may proceed. Null if no conditions or no specific due date.',
    `condition_fulfilled_date` DATE COMMENT 'The date on which all clearance conditions were confirmed as fulfilled and the matter was authorized to proceed. Null if conditions are not yet fulfilled.',
    `condition_fulfillment_status` STRING COMMENT 'Overall status of compliance with all imposed clearance conditions. Not Applicable: no conditions imposed; Pending: conditions not yet started; In Progress: conditions being implemented; Fulfilled: all conditions satisfied; Overdue: one or more conditions past due date.. Valid values are `not_applicable|pending|in_progress|fulfilled|overdue`',
    `conditions_imposed_flag` BOOLEAN COMMENT 'Boolean indicator whether the clearance was granted subject to conditions (ethical wall, scope restriction, client notification, periodic review). True if conditions exist; False if unconditional clearance or denial.',
    `conflict_description` STRING COMMENT 'Detailed narrative description of the identified conflict, including the nature of the adverse interest, the relationship between parties, and the factual basis for the conflict determination. Confidential business information protected by Legal Professional Privilege (LPP).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this clearance record was first created in the system. Audit trail field for record lifecycle tracking.',
    `decision_date` DATE COMMENT 'The date the authorizing partner or general counsel issued the final clearance decision (cleared, declined, or deferred). This date gates matter opening in Elite 3E.',
    `deferral_reason` STRING COMMENT 'Explanation of why the clearance decision was deferred, including what additional information or client waiver is required before a final decision can be made. Empty if clearance was not deferred.',
    `denial_reason` STRING COMMENT 'Detailed explanation of why the clearance was denied, including the specific conflict identified, the parties involved, and the ethical rule violated. Empty if clearance was approved. Confidential business information protected by Legal Professional Privilege (LPP).',
    `ethical_wall_required_flag` BOOLEAN COMMENT 'Boolean indicator whether an ethical wall (information barrier) must be erected as a condition of clearance. True if ethical wall is mandatory; False otherwise. Ethical walls prevent information flow between conflicted timekeepers and the matter team.',
    `expiry_date` DATE COMMENT 'The date after which the clearance decision expires and must be re-evaluated. Typically set for time-sensitive matters or when circumstances may change. Null if clearance does not expire.',
    `for_check` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Each clearance decision concludes exactly one conflict check. This is the terminal state record for the check lifecycle.',
    `imputed_conflict_flag` BOOLEAN COMMENT 'Boolean indicator whether the conflict is imputed to the entire firm under ABA Rule 1.10 (conflicts of interest imputed to all lawyers in the firm). True if conflict is firm-wide; False if conflict is limited to specific timekeepers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this clearance record was last updated. Audit trail field for change tracking and compliance monitoring.',
    `lateral_hire_screening_flag` BOOLEAN COMMENT 'Boolean indicator whether this clearance is part of a lateral hire conflict screening process (evaluating conflicts that a new attorney would bring to the firm). True if lateral hire screening; False for standard new matter clearance.',
    `matter_opened_flag` BOOLEAN COMMENT 'Boolean indicator whether the matter has been formally opened in Elite 3E following clearance approval. True if matter is open; False if clearance granted but matter not yet opened or clearance was denied.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of the clearance decision. Null if no periodic review is required.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to the clearance decision. May include guidance for the matter team, reminders for periodic review, or references to related clearances. Confidential business information.',
    `outcome` STRING COMMENT 'Final decision outcome of the clearance process. Approved: no conflict, unconditional clearance; Approved with Conditions: clearance granted subject to ethical wall, scope restriction, or client notification; Denied: conflict identified and matter cannot proceed; Deferred: decision postponed pending additional information or waiver.. Valid values are `approved|approved_with_conditions|denied|deferred`',
    `periodic_review_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the clearance decision requires periodic re-evaluation (e.g., quarterly review of ongoing conflict status). True if periodic review is mandated; False for one-time clearance.',
    `relationship_mapping_completed_flag` BOOLEAN COMMENT 'Boolean indicator whether comprehensive relationship mapping (identifying all corporate affiliates, subsidiaries, beneficial owners, and related parties) has been completed as part of the clearance process. True if mapping is complete; False if pending.',
    `requested_date` DATE COMMENT 'The date the clearance request was formally submitted for review, typically following completion of the conflict search.',
    `scope_restriction_description` STRING COMMENT 'Detailed description of any scope restrictions imposed as a condition of clearance. Examples: matter limited to specific transaction phase, prohibited from representing client in certain jurisdictions, restricted to advisory role only. Empty if no scope restrictions.',
    `to_check` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Every clearance decision is the terminal outcome of a conflict check. This is the most critical business relationship — clearance gates matter opening and must trace back to the check that produced it',
    `waiver_document_reference` STRING COMMENT 'Reference identifier or document management system (DMS) path to the signed client waiver or informed consent letter. Typically an iManage or NetDocuments document ID. Empty if no waiver required or not yet obtained.',
    CONSTRAINT pk_clearance PRIMARY KEY(`clearance_id`)
) COMMENT 'Formal clearance decision record issued at the conclusion of a conflict check workflow. Captures the clearance outcome (cleared, cleared with conditions, declined — conflict identified, deferred pending waiver), the authorizing partner or general counsel, the ABA rule basis for any identified conflict, and the date clearance was granted or denied. When conditions are imposed (e.g., mandatory ethical wall erection, restricted matter scope, required client notification, periodic review), each condition is recorded with its type, responsible party, due date, and fulfillment status directly on this record. This record gates matter opening in Elite 3E.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`waiver` (
    `waiver_id` BIGINT COMMENT 'Unique identifier for the conflict waiver record. Primary key.',
    `conflict_exception_id` BIGINT COMMENT 'Foreign key linking to conflict.exception. Business justification: Links waivers granted under pre-approved exception frameworks. Some waivers may be granted under standing consent arrangements or pre-approved waiver templates (captured in exception catalog). This FK',
    `conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — The waiver records which party (client) provided informed consent. Must FK to party to identify the consenting entity.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Conflict waivers in litigation contexts must reference the specific court case. Real process: waiver documentation identifies the docket for client consent records and regulatory audit. New attribute ',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to compliance.dpia. Business justification: Waivers involving processing of special category data require DPIA. DPO assesses whether waiver process involves high-risk data processing. Links waiver to DPIA record.',
    `ethical_wall_id` BIGINT COMMENT 'Reference to the ethical wall configuration established in connection with this waiver, if applicable.',
    `clearance_id` BIGINT COMMENT 'FK to conflict.clearance.clearance_id — A waiver is obtained when clearance identifies a waivable conflict. The waiver must reference the clearance record that triggered the need for informed consent.',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Conflict waivers are critical evidence in professional indemnity claims alleging failure to identify conflicts. Claims handlers retrieve waivers to demonstrate informed consent was obtained. Links wai',
    `indemnity_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.indemnity_exposure. Business justification: Conflict waivers that fail (client later claims harm from waived conflict) are a common source of PI exposure. Links indemnity exposures to the waiver decisions that created the risk.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Client waivers are frequently asset-specific in IP practice (client waives conflict on Patent Family A but not Family B). Required for tracking granular consent scope in complex IP portfolios.',
    `legal_document_id` BIGINT COMMENT 'Reference to the consent document stored in the Document Management System (DMS), typically iManage Work document ID.',
    `matter_id` BIGINT COMMENT 'Reference to the matter for which the conflict waiver was obtained.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Waivers must comply with firm conflict of interest policy requirements. Waiver templates and approval workflows are defined in compliance policy. Links waiver to governing policy.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict waivers are practice-area-specific because waiver requirements and client consent standards vary significantly between litigation, transactional, and advisory work. Ethics committees assess w',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Conflict waivers are generated from approved precedent templates to ensure consistent language, proper disclosures, and regulatory compliance. Tracks which precedent template was used for each waiver ',
    `profile_id` BIGINT COMMENT 'Reference to the client who provided the informed consent waiver.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Client conflict waivers represent accepted risks (waived conflicts) that must be tracked for professional indemnity insurance, regulatory reporting, and periodic review. Standard waived conflict risk ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Waivers must cite specific regulatory framework under which consent is obtained (e.g., SRA Code Rule 6.2, ABA Model Rule 1.7). Required for audit trails and regulatory inspection. Waiver documentation',
    `regulatory_return_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_return. Business justification: Waivers obtained during the reporting period are counted in regulatory returns (e.g., SRA annual information report). Compliance team extracts waiver counts for regulatory filings. Links waiver to reg',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links waivers to the formal ethical rule under which informed consent is granted. waiver currently has aba_rule_citation (STRING) which is free-text. This FK normalizes to the authoritative rule catal',
    `to_clearance_id` BIGINT COMMENT 'FK to conflict.clearance.clearance_id — A waiver is obtained in response to a conflict identified during clearance. The waiver record must link to the clearance that required it for audit trail completeness.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the partner or conflicts committee member who approved the waiver request.',
    `waiver_clearance_id` BIGINT COMMENT 'Reference to the conflict clearance record that identified the conflict requiring this waiver.',
    `waiver_conflicts_counsel_timekeeper_id` BIGINT COMMENT 'Reference to the conflicts counsel or ethics partner who reviewed and approved the waiver.',
    `waiver_last_modified_by_user_timekeeper_id` BIGINT COMMENT 'User ID of the individual who last modified the waiver record.',
    `waiver_subject_timekeeper_id` BIGINT COMMENT 'User ID of the individual who created the waiver record in the conflicts system.',
    `waiver_timekeeper_id` BIGINT COMMENT 'Reference to the partner who requested the waiver on behalf of the matter team.',
    `adverse_party_name` STRING COMMENT 'Name of the adverse party or conflicted party disclosed in the waiver, if applicable.',
    `approval_date` DATE COMMENT 'Date on which the waiver was approved by the conflicts committee or conflicts counsel.',
    `approval_notes` STRING COMMENT 'Internal notes or comments recorded by the conflicts committee or conflicts counsel during the approval process.',
    `audit_trail` STRING COMMENT 'Chronological record of all actions taken on the waiver record, including creation, approvals, modifications, and revocations.',
    `conflict_nature_description` STRING COMMENT 'Detailed description of the nature of the conflict disclosed to the client, including the parties involved and the relationship creating the conflict.',
    `conflict_type` STRING COMMENT 'Classification of the conflict requiring waiver under ABA Model Rules (e.g., current client conflict per Rule 1.7, former client conflict per Rule 1.9). [ENUM-REF-CANDIDATE: current_client|former_client|personal_interest|third_party|positional|issue|transactional|litigation|lateral_hire|other — 10 candidates stripped; promote to reference product]',
    `consent_document_path` STRING COMMENT 'Full path or URL to the consent document in the DMS for retrieval and audit purposes.',
    `consent_form_type` STRING COMMENT 'The form in which informed consent was obtained from the client.. Valid values are `written|verbal_confirmed_in_writing|electronic|implied|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waiver record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the waiver becomes effective and the firm may proceed with representation.',
    `ethical_wall_required` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) is required as a condition of the waiver.',
    `execution_date` DATE COMMENT 'Date on which the waiver was executed by the client signatory.',
    `expiration_date` DATE COMMENT 'Date on which the waiver expires, if applicable. Null for indefinite waivers.',
    `is_scope_limited` BOOLEAN COMMENT 'Indicates whether the waiver contains scope limitations or conditions.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 code for the jurisdiction whose conflict rules apply to this waiver.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the waiver record was last modified.',
    `lpp_protected` BOOLEAN COMMENT 'Indicates whether the waiver and related communications are protected by Legal Professional Privilege (LPP).',
    `reference_number` STRING COMMENT 'Business identifier for the waiver record, typically generated by the conflicts system.. Valid values are `^WVR-[0-9]{6,10}$`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body or bar association whose rules govern this waiver (e.g., State Bar of California, Solicitors Regulation Authority).',
    `revocation_date` DATE COMMENT 'Date on which the waiver was revoked by the client or the firm, if applicable.',
    `revocation_reason` STRING COMMENT 'Explanation for why the waiver was revoked, if applicable.',
    `scope_limitation_description` STRING COMMENT 'Description of any limitations or conditions placed on the scope of the waiver (e.g., limited to specific matters, specific time periods, or specific adverse parties).',
    `signatory_email` STRING COMMENT 'Email address of the signatory for correspondence and confirmation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `signatory_name` STRING COMMENT 'Full name of the individual who signed the waiver on behalf of the client.',
    `signatory_title` STRING COMMENT 'Title or role of the signatory within the client organization (e.g., General Counsel, Chief Legal Officer, Authorized Representative).',
    `waiver_status` STRING COMMENT 'Current lifecycle status of the waiver record. [ENUM-REF-CANDIDATE: draft|pending_review|approved|executed|declined|expired|revoked|superseded — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_waiver PRIMARY KEY(`waiver_id`)
) COMMENT 'Records informed consent waivers obtained from clients to permit representation despite an identified conflict of interest under ABA Rule 1.7(b). Captures the waiving client, the conflicted matter, the nature of the conflict disclosed, the form of consent (written, verbal with written confirmation), the consenting signatory, waiver execution date, and any scope limitations. Linked to the clearance record and stored in iManage Work.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` (
    `ethical_wall_id` BIGINT COMMENT 'Unique identifier for the ethical wall (information barrier) record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Ethical walls enforce information barriers in practice management AND trust accounting systems. Screened timekeepers are blocked from viewing/transacting on trust accounts associated with walled matte',
    `clearance_id` BIGINT COMMENT 'Identifier of the conflict clearance record that triggered the creation of this ethical wall, establishing audit trail linkage.',
    `lateral_screening_id` BIGINT COMMENT 'Identifier of the lateral hire screening record that triggered the creation of this ethical wall, if applicable.',
    `governing_clearance_id` BIGINT COMMENT 'FK to conflict.clearance.clearance_id — Ethical walls are erected as a condition of clearance. The wall must reference the clearance decision that mandated its creation.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Ethical walls erected around specific high-value IP assets (standard-essential patents, trade secrets from lateral hires prior firm). Essential for IP practice screening and information barrier enfor',
    `matter_id` BIGINT COMMENT 'Identifier of the specific matter from which timekeepers are being screened by this ethical wall, if the wall is matter-specific.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Ethical wall protocols are defined in firm information security and conflicts policies. Wall establishment follows procedures in compliance policy. Links wall to governing policy.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Ethical walls are scoped to practice areas to prevent information flow within specific service lines. Practice management and document management systems enforce walls by filtering practice area acces',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Ethical wall protocols reference firm-approved precedent documents defining scope, enforcement mechanisms, notification procedures, and dissolution criteria. Ensures walls are implemented consistently',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the equity partner responsible for monitoring and ensuring the integrity and compliance of this ethical screen.',
    `privacy_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_breach. Business justification: Ethical wall breaches may also constitute data privacy breaches if confidential client information was improperly accessed. Wall breach investigations assess whether GDPR/data protection violations oc',
    `profile_id` BIGINT COMMENT 'Identifier of the client whose matters or information are protected by this ethical wall, if the wall is client-specific.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Ethical walls are risk mitigation controls; breaches, monitoring failures, or dissolution events are tracked in risk register. Standard information barrier control monitoring for regulatory compliance',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Ethical walls are mandated by specific regulatory obligations in many jurisdictions. Wall establishment documentation must cite regulatory authority (e.g., SRA guidance on information barriers). Requi',
    `regulatory_return_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_return. Business justification: Active ethical walls are reported in regulatory returns to demonstrate compliance with information barrier requirements. Regulatory returns include count and nature of ethical walls in place. Links wa',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to risk.risk_control. Business justification: Ethical walls are formal risk controls implementing information barriers. Mapped to risk control framework for ISO 27001 compliance, control effectiveness testing, and SOA documentation.',
    `to_clearance_id` BIGINT COMMENT 'FK to conflict.clearance.clearance_id — Ethical walls are triggered by clearance decisions with conditions. The description states it is linked to the clearance or lateral screening record.',
    `to_lateral_screening_id` BIGINT COMMENT 'FK to conflict.lateral_screening.lateral_screening_id — Ethical walls may also be triggered by lateral screening outcomes. Description explicitly references this linkage.',
    `training_programme_id` BIGINT COMMENT 'Foreign key linking to compliance.training_programme. Business justification: Ethical wall protocols are mandatory training for timekeepers subject to walls. Wall membership triggers mandatory training on information barrier obligations. Links wall to training programme on wall',
    `acknowledgment_completion_rate` DECIMAL(18,2) COMMENT 'The percentage of screened timekeepers who have completed the required acknowledgment of the ethical wall, expressed as a decimal (e.g., 0.95 for 95%).',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether screened timekeepers are required to formally acknowledge their understanding of and compliance with the ethical wall (True) or not (False).',
    `adverse_party_name` STRING COMMENT 'Name of the adverse party or conflicted entity that necessitated the ethical screen, if applicable.',
    `breach_incident_count` STRING COMMENT 'The total number of documented breach or violation incidents associated with this ethical wall, tracked for compliance and risk management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ethical wall record was first created in the system.',
    `dissolution_approved_by` STRING COMMENT 'Name or identifier of the partner or conflicts committee member who approved the dissolution of the ethical wall.',
    `dissolution_date` DATE COMMENT 'The actual date on which the ethical wall was formally dissolved or terminated, which may differ from the originally scheduled expiration date.',
    `dissolution_reason` STRING COMMENT 'The business or ethical reason for dissolving or expiring the ethical wall (e.g., matter concluded, lateral hire departed, conflict resolved, time-based expiration).',
    `effective_date` DATE COMMENT 'The date on which the ethical wall became active and enforceable, marking the start of the information barrier.',
    `elite_enforcement_flag` BOOLEAN COMMENT 'Indicates whether matter and timekeeper access restrictions for this ethical wall are actively enforced in the Elite 3E practice management system.',
    `enforcement_mechanism` STRING COMMENT 'The primary method or combination of methods used to enforce the ethical wall (e.g., system access controls in iManage and Elite 3E, physical office separation, document access restrictions).. Valid values are `system_access_control|physical_separation|document_restriction|communication_protocol|combined`',
    `expiration_date` DATE COMMENT 'The date on which the ethical wall is scheduled to expire or was dissolved, marking the end of the information barrier. Nullable for indefinite screens.',
    `imanage_enforcement_flag` BOOLEAN COMMENT 'Indicates whether document access restrictions for this ethical wall are actively enforced in the iManage Work Document Management System (DMS).',
    `last_review_date` DATE COMMENT 'The date on which the ethical wall was most recently reviewed by the supervising partner or conflicts team.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who most recently modified this ethical wall record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ethical wall record was most recently modified or updated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next compliance review of this ethical wall.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or compliance notes related to the ethical wall.',
    `notification_date` DATE COMMENT 'The date on which formal notification of the ethical wall was sent to affected timekeepers and stakeholders.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether formal notification of the ethical wall has been sent to all affected timekeepers and relevant stakeholders (True) or not (False).',
    `regulatory_authority` STRING COMMENT 'The name of the regulatory body or jurisdiction whose rules or requirements mandate or govern this ethical wall (e.g., State Bar, SRA, specific court order).',
    `regulatory_reference` STRING COMMENT 'Specific citation or reference to the regulatory rule, statute, or court order that mandates or governs this ethical wall (e.g., ABA Rule 1.10, court docket number).',
    `review_frequency` STRING COMMENT 'The scheduled frequency at which the ethical wall is reviewed for continued necessity, compliance, and effectiveness.. Valid values are `monthly|quarterly|semi_annually|annually|as_needed`',
    `scope_description` STRING COMMENT 'Detailed description of the scope and boundaries of the ethical wall, including which information, documents, and communications are restricted.',
    `screened_timekeeper_count` STRING COMMENT 'The total number of timekeepers (attorneys, paralegals, staff) who are subject to this ethical wall and restricted from accessing the protected information.',
    `system_enforcement_flag` BOOLEAN COMMENT 'Indicates whether the ethical wall is enforced through automated system access controls in practice management and document management systems (True) or relies on manual compliance (False).',
    `triggering_reason` STRING COMMENT 'The business or ethical circumstance that necessitated the creation of this information barrier (e.g., lateral hire with prior client relationships, adverse party representation, regulatory mandate).. Valid values are `lateral_hire|former_client|adverse_party|regulatory_requirement|conflict_of_interest|other`',
    `triggering_reason_description` STRING COMMENT 'Detailed narrative explanation of the specific circumstances, parties, or matters that required the establishment of this ethical wall.',
    `wall_code` STRING COMMENT 'Unique business identifier or reference code for the ethical wall, typically used in system integrations and reporting.',
    `wall_name` STRING COMMENT 'Business-friendly name or title assigned to this ethical screen for identification and reference purposes.',
    `wall_status` STRING COMMENT 'Current lifecycle status of the ethical screen indicating whether it is currently enforced or has been terminated.. Valid values are `active|expired|dissolved|suspended|pending`',
    `created_by` STRING COMMENT 'Username or identifier of the conflicts analyst or partner who created this ethical wall record.',
    CONSTRAINT pk_ethical_wall PRIMARY KEY(`ethical_wall_id`)
) COMMENT 'Master record of each ethical screen (information barrier) erected to isolate timekeepers from matters where a conflict or LPP risk exists. Captures the screen name, triggering reason (lateral hire, former client, adverse party, regulatory requirement), effective date, expiration date, screen status (active, expired, dissolved), and the supervising partner responsible for screen integrity. Linked to the clearance or lateral screening record that triggered its creation. Sourced from Intapp Conflicts ethical wall module and enforced in iManage Work and Elite 3E access controls.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`wall_membership` (
    `wall_membership_id` BIGINT COMMENT 'Unique identifier for the ethical wall membership record. Primary key.',
    `ethical_wall_id` BIGINT COMMENT 'Reference to the ethical wall (information barrier) to which this membership record applies. Links to the ethical_wall product.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or staff member) who is subject to this ethical wall membership. Links to the timekeeper product.',
    `tertiary_ethical_wall_id` BIGINT COMMENT 'FK to conflict.ethical_wall.ethical_wall_id — Each wall membership record belongs to exactly one ethical wall. This is the master-detail relationship enabling wall enforcement.',
    `tertiary_reviewed_by_partner_timekeeper_id` BIGINT COMMENT 'Reference to the partner who conducted the most recent review of this ethical wall membership. Links to the timekeeper product. Nullable if no review has been conducted.',
    `to_ethical_wall_id` BIGINT COMMENT 'FK to conflict.ethical_wall.ethical_wall_id — Each wall membership record belongs to a specific ethical wall. This is the classic header-line relationship for screen enforcement.',
    `wall_last_modified_by_timekeeper_id` BIGINT COMMENT 'The user ID or system account that most recently modified this ethical wall membership record. Used for audit trail and accountability.',
    `walled_timekeeper_id` BIGINT COMMENT 'The user ID or system account that created this ethical wall membership record. Used for audit trail and accountability.',
    `access_restriction_level` STRING COMMENT 'Granular specification of the type and scope of access restrictions enforced by this membership, such as full block (no access to any information), document block (DMS restrictions), matter block (Elite 3E restrictions), client block (all client matters), or no restriction.. Valid values are `full_block|document_block|matter_block|client_block|no_restriction`',
    `acknowledgment_date` DATE COMMENT 'The date on which the timekeeper formally acknowledged the ethical wall membership and associated restrictions. Nullable if acknowledgment has not been received or is not required.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the timekeeper is required to formally acknowledge receipt and understanding of the ethical wall restrictions or permissions.',
    `authorization_date` DATE COMMENT 'The date on which the authorizing partner approved the ethical wall membership change.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ethical wall membership record was first created in the system. Audit trail field.',
    `dms_enforcement_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this ethical wall membership triggers automated access control enforcement in the document management system (iManage Work or NetDocuments).',
    `effective_date` DATE COMMENT 'The date on which this ethical wall membership becomes active and access restrictions or permissions take effect.',
    `external_reference_code` STRING COMMENT 'Optional external identifier or reference number from the source system (e.g., Intapp Conflicts wall membership ID, Elite 3E security rule ID) used for cross-system reconciliation and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ethical wall membership record was most recently updated. Audit trail field.',
    `last_override_date` DATE COMMENT 'The most recent date on which an ethical wall access restriction was temporarily overridden for this timekeeper. Nullable if no overrides have occurred.',
    `last_reviewed_date` DATE COMMENT 'The most recent date on which this ethical wall membership was reviewed by the conflicts team or authorizing partner. Nullable if no review has been conducted.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the ethical wall membership record indicating whether the membership is currently enforced, pending approval, terminated, or temporarily suspended.. Valid values are `active|inactive|pending|terminated|suspended`',
    `membership_type` STRING COMMENT 'Designation indicating whether the timekeeper is included within the ethical wall (restricted from accessing matter information), excluded from the wall (permitted access), restricted (partial access with conditions), or observer (read-only monitoring role).. Valid values are `included|excluded|restricted|observer`',
    `notification_date` DATE COMMENT 'The date on which the timekeeper was formally notified of the ethical wall membership change. Nullable if notification has not yet been sent.',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the timekeeper has been formally notified of their inclusion in or exclusion from the ethical wall and the associated access restrictions or permissions.',
    `override_count` STRING COMMENT 'The cumulative number of times that ethical wall access restrictions have been temporarily overridden for this timekeeper membership. Used for audit and compliance monitoring.',
    `override_permitted_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether temporary overrides of the ethical wall restrictions are permitted under specific circumstances (e.g., emergency access, partner approval).',
    `practice_management_enforcement_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this ethical wall membership triggers automated access control enforcement in the practice management system (Elite 3E or Aderant Expert) to prevent time entry, billing, or matter visibility.',
    `reason_code` STRING COMMENT 'Categorical code indicating the business or ethical reason for establishing this wall membership, such as lateral hire screening, conflict of interest mitigation, client-requested isolation, or regulatory compliance.. Valid values are `lateral_hire|conflict_of_interest|client_request|matter_sensitivity|regulatory_requirement|other`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the specific circumstances, conflict, or business justification that necessitated adding or removing the timekeeper from the ethical wall. May reference specific matters, clients, or prior representations.',
    `review_date` DATE COMMENT 'The scheduled date for periodic review of this ethical wall membership to determine whether the restrictions or permissions remain necessary and appropriate.',
    `review_notes` STRING COMMENT 'Confidential narrative notes captured during the most recent review of this ethical wall membership, documenting the reviewers analysis, findings, and rationale for the review outcome.',
    `review_outcome` STRING COMMENT 'The result of the most recent periodic review, indicating whether the ethical wall membership was continued unchanged, modified, terminated, or escalated for further analysis.. Valid values are `continued|modified|terminated|escalated`',
    `source_system` STRING COMMENT 'The operational system or process that originated this ethical wall membership record, such as Intapp Conflicts automated workflow, Elite 3E integration, manual entry by conflicts team, or lateral hire onboarding system.. Valid values are `intapp_conflicts|elite_3e|manual_entry|lateral_hire_system|other`',
    `termination_date` DATE COMMENT 'The date on which this ethical wall membership ends and the timekeeper is no longer subject to the wall restrictions or permissions. Nullable for ongoing memberships.',
    CONSTRAINT pk_wall_membership PRIMARY KEY(`wall_membership_id`)
) COMMENT 'Association entity recording which timekeepers (attorneys, paralegals, staff) are included within or excluded from a specific ethical wall. Captures the timekeeper reference, inclusion/exclusion designation, the date added or removed, the reason for the membership change, and the authorizing partner. Enables enforcement of access restrictions in iManage Work and Elite 3E.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` (
    `lateral_screening_id` BIGINT COMMENT 'Unique identifier for the lateral hire conflict screening record. Primary key for the lateral screening entity.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Lateral hire screening includes AML/KYC checks on candidates prior client relationships and matters. Conflicts teams verify candidate has not been involved in matters with AML red flags or sanctions ',
    `check_id` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — A lateral screening triggers or is associated with a conflict check. This link ensures the lateral hire workflow connects to the standard conflict clearance pipeline.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to knowledge.checklist. Business justification: Lateral hire screening follows standardized firm checklists covering candidate disclosure requirements, conflict search procedures, clearance steps, and ethical wall assessment. Ensures consistent scr',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Lateral screening processes candidate personal data and must be registered under data protection law. DPO register includes lateral hire screening as a processing activity with retention periods. Link',
    `indemnity_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.indemnity_exposure. Business justification: Lateral hires who bring inadequately screened conflicts can generate PI exposure when those conflicts materialize. Links PI exposures to lateral screening decisions for root cause analysis and screeni',
    `lateral_candidate_id` BIGINT COMMENT 'Reference to the candidate being screened in the recruitment system. Links to the SAP SuccessFactors recruitment workflow.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who initiated the lateral screening record, typically a recruitment coordinator or conflicts analyst.',
    `lateral_last_modified_by_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified the lateral screening record. Supports audit trail and accountability.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Lateral screening process is governed by firm conflicts policy and hiring policy. Lateral screening checklist implements policy requirements. Links screening to governing policy.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Lateral hire conflict screening is scoped to the candidates proposed practice area. Screening questionnaires, matter disclosure requirements, and conflict search parameters are practice-area-specific',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Lateral hire screening must identify specific IP assets candidate worked on at prior firm (prosecuted Patents X, Y, Z for Competitor A). Critical for assessing portability conflicts and ethical wall r',
    `judge_id` BIGINT COMMENT 'Foreign key linking to court.judge. Business justification: Lateral hire screening checks for prior appearances before specific judges. Real process: candidate disclosure forms ask list judges youve appeared before for recusal analysis and relationship mapp',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Lateral hire screenings identifying conflicts, requiring ethical walls, or needing client consents generate risk register entries for ongoing monitoring. Standard lateral hire conflict risk management',
    `screening_owner_timekeeper_id` BIGINT COMMENT 'Reference to the partner sponsoring the lateral hire. Responsible for reviewing screening results and making the clearance decision.',
    `candidate_email` STRING COMMENT 'Primary email address of the lateral hire candidate. Used for screening communications and questionnaire distribution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `candidate_full_name` STRING COMMENT 'Full legal name of the lateral hire candidate as provided in the application. Used for conflict search and clearance documentation.',
    `candidate_phone` STRING COMMENT 'Primary contact phone number for the lateral hire candidate during the screening process.',
    `clearance_decision` STRING COMMENT 'Final decision by the hiring partner or conflicts committee on whether the lateral hire may proceed. Approved with conditions typically requires ethical walls.. Valid values are `approved|approved_with_conditions|rejected|pending`',
    `clearance_decision_date` DATE COMMENT 'Date when the final clearance decision was made. Establishes the completion of the screening process.',
    `clearance_decision_rationale` STRING COMMENT 'Detailed explanation of the clearance decision, including analysis of conflicts, ethical considerations, and mitigation measures. Protected by Legal Professional Privilege (LPP).',
    `client_consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether required client consent has been obtained and documented. Must be true before clearance can be granted if consent is required.',
    `client_consent_required_flag` BOOLEAN COMMENT 'Indicates whether informed client consent is required to proceed with the hire due to identified conflicts under ABA Rule 1.7.',
    `conflict_search_performed_date` DATE COMMENT 'Date when the automated and manual conflict search was executed against firm client and matter databases.',
    `conflict_severity_level` STRING COMMENT 'Highest severity level of conflicts identified. Disqualifying conflicts prevent hiring without client consent or ethical wall implementation.. Valid values are `none|low|medium|high|disqualifying`',
    `conflicts_committee_review_date` DATE COMMENT 'Date when the conflicts committee reviewed the lateral screening case. Null if no committee review was required.',
    `conflicts_committee_review_flag` BOOLEAN COMMENT 'Indicates whether the screening was escalated to the firm conflicts committee for review due to complexity or severity of identified conflicts.',
    `conflicts_identified_count` STRING COMMENT 'Number of potential conflicts of interest identified during the screening process. Zero indicates no conflicts found.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lateral screening record was first created in the system. Marks the initiation of the screening process.',
    `data_privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the candidate provided informed consent for processing their personal data during the screening process under GDPR Article 6.',
    `ethical_wall_description` STRING COMMENT 'Detailed description of the ethical wall procedures and restrictions to be implemented if the candidate is hired. Includes matter access restrictions and communication protocols.',
    `ethical_wall_required_flag` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) must be established to mitigate imputed disqualification under ABA Rule 1.10(a)(2).',
    `general_counsel_notification_flag` BOOLEAN COMMENT 'Indicates whether the firm General Counsel (GC) or Chief Legal Officer (CLO) was notified of the screening due to high-risk conflicts or regulatory concerns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the lateral screening record was last updated. Tracks the most recent change to any field in the record.',
    `lateral_parent_check` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Lateral screening is a specialized form of conflict check. The lateral_screening record should reference the parent conflict_check that governs its lifecycle and clearance.',
    `matters_disclosed_count` STRING COMMENT 'Number of matters or cases the candidate disclosed from their prior firm employment. Indicates the scope of conflict review required.',
    `parties_disclosed_count` STRING COMMENT 'Number of parties (clients, adverse parties, co-counsel) disclosed by the candidate from prior matters. Used to assess relationship conflicts.',
    `position_title` STRING COMMENT 'Job title or role the candidate held at the prior firm (e.g., Partner, Associate, Counsel, Paralegal). Influences the scope and depth of conflict analysis.',
    `prior_employment_end_date` DATE COMMENT 'Date when the candidate ended employment at the prior firm. Establishes the recency of potential conflicts.',
    `prior_employment_start_date` DATE COMMENT 'Date when the candidate began employment at the prior firm. Defines the temporal scope for matter conflict analysis.',
    `prior_firm_jurisdiction` STRING COMMENT 'Primary jurisdiction or state bar where the prior firm operates. Used to assess applicable conflict rules and ethical obligations.',
    `prior_firm_name` STRING COMMENT 'Name of the law firm or legal organization where the candidate was previously employed. Critical for conflict identification and imputed disqualification analysis.',
    `prior_practice_group` STRING COMMENT 'Practice area or department where the candidate worked at their prior firm (e.g., Corporate M&A, Litigation, IP, Employment). Used to scope conflict search.',
    `proposed_office_location` STRING COMMENT 'Office or geographic location where the candidate will be based if hired. Relevant for jurisdiction-specific conflict rules.',
    `proposed_practice_group` STRING COMMENT 'Practice area or department where the candidate will work if hired. Used to assess potential future conflicts and ethical wall requirements.',
    `questionnaire_received_date` DATE COMMENT 'Date when the completed conflict questionnaire was received from the candidate. Triggers the conflict analysis phase.',
    `questionnaire_sent_date` DATE COMMENT 'Date when the lateral hire conflict questionnaire was sent to the candidate. Establishes the start of the candidate disclosure period.',
    `record_retention_date` DATE COMMENT 'Date until which the lateral screening record must be retained per regulatory and professional responsibility requirements. Typically 7-10 years post-decision.',
    `screening_notes` STRING COMMENT 'Free-text notes and observations recorded during the screening process. May include analyst comments, follow-up actions, and additional context. Protected by LPP.',
    `screening_number` STRING COMMENT 'Business identifier for the lateral screening record. Human-readable unique reference number used in communications and reporting.. Valid values are `^LS-[0-9]{6,10}$`',
    `screening_status` STRING COMMENT 'Current lifecycle status of the lateral screening process. Tracks progression from initiation through clearance or rejection. [ENUM-REF-CANDIDATE: initiated|questionnaire_sent|questionnaire_received|under_review|conflicts_identified|cleared|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_lateral_screening PRIMARY KEY(`lateral_screening_id`)
) COMMENT 'Conflict screening record specific to lateral attorney and staff hires. Captures the candidates prior firm, practice group, matters handled at prior firm (as disclosed), parties represented or adverse, the screening questionnaire responses, identified conflicts, and the hiring partners clearance decision. Enforces ABA Rule 1.10(a)(2) lateral hire imputed disqualification analysis. Integrates with SAP SuccessFactors recruitment workflow.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`relationship_map` (
    `relationship_map_id` BIGINT COMMENT 'Unique identifier for the relationship mapping record.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Party relationship mapping in litigation contexts links to specific court cases. Real process: adverse party analysis requires identifying the docket where the relationship is relevant for conflict as',
    `matter_id` BIGINT COMMENT 'Identifier of the matter in which the adverse party relationship was identified, if applicable. Links the relationship to a specific case or transaction context.',
    `ownership_id` BIGINT COMMENT 'Foreign key linking to ip.ownership. Business justification: Party relationship mapping traces IP ownership chains for conflict expansion (Parent Corp owns Patent A, Subsidiary B is adverse party). Essential for identifying imputed conflicts through IP asset ow',
    `conflict_party_id` BIGINT COMMENT 'Identifier for the first party in the relationship. References the party entity in the conflict universe (client, organisation, individual, or adverse party).',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links relationship mappings to conflict rules they trigger. relationship_map has conflict_expansion_flag indicating the relationship causes conflict expansion under specific rules (e.g., imputed confl',
    `source_conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — Each relationship record connects two parties. This FK references the first party (source/parent side of the relationship).',
    `adverse_party_flag` BOOLEAN COMMENT 'Indicates whether this relationship represents an adverse party pairing (e.g., opposing parties in litigation or transaction). Used to identify direct conflicts of interest.',
    `confidentiality_level` STRING COMMENT 'The confidentiality classification of the relationship data. Determines who within the firm can view the relationship information. Restricted relationships may be subject to ethical walls or limited access.. Valid values are `public|internal|confidential|restricted`',
    `conflict_expansion_flag` BOOLEAN COMMENT 'Indicates whether this relationship should be included in conflict search expansion logic. If true, conflicts identified for Party A will also flag Party B and vice versa.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the relationship record was first created in the system. Used for audit trail and data lineage.',
    `data_source_system` STRING COMMENT 'The name of the system or platform from which the relationship data was ingested (e.g., Intapp Conflicts, Companies House API, KYC platform). Used for data lineage and troubleshooting.',
    `effective_from_date` DATE COMMENT 'The date from which the relationship became effective. Used to determine whether the relationship was active during a specific matter or conflict check period.',
    `effective_to_date` DATE COMMENT 'The date on which the relationship ended or will end. Null if the relationship is ongoing. Used to determine whether the relationship was active during a specific matter or conflict check period.',
    `ethical_wall_applicable` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) can be applied to manage conflicts arising from this relationship. Used in conflict clearance workflows.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or country in which the relationship is registered or primarily operates. Used for regulatory compliance and conflict analysis. Use 3-letter ISO country codes (e.g., USA, GBR, DEU).',
    `last_updated_by` STRING COMMENT 'Name or identifier of the user, system, or process that last updated the relationship record. Used for audit trail and accountability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the relationship record was last updated. Used for audit trail and to determine data freshness for conflict searches.',
    `lateral_hire_flag` BOOLEAN COMMENT 'Indicates whether this relationship was identified as part of a lateral hire screening process. Used to track conflicts introduced by new attorneys joining the firm.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the relationship. May include special instructions for conflict analysts, historical context, or clarifications about the relationship structure.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership or control that Party A holds in Party B, if applicable. Used for beneficial ownership and corporate family tree analysis. Null if not applicable to the relationship type.',
    `relationship_description` STRING COMMENT 'Free-text description providing additional context about the relationship. May include details about the nature of the affiliation, business purpose, or special considerations for conflict analysis.',
    `relationship_direction` STRING COMMENT 'Indicates whether the relationship is directional (Party A to Party B), bidirectional (mutual), or hierarchical (parent-child). Used to determine conflict search traversal logic.. Valid values are `directional|bidirectional|hierarchical`',
    `relationship_party_a` BIGINT COMMENT 'FK to conflict.party.party_id — Each relationship record connects two parties. This FK identifies the first party (or parent in directional relationships).',
    `relationship_role_a` STRING COMMENT 'The role that Party A plays in the relationship (e.g., parent, subsidiary, beneficial owner, joint venture partner, adverse party). Provides semantic context for the relationship.',
    `relationship_role_b` STRING COMMENT 'The role that Party B plays in the relationship (e.g., parent, subsidiary, beneficial owner, joint venture partner, adverse party). Provides semantic context for the relationship.',
    `relationship_source` STRING COMMENT 'The source from which the relationship data was obtained. Indicates the reliability and verification level of the relationship information. [ENUM-REF-CANDIDATE: client_disclosure|public_registry|kyc_review|companies_house|aml_screening|manual_entry|third_party_data|corporate_filing|due_diligence — promote to reference product]. Valid values are `client_disclosure|public_registry|kyc_review|companies_house|aml_screening|manual_entry`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the relationship. Active relationships are included in conflict searches; inactive or terminated relationships may be excluded or flagged differently.. Valid values are `active|inactive|pending_verification|terminated`',
    `relationship_type` STRING COMMENT 'Classification of the relationship between the two parties. Determines the scope of conflict expansion during conflict searches. [ENUM-REF-CANDIDATE: parent_subsidiary|affiliate|beneficial_ownership|joint_venture|adverse_party|corporate_family|sister_company|holding_company|controlled_entity|associated_entity — promote to reference product]. Valid values are `parent_subsidiary|affiliate|beneficial_ownership|joint_venture|adverse_party|corporate_family`',
    `source_document_reference` STRING COMMENT 'Reference to the document or filing that evidences the relationship (e.g., Companies House filing number, KYC document ID, client disclosure form). Used for audit trail and verification purposes.',
    `verification_status` STRING COMMENT 'Indicates whether the relationship has been verified by the conflicts team or compliance officer. Verified relationships carry higher confidence in conflict searches.. Valid values are `verified|unverified|pending|disputed`',
    `verified_by` STRING COMMENT 'Name or identifier of the conflicts analyst, compliance officer, or system that verified the relationship. Used for audit trail and accountability.',
    `verified_date` DATE COMMENT 'The date on which the relationship was verified. Used for audit trail and to determine when re-verification may be required.',
    `created_by` STRING COMMENT 'Name or identifier of the user, system, or process that created the relationship record. Used for audit trail and accountability.',
    CONSTRAINT pk_relationship_map PRIMARY KEY(`relationship_map_id`)
) COMMENT 'Master record capturing known relationships between parties in the conflict universe — corporate family trees (parent/subsidiary), affiliate chains, beneficial ownership structures, joint venture partnerships, and adverse party pairings. Each record defines the two related parties, relationship type, directionality (parent-to-child, peer-to-peer), effective date range, and the source of the relationship data (client disclosure, public registry, KYC/AML review, Companies House filing). Used to expand conflict search scope beyond direct name matches to identify indirect conflicts through corporate affiliations.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`conflict`.`rule` (
    `rule_id` BIGINT COMMENT 'Primary key for rule',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_asset. Business justification: Conflict rules are themselves knowledge assets - firm policies, ethical guidelines, regulatory interpretations, and conflict resolution protocols maintained in knowledge repository. Links rule to its ',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict rules apply different thresholds and requirements by practice area (e.g., litigation adverse-party rules vs transactional same-side rules). Automated conflict checking engines apply practice-',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Conflict rules are updated in response to regulatory changes. Regulatory change implementation includes conflict rule amendments. Links rule to regulatory change that triggered update.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Conflict rules implement specific regulatory obligations (e.g., SRA rule 6.2 on conflicts maps to internal conflict rule CON-001). Conflict rule library is mapped to regulatory obligations for complia',
    `applies_to_lateral_hires` BOOLEAN COMMENT 'Indicates whether this conflict rule applies to lateral hire screening (i.e., checking for conflicts when a lawyer joins the firm from another firm). True if the rule governs imputed conflicts from prior representation; False otherwise.',
    `applies_to_prospective_clients` BOOLEAN COMMENT 'Indicates whether this conflict rule applies to prospective clients (i.e., individuals or organizations who consult with the firm but do not retain the firm). True if the rule governs duties to prospective clients; False otherwise.',
    `automated_check_enabled` BOOLEAN COMMENT 'Indicates whether automated conflict checking logic in Intapp Conflicts is enabled for this rule. True if the system automatically flags potential conflicts based on this rule; False if manual review is required.',
    `check_logic_description` STRING COMMENT 'Description of the automated conflict checking logic or algorithm used to detect violations of this rule in Intapp Conflicts. Includes the data elements checked (e.g., client relationships, matter types, adverse parties, practice areas) and the matching criteria.',
    `citation` STRING COMMENT 'The formal legal citation or reference to the source document for this conflict rule (e.g., ABA Model Rules of Professional Conduct Rule 1.7, SRA Standards and Regulations 2019, Rule 6.1, New York Rules of Professional Conduct Rule 1.7).',
    `confidentiality_obligation` STRING COMMENT 'The level of confidentiality obligation imposed by this conflict rule. Absolute: no disclosure permitted; Qualified: disclosure permitted with consent or under specific circumstances; Limited: disclosure permitted for certain purposes; None: no confidentiality obligation.. Valid values are `Absolute|Qualified|Limited|None`',
    `conflict_type` STRING COMMENT 'The nature of the conflict that this rule addresses (e.g., Direct Adverse representation, Material Limitation on representation, Positional conflict, Transactional conflict, Issue conflict).. Valid values are `Direct Adverse|Material Limitation|Positional|Transactional|Issue|Other`',
    `consent_form_required` BOOLEAN COMMENT 'Indicates whether a written consent form is required from the client(s) to waive the conflict governed by this rule. True if written consent is mandatory; False if oral consent is sufficient or if the conflict is non-waivable.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this conflict rule record was first created in the system. Used for audit trail and data lineage purposes.',
    `disclosure_requirements` STRING COMMENT 'Description of the disclosure requirements that must be met when seeking a waiver or managing a conflict under this rule. Includes the information that must be disclosed to clients, the form of disclosure (written, oral), and the timing of disclosure.',
    `documentation_requirements` STRING COMMENT 'Description of the documentation that must be maintained when managing a conflict under this rule. Includes conflict check records, waiver forms, ethical wall memos, client communications, and any other records required for compliance and audit purposes.',
    `effective_date` DATE COMMENT 'The date on which this conflict rule became effective and enforceable. Used to determine which version of the rule applies to matters opened on or after this date.',
    `expiration_date` DATE COMMENT 'The date on which this conflict rule was superseded or ceased to be effective. Null if the rule is currently in force.',
    `governing_body` STRING COMMENT 'The regulatory or professional body that promulgated this conflict rule (e.g., American Bar Association, Solicitors Regulation Authority, State Bar Association, International Bar Association). [ENUM-REF-CANDIDATE: ABA|Law Society of England and Wales|IBA|SRA|State Bar|LSB|Other — 7 candidates stripped; promote to reference product]',
    `is_waivable` BOOLEAN COMMENT 'Indicates whether the conflict governed by this rule may be waived by informed client consent. True if waivable under certain conditions; False if non-waivable (e.g., direct adverse representation in the same matter).',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction(s) or geographic scope in which this conflict rule applies. May be a single jurisdiction (e.g., New York, England and Wales) or multiple jurisdictions separated by semicolons. Use 3-letter uppercase country codes where applicable (e.g., USA, GBR, CAN).',
    `lpp_protected` BOOLEAN COMMENT 'Indicates whether this conflict rule is designed to protect Legal Professional Privilege (attorney-client privilege). True if the rule safeguards confidential client communications; False otherwise.',
    `modified_by` STRING COMMENT 'The user ID or name of the individual who last modified this conflict rule record. Used for audit trail and accountability purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this conflict rule record was last modified. Used for audit trail and change tracking purposes.',
    `notes` STRING COMMENT 'Additional notes, commentary, or guidance related to the application of this conflict rule. May include firm-specific interpretations, exceptions, or best practices for managing conflicts under this rule.',
    `notification_recipients` STRING COMMENT 'Description of the parties who must be notified when a conflict governed by this rule is identified (e.g., All affected clients, Opposing counsel, Tribunal, Firm management). Null if no notification is required.',
    `notification_required` BOOLEAN COMMENT 'Indicates whether notification to affected parties (clients, opposing counsel, tribunal) is required when a conflict governed by this rule is identified. True if notification is mandatory; False otherwise.',
    `related_rules` STRING COMMENT 'Comma-separated list of related conflict rule codes that should be considered in conjunction with this rule (e.g., ABA_1.9,ABA_1.10 for a rule that interacts with former client and imputed conflict rules). Used for cross-referencing and comprehensive conflict analysis.',
    `requires_ethical_wall` BOOLEAN COMMENT 'Indicates whether this conflict rule requires the establishment of an ethical wall (information barrier, Chinese wall) to screen conflicted individuals from the matter. True if an ethical wall is a permissible or required mitigation; False otherwise.',
    `retention_period_years` STRING COMMENT 'The number of years that conflict check records and related documentation must be retained for this rule, as required by the governing body or firm policy. Used to enforce records retention schedules and compliance with regulatory obligations.',
    `rule_category` STRING COMMENT 'Classification of the conflict rule by the type of conflict it governs (e.g., Concurrent Conflict of Interest, Former Client Conflict, Imputed Conflict, Prospective Client Conflict, Third-Party Conflict, Government Lawyer Conflict). [ENUM-REF-CANDIDATE: Concurrent Conflict|Former Client Conflict|Imputed Conflict|Prospective Client Conflict|Third-Party Conflict|Government Lawyer Conflict|Other — 7 candidates stripped; promote to reference product]',
    `rule_code` STRING COMMENT 'Business identifier for the conflict rule (e.g., ABA_1.7, ABA_1.9, ABA_1.10, SRA_6.1, IBA_CONFLICT_01). Used as the externally-known unique code for the rule in Intapp Conflicts and other systems.. Valid values are `^[A-Z0-9._-]{1,50}$`',
    `rule_description` STRING COMMENT 'Detailed description of the conflict-of-interest rule, including the ethical obligation, the conditions under which it applies, and the rationale. May include excerpts from the governing bodys rule text.',
    `rule_name` STRING COMMENT 'Human-readable name or title of the conflict rule (e.g., Concurrent Conflict of Interest, Former Client Conflict, Imputed Conflict).',
    `rule_status` STRING COMMENT 'Current lifecycle status of the conflict rule. Active: currently in force; Superseded: replaced by a newer version; Proposed: under consideration but not yet adopted; Withdrawn: no longer applicable.. Valid values are `Active|Superseded|Proposed|Withdrawn`',
    `screening_scope` STRING COMMENT 'The organizational scope at which conflict screening must be performed for this rule (e.g., Individual timekeeper, Practice Group, Office, Firm-Wide). Determines the breadth of relationship and matter checks required.. Valid values are `Individual|Practice Group|Office|Firm-Wide|Not Applicable`',
    `severity_level` STRING COMMENT 'The severity or risk level associated with a violation of this conflict rule. Critical: non-waivable, direct adverse representation; High: waivable only with stringent conditions; Medium: waivable with informed consent; Low: administrative or positional conflict.. Valid values are `Critical|High|Medium|Low`',
    `waiver_conditions` STRING COMMENT 'Detailed description of the conditions under which the conflict may be waived, if applicable. Includes requirements for informed consent, written disclosure, independent legal advice, and any other conditions mandated by the governing body. Null if the conflict is non-waivable.',
    `created_by` STRING COMMENT 'The user ID or name of the individual who created this conflict rule record in the system. Used for audit trail and accountability purposes.',
    CONSTRAINT pk_rule PRIMARY KEY(`rule_id`)
) COMMENT 'Reference catalog of conflict-of-interest rules and ethical obligations configured in the firms conflict system. Each record defines the rule identifier (e.g., ABA 1.7, ABA 1.9, ABA 1.10, SRA Rule 6.1), the governing body, the rule description, the jurisdiction(s) of applicability, the conflict category it governs, and whether the conflict is waivable. Drives automated conflict classification logic in Intapp Conflicts.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`party_alias` (
    `party_alias_id` BIGINT COMMENT 'Unique identifier for the party alias record. Primary key.',
    `conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — Each alias links to its canonical party record. Description explicitly states this linkage. Without it, aliases cannot be resolved to parties during search.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user or system account that created this alias record. Links to the user or system entity responsible for the initial data entry.',
    `party_last_modified_by_timekeeper_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this alias record. Links to the user or system entity responsible for the most recent update.',
    `primary_conflict_party_id` BIGINT COMMENT 'Foreign key reference to the canonical conflict_party record to which this alias belongs. Links the alias to the authoritative party entity in the conflict search universe.',
    `alias_canonical_party` BIGINT COMMENT 'FK to conflict.party.party_id — Each alias record links to its canonical party record. This FK is essential for the fuzzy matching engine to resolve aliases back to the master party.',
    `alias_name` STRING COMMENT 'The alternate name, former name, trade name, DBA (Doing Business As) designation, or transliterated variant of the party. This is the searchable alias string used during conflict searches to identify potential matches.',
    `alias_source` STRING COMMENT 'The origin or source from which the alias was obtained. Values: client_disclosure (provided by client during intake), public_registry (obtained from government or corporate registry), prior_matter (identified in historical matter records), lateral_hire_screening (discovered during lateral attorney conflict check), third_party_database (sourced from external data provider), manual_entry (manually added by conflicts team).. Valid values are `client_disclosure|public_registry|prior_matter|lateral_hire_screening|third_party_database|manual_entry`',
    `alias_type` STRING COMMENT 'Classification of the alias indicating the nature of the alternate name. Values: legal_name (official registered name), former_name (historical name prior to change), trade_name (commercial operating name), dba (Doing Business As designation), transliteration (name rendered in different script or alphabet), phonetic_variant (phonetically similar name for fuzzy matching).. Valid values are `legal_name|former_name|trade_name|dba|transliteration|phonetic_variant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this alias record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_from_date` DATE COMMENT 'The date from which this alias became valid or applicable to the party. For former names, this is the start date of the name usage period. For current names, this is the date the alias was first recognized.',
    `effective_to_date` DATE COMMENT 'The date until which this alias was valid or applicable to the party. For former names, this is the end date of the name usage period. Null for current or ongoing aliases.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this alias is currently active and should be included in conflict searches. True if active; False if retired or deprecated.',
    `is_primary_alias` BOOLEAN COMMENT 'Boolean flag indicating whether this alias is the primary or preferred alternate name for the party in conflict searches. True if this is the main alias to be used; False otherwise.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the jurisdiction in which this alias is registered or recognized. Relevant for trade names and DBA designations that may be jurisdiction-specific. Examples: USA, GBR, CAN, AUS, DEU.. Valid values are `^[A-Z]{3}$`',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language or script in which the alias is expressed. Used for transliterated variants and multilingual conflict searches. Examples: ENG (English), FRA (French), DEU (German), CHI (Chinese), ARA (Arabic).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this alias record was last modified or updated. Used for audit trail, change tracking, and data currency assessment.',
    `notes` STRING COMMENT 'Free-text field for additional context, comments, or explanatory notes about the alias. May include information about the reason for the alias, historical context, or special handling instructions for conflict searches.',
    `phonetic_encoding` STRING COMMENT 'Phonetic encoding of the alias name using algorithms such as Soundex, Metaphone, or Double Metaphone. Enables fuzzy matching and phonetic similarity searches during conflict checks to identify parties with similar-sounding names.',
    `search_priority` STRING COMMENT 'Integer ranking indicating the priority or weight of this alias in conflict search algorithms. Higher values indicate higher priority. Used to rank search results when multiple aliases match a conflict search query.',
    `verification_date` DATE COMMENT 'The date on which the alias was last verified or validated against authoritative sources. Used to track the currency and reliability of alias data for conflict search purposes.',
    `verification_source` STRING COMMENT 'The authoritative source or registry used to verify the alias. Examples: Companies House (UK), SEC EDGAR (USA), state business registry, corporate charter, court records, client-provided documentation.',
    `verification_status` STRING COMMENT 'Status indicating whether the alias has been verified against authoritative sources. Values: verified (confirmed against official records), unverified (not yet validated), pending_verification (verification in progress), disputed (conflicting information exists).. Valid values are `verified|unverified|pending_verification|disputed`',
    CONSTRAINT pk_party_alias PRIMARY KEY(`party_alias_id`)
) COMMENT 'Registry of known name aliases, former names, trade names, DBA designations, and transliterated variants for parties in the conflict search universe. Each alias record links to the canonical conflict_party record and captures the alias type, the source of the alias (client disclosure, public registry, prior matter), and the effective date range. Enables comprehensive fuzzy and phonetic matching during conflict searches.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`conflict`.`conflict_exception` (
    `conflict_exception_id` BIGINT COMMENT 'Unique identifier for the conflict exception record. Primary key.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict exceptions are granted for specific practice areas where firm policy allows flexibility (e.g., transactional same-side exceptions). Exception approval workflows and usage tracking are practic',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Conflict exceptions (approved deviations from conflict rules) represent accepted risks requiring tracking, periodic review, and governance oversight. Standard exception-based risk acceptance workflow.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Conflict exceptions must be justified against regulatory obligations to ensure they do not violate mandatory rules. Exception approval workflow requires regulatory compliance review. Links exception t',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links exceptions to the specific conflict rules they override or modify. Exceptions are granted as deviations from standard rules; this FK captures which rule is being excepted. Removes redundant regu',
    `approval_date` DATE COMMENT 'Date on which the exception was formally approved and became effective.',
    `approver_name` STRING COMMENT 'Full name of the individual or committee chair who approved this exception.',
    `approving_authority` STRING COMMENT 'The role or body that approved this exception: managing partner, ethics committee, general counsel, conflicts counsel, or risk management committee.. Valid values are `managing_partner|ethics_committee|general_counsel|conflicts_counsel|risk_management_committee`',
    `audit_trail_notes` STRING COMMENT 'Free-text field for recording audit notes, review comments, or historical context related to the exception approval and usage.',
    `client_category` STRING COMMENT 'Category or classification of clients covered by this exception (e.g., Fortune 500 financial institutions, approved nonprofit organizations, government entities).',
    `client_consent_required` BOOLEAN COMMENT 'Indicates whether informed client consent is required when applying this exception, even though it is pre-approved.',
    `conflict_exception_status` STRING COMMENT 'Current lifecycle status of the exception: active (in force), suspended (temporarily inactive), expired (past review date), revoked (terminated), pending review (awaiting approval), or draft (not yet approved).. Valid values are `active|suspended|expired|revoked|pending_review|draft`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exception record was first created in the conflict management system.',
    `effective_from_date` DATE COMMENT 'Date from which this exception is valid and may be applied to conflict clearance decisions.',
    `ethical_wall_required` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) must be established when this exception is applied to protect Legal Professional Privilege (LPP) and client confidentiality.',
    `exception_code` STRING COMMENT 'Business identifier code for the exception, used for reference in conflict clearance workflows and audit trails.. Valid values are `^[A-Z0-9]{6,20}$`',
    `exception_description` STRING COMMENT 'Detailed narrative describing the scope, rationale, and conditions under which this exception applies to conflict clearance requirements.',
    `exception_name` STRING COMMENT 'Human-readable name or title of the exception for identification in conflict management systems and reporting.',
    `exception_type` STRING COMMENT 'Classification of the exception category: pre-approved engagement categories, standing institutional client waivers, regulatory safe harbors, de minimis thresholds, pro bono matter categories for approved nonprofits, or institutional client blanket waivers.. Valid values are `pre_approved_engagement|standing_client_waiver|regulatory_safe_harbor|de_minimis_threshold|pro_bono_category|institutional_client_blanket`',
    `expiration_date` DATE COMMENT 'Date on which this exception expires and must be reviewed or renewed. Nullable for exceptions with no fixed expiration.',
    `jurisdiction_covered` STRING COMMENT 'Geographic or regulatory jurisdictions in which this exception is valid (e.g., USA, GBR, DEU, or specific state bars).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this exception record was last updated or modified.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent formal review of this exception by the approving authority.',
    `last_usage_date` DATE COMMENT 'Most recent date on which this exception was applied to a conflict clearance decision.',
    `mandatory_review_date` DATE COMMENT 'Date by which this exception must be reviewed by the approving authority, regardless of expiration status, to ensure continued appropriateness.',
    `matter_type_covered` STRING COMMENT 'Types of legal matters or engagement categories to which this exception applies (e.g., pro bono immigration matters, routine corporate filings, regulatory compliance advisory).',
    `notification_required` BOOLEAN COMMENT 'Indicates whether the conflicts counsel or ethics committee must be notified each time this exception is applied.',
    `practice_group_covered` STRING COMMENT 'Practice groups or departments within the firm to which this exception applies (e.g., Corporate, Litigation, Intellectual Property, Employment).',
    `revocation_date` DATE COMMENT 'Date on which this exception was revoked or terminated. Nullable if exception has not been revoked.',
    `revocation_reason` STRING COMMENT 'Explanation or rationale for revoking this exception, including any regulatory changes, risk events, or policy updates that necessitated revocation.',
    `scope_definition` STRING COMMENT 'Detailed specification of the scope covered by this exception, including client categories, matter types, practice groups, jurisdictions, or transaction thresholds to which the exception applies prospectively.',
    `source_system` STRING COMMENT 'Name of the operational system from which this exception record originated (e.g., Intapp Conflicts, internal ethics management system).',
    `source_system_code` STRING COMMENT 'Unique identifier of this exception in the source operational system, used for data lineage and reconciliation.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold value for de minimis exceptions (e.g., matters below USD 50,000 may be pre-approved). Nullable if exception is not amount-based.',
    `threshold_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the threshold amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `usage_count` STRING COMMENT 'Number of times this exception has been applied to conflict clearance decisions since approval. Used for monitoring and audit purposes.',
    CONSTRAINT pk_conflict_exception PRIMARY KEY(`conflict_exception_id`)
) COMMENT 'Records formally approved exceptions to standard conflict clearance requirements — including pre-approved engagement categories (e.g., pro bono matters for approved nonprofits), standing institutional client waivers, regulatory safe harbors, and de minimis thresholds. Captures the exception type, approving authority (managing partner, ethics committee, general counsel), scope definition (client categories, matter types, practice groups covered), approval date, expiration or mandatory review date, and usage count. Distinct from per-matter waivers: exceptions apply prospectively to categories of work rather than retroactively to a specific identified conflict.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`audit_log` (
    `audit_log_id` BIGINT COMMENT 'Primary key for audit_log',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the reviewer assigned to or responding to a conflict hit, if the action_type is reviewer_assigned or reviewer_response. Null for other action types.',
    `audit_actor_timekeeper_id` BIGINT COMMENT 'Identifier of the individual or system account that performed the action. References timekeeper or system user record.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Conflict system audit logs are reviewed during compliance audit engagements to verify access controls and process adherence. External auditors sample conflict audit logs as evidence for SOC 2 / ISO 27',
    `audit_session_id` BIGINT COMMENT 'Unique identifier of the user session or system transaction in which the action occurred. Enables correlation of related audit events.',
    `check_id` BIGINT COMMENT 'Identifier of the conflict check to which this audit event pertains. Used for partitioning and per-matter audit retrieval.',
    `clearance_id` BIGINT COMMENT 'Foreign key linking to conflict.clearance. Business justification: Links audit events to specific clearance records. audit_log currently has clearance_decision (STRING) but no FK to clearance entity. This FK enables tracking all audit events (submission, review, appr',
    `conflict_exception_id` BIGINT COMMENT 'Foreign key linking to conflict.exception. Business justification: Links audit events to specific conflict exceptions. When exceptions are approved, invoked, or revoked, the audit log should reference the exception record. Removes redundant exception_approval_level a',
    `data_subject_request_id` BIGINT COMMENT 'Foreign key linking to compliance.data_subject_request. Business justification: Conflict audit logs are searched to fulfill DSR requests (right to know who accessed my data). DSR fulfillment includes audit log extracts showing access history. Links audit log to DSR record.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Audit trail for conflict decisions on litigation matters. Real process: regulatory audit (SRA, state bar) requires tracing conflict decisions to specific court cases for professional responsibility co',
    `ethical_wall_id` BIGINT COMMENT 'Identifier of the ethical wall created, modified, or dissolved by this action. Null if action does not pertain to an ethical wall.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Audit trails must capture conflict decisions tied to specific IP assets for professional indemnity claims and regulatory audits (SRA, state bar). Required for demonstrating due diligence in IP conflic',
    `lateral_screening_id` BIGINT COMMENT 'Foreign key linking to conflict.lateral_screening. Business justification: Adds audit trail for lateral screening events. Lateral hire screening is a critical compliance workflow that requires full audit trail (questionnaire sent, conflicts identified, clearance decision). T',
    `matter_id` BIGINT COMMENT 'Identifier of the matter for which the conflict check was performed, if applicable. Null for lateral hire screening or other non-matter conflict checks.',
    `profile_id` BIGINT COMMENT 'Identifier of the client associated with the conflict check, if applicable. Null for lateral hire screening or other non-client conflict checks.',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links audit events to specific conflict rules being evaluated or enforced. Audit log tracks rule evaluation events, rule violations, and rule-based decisions. This FK enables rule-specific audit repor',
    `waiver_id` BIGINT COMMENT 'Foreign key linking to conflict.waiver. Business justification: Adds traceability from audit events to specific waivers. audit_log currently has waiver_executed_flag (boolean) but no FK to the waiver entity. This FK enables linking audit events (waiver execution, ',
    `aba_ethics_audit_flag` BOOLEAN COMMENT 'Indicates whether this audit event is required for American Bar Association (ABA) ethics audit and compliance review. True if required, False otherwise.',
    `action_type` STRING COMMENT 'Type of action or state change captured in this audit entry. Enumerates all material lifecycle events in the conflict check process. [ENUM-REF-CANDIDATE: check_created|search_executed|hit_reviewed|reviewer_assigned|reviewer_response|clearance_decision|waiver_executed|ethical_wall_created|ethical_wall_modified|ethical_wall_dissolved|exception_approved|exception_revoked — 12 candidates stripped; promote to reference product]',
    `actor_name` STRING COMMENT 'Full name of the individual or system account that performed the action. Denormalized for audit trail readability and GDPR Article 15 data subject access requests.',
    `actor_type` STRING COMMENT 'Category of actor who performed the action: timekeeper (lawyer or staff), system (automated process), or administrator (privileged user).. Valid values are `timekeeper|system|administrator`',
    `affected_entity_reference` BIGINT COMMENT 'Identifier of the specific entity instance affected by this action. Interpreted in conjunction with affected_entity_type.',
    `affected_entity_type` STRING COMMENT 'Type of business entity affected by this action (e.g., conflict_check, conflict_hit, ethical_wall). Provides context for the affected_entity_id. [ENUM-REF-CANDIDATE: conflict_check|conflict_search|conflict_hit|reviewer_assignment|clearance|waiver|ethical_wall|exception — 8 candidates stripped; promote to reference product]',
    `audit_check_reference` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Most audit log entries relate to a specific conflict check lifecycle event. FK enables filtering audit trail by check for compliance review.',
    `data_residency_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the jurisdiction in which this audit record is stored. Required for GDPR and data sovereignty compliance.. Valid values are `USA|GBR|DEU|FRA|AUS|CAN`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the audited action occurred, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). This is the business event time, distinct from record creation time.',
    `gdpr_data_subject_flag` BOOLEAN COMMENT 'Indicates whether this audit record contains personal data of an EU/UK data subject and is therefore subject to GDPR Article 15/17 access and erasure rights. True if GDPR applies, False otherwise.',
    `hit_count` STRING COMMENT 'Number of conflict hits returned by a search, if the action_type is search_executed. Null for other action types.',
    `ip_address` STRING COMMENT 'IP address from which the action was initiated. Supports security audit and forensic investigation. May be IPv4 or IPv6 format.',
    `legal_basis_for_processing` STRING COMMENT 'GDPR Article 6 legal basis under which this personal data is processed and retained. Required for EU/UK personal data.. Valid values are `legitimate_interest|legal_obligation|contract|consent`',
    `new_state` STRING COMMENT 'State or value of the affected entity immediately after this action. Captured as JSON or delimited string for complex state. May be null for deletion events.',
    `prior_state` STRING COMMENT 'State or value of the affected entity immediately before this action. Captured as JSON or delimited string for complex state. May be null for creation events.',
    `professional_indemnity_relevant_flag` BOOLEAN COMMENT 'Indicates whether this audit event is relevant to professional indemnity insurance audit requirements. True if relevant, False otherwise.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason or trigger for this action. Supports categorization and reporting of audit events. [ENUM-REF-CANDIDATE: routine|lateral_hire_screening|matter_intake|client_request|regulatory_audit|exception_request|system_maintenance — 7 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text explanation or additional context provided by the actor for this action. Supports professional indemnity insurance audit and ethics review.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit log record was created in the data platform, in ISO 8601 format. Distinct from event_timestamp, which captures the business event time.',
    `retention_period_years` STRING COMMENT 'Number of years this audit record must be retained post-matter closure, per jurisdiction-specific professional conduct rules. Typically 6-10 years.',
    `reviewer_response` STRING COMMENT 'Response provided by the reviewer regarding a conflict hit, if the action_type is reviewer_response. Null for other action types.. Valid values are `no_conflict|potential_conflict|confirmed_conflict|requires_escalation`',
    `search_query_text` STRING COMMENT 'Text of the search query executed, if the action_type is search_executed. Null for other action types. Supports audit trail reconstruction.',
    `sra_accountability_flag` BOOLEAN COMMENT 'Indicates whether this audit event is required for Solicitors Regulation Authority (SRA) accountability and ethics audit. True if required, False otherwise.',
    `system_source` STRING COMMENT 'Name of the system or module that generated this audit event (e.g., Intapp Conflicts, Elite 3E, custom workflow engine). Supports multi-system audit consolidation.',
    CONSTRAINT pk_audit_log PRIMARY KEY(`audit_log_id`)
) COMMENT 'Business-level audit trail capturing every material state change in the conflict check lifecycle — check creation, search execution, hit review disposition, reviewer assignment and response, clearance decision, waiver execution, ethical wall creation/modification/dissolution, and exception approval or revocation. Each log entry records the actor (timekeeper or system), action type, affected entity and ID, prior state, new state, timestamp, and IP address. Supports SRA accountability, ABA ethics audit, GDPR data subject access requests (Article 15/17), and professional indemnity insurance audit requirements. Partitioned by conflict_check_id for efficient per-matter audit retrieval. Data residency: audit records containing EU/UK personal data are subject to GDPR storage requirements and must be retained in compliant jurisdictions with documented legal basis for processing. Retention periods follow jurisdiction-specific professional conduct rules (typically 6-10 years post-matter closure). This is a business compliance record, not a technical system log.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` (
    `matter_party_role_id` BIGINT COMMENT 'Unique identifier for the matter party role record. Primary key for conflict-domain tracking of party-matter relationships.',
    `ethical_wall_id` BIGINT COMMENT 'Reference to the ethical wall configuration applied to protect LPP and prevent information flow between conflicted matters. Null if no wall is required.',
    `matter_id` BIGINT COMMENT 'Reference to the matter on which this party holds a role. Links to the canonical matter record owned by the matter domain.',
    `conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — Each matter_party_role record identifies which party holds the role. Must FK to party for conflict index population.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney whose lateral hire screening identified this party role conflict. Null if not applicable.',
    `primary_matter_conflict_party_id` BIGINT COMMENT 'Reference to the party (individual or organization) holding this role on the matter. Links to client domain party master data.',
    `tertiary_matter_disclosed_by_party_conflict_party_id` BIGINT COMMENT 'Reference to the party (typically the client) who disclosed this relationship during intake or KYC (Know Your Client) process.',
    `approval_date` DATE COMMENT 'Date on which the party role assignment was approved by conflicts counsel or authorized partner.',
    `approval_notes` STRING COMMENT 'Confidential notes documenting the rationale for approving this party role despite conflicts. May reference waiver terms or ethical wall measures.',
    `billing_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this party role carries billing responsibility for the matter. True for client and co-client roles that are financially responsible.',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality protection required for information related to this party role. Attorney_work_product indicates highest protection under LPP (Legal Professional Privilege).. Valid values are `standard|enhanced|privileged|attorney_work_product`',
    `conflict_clearance_date` DATE COMMENT 'Date on which conflict clearance was granted or waived for this party role. Required before matter opening can proceed.',
    `conflict_clearance_status` STRING COMMENT 'Outcome of conflict screening for this party role. Ethical_wall_required indicates LPP (Legal Professional Privilege) protection measures are in place.. Valid values are `cleared|pending|waived|declined|ethical_wall_required`',
    `conflict_waiver_date` DATE COMMENT 'Date on which the conflict waiver was executed by the affected parties. Null if no waiver was required or obtained.',
    `conflict_waiver_obtained` BOOLEAN COMMENT 'Indicates whether a written conflict waiver was obtained from the affected parties per ABA Rule 1.7(b). True if waiver is on file.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this party role record was first created in the lakehouse. Audit trail for data lineage.',
    `disclosure_date` DATE COMMENT 'Date on which this party role or relationship was disclosed to the firm. May differ from role_effective_date if disclosure occurred after the relationship began.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this party role record is currently active. False for soft-deleted or archived records.',
    `last_conflict_check_date` DATE COMMENT 'Date of the most recent conflict check performed against this party role. Used for periodic re-screening and compliance audits.',
    `lateral_hire_flag` BOOLEAN COMMENT 'Indicates whether this party role was identified during lateral hire conflict screening. True if the relationship was discovered when screening a new attorney joining the firm.',
    `matter_opening_approval_required` BOOLEAN COMMENT 'Indicates whether this party role requires additional approval before the matter can be opened. True for high-risk conflict scenarios.',
    `relationship_nature` STRING COMMENT 'Free-text description of the nature of the partys relationship to the matter. Captures nuances not conveyed by role_type alone (e.g., parent company guarantor or former employee witness).',
    `role_assignment_source` STRING COMMENT 'Origin of the role assignment. Tracks whether the relationship was disclosed at intake, discovered in court filings, or identified during lateral hire screening.. Valid values are `matter_opening_form|court_filing|client_disclosure|lateral_hire_screening|manual_entry|system_import`',
    `role_effective_date` DATE COMMENT 'Date on which this party role became effective on the matter. Used for temporal conflict screening and lateral hire checks.',
    `role_end_date` DATE COMMENT 'Date on which this party role ended or was terminated. Null for ongoing roles. Critical for screening former client conflicts per ABA Rule 1.9.',
    `role_priority` STRING COMMENT 'Numeric ranking of this roles priority on the matter. Lower numbers indicate higher priority. Used when a party holds multiple roles (e.g., client and guarantor).',
    `role_status` STRING COMMENT 'Current lifecycle status of the party role assignment. Active roles populate the conflict search index; conflicted_out roles trigger ethical wall enforcement.. Valid values are `active|inactive|pending_clearance|terminated|conflicted_out`',
    `role_type` STRING COMMENT 'Classification of the partys role on the matter. Determines conflict screening rules and ethical wall requirements. [ENUM-REF-CANDIDATE: client|co-client|adverse_party|third_party_witness|guarantor|related_entity|regulatory_counterparty|opposing_counsel|expert_witness|beneficiary|trustee|secured_creditor — promote to reference product]. Valid values are `client|co-client|adverse_party|third_party_witness|guarantor|related_entity`',
    `search_index_included` BOOLEAN COMMENT 'Indicates whether this party role is included in the conflict search index. False for terminated roles or roles behind ethical walls.',
    `source_system` STRING COMMENT 'System of record from which this party role record originated. Intapp Conflicts is the primary system for conflict-domain data.. Valid values are `intapp_conflicts|elite_3e|manual_entry|lateral_hire_module|court_filing_import`',
    `source_system_code` STRING COMMENT 'Unique identifier of this party role record in the source system. Used for reconciliation and audit trail.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this party role record was last modified in the lakehouse. Audit trail for change tracking.',
    CONSTRAINT pk_matter_party_role PRIMARY KEY(`matter_party_role_id`)
) COMMENT 'Conflict-domain view of each partys role on a specific matter — client, co-client, adverse party, third-party witness, guarantor, related entity, or regulatory counterparty. Captures the role effective date, role end date, and the source of the role assignment (matter opening form, court filing, client disclosure). This entity populates and maintains the conflict search index by recording party-matter relationships as they are disclosed or discovered. The matter domain owns the canonical matter record; this product owns the conflict-specific role classification and temporal tracking needed for conflict screening.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` (
    `party_judge_appearance_id` BIGINT COMMENT 'Unique identifier for this party-judge appearance history record. Primary key for the association.',
    `conflict_party_id` BIGINT COMMENT 'Foreign key to conflict_party. Identifies which party appeared before the judge.',
    `judge_id` BIGINT COMMENT 'Foreign key to judge. Identifies the judicial officer before whom the party appeared.',
    `matter_id` BIGINT COMMENT 'Foreign key to matter.matter.matter_id',
    `appearance_count` STRING COMMENT 'Total number of times this party has appeared before this judge across all matters. Used to assess relationship strength and familiarity for conflict and recusal analysis.',
    `first_appearance_date` DATE COMMENT 'Date of the first recorded appearance of this party before this judge. Establishes the start of the relationship history for conflict screening purposes.',
    `last_appearance_date` DATE COMMENT 'Date of the most recent appearance of this party before this judge. Used to assess recency of relationship for conflict and recusal risk assessment.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this appearance history record. Used for data freshness tracking and conflict screening audit trails.',
    `matter_count` STRING COMMENT 'Number of distinct matters in which this party appeared before this judge. Distinct from appearance_count, which may include multiple appearances within the same matter.',
    `outcome_summary` STRING COMMENT 'High-level summary of outcomes when this party appeared before this judge (e.g., Favorable in 8 of 12 matters, Mixed outcomes). Used for litigation strategy and judicial relationship intelligence.',
    `party_role_in_appearances` STRING COMMENT 'The predominant role this party played when appearing before this judge. Client indicates the party was represented by the firm; Adverse_Party indicates opposition; Mixed indicates the party appeared in different roles across matters. Used for conflict and relationship risk assessment.',
    `recusal_date` DATE COMMENT 'Date of the most recent recusal by this judge involving this party. Null if no recusal history exists. Used for conflict screening and relationship intelligence.',
    `recusal_history_flag` BOOLEAN COMMENT 'Indicates whether this judge has ever recused themselves from a matter involving this party. True indicates recusal history exists, triggering additional conflict review for future matters.',
    `recusal_reason_notes` STRING COMMENT 'Free-text notes capturing the reason for recusal, if applicable. Used to inform future conflict assessments and lateral hire screening decisions.',
    `relationship_strength` STRING COMMENT 'Assessed strength of the party-judge relationship based on appearance frequency, recency, and matter significance. Values: Minimal (1-2 appearances), Low (3-5), Moderate (6-10), High (11-20), Very_High (20+). Used in conflict screening and lateral hire risk assessment.',
    `source_system` STRING COMMENT 'System of record from which this appearance history was derived (e.g., matter management system, court docket tracking, conflict database). Used for data lineage and audit purposes.',
    CONSTRAINT pk_party_judge_appearance PRIMARY KEY(`party_judge_appearance_id`)
) COMMENT 'This association product represents the appearance history between conflict parties and judges. It captures the operational record of which parties have appeared before which judges across matters, supporting conflict screening, recusal analysis, and litigation strategy intelligence. Each record links one conflict party to one judge with relationship metrics that exist only in the context of their appearance history.. Existence Justification: In legal practice, conflict parties (clients, adverse parties, related entities) appear before multiple judges across different matters over time, and judges preside over cases involving multiple parties. Law firms must track this appearance history to support conflict screening (ensuring no conflicts when taking on new matters), lateral hire screening (assessing whether a new attorney brings conflicts based on their prior party-judge relationships), and litigation strategy (understanding judicial familiarity and past outcomes with specific parties).';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` (
    `party_practice_conflict_id` BIGINT COMMENT 'Unique identifier for this party-practice area conflict relationship record. Primary key.',
    `conflict_party_id` BIGINT COMMENT 'Foreign key to conflict_party. Part of the composite business key.',
    `matter_id` BIGINT COMMENT 'Foreign key to matter.matter.matter_id',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to the practice area for which this partys conflict status applies.',
    `active_matter_count` STRING COMMENT 'The current count of active matters in this practice area involving this party (either as client or adverse). Used to assess the recency and intensity of the relationship.',
    `conflict_severity_level` STRING COMMENT 'The assessed severity of conflict for this party within this practice area. None indicates no conflict; low indicates minor relationship requiring disclosure; medium indicates conflict requiring waiver; high indicates serious conflict requiring senior partner approval; absolute indicates non-waivable conflict (e.g., direct adversity in ongoing litigation).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this party-practice area conflict relationship record was first created.',
    `historical_matter_count` STRING COMMENT 'The total historical count of all matters (active and closed) in this practice area involving this party. Provides context for the depth of the relationship.',
    `last_conflict_check_date` DATE COMMENT 'The date on which the most recent conflict check was performed for this party in this practice area. Updated each time a new matter intake or lateral hire triggers a conflict search involving this party-practice area combination.',
    `last_conflict_check_result` STRING COMMENT 'The outcome of the most recent conflict check. Clear indicates no conflict found; conflict_identified indicates a conflict was detected; waiver_required indicates client waiver is needed; escalation_required indicates the conflict requires conflicts committee review.',
    `last_modified_by` STRING COMMENT 'The user or system that last modified this party-practice area conflict relationship record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this party-practice area conflict relationship record was last modified.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about this partys conflict status in this practice area, such as specific matters of concern, ethical considerations, or conflicts committee decisions.',
    `relationship_end_date` DATE COMMENT 'The date on which this partys relationship with the firm in this practice area ended or was resolved. Null for ongoing relationships. For client relationships, typically the matter close date; for adverse relationships, the date the adversity was resolved or the matter concluded.',
    `relationship_start_date` DATE COMMENT 'The date on which this partys relationship with the firm in this practice area began. For client relationships, typically the date of the first engagement; for adverse relationships, the date the party was first identified as adverse in this practice area.',
    `relationship_type` STRING COMMENT 'The nature of the partys relationship to the firm within this specific practice area. Client indicates the party is or was a client for matters in this practice area; adverse indicates the party has been adverse to firm clients in this practice area; related_entity indicates affiliation with clients or adverse parties; neutral indicates no conflict identified; potential_conflict indicates a relationship requiring further review.',
    `waiver_expiration_date` DATE COMMENT 'The date on which the current conflict waiver expires, if applicable. Null if no waiver is on file or if the waiver has no expiration.',
    `waiver_on_file_flag` BOOLEAN COMMENT 'Indicates whether a signed conflict waiver is on file for this party in this practice area. True if a waiver has been obtained and is currently valid; false otherwise.',
    `created_by` STRING COMMENT 'The user or system that created this party-practice area conflict relationship record.',
    CONSTRAINT pk_party_practice_conflict PRIMARY KEY(`party_practice_conflict_id`)
) COMMENT 'This association product represents the practice-area-specific conflict relationship between a conflict party and a practice area. Legal firms must track conflict status at the granular level of each party-practice area combination because a single party may simultaneously be a client in one practice area (e.g., IP) while being adverse in another (e.g., litigation). Each record captures the conflict severity, relationship type (client/adverse/neutral), and temporal tracking of conflict checks specific to that party-practice area pairing.. Existence Justification: In legal practice, conflict checking must be performed at the granular level of each party-practice area combination because a single party can simultaneously hold different conflict statuses across practice areas. For example, a corporation may be a current client for IP matters while being adverse to another client in litigation, or a related entity in M&A while neutral in employment law. Law firms operationally manage these practice-area-specific conflict relationships as distinct records, each with its own severity assessment, relationship type, conflict check history, and waiver status.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` (
    `wall_enforcement_id` BIGINT COMMENT 'Primary key for the wall_enforcement association',
    `contract_agreement_id` BIGINT COMMENT 'Foreign key linking to the agreement subject to the ethical wall',
    `timekeeper_id` BIGINT COMMENT 'Foreign key to workforce.timekeeper.timekeeper_id',
    `ethical_wall_id` BIGINT COMMENT 'Foreign key linking to the ethical wall being enforced',
    `applicability_reason` STRING COMMENT 'Specific reason why this ethical wall applies to this particular agreement (e.g., Agreement involves former client of lateral hire, Counterparty is adverse party in screened matter)',
    `breach_count` STRING COMMENT 'Number of documented breach or violation incidents for this specific wall-agreement enforcement',
    `effective_date` DATE COMMENT 'Date on which this ethical wall enforcement became active for this specific agreement',
    `enforcement_status` STRING COMMENT 'Current status of the wall enforcement for this agreement (active, expired, dissolved, suspended)',
    `expiration_date` DATE COMMENT 'Date on which this ethical wall enforcement expired or was dissolved for this specific agreement',
    `last_review_date` DATE COMMENT 'Date on which this specific wall-agreement enforcement was last reviewed for continued necessity',
    `notification_date` DATE COMMENT 'Date on which notification of this wall enforcement was sent for this specific agreement',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether formal notification of this wall enforcement has been sent to affected parties for this agreement',
    CONSTRAINT pk_wall_enforcement PRIMARY KEY(`wall_enforcement_id`)
) COMMENT 'This association product represents the enforcement relationship between an ethical wall (information barrier) and a specific agreement. It captures the applicability of an ethical screen to a contract artifact, tracking when and why the wall applies to the agreement, enforcement status, and any breach incidents. Each record links one ethical wall to one agreement with attributes that exist only in the context of this enforcement relationship.. Existence Justification: In legal practice, one ethical wall can apply to multiple agreements when the conflict or screening trigger affects multiple contracts (e.g., a lateral hires former client has multiple active agreements with the firm). Conversely, one agreement can be subject to multiple ethical walls when different conflicts arise from different sources (e.g., multiple lateral hires with conflicts, or multiple adverse parties). The firm actively manages these enforcement relationships, tracking when each wall applies to each agreement, with specific applicability reasons, dates, and breach monitoring per wall-agreement pair.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`conflict`.`audit_session` (
    `audit_session_id` BIGINT COMMENT 'Primary key for audit_session',
    `user_id` BIGINT COMMENT 'Identifier of the user who made the final clearance decision.',
    `audit_escalated_to_user_id` BIGINT COMMENT 'Identifier of the user to whom the session was escalated.',
    `audit_initiated_by_user_id` BIGINT COMMENT 'Identifier of the user who initiated the audit session.',
    `audit_last_modified_by_user_id` BIGINT COMMENT 'Identifier of the user who last modified this audit session record.',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter associated with this audit session, if applicable.',
    `prior_audit_session_id` BIGINT COMMENT 'Self-referencing FK on audit_session (prior_audit_session_id)',
    `profile_id` BIGINT COMMENT 'Identifier of the client for whom the conflict screening or clearance is being performed.',
    `reviewer_user_id` BIGINT COMMENT 'Identifier of the user who reviewed the conflict screening results.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail logs for this session.',
    `clearance_decision` STRING COMMENT 'Final clearance decision resulting from the audit session workflow.',
    `clearance_decision_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance decision was made.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the audit session was completed or closed.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to this audit session based on sensitivity of information.',
    `conflict_description` STRING COMMENT 'Detailed description of any conflicts identified during the session, including nature and parties involved.',
    `conflict_detected_flag` BOOLEAN COMMENT 'Indicates whether a conflict of interest was detected during this audit session.',
    `conflict_rule_applied` STRING COMMENT 'The specific American Bar Association (ABA) Model Rule or custom conflict rule applied during this audit session.',
    `conflict_severity` STRING COMMENT 'Severity classification of any detected conflict, ranging from none to critical.',
    `conflicts_identified_count` STRING COMMENT 'Total number of conflicts identified during this audit session.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this audit session record was first created in the system.',
    `duration_seconds` STRING COMMENT 'Total duration of the audit session measured in seconds from initiation to completion.',
    `entities_screened_count` STRING COMMENT 'Total number of entities (clients, matters, parties) screened during this audit session.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the session results require escalation to senior management or ethics committee.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the session was escalated for higher-level review.',
    `ethical_wall_required_flag` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) is required as a result of this session.',
    `expiration_date` DATE COMMENT 'Date on which the audit session clearance or approval expires and requires renewal.',
    `firm_office_location` STRING COMMENT 'The firm office location where the audit session was initiated or primarily managed.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the audit session was first initiated by a user or system process.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this audit session record is currently active and valid.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO country code representing the legal jurisdiction under which this audit session is governed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this audit session record was last modified.',
    `mitigation_strategy` STRING COMMENT 'Description of the strategy or measures implemented to mitigate identified conflicts.',
    `practice_area` STRING COMMENT 'The legal practice area associated with this audit session (e.g., Corporate, Litigation, IP, Employment).',
    `relationship_mapping_performed_flag` BOOLEAN COMMENT 'Indicates whether relationship mapping analysis was performed during this audit session.',
    `review_notes` STRING COMMENT 'Confidential notes and comments recorded by the reviewer during the audit session review process.',
    `screening_scope` STRING COMMENT 'The organizational scope of the conflict screening performed in this session.',
    `session_identifier` STRING COMMENT 'Business-facing unique session identifier used for tracking and reference across conflict screening workflows.',
    `session_status` STRING COMMENT 'Current lifecycle state of the audit session within the conflict screening workflow.',
    `session_type` STRING COMMENT 'Classification of the audit session by its business purpose within the conflict management domain.',
    `source_system` STRING COMMENT 'The system of record or source from which this audit session was created or imported.',
    `source_system_session_code` STRING COMMENT 'The unique session identifier from the source system (e.g., Intapp Conflicts session ID).',
    CONSTRAINT pk_audit_session PRIMARY KEY(`audit_session_id`)
) COMMENT 'Master reference table for audit_session. Referenced by session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_conflict_exception_id` FOREIGN KEY (`conflict_exception_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_exception`(`conflict_exception_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm_v1`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_matched_conflict_party_id` FOREIGN KEY (`matched_conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_search_execution_id` FOREIGN KEY (`search_execution_id`) REFERENCES `legal_ecm_v1`.`conflict`.`search_execution`(`search_execution_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm_v1`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_to_search_execution_id` FOREIGN KEY (`to_search_execution_id`) REFERENCES `legal_ecm_v1`.`conflict`.`search_execution`(`search_execution_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_conflict_exception_id` FOREIGN KEY (`conflict_exception_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_exception`(`conflict_exception_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm_v1`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_search_execution_id` FOREIGN KEY (`search_execution_id`) REFERENCES `legal_ecm_v1`.`conflict`.`search_execution`(`search_execution_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_conflict_exception_id` FOREIGN KEY (`conflict_exception_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_exception`(`conflict_exception_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm_v1`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm_v1`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_to_clearance_id` FOREIGN KEY (`to_clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_clearance_id` FOREIGN KEY (`waiver_clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_lateral_screening_id` FOREIGN KEY (`lateral_screening_id`) REFERENCES `legal_ecm_v1`.`conflict`.`lateral_screening`(`lateral_screening_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_governing_clearance_id` FOREIGN KEY (`governing_clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_to_clearance_id` FOREIGN KEY (`to_clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_to_lateral_screening_id` FOREIGN KEY (`to_lateral_screening_id`) REFERENCES `legal_ecm_v1`.`conflict`.`lateral_screening`(`lateral_screening_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm_v1`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_tertiary_ethical_wall_id` FOREIGN KEY (`tertiary_ethical_wall_id`) REFERENCES `legal_ecm_v1`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_to_ethical_wall_id` FOREIGN KEY (`to_ethical_wall_id`) REFERENCES `legal_ecm_v1`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm_v1`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_source_conflict_party_id` FOREIGN KEY (`source_conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ADD CONSTRAINT `fk_conflict_party_alias_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ADD CONSTRAINT `fk_conflict_party_alias_primary_conflict_party_id` FOREIGN KEY (`primary_conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ADD CONSTRAINT `fk_conflict_conflict_exception_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm_v1`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_audit_session_id` FOREIGN KEY (`audit_session_id`) REFERENCES `legal_ecm_v1`.`conflict`.`audit_session`(`audit_session_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_conflict_exception_id` FOREIGN KEY (`conflict_exception_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_exception`(`conflict_exception_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm_v1`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_lateral_screening_id` FOREIGN KEY (`lateral_screening_id`) REFERENCES `legal_ecm_v1`.`conflict`.`lateral_screening`(`lateral_screening_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm_v1`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_waiver_id` FOREIGN KEY (`waiver_id`) REFERENCES `legal_ecm_v1`.`conflict`.`waiver`(`waiver_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ADD CONSTRAINT `fk_conflict_matter_party_role_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm_v1`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ADD CONSTRAINT `fk_conflict_matter_party_role_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ADD CONSTRAINT `fk_conflict_matter_party_role_primary_matter_conflict_party_id` FOREIGN KEY (`primary_matter_conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ADD CONSTRAINT `fk_conflict_matter_party_role_tertiary_matter_disclosed_by_party_conflict_party_id` FOREIGN KEY (`tertiary_matter_disclosed_by_party_conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ADD CONSTRAINT `fk_conflict_party_judge_appearance_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ADD CONSTRAINT `fk_conflict_party_practice_conflict_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ADD CONSTRAINT `fk_conflict_wall_enforcement_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm_v1`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_prior_audit_session_id` FOREIGN KEY (`prior_audit_session_id`) REFERENCES `legal_ecm_v1`.`conflict`.`audit_session`(`audit_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`conflict` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm_v1`.`conflict` SET TAGS ('dbx_domain' = 'conflict');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Ethics Partner ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `check_supervising_partner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `check_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `conflict_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Exception Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `primary_reviewer_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Reviewer ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `training_programme_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `actual_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Turnaround Hours');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Assigned Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Number');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = 'aba_rule_1_7_current_client|aba_rule_1_9_former_client|aba_rule_1_10_imputed_disqualification|lateral_hire|matter_opening|new_business_intake');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|rejected|pending_review|conditional_clearance|escalated|withdrawn');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Cleared Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `client_waiver_obtained` SET TAGS ('dbx_business_glossary_term' = 'Client Waiver Obtained Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `client_waiver_required` SET TAGS ('dbx_business_glossary_term' = 'Client Waiver Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `conflict_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|waived|ethical_wall_required|withdrawn');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `ethics_partner_disposition` SET TAGS ('dbx_business_glossary_term' = 'Ethics Partner Disposition');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `ethics_partner_disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|escalated|pending');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `ethics_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Ethics Partner Full Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `ethics_partner_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `ethics_partner_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Conflict Mitigation Measures');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `primary_reviewer_disposition` SET TAGS ('dbx_business_glossary_term' = 'Primary Reviewer Disposition');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `primary_reviewer_disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|escalated|pending');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `primary_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Reviewer Full Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `primary_reviewer_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `primary_reviewer_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Priority Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Rejected Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `requestor_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `requestor_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Full Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `requestor_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `requestor_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Reviewed Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Submitted Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `supervising_partner_disposition` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner Disposition');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `supervising_partner_disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|escalated|pending');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `supervising_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner Full Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `supervising_partner_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `supervising_partner_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ALTER COLUMN `waiver_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Obtained Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `aml_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Risk Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `reputational_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Flag Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `adverse_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `ccpa_subject_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Subject Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `conflict_search_indexed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Indexed Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `data_residency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `external_party_reference` SET TAGS ('dbx_business_glossary_term' = 'External Party Reference');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `gdpr_subject_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Subject Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'tax_id|company_registration|passport|national_id|duns_number|lei');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier Value');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `identifier_value` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `identifier_value` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation or Domicile');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `jurisdiction_of_primary_operations` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Primary Operations');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Completion Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|expired|waived');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_1` SET TAGS ('dbx_business_glossary_term' = 'Party Name Variant 1');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_1` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_2` SET TAGS ('dbx_business_glossary_term' = 'Party Name Variant 2');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_2` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_3` SET TAGS ('dbx_business_glossary_term' = 'Party Name Variant 3');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_3` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Party Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `parent_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `parent_entity_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Legal Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|dissolved|deceased');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `role_classification` SET TAGS ('dbx_business_glossary_term' = 'Party Role Classification');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `role_classification` SET TAGS ('dbx_value_regex' = 'client|adverse_party|related_entity|guarantor|beneficial_owner|witness');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'not_screened|clear|match_found|under_review');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'intapp_conflicts|elite_3e|crm|manual_entry|lateral_hire_screening');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `source_system_party_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Party Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `ultimate_beneficial_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO) Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `ultimate_beneficial_owner_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ALTER COLUMN `ultimate_beneficial_owner_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Search Execution Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By User ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `ethical_wall_consideration_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Consideration Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `exact_match_count` SET TAGS ('dbx_business_glossary_term' = 'Exact Match Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `fuzzy_match_applied` SET TAGS ('dbx_business_glossary_term' = 'Fuzzy Match Applied Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `fuzzy_match_count` SET TAGS ('dbx_business_glossary_term' = 'Fuzzy Match Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `fuzzy_match_threshold` SET TAGS ('dbx_business_glossary_term' = 'Fuzzy Match Threshold Percentage');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `hit_count` SET TAGS ('dbx_business_glossary_term' = 'Hit Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `include_former_names_flag` SET TAGS ('dbx_business_glossary_term' = 'Include Former Names Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `include_subsidiaries_flag` SET TAGS ('dbx_business_glossary_term' = 'Include Subsidiaries Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `industry_filter` SET TAGS ('dbx_business_glossary_term' = 'Industry Filter');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `jurisdiction_filter` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Filter');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `lateral_hire_screen_flag` SET TAGS ('dbx_business_glossary_term' = 'Lateral Hire Screen Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `phonetic_match_count` SET TAGS ('dbx_business_glossary_term' = 'Phonetic Match Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `phonetic_variant_applied` SET TAGS ('dbx_business_glossary_term' = 'Phonetic Variant Applied Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `practice_area_filter` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Filter');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `relationship_depth` SET TAGS ('dbx_business_glossary_term' = 'Relationship Depth');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Search Algorithm Version');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_duration_milliseconds` SET TAGS ('dbx_business_glossary_term' = 'Search Duration in Milliseconds');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Search Execution Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_parent_check` SET TAGS ('dbx_business_glossary_term' = 'Search Parent Check');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_result_hash` SET TAGS ('dbx_business_glossary_term' = 'Search Result Hash');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_scope` SET TAGS ('dbx_business_glossary_term' = 'Search Scope');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_scope` SET TAGS ('dbx_value_regex' = 'current_clients|former_clients|adverse_parties|all_parties|lateral_hire_screen');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_status` SET TAGS ('dbx_business_glossary_term' = 'Search Execution Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_status` SET TAGS ('dbx_value_regex' = 'completed|failed|timeout|cancelled');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_string` SET TAGS ('dbx_business_glossary_term' = 'Search String');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_type` SET TAGS ('dbx_business_glossary_term' = 'Search Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `search_type` SET TAGS ('dbx_value_regex' = 'individual|organization|matter|related_party|adverse_party|beneficial_owner');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ALTER COLUMN `to_conflict_check` SET TAGS ('dbx_business_glossary_term' = 'To Conflict Check');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `search_hit_id` SET TAGS ('dbx_business_glossary_term' = 'Search Hit Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Dpia Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Party ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Judge Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `judge_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matched_conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'To Matched Party');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Matter ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `search_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `to_search_execution_id` SET TAGS ('dbx_business_glossary_term' = 'To Search Execution Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `escalated_to_partner` SET TAGS ('dbx_business_glossary_term' = 'Escalated to Partner Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `hit_matched_party` SET TAGS ('dbx_business_glossary_term' = 'Hit Matched Party');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `hit_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Hit Sequence Number');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `hit_source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Hit Source Record ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `hit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Hit Source System');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `hit_source_system` SET TAGS ('dbx_value_regex' = 'intapp_conflicts|elite_3e|imanage|external_database|manual_entry');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `initial_assessment` SET TAGS ('dbx_business_glossary_term' = 'Initial Assessment');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `initial_assessment` SET TAGS ('dbx_value_regex' = 'potential_conflict|no_conflict|waivable|requires_review|false_positive');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `is_false_positive` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `lpp_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Risk Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `match_method` SET TAGS ('dbx_business_glossary_term' = 'Match Method');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matched_client_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Client Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matched_matter_description` SET TAGS ('dbx_business_glossary_term' = 'Matched Matter Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matched_party_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Party Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matter_close_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Close Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matter_open_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Open Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matter_status` SET TAGS ('dbx_business_glossary_term' = 'Matter Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `matter_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|archived');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `relationship_role` SET TAGS ('dbx_business_glossary_term' = 'Relationship Role');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `requires_waiver` SET TAGS ('dbx_business_glossary_term' = 'Requires Waiver Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|declined|waived|ethical_wall_established');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `responsible_attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `reviewed_by_attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Attorney Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `substantially_related_matter` SET TAGS ('dbx_business_glossary_term' = 'Substantially Related Matter Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ALTER COLUMN `waiver_obtained` SET TAGS ('dbx_business_glossary_term' = 'Waiver Obtained Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Check Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `clearance_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `clearance_responsible_party_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `clearance_reviewing_counsel_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Counsel ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `clearance_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Partner ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `conflict_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Exception Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `intake_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `search_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `adverse_party_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Party Identified Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `clearance_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Number');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending_review|cleared|cleared_with_conditions|declined_conflict_identified|deferred_pending_waiver|withdrawn');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `client_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `client_waiver_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Waiver Obtained Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `condition_due_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Due Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `condition_fulfilled_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Fulfilled Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `condition_fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Fulfillment Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `condition_fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|in_progress|fulfilled|overdue');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `conditions_imposed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditions Imposed Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `conflict_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reason');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `denial_reason` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `ethical_wall_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiry Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `for_check` SET TAGS ('dbx_business_glossary_term' = 'For Check');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `imputed_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Imputed Conflict Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `lateral_hire_screening_flag` SET TAGS ('dbx_business_glossary_term' = 'Lateral Hire Screening Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `matter_opened_flag` SET TAGS ('dbx_business_glossary_term' = 'Matter Opened Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Clearance Outcome');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|denied|deferred');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `periodic_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Periodic Review Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `relationship_mapping_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Relationship Mapping Completed Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Requested Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `scope_restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Restriction Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `scope_restriction_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `to_check` SET TAGS ('dbx_business_glossary_term' = 'To Check');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `waiver_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Waiver Document Reference');
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ALTER COLUMN `waiver_document_reference` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `conflict_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Exception Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Dpia Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `regulatory_return_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `to_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'To Clearance Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Partner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_conflicts_counsel_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Conflicts Counsel Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_subject_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_subject_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_subject_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Partner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `adverse_party_name` SET TAGS ('dbx_business_glossary_term' = 'Adverse Party Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `adverse_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `approval_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `conflict_nature_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Nature Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `conflict_nature_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `conflict_type` SET TAGS ('dbx_business_glossary_term' = 'Conflict Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `consent_document_path` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Path');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `consent_form_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `consent_form_type` SET TAGS ('dbx_value_regex' = 'written|verbal_confirmed_in_writing|electronic|implied|other');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `is_scope_limited` SET TAGS ('dbx_business_glossary_term' = 'Is Scope Limited Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `lpp_protected` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reference Number');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^WVR-[0-9]{6,10}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `scope_limitation_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Limitation Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `signatory_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `signatory_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `signatory_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `signatory_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `lateral_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Lateral Screening ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `governing_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Protected Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `regulatory_return_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `to_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'To Clearance Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `to_lateral_screening_id` SET TAGS ('dbx_business_glossary_term' = 'To Lateral Screening Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `training_programme_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `acknowledgment_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Completion Rate');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `adverse_party_name` SET TAGS ('dbx_business_glossary_term' = 'Adverse Party Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `adverse_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `breach_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `dissolution_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Approved By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `dissolution_reason` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Reason');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `elite_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Elite 3E Enforcement Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_value_regex' = 'system_access_control|physical_separation|document_restriction|communication_protocol|combined');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `imanage_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'iManage Enforcement Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|as_needed');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `scope_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `screened_timekeeper_count` SET TAGS ('dbx_business_glossary_term' = 'Screened Timekeeper Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `system_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'System Enforcement Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `triggering_reason` SET TAGS ('dbx_business_glossary_term' = 'Triggering Reason');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `triggering_reason` SET TAGS ('dbx_value_regex' = 'lateral_hire|former_client|adverse_party|regulatory_requirement|conflict_of_interest|other');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `triggering_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Triggering Reason Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `triggering_reason_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `wall_code` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `wall_name` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `wall_status` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `wall_status` SET TAGS ('dbx_value_regex' = 'active|expired|dissolved|suspended|pending');
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `wall_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Wall Membership ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `tertiary_ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Ethical Wall Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `tertiary_reviewed_by_partner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Partner ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `to_ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'To Ethical Wall Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `wall_last_modified_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `wall_last_modified_by_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `wall_last_modified_by_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `walled_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `walled_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `walled_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_value_regex' = 'full_block|document_block|matter_block|client_block|no_restriction');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `dms_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Enforcement Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `last_override_date` SET TAGS ('dbx_business_glossary_term' = 'Last Override Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'included|excluded|restricted|observer');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `override_count` SET TAGS ('dbx_business_glossary_term' = 'Override Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `override_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Permitted Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `practice_management_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Practice Management Enforcement Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'lateral_hire|conflict_of_interest|client_request|matter_sensitivity|regulatory_requirement|other');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `reason_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `review_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'continued|modified|terminated|escalated');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'intapp_conflicts|elite_3e|manual_entry|lateral_hire_system|other');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `lateral_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Lateral Screening ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Check Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `lateral_candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `lateral_last_modified_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `lateral_last_modified_by_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `lateral_last_modified_by_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Firm Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Judge Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `judge_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `screening_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Partner ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_email` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_full_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Full Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_full_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_full_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|pending');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `clearance_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `clearance_decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision Rationale');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `clearance_decision_rationale` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `client_consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Obtained Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `client_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `conflict_search_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Performed Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `conflict_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `conflict_severity_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|disqualifying');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `conflicts_committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Conflicts Committee Review Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `conflicts_committee_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflicts Committee Review Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `conflicts_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Conflicts Identified Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `data_privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Consent Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `ethical_wall_description` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `ethical_wall_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `ethical_wall_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `general_counsel_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'General Counsel (GC) Notification Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `lateral_parent_check` SET TAGS ('dbx_business_glossary_term' = 'Lateral Parent Check');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `matters_disclosed_count` SET TAGS ('dbx_business_glossary_term' = 'Matters Disclosed Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `parties_disclosed_count` SET TAGS ('dbx_business_glossary_term' = 'Parties Disclosed Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `prior_employment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Employment End Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `prior_employment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Employment Start Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `prior_firm_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Prior Firm Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `prior_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Prior Firm Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `prior_firm_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `prior_practice_group` SET TAGS ('dbx_business_glossary_term' = 'Prior Practice Group');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `prior_practice_group` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `proposed_office_location` SET TAGS ('dbx_business_glossary_term' = 'Proposed Office Location');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `proposed_practice_group` SET TAGS ('dbx_business_glossary_term' = 'Proposed Practice Group');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `questionnaire_received_date` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Received Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `questionnaire_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Sent Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `record_retention_date` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_business_glossary_term' = 'Screening Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `screening_number` SET TAGS ('dbx_business_glossary_term' = 'Lateral Screening Number');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `screening_number` SET TAGS ('dbx_value_regex' = '^LS-[0-9]{6,10}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_map_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Map ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Ownership Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party A ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `source_conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `adverse_party_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Party Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `conflict_expansion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Expansion Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `ethical_wall_applicable` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Applicable');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `lateral_hire_flag` SET TAGS ('dbx_business_glossary_term' = 'Lateral Hire Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_value_regex' = 'directional|bidirectional|hierarchical');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_party_a` SET TAGS ('dbx_business_glossary_term' = 'Relationship Party A');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_role_a` SET TAGS ('dbx_business_glossary_term' = 'Relationship Role A');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_role_b` SET TAGS ('dbx_business_glossary_term' = 'Relationship Role B');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_source` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_source` SET TAGS ('dbx_value_regex' = 'client_disclosure|public_registry|kyc_review|companies_house|aml_screening|manual_entry');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_verification|terminated');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'parent_subsidiary|affiliate|beneficial_ownership|joint_venture|adverse_party|corporate_family');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|disputed');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Verified Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `applies_to_lateral_hires` SET TAGS ('dbx_business_glossary_term' = 'Applies to Lateral Hires');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `applies_to_prospective_clients` SET TAGS ('dbx_business_glossary_term' = 'Applies to Prospective Clients');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `automated_check_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automated Check Enabled');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `check_logic_description` SET TAGS ('dbx_business_glossary_term' = 'Check Logic Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `citation` SET TAGS ('dbx_business_glossary_term' = 'Rule Citation');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `confidentiality_obligation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Obligation');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `confidentiality_obligation` SET TAGS ('dbx_value_regex' = 'Absolute|Qualified|Limited|None');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `conflict_type` SET TAGS ('dbx_business_glossary_term' = 'Conflict Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `conflict_type` SET TAGS ('dbx_value_regex' = 'Direct Adverse|Material Limitation|Positional|Transactional|Issue|Other');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `consent_form_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Required');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `disclosure_requirements` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Requirements');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `documentation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirements');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `is_waivable` SET TAGS ('dbx_business_glossary_term' = 'Is Waivable');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `lpp_protected` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipients');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Notification Required');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `related_rules` SET TAGS ('dbx_business_glossary_term' = 'Related Rules');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `requires_ethical_wall` SET TAGS ('dbx_business_glossary_term' = 'Requires Ethical Wall');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,50}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'Active|Superseded|Proposed|Withdrawn');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `screening_scope` SET TAGS ('dbx_business_glossary_term' = 'Screening Scope');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `screening_scope` SET TAGS ('dbx_value_regex' = 'Individual|Practice Group|Office|Firm-Wide|Not Applicable');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `waiver_conditions` SET TAGS ('dbx_business_glossary_term' = 'Waiver Conditions');
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `party_alias_id` SET TAGS ('dbx_business_glossary_term' = 'Party Alias Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `party_last_modified_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `party_last_modified_by_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `party_last_modified_by_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `primary_conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `alias_canonical_party` SET TAGS ('dbx_business_glossary_term' = 'Alias Canonical Party');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `alias_name` SET TAGS ('dbx_business_glossary_term' = 'Alias Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `alias_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `alias_source` SET TAGS ('dbx_business_glossary_term' = 'Alias Source');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `alias_source` SET TAGS ('dbx_value_regex' = 'client_disclosure|public_registry|prior_matter|lateral_hire_screening|third_party_database|manual_entry');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `alias_type` SET TAGS ('dbx_business_glossary_term' = 'Alias Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `alias_type` SET TAGS ('dbx_value_regex' = 'legal_name|former_name|trade_name|dba|transliteration|phonetic_variant');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `is_primary_alias` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Alias Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Alias Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `phonetic_encoding` SET TAGS ('dbx_business_glossary_term' = 'Phonetic Encoding');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `search_priority` SET TAGS ('dbx_business_glossary_term' = 'Search Priority');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|disputed');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `conflict_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Exception Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `approver_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `approving_authority` SET TAGS ('dbx_value_regex' = 'managing_partner|ethics_committee|general_counsel|conflicts_counsel|risk_management_committee');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `client_category` SET TAGS ('dbx_business_glossary_term' = 'Client Category');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `client_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Required');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `conflict_exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `conflict_exception_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_review|draft');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `exception_name` SET TAGS ('dbx_business_glossary_term' = 'Exception Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'pre_approved_engagement|standing_client_waiver|regulatory_safe_harbor|de_minimis_threshold|pro_bono_category|institutional_client_blanket');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `jurisdiction_covered` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Covered');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `mandatory_review_date` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Review Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `matter_type_covered` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Covered');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Notification Required');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `practice_group_covered` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Covered');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `scope_definition` SET TAGS ('dbx_business_glossary_term' = 'Scope Definition');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `audit_log_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `audit_actor_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Actor ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `audit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `conflict_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Exception Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `docket_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `lateral_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Lateral Screening Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `waiver_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `aba_ethics_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'ABA Ethics Audit Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `actor_name` SET TAGS ('dbx_business_glossary_term' = 'Actor Name');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `actor_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `actor_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'timekeeper|system|administrator');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `affected_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `audit_check_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Check Reference');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `data_residency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `data_residency_jurisdiction` SET TAGS ('dbx_value_regex' = 'USA|GBR|DEU|FRA|AUS|CAN');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `gdpr_data_subject_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Subject Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `hit_count` SET TAGS ('dbx_business_glossary_term' = 'Hit Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_dbx_pii_ip' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `legal_basis_for_processing` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `legal_basis_for_processing` SET TAGS ('dbx_value_regex' = 'legitimate_interest|legal_obligation|contract|consent');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `new_state` SET TAGS ('dbx_business_glossary_term' = 'New State');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `prior_state` SET TAGS ('dbx_business_glossary_term' = 'Prior State');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `professional_indemnity_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Relevant Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `reviewer_response` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Response');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `reviewer_response` SET TAGS ('dbx_value_regex' = 'no_conflict|potential_conflict|confirmed_conflict|requires_escalation');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `search_query_text` SET TAGS ('dbx_business_glossary_term' = 'Search Query Text');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `sra_accountability_flag` SET TAGS ('dbx_business_glossary_term' = 'SRA Accountability Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `matter_party_role_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Party Role ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lateral Hire Attorney ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `primary_matter_conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `tertiary_matter_disclosed_by_party_conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Disclosed By Party ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `approval_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `billing_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Responsibility Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|privileged|attorney_work_product');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `conflict_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `conflict_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `conflict_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|waived|declined|ethical_wall_required');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `conflict_waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Waiver Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `conflict_waiver_obtained` SET TAGS ('dbx_business_glossary_term' = 'Conflict Waiver Obtained Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `last_conflict_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Conflict Check Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `lateral_hire_flag` SET TAGS ('dbx_business_glossary_term' = 'Lateral Hire Screening Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `matter_opening_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Matter Opening Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `relationship_nature` SET TAGS ('dbx_business_glossary_term' = 'Relationship Nature Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Role Assignment Source');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_assignment_source` SET TAGS ('dbx_value_regex' = 'matter_opening_form|court_filing|client_disclosure|lateral_hire_screening|manual_entry|system_import');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Role Effective Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_end_date` SET TAGS ('dbx_business_glossary_term' = 'Role End Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_priority` SET TAGS ('dbx_business_glossary_term' = 'Role Priority Rank');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_clearance|terminated|conflicted_out');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Party Role Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'client|co-client|adverse_party|third_party_witness|guarantor|related_entity');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `search_index_included` SET TAGS ('dbx_business_glossary_term' = 'Search Index Included Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'intapp_conflicts|elite_3e|manual_entry|lateral_hire_module|court_filing_import');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `party_judge_appearance_id` SET TAGS ('dbx_business_glossary_term' = 'Party Judge Appearance Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Judge Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `appearance_count` SET TAGS ('dbx_business_glossary_term' = 'Appearance Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `first_appearance_date` SET TAGS ('dbx_business_glossary_term' = 'First Appearance Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `last_appearance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Appearance Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `matter_count` SET TAGS ('dbx_business_glossary_term' = 'Matter Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_business_glossary_term' = 'Outcome Summary');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `party_role_in_appearances` SET TAGS ('dbx_business_glossary_term' = 'Party Role in Appearances');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `recusal_date` SET TAGS ('dbx_business_glossary_term' = 'Recusal Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `recusal_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Recusal History Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `recusal_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Recusal Reason Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `party_practice_conflict_id` SET TAGS ('dbx_business_glossary_term' = 'Party Practice Conflict ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party ID');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Party Practice Conflict - Practice Area Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `active_matter_count` SET TAGS ('dbx_business_glossary_term' = 'Active Matter Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `conflict_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `historical_matter_count` SET TAGS ('dbx_business_glossary_term' = 'Historical Matter Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `last_conflict_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Conflict Check Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `last_conflict_check_result` SET TAGS ('dbx_business_glossary_term' = 'Last Conflict Check Result');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `waiver_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver On File Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `wall_enforcement_id` SET TAGS ('dbx_business_glossary_term' = 'Wall Enforcement - Wall Enforcement Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Wall Enforcement - Agreement Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Wall Enforcement - Ethical Wall Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `applicability_reason` SET TAGS ('dbx_business_glossary_term' = 'Wall Applicability Reason');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Effective Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Expiration Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Session Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker User Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_escalated_to_user_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To User Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_escalated_to_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_escalated_to_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_initiated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_initiated_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_initiated_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_last_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_last_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_last_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `prior_audit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Audit Session Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `prior_audit_session_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `reviewer_user_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User Id');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `reviewer_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `reviewer_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `clearance_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `conflict_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `conflict_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Detected Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `conflict_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Applied');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `conflicts_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Conflicts Identified Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `entities_screened_count` SET TAGS ('dbx_business_glossary_term' = 'Entities Screened Count');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `ethical_wall_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `firm_office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Initiated Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `relationship_mapping_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Relationship Mapping Performed Flag');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `review_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `screening_scope` SET TAGS ('dbx_business_glossary_term' = 'Screening Scope');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `session_identifier` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ALTER COLUMN `source_system_session_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Session Code');
