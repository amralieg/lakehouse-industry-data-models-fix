-- Schema for Domain: conflict | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`conflict` COMMENT 'Manages new business intake, conflict-of-interest screening, ethical wall configuration, and clearance workflows required before any matter may be opened. Integrates Intapp Conflicts as the system of record. Enforces ABA Rule 1.7/1.9/1.10 conflict rules, lateral hire screening, and relationship mapping to protect LPP and firm ethics obligations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`check` (
    `check_id` BIGINT COMMENT 'Unique identifier for the conflict-of-interest screening request. Primary key sourced from Intapp Conflicts system.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Conflict checks for new clients trigger AML/KYC program requirements (client due diligence). Conflict clearance is gated on completion of KYC checks per AML program. Links check to AML program.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: A conflict check triggers a formal risk assessment in legal practice. When a conflict is identified, the firm must assess severity and treatment options. Legal risk managers expect the check record to',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Firms run preliminary conflict checks at the engagement opportunity stage before a formal intake request is submitted. intake.engagement_opportunity has conflict_check_status and conflict_check_comple',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Client acceptance and conflicts-of-interest policies govern every conflict check — the policy defines screening scope, waiver conditions, and documentation requirements. Compliance officers and audito',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Conflict checks are initiated for a specific legal service engagement (legal_service.requires_conflict_check = true). Linking check to legal_service enables service-level conflict reporting, SLA bench',
    `matter_risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.matter_risk_profile. Business justification: The conflict check outcome directly populates the conflict_risk_level field on the matter risk profile. Legal risk managers expect the check to reference the matter risk profile so that conflict clear',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Foreign key linking to client.outside_counsel_guideline. Business justification: Conflict checks must verify OCG staffing restrictions and practice area limitations before clearance. Legal ops teams cross-reference the applicable OCG during conflict review to confirm no prohibited',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict checks apply practice-area-specific rules and sensitivity thresholds. Automated conflict screening systems filter rule sets by practice area. Essential for routing checks to appropriate ethic',
    `profile_id` BIGINT COMMENT 'Reference to the existing client entity involved in the conflict check, if the check relates to an existing client relationship.',
    `prospect_id` BIGINT COMMENT 'Reference to the prospective client entity being screened for conflicts during new business intake.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Conflict checks identifying material risks (adverse relationships, ethical concerns, waiver requirements) trigger risk register entries for ongoing monitoring. Standard conflict-to-risk escalation wor',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Conflict checks must verify compliance with specific regulatory obligations (SRA rules, ABA ethics rules). Clearance workflow references applicable obligations to determine waiver requirements and eth',
    `request_id` BIGINT COMMENT 'Reference to the new business intake request that triggered this conflict check, if applicable.',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: Firms run conflict checks before responding to RFPs to avoid committing resources to a pitch that will be blocked by conflicts. intake.rfp_submission has denormalized conflict_check_status and conflic',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Conflict checks have explicit SLA targets (sla_target_hours, sla_met_flag). These targets should be governed by the firms SLA templates. Linking check to sla_template enables template-driven turnarou',
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

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`conflict_party` (
    `conflict_party_id` BIGINT COMMENT 'Unique identifier for the conflict party record. Primary key for the conflict party registry. This is the system-generated identifier used internally for conflict search indexing and relationship mapping.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Conflict parties undergo AML/KYC screening under a specific program that determines risk methodology, documentation requirements, and screening scope. The party record must reference the governing AML',
    `individual_id` BIGINT COMMENT 'Foreign key linking to client.individual. Business justification: Lateral hire screening and individual client intake conflict checks require linking conflict parties to individual client records. Business process: when candidates disclose prior matters or when scre',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to client.kyc_record. Business justification: Conflict analysis requires AML/KYC status of identified parties — regulators require firms to screen conflict parties for AML risk. conflict_party.kyc_status and aml_risk_rating are denormalized from ',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Conflict clearance workflow requires linking conflict parties to client organisations for adverse representation checks, corporate hierarchy conflict analysis, and relationship mapping. When screening',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: A conflict party with elevated AML, sanctions, or PEP status generates a risk register entry for ongoing monitoring. Legal compliance teams track sanctioned or PEP-linked parties in the risk register ',
    `adverse_media_flag` BOOLEAN COMMENT 'Indicates whether adverse media (negative news coverage related to financial crime, corruption, fraud, or other reputational risk) has been identified for this party during due diligence. True indicates adverse media found, requiring risk assessment and potential escalation. False indicates no adverse media identified. Part of enhanced due diligence for high-risk parties.',
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
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this party record was most recently modified. Part of the audit trail for data lineage and compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `name_variant_1` STRING COMMENT 'First alternate name or alias for the party. Used to capture DBA (Doing Business As) names, trade names, former legal names, or common abbreviations. Critical for comprehensive conflict search coverage to ensure all name variations are indexed.',
    `name_variant_2` STRING COMMENT 'Second alternate name or alias for the party. Captures additional name variations such as translated names, historical names, or subsidiary brand names to ensure thorough conflict screening.',
    `name_variant_3` STRING COMMENT 'Third alternate name or alias for the party. Provides additional name variant coverage for complex entities with multiple operating names or jurisdictional variations.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the party, such as special conflict considerations, relationship history, or due diligence findings. Confidential due to potential inclusion of sensitive business information or attorney work product. Used by conflict analysts and intake teams for decision-making.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`search_execution` (
    `search_execution_id` BIGINT COMMENT 'Primary key for search_execution',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: AML/KYC search executions are conducted under a specific program that dictates algorithm version, jurisdiction filters, and screening scope. Regulatory audit trails require each search execution to di',
    `conflict_search_id` BIGINT COMMENT 'Foreign key linking to intake.conflict_search. Business justification: intake.conflict_search is the intake-side search request record; conflict.search_execution is the conflict-domain execution of that search. Linking them enables reconciliation between what intake requ',
    `check_id` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Each search execution belongs to exactly one conflict check. This is the header-to-line relationship that enables reconstructing the full search scope of a check.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Search executions are mandated by specific regulatory obligations (e.g., SRA Code of Conduct requiring conflict checks before engagement). Regulatory audit trails require each search execution to dire',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.request. Business justification: Conflict search executions are directly triggered by intake requests. Direct FK enables SLA reporting and audit traceability — which intake request spawned this search execution — without requiring ',
    `to_check_id` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Every search execution is spawned by a specific conflict check — this is the core parent-child relationship in the screening workflow. Without this FK, you cannot reconstruct which searches belong to ',
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
    `search_result_hash` STRING COMMENT 'Cryptographic hash of the search result set. Enables detection of result changes if the same search is re-executed later, supporting audit and change tracking.',
    `search_scope` STRING COMMENT 'Defines the population of records searched. Determines whether the search covers only current clients, includes former clients (for ABA Rule 1.9 successive representation conflicts), adverse parties, or all parties in the system.. Valid values are `current_clients|former_clients|adverse_parties|all_parties|lateral_hire_screen`',
    `search_status` STRING COMMENT 'The outcome status of the search execution. Completed indicates successful execution; failed/timeout/cancelled indicate technical issues requiring retry or escalation.. Valid values are `completed|failed|timeout|cancelled`',
    `search_string` STRING COMMENT 'The exact name or entity string submitted for conflict search. This is the raw input text used to query the conflict database for potential matches.',
    `search_type` STRING COMMENT 'The category of entity being searched. Determines which conflict rules and matching algorithms are applied.. Valid values are `individual|organization|matter|related_party|adverse_party|beneficial_owner`',
    `source_system_code` STRING COMMENT 'The unique identifier of this search execution record in the source system (Intapp Conflicts). Used for data lineage and reconciliation between the lakehouse and the operational system.',
    CONSTRAINT pk_search_execution PRIMARY KEY(`search_execution_id`)
) COMMENT 'Transactional record of each individual name or entity search executed within a conflict check. Captures the search string, phonetic and fuzzy-match variants applied, search algorithm version, number of hits returned, and the timestamp of execution. One conflict_check may spawn multiple search_execution records (one per party searched). Sourced from Intapp Conflicts search audit log. Note: the logical primary key is conflict_search_id; the physical PK conflict_conflict_search_id reflects the platform naming convention (domain prefix + product-derived name).';

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`search_hit` (
    `search_hit_id` BIGINT COMMENT 'Primary key for search_hit',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: A conflict search hit with high match confidence triggers a risk assessment to determine whether the conflict is material and what treatment is required. Legal risk teams link the hit to the assessmen',
    `conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — Each search hit identifies a matched party from the party index. This FK enables navigating from a hit to the full party record for review.',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links each conflict hit to the specific rule it potentially violates. search_hit currently has conflict_severity and initial_assessment but no reference to which rule is triggered. This FK enables rul',
    `ethical_wall_id` BIGINT COMMENT 'Reference to the ethical wall configuration established to address this conflict. Null if no ethical wall is required.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Search hits identify conflicts with existing litigation matters. Real process: hit analysis requires linking to the court docket for adverse party and relationship assessment. New attribute; matched_m',
    `judge_id` BIGINT COMMENT 'Foreign key linking to court.judge. Business justification: Conflict hits may identify prior appearances before the same judge. Real process: judicial relationship tracking for recusal analysis and strategic litigation planning. New attribute needed; no existi',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Search hits identify conflicts arising from prior representation on specific IP assets (firm prosecuted Patent A for Client X, now adverse party in litigation). Critical for IP conflict analysis and c',
    `matter_id` BIGINT COMMENT 'Reference to the matter or engagement where the conflicting relationship was found. May be null if the hit is based on party relationship only.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to ip.patent. Business justification: Patent conflict reporting requires direct access to patent-specific data (prosecution_status, patent_type, claims count) not available on ip_asset. When a conflict search hits a patent, attorneys need',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict hits are triaged and assessed based on practice area to determine severity and route to specialized reviewers. Practice area context drives conflict severity scoring and determines which ethi',
    `primary_search_conflict_party_id` BIGINT COMMENT 'Reference to the party record that matched the search criteria. Links to the intake_party product.',
    `search_execution_id` BIGINT COMMENT 'Reference to the parent conflict search that generated this hit. Links to the conflict_search product.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: A high-severity or unresolved conflict search hit is a risk event that must be logged in the risk register. Legal risk managers expect search hits above a severity threshold to generate risk register ',
    `to_conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — Each search hit references the matched party record from the conflict party index. Critical for resolving what entity was matched.',
    `to_search_execution_id` BIGINT COMMENT 'FK to conflict.search_execution.search_execution_id — Each hit is produced by a specific search execution. This is the fundamental lineage link from hit back to the search that produced it.',
    `assessment_notes` STRING COMMENT 'Free-text notes recorded by the reviewing attorney explaining the rationale for the initial assessment. Critical for audit trail and ethics compliance.',
    `conflict_severity` STRING COMMENT 'System-assigned severity level based on relationship type, matter status, and match confidence. High severity requires partner-level review.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this conflict hit record was first created in the system. Used for audit trail and SLA tracking.',
    `escalated_to_partner` BOOLEAN COMMENT 'Indicates whether this conflict hit has been escalated to a partner for senior-level review. Required for high-severity conflicts.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict hit was escalated to partner review. Null if not escalated.',
    `ethical_wall_required` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) must be established to mitigate the conflict under ABA Rule 1.10. Common for lateral hire conflicts.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`clearance` (
    `clearance_id` BIGINT COMMENT 'Unique identifier for the conflict clearance decision record. Primary key. Inferred role: TRANSACTION_HEADER (clearance is a discrete business event with a clear lifecycle: requested, reviewed, cleared/declined/deferred).',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Clearances for high-risk clients require enhanced due diligence per AML program. Clearance conditions include AML program compliance verification. Links clearance to AML program.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: A clearance decision (cleared, conditional, denied) is a direct input to the matter risk assessment. Legal risk managers conduct a risk assessment to evaluate residual risk after clearance conditions ',
    `check_id` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Each clearance decision concludes exactly one conflict check. This is the terminal state record for the check lifecycle.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Clearances are issued under specific compliance policies (client acceptance policy, conflicts policy) that define approval thresholds, conditions, and documentation requirements. Compliance reporting ',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links clearance decisions to the formal conflict rule they are based on. clearance currently has conflict_rule_basis (STRING) which is a free-text description. This FK normalizes to the authoritative ',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Business development teams track conflict clearance status per engagement opportunity to determine whether to proceed with pitching. Clearance is issued before a formal matter opens, often at the oppo',
    `engagement_scope_id` BIGINT COMMENT 'Foreign key linking to client.client_engagement_scope. Business justification: Clearance is granted within the bounds of a specific client engagement scope defining authorised practice areas, jurisdictions, and billing terms. Scope-limited clearances are standard legal risk mana',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: In transactional matters, a conflict clearance is required before an escrow arrangement can be established. Linking clearance to escrow_arrangement enables the firm to confirm that a valid clearance e',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to client.kyc_record. Business justification: Clearance decisions are conditioned on KYC/AML status in legal services — a matter cannot be cleared if KYC is incomplete or high-risk. Compliance teams must record which KYC record was reviewed when ',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Conflicts counsel frequently attach or reference engagement letters, scope limitation memos, or client correspondence when granting conditional clearances. This FK enables audit trail of the controlli',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: A clearance decision governs whether the firm may proceed with delivering a specific legal service. This link is essential for matter-opening workflows, service-level conflict dashboards, and regulato',
    `matter_id` BIGINT COMMENT 'Reference to the matter record in Elite 3E that was opened following clearance approval. Null if matter has not yet been opened or clearance was denied.',
    `matter_risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.matter_risk_profile. Business justification: A conditional or denied clearance changes the overall risk tier of the matter risk profile. Legal risk and intake teams require the clearance record to reference the matter risk profile so that matter',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Foreign key linking to client.outside_counsel_guideline. Business justification: At matter opening, clearance must document which OCG version governed staffing restrictions and rate caps applied to the cleared matter. This is a distinct audit requirement from check-level OCG revie',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Clearances often impose practice-area-specific scope restrictions and conditions. Ethical walls and engagement limitations are designed with practice area boundaries. Essential for clearance condition',
    `primary_clearance_check_id` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Each clearance decision is the terminal outcome of a conflict check. One-to-one or one-to-many relationship that gates matter opening.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Conflict clearances with conditions, ethical walls, or scope restrictions generate risk register entries for ongoing monitoring and periodic review. Standard conditional clearance risk tracking proces',
    `request_id` BIGINT COMMENT 'Reference to the new business intake request that requires clearance before matter opening.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Clearances impose asset-specific scope restrictions (approved for Trademark B prosecution but not Patent C due to adverse representation). Enables granular conflict management in IP portfolios with pa',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: Conflict clearance gates retainer agreement activation: firms must complete a conflict check before a retainer is established and trust funds received. Legal operations teams track which clearance aut',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to risk.risk_control. Business justification: A conditional clearance imposes specific risk controls (e.g., information barriers, scope restrictions) as conditions of proceeding. Legal risk and compliance teams track which risk control record gov',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.sar_filing. Business justification: Clearances involving parties with AML red flags may trigger SAR filings. Conflicts team escalates suspicious party relationships to MLRO for SAR consideration. Links clearance to SAR filing record.',
    `search_execution_id` BIGINT COMMENT 'Reference to the conflict search that triggered this clearance workflow. Links to the upstream conflict check process.',
    `to_check_id` BIGINT COMMENT 'FK to conflict.conflict_check.conflict_check_id — Every clearance decision is the terminal outcome of a conflict check. This is the most critical business relationship — clearance gates matter opening and must trace back to the check that produced it',
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
    `waiver_document_reference` STRING COMMENT 'Reference identifier or document management system (DMS) path to the signed client waiver or informed consent letter. Typically an iManage or NetDocuments document ID. Empty if no waiver required or not yet obtained.',
    CONSTRAINT pk_clearance PRIMARY KEY(`clearance_id`)
) COMMENT 'Formal clearance decision record issued at the conclusion of a conflict check workflow. Captures the clearance outcome (cleared, cleared with conditions, declined — conflict identified, deferred pending waiver), the authorizing partner or general counsel, the ABA rule basis for any identified conflict, and the date clearance was granted or denied. When conditions are imposed (e.g., mandatory ethical wall erection, restricted matter scope, required client notification, periodic review), each condition is recorded with its type, responsible party, due date, and fulfillment status directly on this record. This record gates matter opening in Elite 3E.';

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`waiver` (
    `waiver_id` BIGINT COMMENT 'Unique identifier for the conflict waiver record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: Conflict waivers are executed in the context of a specific engagement contract — the client consents to the firms dual representation under a particular contract. Ethics and compliance teams must lin',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: A conflict waiver represents accepted residual risk. Legal risk management requires a formal risk assessment before a waiver is approved, evaluating the risk of proceeding with the conflict. This link',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Client waivers are frequently asset-specific in IP practice (client waives conflict on Patent Family A but not Family B). Required for tracking granular consent scope in complex IP portfolios.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Waivers must comply with firm conflict of interest policy requirements. Waiver templates and approval workflows are defined in compliance policy. Links waiver to governing policy.',
    `conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — The waiver records which party (client) provided informed consent. Must FK to party to identify the consenting entity.',
    `rule_id` BIGINT COMMENT 'Foreign key linking to conflict.rule. Business justification: Links waivers to the formal ethical rule under which informed consent is granted. waiver currently has aba_rule_citation (STRING) which is free-text. This FK normalizes to the authoritative rule catal',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Conflict waivers in litigation contexts must reference the specific court case. Real process: waiver documentation identifies the docket for client consent records and regulatory audit. New attribute ',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: A waiver is required when a conflicted party is a beneficiary of an escrow arrangement. The waiver document governs the firms authority to hold and release escrow funds despite the conflict, and must',
    `ethical_wall_id` BIGINT COMMENT 'Reference to the ethical wall configuration established in connection with this waiver, if applicable.',
    `legal_document_id` BIGINT COMMENT 'Reference to the consent document stored in the Document Management System (DMS), typically iManage Work document ID.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: A conflict waiver is obtained specifically to permit delivery of a named legal service despite a conflict. This link supports waiver management workflows, service-level conflict disclosure reporting, ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: When a conflict arises from a license agreement (e.g., firm negotiated the license for licensor, now asked to represent licensee in a dispute), a waiver must be executed referencing that specific agre',
    `matter_id` BIGINT COMMENT 'Reference to the matter for which the conflict waiver was obtained.',
    `pi_claim_id` BIGINT COMMENT 'Foreign key linking to risk.pi_claim. Business justification: A conflict waiver is primary evidence in a professional indemnity claim if the conflict later materialises into a client complaint or claim. PI insurers and defence counsel require the waiver record t',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict waivers are practice-area-specific because waiver requirements and client consent standards vary significantly between litigation, transactional, and advisory work. Ethics committees assess w',
    `profile_id` BIGINT COMMENT 'Reference to the client who provided the informed consent waiver.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Client conflict waivers represent accepted risks (waived conflicts) that must be tracked for professional indemnity insurance, regulatory reporting, and periodic review. Standard waived conflict risk ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Waivers must cite specific regulatory framework under which consent is obtained (e.g., SRA Code Rule 6.2, ABA Model Rule 1.7). Required for audit trails and regulatory inspection. Waiver documentation',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.request. Business justification: Conflict waivers are obtained during the intake process in response to a specific intake request. Intake coordinators must track waiver status per request for matter opening approval. No existing FK l',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: A conflict waiver may be a condition precedent to maintaining a retainer arrangement where a conflict exists. Ethics audits require tracing which waiver authorized continued retention of client funds ',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to risk.risk_control. Business justification: A conflict waiver is often conditioned on specific risk controls remaining in place (e.g., information barriers, restricted access). Legal risk teams track which risk control record governs each waive',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Conflict waivers must be executed by an authorised client signatory. client_contact carries is_signatory and signatory_authority_level. waiver.signatory_name and signatory_email are denormalized repre',
    `contract_party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: A conflict waiver must be signed by an authorized representative who is a contract party. Linking to contract_party replaces denormalized signatory_name/email/title fields and enables compliance teams',
    `clearance_id` BIGINT COMMENT 'FK to conflict.clearance.clearance_id — A waiver is obtained in response to a conflict identified during clearance. The waiver record must link to the clearance that required it for audit trail completeness.',
    `waiver_clearance_id` BIGINT COMMENT 'FK to conflict.clearance.clearance_id — A waiver is obtained when clearance identifies a waivable conflict. The waiver must reference the clearance record that triggered the need for informed consent.',
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
    `waiver_status` STRING COMMENT 'Current lifecycle status of the waiver record. [ENUM-REF-CANDIDATE: draft|pending_review|approved|executed|declined|expired|revoked|superseded — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_waiver PRIMARY KEY(`waiver_id`)
) COMMENT 'Records informed consent waivers obtained from clients to permit representation despite an identified conflict of interest under ABA Rule 1.7(b). Captures the waiving client, the conflicted matter, the nature of the conflict disclosed, the form of consent (written, verbal with written confirmation), the consenting signatory, waiver execution date, and any scope limitations. Linked to the clearance record and stored in iManage Work.';

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`ethical_wall` (
    `ethical_wall_id` BIGINT COMMENT 'Unique identifier for the ethical wall (information barrier) record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Ethical walls enforce information barriers in practice management AND trust accounting systems. Screened timekeepers are blocked from viewing/transacting on trust accounts associated with walled matte',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: An ethical wall is a risk mitigation measure whose effectiveness must be formally assessed. Legal risk teams conduct periodic risk assessments to evaluate whether the wall adequately mitigates the ide',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Ethical wall protocols are defined in firm information security and conflicts policies. Wall establishment follows procedures in compliance policy. Links wall to governing policy.',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to risk.data_breach_incident. Business justification: A breach of an ethical wall constitutes a data breach incident under GDPR and SRA rules, as confidential client information is exposed. The ethical wall record must reference the resulting data breach',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Ethical walls restrict access to personal data and constitute a documented technical/organisational security measure under GDPR Article 32. The wall must reference the data privacy register entry cove',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: In M&A and dispute matters, ethical walls are erected around escrow arrangements to prevent conflicted attorneys from accessing escrow details or authorizing releases. Compliance teams must link the w',
    `clearance_id` BIGINT COMMENT 'FK to conflict.clearance.clearance_id — Ethical walls are erected as a condition of clearance. The wall must reference the clearance decision that mandated its creation.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Ethical walls are erected to permit delivery of a specific legal service despite an identified conflict. Linking ethical_wall to legal_service enables service-level wall reporting, enforcement configu',
    `matter_id` BIGINT COMMENT 'Identifier of the specific matter from which timekeepers are being screened by this ethical wall, if the wall is matter-specific.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Ethical walls are scoped to practice areas to prevent information flow within specific service lines. Practice management and document management systems enforce walls by filtering practice area acces',
    `primary_ethical_clearance_id` BIGINT COMMENT 'Identifier of the conflict clearance record that triggered the creation of this ethical wall, establishing audit trail linkage.',
    `profile_id` BIGINT COMMENT 'Identifier of the client whose matters or information are protected by this ethical wall, if the wall is client-specific.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Ethical walls erected around specific high-value IP assets (standard-essential patents, trade secrets from lateral hires prior firm). Essential for IP practice screening and information barrier enfor',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Ethical walls are risk mitigation controls; breaches, monitoring failures, or dissolution events are tracked in risk register. Standard information barrier control monitoring for regulatory compliance',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Ethical walls are mandated by specific regulatory obligations in many jurisdictions. Wall establishment documentation must cite regulatory authority (e.g., SRA guidance on information barriers). Requi',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to risk.risk_control. Business justification: Ethical walls are formal risk controls implementing information barriers. Mapped to risk control framework for ISO 27001 compliance, control effectiveness testing, and SOA documentation.',
    `to_clearance_id` BIGINT COMMENT 'FK to conflict.clearance.clearance_id — Ethical walls are triggered by clearance decisions with conditions. The description states it is linked to the clearance or lateral screening record.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`wall_membership` (
    `wall_membership_id` BIGINT COMMENT 'Unique identifier for the ethical wall membership record. Primary key.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Ethical wall membership requires attorneys to sign a formal acknowledgment document. wall_membership tracks acknowledgment_date and acknowledgment_required_flag but has no FK to the signed acknowledgm',
    `ethical_wall_id` BIGINT COMMENT 'Reference to the ethical wall (information barrier) to which this membership record applies. Links to the ethical_wall product.',
    `tertiary_ethical_wall_id` BIGINT COMMENT 'FK to conflict.ethical_wall.ethical_wall_id — Each wall membership record belongs to exactly one ethical wall. This is the master-detail relationship enabling wall enforcement.',
    `to_ethical_wall_id` BIGINT COMMENT 'FK to conflict.ethical_wall.ethical_wall_id — Each wall membership record belongs to a specific ethical wall. This is the classic header-line relationship for screen enforcement.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`rule` (
    `rule_id` BIGINT COMMENT 'Primary key for rule',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.category. Business justification: Each conflict rule (concurrent conflict, former client, positional conflict) belongs to a risk category that governs risk appetite thresholds and escalation levels. Legal risk frameworks map conflict ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Conflict rules are established by and derive authority from compliance policies (e.g., the firms conflicts-of-interest policy creates specific screening rules). Policy management and rule governance ',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Conflict rules are frequently scoped to specific legal services (e.g., concurrent-representation prohibition applies only to M&A advisory). Linking rule to legal_service enables service-specific confl',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict rules apply different thresholds and requirements by practice area (e.g., litigation adverse-party rules vs transactional same-side rules). Automated conflict checking engines apply practice-',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Conflict rules implement specific regulatory obligations (e.g., SRA rule 6.2 on conflicts maps to internal conflict rule CON-001). Conflict rule library is mapped to regulatory obligations for complia',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to risk.risk_control. Business justification: A conflict rule prescribes specific risk controls — a rule requiring an ethical wall or mandatory disclosure maps to a risk control record. Legal compliance teams use this link to verify that required',
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

CREATE OR REPLACE TABLE `legal_ecm`.`conflict`.`party_alias` (
    `party_alias_id` BIGINT COMMENT 'Unique identifier for the party alias record. Primary key.',
    `conflict_party_id` BIGINT COMMENT 'Foreign key reference to the canonical conflict_party record to which this alias belongs. Links the alias to the authoritative party entity in the conflict search universe.',
    `tertiary_conflict_party_id` BIGINT COMMENT 'FK to conflict.party.party_id — Each alias record links to its canonical party record. This FK is essential for the fuzzy matching engine to resolve aliases back to the master party.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_to_check_id` FOREIGN KEY (`to_check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_primary_search_conflict_party_id` FOREIGN KEY (`primary_search_conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_search_execution_id` FOREIGN KEY (`search_execution_id`) REFERENCES `legal_ecm`.`conflict`.`search_execution`(`search_execution_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_to_conflict_party_id` FOREIGN KEY (`to_conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_to_search_execution_id` FOREIGN KEY (`to_search_execution_id`) REFERENCES `legal_ecm`.`conflict`.`search_execution`(`search_execution_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_primary_clearance_check_id` FOREIGN KEY (`primary_clearance_check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_search_execution_id` FOREIGN KEY (`search_execution_id`) REFERENCES `legal_ecm`.`conflict`.`search_execution`(`search_execution_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_to_check_id` FOREIGN KEY (`to_check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm`.`conflict`.`rule`(`rule_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_clearance_id` FOREIGN KEY (`waiver_clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_primary_ethical_clearance_id` FOREIGN KEY (`primary_ethical_clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_to_clearance_id` FOREIGN KEY (`to_clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_tertiary_ethical_wall_id` FOREIGN KEY (`tertiary_ethical_wall_id`) REFERENCES `legal_ecm`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_to_ethical_wall_id` FOREIGN KEY (`to_ethical_wall_id`) REFERENCES `legal_ecm`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ADD CONSTRAINT `fk_conflict_party_alias_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ADD CONSTRAINT `fk_conflict_party_alias_tertiary_conflict_party_id` FOREIGN KEY (`tertiary_conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`conflict` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm`.`conflict` SET TAGS ('dbx_domain' = 'conflict');
ALTER TABLE `legal_ecm`.`conflict`.`check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`conflict`.`check` SET TAGS ('dbx_subdomain' = 'conflict_screening');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check ID');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `matter_risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request ID');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `actual_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Turnaround Hours');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Assigned Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Number');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Type');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = 'aba_rule_1_7_current_client|aba_rule_1_9_former_client|aba_rule_1_10_imputed_disqualification|lateral_hire|matter_opening|new_business_intake');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance Status');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|rejected|pending_review|conditional_clearance|escalated|withdrawn');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Cleared Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `client_waiver_obtained` SET TAGS ('dbx_business_glossary_term' = 'Client Waiver Obtained Flag');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `client_waiver_required` SET TAGS ('dbx_business_glossary_term' = 'Client Waiver Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `conflict_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity Level');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|waived|ethical_wall_required|withdrawn');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `ethics_partner_disposition` SET TAGS ('dbx_business_glossary_term' = 'Ethics Partner Disposition');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `ethics_partner_disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|escalated|pending');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `ethics_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Ethics Partner Full Name');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `ethics_partner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `ethics_partner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Conflict Mitigation Measures');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `primary_reviewer_disposition` SET TAGS ('dbx_business_glossary_term' = 'Primary Reviewer Disposition');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `primary_reviewer_disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|escalated|pending');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `primary_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Reviewer Full Name');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `primary_reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `primary_reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Priority Level');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Rejected Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Full Name');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Reviewed Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Submitted Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `supervising_partner_disposition` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner Disposition');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `supervising_partner_disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|escalated|pending');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `supervising_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner Full Name');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `supervising_partner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `supervising_partner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Description');
ALTER TABLE `legal_ecm`.`conflict`.`check` ALTER COLUMN `waiver_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Obtained Date');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` SET TAGS ('dbx_subdomain' = 'party_registry');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `adverse_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Flag');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `ccpa_subject_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Subject Flag');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `conflict_search_indexed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Indexed Flag');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `data_residency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Jurisdiction');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `external_party_reference` SET TAGS ('dbx_business_glossary_term' = 'External Party Reference');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `gdpr_subject_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Subject Flag');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier Type');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'tax_id|company_registration|passport|national_id|duns_number|lei');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier Value');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `identifier_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `identifier_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation or Domicile');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `jurisdiction_of_primary_operations` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Primary Operations');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Completion Date');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_1` SET TAGS ('dbx_business_glossary_term' = 'Party Name Variant 1');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_2` SET TAGS ('dbx_business_glossary_term' = 'Party Name Variant 2');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_3` SET TAGS ('dbx_business_glossary_term' = 'Party Name Variant 3');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `name_variant_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Party Notes');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Legal Name');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|dissolved|deceased');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `role_classification` SET TAGS ('dbx_business_glossary_term' = 'Party Role Classification');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `role_classification` SET TAGS ('dbx_value_regex' = 'client|adverse_party|related_entity|guarantor|beneficial_owner|witness');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'not_screened|clear|match_found|under_review');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'intapp_conflicts|elite_3e|crm|manual_entry|lateral_hire_screening');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `source_system_party_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Party Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `ultimate_beneficial_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Beneficial Owner (UBO) Name');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `ultimate_beneficial_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ALTER COLUMN `ultimate_beneficial_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` SET TAGS ('dbx_subdomain' = 'conflict_screening');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Search Execution Identifier');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `conflict_search_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `ethical_wall_consideration_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Consideration Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `exact_match_count` SET TAGS ('dbx_business_glossary_term' = 'Exact Match Count');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `fuzzy_match_applied` SET TAGS ('dbx_business_glossary_term' = 'Fuzzy Match Applied Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `fuzzy_match_count` SET TAGS ('dbx_business_glossary_term' = 'Fuzzy Match Count');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `fuzzy_match_threshold` SET TAGS ('dbx_business_glossary_term' = 'Fuzzy Match Threshold Percentage');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `hit_count` SET TAGS ('dbx_business_glossary_term' = 'Hit Count');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `include_former_names_flag` SET TAGS ('dbx_business_glossary_term' = 'Include Former Names Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `include_subsidiaries_flag` SET TAGS ('dbx_business_glossary_term' = 'Include Subsidiaries Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `industry_filter` SET TAGS ('dbx_business_glossary_term' = 'Industry Filter');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `jurisdiction_filter` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Filter');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `lateral_hire_screen_flag` SET TAGS ('dbx_business_glossary_term' = 'Lateral Hire Screen Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `phonetic_match_count` SET TAGS ('dbx_business_glossary_term' = 'Phonetic Match Count');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `phonetic_variant_applied` SET TAGS ('dbx_business_glossary_term' = 'Phonetic Variant Applied Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `practice_area_filter` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Filter');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `relationship_depth` SET TAGS ('dbx_business_glossary_term' = 'Relationship Depth');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Search Algorithm Version');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_duration_milliseconds` SET TAGS ('dbx_business_glossary_term' = 'Search Duration in Milliseconds');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Search Execution Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_result_hash` SET TAGS ('dbx_business_glossary_term' = 'Search Result Hash');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_scope` SET TAGS ('dbx_business_glossary_term' = 'Search Scope');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_scope` SET TAGS ('dbx_value_regex' = 'current_clients|former_clients|adverse_parties|all_parties|lateral_hire_screen');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_status` SET TAGS ('dbx_business_glossary_term' = 'Search Execution Status');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_status` SET TAGS ('dbx_value_regex' = 'completed|failed|timeout|cancelled');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_string` SET TAGS ('dbx_business_glossary_term' = 'Search String');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_type` SET TAGS ('dbx_business_glossary_term' = 'Search Type');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `search_type` SET TAGS ('dbx_value_regex' = 'individual|organization|matter|related_party|adverse_party|beneficial_owner');
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` SET TAGS ('dbx_subdomain' = 'conflict_screening');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `search_hit_id` SET TAGS ('dbx_business_glossary_term' = 'Search Hit Identifier');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall ID');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Hit Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Judge Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Matter ID');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Patent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `primary_search_conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Party ID');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `search_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search ID');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `escalated_to_partner` SET TAGS ('dbx_business_glossary_term' = 'Escalated to Partner Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `hit_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Hit Sequence Number');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `hit_source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Hit Source Record ID');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `hit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Hit Source System');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `hit_source_system` SET TAGS ('dbx_value_regex' = 'intapp_conflicts|elite_3e|imanage|external_database|manual_entry');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `initial_assessment` SET TAGS ('dbx_business_glossary_term' = 'Initial Assessment');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `initial_assessment` SET TAGS ('dbx_value_regex' = 'potential_conflict|no_conflict|waivable|requires_review|false_positive');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `is_false_positive` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `lpp_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Risk Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `match_method` SET TAGS ('dbx_business_glossary_term' = 'Match Method');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `matched_client_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Client Name');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `matched_matter_description` SET TAGS ('dbx_business_glossary_term' = 'Matched Matter Description');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `matched_party_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Party Name');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `matter_close_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Close Date');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `matter_open_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Open Date');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `matter_status` SET TAGS ('dbx_business_glossary_term' = 'Matter Status');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `matter_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|archived');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `relationship_role` SET TAGS ('dbx_business_glossary_term' = 'Relationship Role');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `requires_waiver` SET TAGS ('dbx_business_glossary_term' = 'Requires Waiver Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|declined|waived|ethical_wall_established');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `responsible_attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Name');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `reviewed_by_attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Attorney Name');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `substantially_related_matter` SET TAGS ('dbx_business_glossary_term' = 'Substantially Related Matter Flag');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ALTER COLUMN `waiver_obtained` SET TAGS ('dbx_business_glossary_term' = 'Waiver Obtained Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` SET TAGS ('dbx_subdomain' = 'conflict_screening');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance ID');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `engagement_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Client Engagement Scope Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `matter_risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request ID');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `search_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search ID');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `adverse_party_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Party Identified Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `clearance_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Number');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending_review|cleared|cleared_with_conditions|declined_conflict_identified|deferred_pending_waiver|withdrawn');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `client_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `client_waiver_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Waiver Obtained Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `condition_due_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Due Date');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `condition_fulfilled_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Fulfilled Date');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `condition_fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Fulfillment Status');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `condition_fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|in_progress|fulfilled|overdue');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `conditions_imposed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditions Imposed Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `conflict_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision Date');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reason');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `denial_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `ethical_wall_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiry Date');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `imputed_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Imputed Conflict Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `lateral_hire_screening_flag` SET TAGS ('dbx_business_glossary_term' = 'Lateral Hire Screening Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `matter_opened_flag` SET TAGS ('dbx_business_glossary_term' = 'Matter Opened Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Clearance Outcome');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|denied|deferred');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `periodic_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Periodic Review Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `relationship_mapping_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Relationship Mapping Completed Flag');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Requested Date');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `scope_restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Restriction Description');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `scope_restriction_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `waiver_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Waiver Document Reference');
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ALTER COLUMN `waiver_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` SET TAGS ('dbx_subdomain' = 'conflict_screening');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `waiver_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `pi_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pi Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Signing Contract Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `adverse_party_name` SET TAGS ('dbx_business_glossary_term' = 'Adverse Party Name');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `adverse_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `approval_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `conflict_nature_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Nature Description');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `conflict_nature_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `conflict_type` SET TAGS ('dbx_business_glossary_term' = 'Conflict Type');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `consent_document_path` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Path');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `consent_form_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Type');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `consent_form_type` SET TAGS ('dbx_value_regex' = 'written|verbal_confirmed_in_writing|electronic|implied|other');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `is_scope_limited` SET TAGS ('dbx_business_glossary_term' = 'Is Scope Limited Flag');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `lpp_protected` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected Flag');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reference Number');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^WVR-[0-9]{6,10}$');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `scope_limitation_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Limitation Description');
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` SET TAGS ('dbx_subdomain' = 'party_registry');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall ID');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `primary_ethical_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance ID');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Protected Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `acknowledgment_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Completion Rate');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `adverse_party_name` SET TAGS ('dbx_business_glossary_term' = 'Adverse Party Name');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `adverse_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `breach_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Count');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `dissolution_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Approved By');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `dissolution_reason` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Reason');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `elite_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Elite 3E Enforcement Flag');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_value_regex' = 'system_access_control|physical_separation|document_restriction|communication_protocol|combined');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `imanage_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'iManage Enforcement Flag');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|as_needed');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `scope_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `screened_timekeeper_count` SET TAGS ('dbx_business_glossary_term' = 'Screened Timekeeper Count');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `system_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'System Enforcement Flag');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `triggering_reason` SET TAGS ('dbx_business_glossary_term' = 'Triggering Reason');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `triggering_reason` SET TAGS ('dbx_value_regex' = 'lateral_hire|former_client|adverse_party|regulatory_requirement|conflict_of_interest|other');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `triggering_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Triggering Reason Description');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `triggering_reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `wall_code` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Code');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `wall_name` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Name');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `wall_status` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Status');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `wall_status` SET TAGS ('dbx_value_regex' = 'active|expired|dissolved|suspended|pending');
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` SET TAGS ('dbx_subdomain' = 'party_registry');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `wall_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Wall Membership ID');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `ethical_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall ID');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_value_regex' = 'full_block|document_block|matter_block|client_block|no_restriction');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `dms_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Enforcement Flag');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `last_override_date` SET TAGS ('dbx_business_glossary_term' = 'Last Override Date');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'included|excluded|restricted|observer');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `override_count` SET TAGS ('dbx_business_glossary_term' = 'Override Count');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `override_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Permitted Flag');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `practice_management_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Practice Management Enforcement Flag');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'lateral_hire|conflict_of_interest|client_request|matter_sensitivity|regulatory_requirement|other');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'continued|modified|terminated|escalated');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'intapp_conflicts|elite_3e|manual_entry|lateral_hire_system|other');
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm`.`conflict`.`rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm`.`conflict`.`rule` SET TAGS ('dbx_subdomain' = 'party_registry');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Identifier');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `applies_to_lateral_hires` SET TAGS ('dbx_business_glossary_term' = 'Applies to Lateral Hires');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `applies_to_prospective_clients` SET TAGS ('dbx_business_glossary_term' = 'Applies to Prospective Clients');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `automated_check_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automated Check Enabled');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `check_logic_description` SET TAGS ('dbx_business_glossary_term' = 'Check Logic Description');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `citation` SET TAGS ('dbx_business_glossary_term' = 'Rule Citation');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `confidentiality_obligation` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Obligation');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `confidentiality_obligation` SET TAGS ('dbx_value_regex' = 'Absolute|Qualified|Limited|None');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `conflict_type` SET TAGS ('dbx_business_glossary_term' = 'Conflict Type');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `conflict_type` SET TAGS ('dbx_value_regex' = 'Direct Adverse|Material Limitation|Positional|Transactional|Issue|Other');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `consent_form_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Required');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `disclosure_requirements` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Requirements');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `documentation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirements');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `is_waivable` SET TAGS ('dbx_business_glossary_term' = 'Is Waivable');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `lpp_protected` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipients');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Notification Required');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `requires_ethical_wall` SET TAGS ('dbx_business_glossary_term' = 'Requires Ethical Wall');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,50}$');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'Active|Superseded|Proposed|Withdrawn');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `screening_scope` SET TAGS ('dbx_business_glossary_term' = 'Screening Scope');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `screening_scope` SET TAGS ('dbx_value_regex' = 'Individual|Practice Group|Office|Firm-Wide|Not Applicable');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `waiver_conditions` SET TAGS ('dbx_business_glossary_term' = 'Waiver Conditions');
ALTER TABLE `legal_ecm`.`conflict`.`rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` SET TAGS ('dbx_subdomain' = 'party_registry');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `party_alias_id` SET TAGS ('dbx_business_glossary_term' = 'Party Alias Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `conflict_party_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Party Identifier (ID)');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `alias_name` SET TAGS ('dbx_business_glossary_term' = 'Alias Name');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `alias_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `alias_source` SET TAGS ('dbx_business_glossary_term' = 'Alias Source');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `alias_source` SET TAGS ('dbx_value_regex' = 'client_disclosure|public_registry|prior_matter|lateral_hire_screening|third_party_database|manual_entry');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `alias_type` SET TAGS ('dbx_business_glossary_term' = 'Alias Type');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `alias_type` SET TAGS ('dbx_value_regex' = 'legal_name|former_name|trade_name|dba|transliteration|phonetic_variant');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `is_primary_alias` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Alias Flag');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Alias Notes');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `phonetic_encoding` SET TAGS ('dbx_business_glossary_term' = 'Phonetic Encoding');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `search_priority` SET TAGS ('dbx_business_glossary_term' = 'Search Priority');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|disputed');
