-- Schema for Domain: care | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-23 01:34:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`care` COMMENT 'Manages care management, disease management, and case management programs — chronic condition registries, care gaps, care plans, population health stratification, high-risk member outreach, and health risk assessments (HRA). Owns HCC/RAF-relevant clinical data, HEDIS measure tracking, CAHPS survey results, SNF/DME post-acute coordination, and care coordinator assignments. Source system: Casenet TruCare or Altruista. Distinct from utilization which owns UM/PA authorization workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program` (
    `program_id` BIGINT COMMENT 'System-generated unique identifier for the care program.',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: Care programs are operationally created and governed by VBC contracts — the VBC contract defines quality targets, HEDIS measure requirements, and performance benchmarks that the care program must exec',
    `accreditation_body` STRING COMMENT 'Organization that provides accreditation for the program.',
    `accreditation_status` STRING COMMENT 'Current accreditation state of the program (e.g., NCQA, URAC).. Valid values are `accredited|pending|denied`',
    `program_category` STRING COMMENT 'More granular category within the program type (e.g., diabetes, CHF, COPD).',
    `clinical_protocol` STRING COMMENT 'Standardized clinical pathway or guideline applied within the program.',
    `program_code` STRING COMMENT 'Internal code used to reference the program in operational systems.',
    `contact_email` STRING COMMENT 'Primary email address for program inquiries.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for program inquiries.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the program record was first created.',
    `data_source_system` STRING COMMENT 'Operational system that provides the master program data (e.g., Casenet TruCare).',
    `program_description` STRING COMMENT 'Detailed narrative describing the programs purpose, services, and scope.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine member eligibility for enrollment in the program.',
    `end_date` DATE COMMENT 'Date the program is retired or no longer offered (nullable for open‑ended).',
    `enrollment_cap` BIGINT COMMENT 'Maximum number of members allowed to enroll in the program.',
    `enrollment_current` BIGINT COMMENT 'Number of members currently enrolled.',
    `enrollment_end_date` DATE COMMENT 'Date when enrollment closes for the program.',
    `enrollment_start_date` DATE COMMENT 'Date when enrollment opens for the program.',
    `evidence_source` STRING COMMENT 'Reference to the clinical study or guideline that validates the program.',
    `hcc_included` STRING COMMENT 'Comma‑separated list of HCC codes that are counted toward the programs risk adjustment.',
    `hcc_version` STRING COMMENT 'Version of the HCC model used for the program (e.g., 2024).',
    `is_evidence_based` BOOLEAN COMMENT 'Indicates whether the program is supported by clinical evidence.',
    `last_review_date` DATE COMMENT 'Date the program was last reviewed for clinical relevance or compliance.',
    `program_name` STRING COMMENT 'Human‑readable name of the care program.',
    `outcome_actual` STRING COMMENT 'Most recent observed value for the outcome measure.',
    `outcome_measure` STRING COMMENT 'Key performance indicator used to evaluate program effectiveness.',
    `outcome_target` STRING COMMENT 'Target value or threshold for the outcome measure.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|suspended|retired|draft`',
    `program_type` STRING COMMENT 'Broad classification of the program offering.. Valid values are `disease_management|case_management|maternity|behavioral_health|wellness|chronic_care`',
    `review_frequency` STRING COMMENT 'How often the program is scheduled for review.. Valid values are `annual|biennial|quarterly|monthly|semiannual`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk‑adjusted payment calculations (e.g., 0.1234).',
    `start_date` DATE COMMENT 'Date the program becomes effective and available to members.',
    `target_population` STRING COMMENT 'Demographic or clinical segment the program is designed for.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the program record.',
    `version_number` STRING COMMENT 'Version identifier for the program definition.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master registry of all care management, disease management, and case management programs offered by the health plan — including chronic condition programs (diabetes, CHF, COPD, asthma), complex case management, maternity management, behavioral health programs, and population health initiatives. Tracks program type, eligibility criteria, clinical protocols, accreditation standards (NCQA/URAC), program status, and line-of-business applicability. Source: Casenet TruCare or Altruista program configuration. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` (
    `care_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for each care enrollment record.',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Member enrollment in care programs under capitation models must be linked to the capitation arrangement for PMPM payment reconciliation, attributed member count tracking, and RAF adjustment. Capitatio',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to the member for this enrollment.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Care program enrollment eligibility is policy-dependent. Care managers must confirm active coverage and benefit limits under a specific policy when enrolling members in disease/case management program',
    `program_id` BIGINT COMMENT 'Identifier of the care, disease, or case management program to which the member is enrolled.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Care management enrollment is triggered by or attributed to a PCP or specialist. Provider-level enrollment reporting, referral tracking, and value-based care performance measurement require linking ea',
    `acuity_level` STRING COMMENT 'Clinical acuity assigned to the member for this program.. Valid values are `low|moderate|high|critical`',
    `care_manager_assigned_date` DATE COMMENT 'Date the care manager was officially assigned to the member.',
    `consent_status` STRING COMMENT 'Members consent status for participation and data sharing within the program.. Valid values are `consented|declined|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `disenrollment_date` DATE COMMENT 'Actual date the member left the program.',
    `effective_end_date` DATE COMMENT 'Planned termination date of the enrollment (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the enrollment becomes effective.',
    `enrollment_number` STRING COMMENT 'Business identifier assigned to the enrollment, used in operational reporting and member communications.',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment request, indicating how the member entered the program.. Valid values are `outreach|referral|self_referral|claims_triggered|hra_triggered`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the enrollment.. Valid values are `active|inactive|completed|disenrolled|pending`',
    `enrollment_type` STRING COMMENT 'Category of care program (e.g., disease management).. Valid values are `disease_management|case_management|population_health|wellness`',
    `hcc_score` DECIMAL(18,2) COMMENT 'Aggregated HCC score associated with the member at enrollment.',
    `notes` STRING COMMENT 'Free‑form notes entered by care staff regarding the enrollment.',
    `program_tier` STRING COMMENT 'Level of service intensity offered by the program.. Valid values are `standard|enhanced|premium`',
    `reason` STRING COMMENT 'Business reason or clinical trigger for enrolling the member.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score used for prioritizing outreach (0‑100).',
    `status_reason` STRING COMMENT 'Explanation for the current enrollment status (e.g., member request, clinical criteria).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_care_enrollment PRIMARY KEY(`care_enrollment_id`)
) COMMENT '[SSOT:enrollment] Reference to canonical SSOT member.member_enrollment for the enrollment concept; do not duplicate authoritative data here. Tracks member enrollment into specific care management, disease management, or case management programs — capturing enrollment date, disenrollment date, enrollment source (outreach, referral, self-referral, claims-triggered, HRA-triggered), consent status, program tier, enrollment status, and acuity level. Represents the active participation record linking a member to a care program. Coordinator assignment details are maintained on the care_coordinator product. Distinct from health plan enrollment (owned by the enrollment domain). Source: Casenet TruCare or Altruista. SSOT NOTE: Canonical source of truth for the enrollment concept is member.member_enrollment; this product is retained as a domain-specific view/duplicate and must defer to the canonical entity. [FHIR-aligned] SSOT duplicate; single source of truth is member.member_enrollment.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`care_plan` (
    `care_plan_id` BIGINT COMMENT 'System-generated unique identifier for the care plan record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Care coordinators reference the members benefit package to identify covered services, prior auth requirements, and cost-sharing when building care plans. Benefit-package-level care management reporti',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to manage the plan.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Care plans are executed within a specific coverage period. Care coordinators and UM teams reference the active policy to confirm covered services, authorization requirements, and benefit limits when b',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Plan belongs to a program; adding program_id FK establishes parent-child relationship and enables join to program attributes.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Care plan authorship and accountability: a care plan is owned by a specific treating/managing provider. Care coordination workflows, provider outreach, and regulatory care management reporting require',
    `barriers_to_care` STRING COMMENT 'Identified obstacles that may impede goal achievement (e.g., transportation, language).',
    `care_plan_status` STRING COMMENT 'Current lifecycle status of the care plan.. Valid values are `active|inactive|completed|abandoned|draft`',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the care plan record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the care plan expires or is terminated; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the care plan becomes effective for the member.',
    `fhir_activity` STRING COMMENT 'FHIR CarePlan.activity mapping',
    `fhir_goal` STRING COMMENT 'FHIR CarePlan.goal mapping',
    `fhir_intent` STRING COMMENT 'FHIR CarePlan.intent mapping',
    `fhir_status` STRING COMMENT 'FHIR CarePlan.status mapping',
    `fhir_subject` STRING COMMENT 'FHIR CarePlan.subject mapping',
    `high_risk_flag` BOOLEAN COMMENT 'Indicates whether the member meets high‑risk criteria for intensive management.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the care plan, e.g., "Diabetes Management Plan".',
    `plan_number` STRING COMMENT 'External business identifier assigned to the care plan, used in member communications and reporting.',
    `plan_type` STRING COMMENT 'Category of the care plan indicating its primary focus area.. Valid values are `clinical|behavioral|sdoh|social|pharmacologic`',
    `privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the member has consented to share health information for care planning.',
    `progress_notes` STRING COMMENT 'Free‑text notes documenting progress toward the goal.',
    `version` STRING COMMENT 'Incremental version number tracking revisions to the care plan.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_care_plan PRIMARY KEY(`care_plan_id`)
) COMMENT 'Individualized care plan created for a member enrolled in a care or case management program — documenting clinical and behavioral goals (goal description, category, target value, target date, status: active/achieved/abandoned, progress notes), interventions, barriers to care, target dates, care coordinator assignments, plan status, and clinical/progress notes. Goals are modeled as embedded detail records within the care plan with independent status tracking, enabling multi-dimensional progress measurement across clinical, behavioral, and SDOH goal categories. Single source of truth for all care plan goal lifecycle management. Supports longitudinal tracking of member health outcomes. Aligns with NCQA care management standards and CMS chronic care management (CCM) requirements. Source: Casenet TruCare or Altruista. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` (
    `plan_goal_id` BIGINT COMMENT 'System-generated unique identifier for the care plan goal.',
    `care_plan_id` BIGINT COMMENT 'Identifier of the care plan to which this goal belongs.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the staff member responsible for overseeing the goal.',
    `actual_date` DATE COMMENT 'Date when the actual value was recorded.',
    `actual_value` DECIMAL(18,2) COMMENT 'Measured value achieved toward the goal.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the goal complies with clinical guidelines or regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goal record was first created in the system.',
    `goal_category` STRING COMMENT 'Classification of the goal indicating its domain (e.g., clinical, behavioral, social determinant).. Valid values are `clinical|behavioral|social_determinant|pharmacologic|nutrition`',
    `goal_code` STRING COMMENT 'Business identifier or code assigned to the goal for reference and reporting.',
    `goal_name` STRING COMMENT 'Human‑readable name or title of the care plan goal.',
    `measurement_type` STRING COMMENT 'Source or method of the measurement (e.g., lab result, vital sign).. Valid values are `lab|vital|self_report|clinical_assessment`',
    `plan_goal_status` STRING COMMENT 'Current lifecycle status of the goal.. Valid values are `active|achieved|abandoned|on_hold|cancelled`',
    `priority` STRING COMMENT 'Priority level assigned to the goal to guide care team focus.. Valid values are `high|medium|low`',
    `progress_notes` STRING COMMENT 'Free‑text notes documenting progress, barriers, or interventions related to the goal.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score associated with the goal (e.g., based on HCC/RAF models).',
    `target_date` DATE COMMENT 'Date by which the goal is expected to be met.',
    `target_unit` STRING COMMENT 'Unit of measure for the target value.. Valid values are `mg/dL|mmol/L|%|mmHg|kg|steps`',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target the member should achieve (e.g., HbA1c 7.0).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goal record.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_plan_goal PRIMARY KEY(`plan_goal_id`)
) COMMENT 'Individual clinical or behavioral goals defined within a member care plan — including goal description, goal category (clinical, behavioral, social determinants), target value, target date, goal status (active, achieved, abandoned), and progress notes. Each goal has its own lifecycle independent of the parent care plan, enabling granular tracking of member progress across multiple care dimensions. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`gap` (
    `gap_id` BIGINT COMMENT 'Unique identifier for the care gap record.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to address the gap.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Gap closure is determined at the claim line level — a specific procedure code on a specific service line satisfies a HEDIS or clinical gap. Line-level precision is required for gap closure audits; the',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: Care gaps are frequently HCC-specific — closing a gap (e.g., documenting a chronic condition) directly impacts risk adjustment scores. This FK links each gap to the specific HCC code it targets, suppo',
    `hedis_measure_id` BIGINT COMMENT 'Foreign key linking to care.hedis_measure. Business justification: gap.hedis_measure_code is a denormalized string reference to the HEDIS measure catalog. Care gaps are frequently defined by non-compliance with specific HEDIS measures (e.g., a gap for HbA1c testing m',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: HEDIS care gap identification and closure tracking is tied to a members active policy/coverage period. Gap closure outreach and compliance reporting require knowing which policy was in force when the',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: HEDIS/quality gap closure is attributed to a responsible provider for provider scorecards, gap closure outreach, and pay-for-performance reporting. Role-prefix responsible used because the business ',
    `actual_resolution_date` DATE COMMENT 'Date when the care gap was actually resolved.',
    `clinical_category` STRING COMMENT 'Clinical domain or condition associated with the gap (e.g., diabetes, cardiovascular).',
    `close_date` DATE COMMENT 'Date when the care gap was resolved or closed (nullable if still open).',
    `closure_method` STRING COMMENT 'Method by which the care gap was closed.. Valid values are `claim|supplemental|attestation|provider_update|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care gap record was created in the lakehouse.',
    `gap_description` STRING COMMENT 'Narrative description of the identified care gap.',
    `documentation_status` STRING COMMENT 'Status of required documentation for the care gap.. Valid values are `complete|pending|missing`',
    `gap_status` STRING COMMENT 'Current lifecycle status of the care gap.. Valid values are `open|closed|in_progress|resolved`',
    `gap_type` STRING COMMENT 'Category of the care gap (e.g., preventive service, chronic condition management).. Valid values are `preventive|chronic|medication|screening|followup|other`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the gap is considered critical for member health.',
    `measure_target_value` DECIMAL(18,2) COMMENT 'Expected target value for the measure (e.g., HbA1c <7%).',
    `open_date` DATE COMMENT 'Date when the care gap was first identified.',
    `priority_level` STRING COMMENT 'Business-assigned priority for addressing the care gap.. Valid values are `high|medium|low`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score associated with the gap (e.g., based on HCC/RAF).',
    `target_date` DATE COMMENT 'Desired date by which the care gap should be closed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care gap record.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_gap PRIMARY KEY(`gap_id`)
) COMMENT 'Registry of identified care gaps for members — preventive services, chronic condition management measures, and HEDIS-aligned quality measures that have not been completed (e.g., HbA1c testing, mammography, colorectal cancer screening, medication adherence). Tracks gap type, HEDIS measure code, gap open date, gap close date, closure method (claim, supplemental data, attestation), and gap status. Core to HEDIS performance and Star Ratings improvement programs. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`coordinator` (
    `coordinator_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each care coordinator record.',
    `assigned_lob` STRING COMMENT 'Business line for which the coordinator primarily provides services.. Valid values are `individual|group|employer|government`',
    `caseload_capacity` STRING COMMENT 'Maximum number of members the coordinator can actively manage.',
    `caseload_weight` DECIMAL(18,2) COMMENT 'Weighted factor reflecting case complexity for workload balancing.',
    `certification_codes` STRING COMMENT 'Comma‑separated list of professional certifications (e.g., CCM, ACM, CPH).',
    `coordinator_status` STRING COMMENT 'Current lifecycle status of the coordinator record.. Valid values are `active|inactive|suspended|retired`',
    `current_caseload_count` STRING COMMENT 'Number of members currently assigned to the coordinator.',
    `email_address` STRING COMMENT 'Primary email address used for secure communications with the coordinator.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `employment_status` STRING COMMENT 'Current employment state of the coordinator.. Valid values are `active|inactive|on_leave|terminated`',
    `first_name` STRING COMMENT 'Given name of the care coordinator.',
    `full_name` STRING COMMENT 'Legal full name of the care coordinator as used in member communications and credentialing.',
    `hire_date` DATE COMMENT 'Date the coordinator was hired by the organization.',
    `last_name` STRING COMMENT 'Family name of the care coordinator.',
    `last_training_date` DATE COMMENT 'Date of the most recent mandatory training completed by the coordinator.',
    `notes` STRING COMMENT 'Free‑form notes entered by supervisors or administrators about the coordinator.',
    `organization_unit` STRING COMMENT 'Department or unit within the health plan where the coordinator is assigned.',
    `phone_number` STRING COMMENT 'Primary telephone number for reaching the coordinator.. Valid values are `^+?[0-9]{1,3}[ -]?(?[0-9]{3})?[ -]?[0-9]{3}[ -]?[0-9]{4}$`',
    `primary_contact_method` STRING COMMENT 'Preferred channel for contacting the coordinator.. Valid values are `email|phone|portal`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the coordinator record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the coordinator record.',
    `role_type` STRING COMMENT 'Functional role of the coordinator within the care management domain.. Valid values are `care_coordinator|case_manager|disease_management_nurse|health_coach`',
    `specialty_area` STRING COMMENT 'Clinical specialty or disease focus of the coordinator.. Valid values are `diabetes|cardiology|oncology|behavioral_health|pediatrics|geriatrics`',
    `termination_date` DATE COMMENT 'Date the coordinators employment ended, if applicable.',
    `training_certifications` STRING COMMENT 'Comma‑separated list of completed training programs (e.g., HEDIS, STAR).',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_coordinator PRIMARY KEY(`coordinator_id`)
) COMMENT 'Master record for care coordinators, case managers, disease management nurses, and health coaches — capturing demographics, credentials (RN, LCSW, CHW), certifications (CCM, ACM), caseload capacity, specialty focus areas, assigned LOB, active status, and supervisor hierarchy. Single source of truth for coordinator-to-member assignment history including assignment date, assignment type (primary, backup, specialist), assignment reason, caseload weight, assignment status, reassignment/handoff tracking, and continuity-of-care documentation. Enables caseload management, workload balancing, continuity-of-care reporting, and coordinator performance analytics. Source: Casenet TruCare or Altruista workforce configuration. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` (
    `condition_registry_id` BIGINT COMMENT 'System-generated unique identifier for each condition registry record.',
    `care_plan_id` BIGINT COMMENT 'Identifier of the care plan linked to this condition, if any.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Risk adjustment and HCC coding workflows require knowing which provider diagnosed each condition. CMS risk adjustment audits and RADV reviews trace HCC codes to diagnosing providers. Role-prefix diag',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: CMS risk adjustment requires each diagnosed condition in the registry to map to a specific HCC code record. This FK drives RAF score calculation and RAPS submission workflows. hcc_code on condition_re',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the condition applies.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to claim.diagnosis. Business justification: Chronic condition registry entries are sourced from claim diagnoses (ICD codes). This FK supports HCC coding, risk adjustment, and chronic condition identification workflows — a domain expert expects ',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the condition is currently active for the member.',
    `condition_category` STRING COMMENT 'Business classification of the condition (e.g., HCC‑mapped, HEDIS chronic, behavioral health).. Valid values are `HCC|HEDIS|Behavioral|Other`',
    `condition_code` STRING COMMENT 'Standard ICD-10 diagnosis code representing the clinical condition.. Valid values are `^[A-Z][0-9][0-9A-Z]{0,3}$`',
    `condition_description` STRING COMMENT 'Human‑readable description of the condition.',
    `confirmation_status` STRING COMMENT 'Current confirmation state of the condition record.. Valid values are `confirmed|pending|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition record was first created.',
    `data_quality_status` STRING COMMENT 'Current data quality assessment of the condition record.. Valid values are `valid|invalid|pending_review`',
    `effective_end_date` DATE COMMENT 'Date the condition ceased to be effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date the condition became effective for care program eligibility.',
    `fhir_clinical_status` STRING COMMENT 'FHIR Condition.clinicalStatus mapping',
    `fhir_code` STRING COMMENT 'FHIR Condition.code mapping',
    `fhir_subject` STRING COMMENT 'FHIR Condition.subject mapping',
    `identification_date` DATE COMMENT 'Date the condition was first identified for the member.',
    `identification_method` STRING COMMENT 'Method used to identify the condition for the member.. Valid values are `claims|ehr|provider_attestation|hra`',
    `is_chronic` BOOLEAN COMMENT 'Flag indicating whether the condition is considered chronic for HEDIS and risk adjustment.',
    `last_review_date` DATE COMMENT 'Date the condition record was last reviewed for accuracy.',
    `notes` STRING COMMENT 'Free‑text clinical notes or comments about the condition.',
    `onset_date` DATE COMMENT 'Date when the condition first manifested.',
    `population_segment` STRING COMMENT 'Segment of the member population based on the conditions risk level.. Valid values are `high_risk|medium_risk|low_risk`',
    `raf_score` DECIMAL(18,2) COMMENT 'Calculated RAF score associated with the condition.',
    `resolution_date` DATE COMMENT 'Date when the condition was resolved or considered inactive.',
    `risk_adjustment_flag` BOOLEAN COMMENT 'Indicates if the condition contributes to risk‑adjusted payments.',
    `severity` STRING COMMENT 'Clinical severity level of the condition.. Valid values are `mild|moderate|severe|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the condition record.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_condition_registry PRIMARY KEY(`condition_registry_id`)
) COMMENT 'Chronic condition registry identifying members with specific diagnosed conditions — including ICD-10 condition code, condition category (HCC-mapped, HEDIS chronic condition, behavioral health), identification method (claims-based, EHR, provider attestation, HRA), identification date, confirmation status, and active/inactive flag. Serves as the authoritative clinical condition roster within the care domain for care program targeting, population health stratification, and HEDIS measure eligibility determination. References the risk domain for authoritative HCC/RAF scoring. Source: Casenet TruCare or Altruista clinical data. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` (
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the HEDIS measure. [_canonical_skip_reason: REFERENCE_LOOKUP - catalog of HEDIS quality measures]',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: CMS Star Ratings and risk adjustment programs require HEDIS measures to be aligned with specific HCC codes. This FK supports integrated quality-risk reporting and regulatory submissions. measure_relat',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measure record was first created in the data lake.',
    `data_collection_methodology` STRING COMMENT 'Method used to collect data for the measure (administrative, hybrid, or survey).. Valid values are `administrative|hybrid|survey`',
    `denominator_definition` STRING COMMENT 'Exact definition of the denominator component of the measure.',
    `effective_date` DATE COMMENT 'Date when the measure became effective for reporting.',
    `eligible_population_criteria` STRING COMMENT 'Eligibility rules that define the member cohort for the measure.',
    `exclusion_criteria` STRING COMMENT 'Conditions or member attributes that exclude a member from the denominator.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the measure record.',
    `measure_code` STRING COMMENT 'Official NCQA code that uniquely identifies the measure.',
    `measure_denominator_logic` STRING COMMENT 'Detailed logical expression or algorithm used to compute the denominator.',
    `measure_description` STRING COMMENT 'Full textual description of what the measure evaluates.',
    `measure_domain` STRING COMMENT 'High‑level domain of the measure (e.g., effectiveness of care, access/availability, utilization).. Valid values are `effectiveness_of_care|access_availability|utilization`',
    `measure_exclusion_logic` STRING COMMENT 'Detailed logical expression defining exclusions from the denominator.',
    `measure_last_reviewed_date` DATE COMMENT 'Date when the measure definition was last reviewed for accuracy.',
    `measure_last_updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `measure_name` STRING COMMENT 'Descriptive name of the HEDIS quality measure.',
    `measure_national_benchmark` DECIMAL(18,2) COMMENT 'National average performance for the measure (percentage).',
    `measure_notes` STRING COMMENT 'Free‑form notes or comments about the measure.',
    `measure_numerator_logic` STRING COMMENT 'Detailed logical expression or algorithm used to compute the numerator.',
    `measure_owner` STRING COMMENT 'Business unit or team responsible for the measure.',
    `measure_related_raf` DECIMAL(18,2) COMMENT 'Comma‑separated list of Risk Adjustment Factor (RAF) variables linked to the measure.',
    `measure_reporting_frequency` STRING COMMENT 'How often the measure is reported (annual, semi‑annual, quarterly).. Valid values are `annual|semiannual|quarterly`',
    `measure_scoring_method` STRING COMMENT 'Method used to calculate the final score (e.g., rate, percentage, binary).. Valid values are `rate|percentage|binary`',
    `measure_star_rating_impact` STRING COMMENT 'Explanation of how the measure influences Medicare Star Ratings.',
    `measure_state_benchmark` DECIMAL(18,2) COMMENT 'State‑level average performance for the measure (percentage).',
    `measure_status` STRING COMMENT 'Current lifecycle status of the measure.. Valid values are `active|retired|draft|pending`',
    `measure_target_value` DECIMAL(18,2) COMMENT 'Target performance value or threshold for the measure.',
    `measure_url` STRING COMMENT 'Link to the official documentation or specification for the measure.',
    `measurement_year` STRING COMMENT 'Calendar year for which the measure is defined.',
    `numerator_definition` STRING COMMENT 'Exact definition of the numerator component of the measure.',
    `retirement_date` DATE COMMENT 'Date when the measure was retired or superseded (null if still active).',
    `version_number` STRING COMMENT 'Version of the measure definition, incremented on each change.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_hedis_measure PRIMARY KEY(`hedis_measure_id`)
) COMMENT 'Reference catalog of HEDIS (Healthcare Effectiveness Data and Information Set) quality measures maintained by NCQA — including measure ID, measure name, measure domain (effectiveness of care, access/availability, utilization), measurement year, eligible population criteria, numerator definition, denominator definition, exclusion criteria, and data collection methodology (administrative, hybrid, survey). Authoritative reference for HEDIS performance tracking and Star Ratings. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` (
    `hedis_result_id` BIGINT COMMENT 'System-generated unique identifier for each HEDIS result record.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: HEDIS compliance status depends on whether a claim was adjudicated as paid or denied. NCQA HEDIS audit trails require linking each result to the adjudication record that confirmed claim payment, suppo',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: HEDIS numerator and denominator criteria are evaluated at the claim line level (procedure codes, service dates, revenue codes). NCQA HEDIS audit requirements demand traceability from each result to th',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: NCQA and CMS HEDIS reporting requires that measure results be tied to the specific enrollment period qualifying the member for the denominator. The eligibility span defines the continuous enrollment c',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: HEDIS results are reported at group practice level for ACO/PCMH performance reporting and value-based contracts. Group-level quality scorecards and CMS ACO reporting require aggregating measure result',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled.',
    `hedis_measure_id` BIGINT COMMENT 'Standard code for the HEDIS quality measure (e.g., HM-001).',
    `identity_id` BIGINT COMMENT 'Unique identifier for the member to whom the HEDIS result applies.',
    `practice_location_id` BIGINT COMMENT 'Identifier of the provider associated with the source claim or service.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: HEDIS results are attributed to rendering providers for provider-level quality reporting, star ratings, and pay-for-performance calculations. Health plans must identify which providers attributed mem',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: VBC contracts specify HEDIS measure targets as quality gates (vbc_contract.hedis_measure_targets, quality_gate_met, quality_score). Actual HEDIS results must be linked to the VBC contract for shared s',
    `audit_created` TIMESTAMP COMMENT 'Timestamp when the HEDIS result record was first created in the lakehouse.',
    `audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the HEDIS result record.',
    `collection_method` STRING COMMENT 'Methodology used to collect the underlying data for the measure.. Valid values are `administrative|hybrid|survey`',
    `compliance_status` STRING COMMENT 'Overall compliance outcome for the member on this measure.. Valid values are `compliant|non_compliant|excluded`',
    `data_source` STRING COMMENT 'Origin of the data used to determine the HEDIS result.. Valid values are `claim|lab|supplemental|medical_record`',
    `denominator_criteria_met` BOOLEAN COMMENT 'Indicates whether the member satisfied the denominator condition (typically eligibility).',
    `eligibility_criteria` STRING COMMENT 'Logical definition of the member population eligible for the measure.',
    `exclusion_criteria` STRING COMMENT 'Specific criteria that triggered the members exclusion.',
    `exclusion_reason` STRING COMMENT 'Reason or code describing why the member was excluded.',
    `is_excluded` BOOLEAN COMMENT 'True if the member is excluded from the measure based on exclusion criteria.',
    `measure_category` STRING COMMENT 'Category grouping of the measure (e.g., preventive, chronic).. Valid values are `preventive|chronic|behavioral|screening`',
    `measure_score` DECIMAL(18,2) COMMENT 'Numeric score assigned to the member for the measure (if applicable).',
    `measure_type` STRING COMMENT 'Classification of the measure as process, outcome, or structure.. Valid values are `process|outcome|structure`',
    `measure_version` STRING COMMENT 'Version or edition of the measure as published by NCQA.',
    `measurement_year` STRING COMMENT 'Calendar year for which the HEDIS measurement is reported.',
    `numerator_criteria_met` BOOLEAN COMMENT 'Indicates whether the member satisfied the numerator condition for the measure.',
    `result_timestamp` TIMESTAMP COMMENT 'Date and time when the HEDIS result was calculated.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_hedis_result PRIMARY KEY(`hedis_result_id`)
) COMMENT 'Single source of truth for HEDIS (Healthcare Effectiveness Data and Information Set) quality measure definitions and member-level compliance results. Contains the authoritative NCQA-published measure catalog (measure ID, name, domain: effectiveness of care/access/availability/utilization, measurement year, eligible population criteria, numerator/denominator definitions, exclusion criteria, data collection methodology: administrative/hybrid/survey) and member-level results indicating whether each member met numerator criteria for a given measurement year. Tracks data source (claim, lab, supplemental, medical record), compliance status (compliant, non-compliant, excluded), and hybrid audit trail. Aggregated to produce plan-level HEDIS rates submitted to NCQA for Star Ratings, accreditation, and quality bonus payments. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` (
    `member_risk_tier_id` BIGINT COMMENT 'System‑generated unique identifier for each risk‑tier record.',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Capitation arrangements include raf_adjustment_factor and risk_adjustment_applicable fields. Member risk tier directly determines which capitation rate tier and RAF adjustment applies. This FK enables',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to which the tier assignment applies.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Risk tier assignment is operationally derived from a specific member risk score calculation. This FK enables tier-to-score traceability for population health stratification reports and audit trails. r',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: member_risk_tier.recommended_care_program is a free-text STRING field that denormalizes a reference to a care management program. Population health stratification and risk tiering directly drives prog',
    `assignment_date` DATE COMMENT 'Date the tier was assigned to the member.',
    `assignment_method` STRING COMMENT 'Method used to assign the tier to a member.. Valid values are `automated_model|manual_override|clinical_review`',
    `chronic_condition_flag` BOOLEAN COMMENT 'True if the member has at least one chronic condition flagged.',
    `claims_count_last_year` STRING COMMENT 'Number of claims submitted by the member in the prior 12 months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tier record was first created.',
    `demographic_group` STRING COMMENT 'Broad demographic segment of the member.. Valid values are `adult|senior|child|young_adult|teen`',
    `effective_from` DATE COMMENT 'Date when the tier definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when the tier definition expires (null for open‑ended).',
    `hcc_score` DECIMAL(18,2) COMMENT 'Hierarchical Condition Category score used for RAF calculations.',
    `inclusion_criteria` STRING COMMENT 'Business rules that determine member eligibility for this tier.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this row represents the members current active tier.',
    `member_risk_tier_status` STRING COMMENT 'Current lifecycle status of the tier definition.. Valid values are `active|inactive|retired`',
    `model_type` STRING COMMENT 'Type of model used to generate the tier assignment.. Valid values are `predictive|hcc_based|claims_based`',
    `next_reassessment_date` DATE COMMENT 'Planned date for the next risk‑tier reassessment.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes.',
    `pmpm_cost_band` DECIMAL(18,2) COMMENT 'Per‑Member‑Per‑Month cost band associated with the tier.',
    `risk_factor_weight` DECIMAL(18,2) COMMENT 'Weight applied to the risk factor in the predictive model.',
    `segment_description` STRING COMMENT 'Detailed description of the segment criteria.',
    `segment_name` STRING COMMENT 'Name of the population segment definition linked to this tier.',
    `tier_band` STRING COMMENT 'Broad risk band classification.. Valid values are `low|rising|high|catastrophic`',
    `tier_code` STRING COMMENT 'Business identifier/code used to reference the tier in downstream systems.',
    `tier_name` STRING COMMENT 'Human‑readable name of the risk tier (e.g., "High Risk").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tier record.',
    `version_number` STRING COMMENT 'Version of the tier definition for change tracking.',
    `vreq_validated` BOOLEAN COMMENT 'Validation marker for VREQ preservation requirement',
    CONSTRAINT pk_member_risk_tier PRIMARY KEY(`member_risk_tier_id`)
) COMMENT 'Member-level risk tier assignment and population health stratification — containing population segment definitions (segment name, stratification model: predictive risk model/HCC-based/claims-based, risk tier bands: low/rising risk/high/catastrophic, inclusion criteria, recommended care program, PMPM cost band, effective date) and member-specific tier assignments (risk score, assignment date, assignment method: automated model/manual override/clinical review, next reassessment date). Single source of truth for both population segment configuration and member-level risk tier history. Tracks risk tier changes over time to support longitudinal population health management and care program targeting. Distinct from CMS RAF scores (owned by the risk domain) — this covers all LOBs and internal stratification models. Source: Casenet TruCare or Altruista population health module. [FHIR-aligned]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`care` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`care` SET TAGS ('dbx_domain' = 'care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending|denied');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Care Program Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `clinical_protocol` SET TAGS ('dbx_business_glossary_term' = 'Clinical Protocol');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Care Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_fhir' = 'telecom');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_fhir' = 'telecom');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_cap` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_current` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('dbx_business_glossary_term' = 'Included HCC Codes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('dbx_sensitivity' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('dbx_sensitivity' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `is_evidence_based` SET TAGS ('dbx_business_glossary_term' = 'Evidence‑Based Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Care Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_actual` SET TAGS ('dbx_business_glossary_term' = 'Outcome Actual');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_measure` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_target` SET TAGS ('dbx_business_glossary_term' = 'Outcome Target');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|draft');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Care Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'disease_management|case_management|maternity|behavioral_health|wellness|chronic_care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly|monthly|semiannual');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Program Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Manager ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `acuity_level` SET TAGS ('dbx_business_glossary_term' = 'Acuity Level (ACUITY_LEVEL)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `acuity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `care_manager_assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Care Manager Assigned Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status (CONSENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|declined|pending');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENROLLMENT_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ENROLLMENT_SOURCE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'outreach|referral|self_referral|claims_triggered|hra_triggered');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLLMENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|disenrolled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ENROLLMENT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'disease_management|case_management|population_health|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_sensitivity' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Tier (PROGRAM_TIER)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_value_regex' = 'standard|enhanced|premium');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `barriers_to_care` SET TAGS ('dbx_business_glossary_term' = 'Barriers to Care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|abandoned|draft');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `fhir_activity` SET TAGS ('dbx_fhir' = 'activity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `fhir_goal` SET TAGS ('dbx_fhir' = 'goal');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `fhir_intent` SET TAGS ('dbx_fhir' = 'intent');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `fhir_status` SET TAGS ('dbx_fhir' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `fhir_subject` SET TAGS ('dbx_fhir' = 'subject');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `high_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Name (PLAN_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Number (PLAN_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'clinical|behavioral|sdoh|social|pharmacologic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Goal Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Care Plan Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Measurement Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'clinical|behavioral|social_determinant|pharmacologic|nutrition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_code` SET TAGS ('dbx_business_glossary_term' = 'Goal Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_business_glossary_term' = 'Goal Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'lab|vital|self_report|clinical_assessment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('dbx_value_regex' = 'active|achieved|abandoned|on_hold|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Goal Priority');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'mg/dL|mmol/L|%|mmHg|kg|steps');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Identifier (CGID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (CCI)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Hedis Measure Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date (ARD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `clinical_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Category (CCAT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Close Date (GCD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_business_glossary_term' = 'Gap Closure Method (GCM)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_value_regex' = 'claim|supplemental|attestation|provider_update|none');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_description` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Description (CGD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Status (DOCS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('dbx_value_regex' = 'complete|pending|missing');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Status (CGS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|resolved');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Type (CGT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_value_regex' = 'preventive|chronic|medication|screening|followup|other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag (CRIT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `measure_target_value` SET TAGS ('dbx_business_glossary_term' = 'Measure Target Value (MTV)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Open Date (GOD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PRIO)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date (TRD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (CCID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `assigned_lob` SET TAGS ('dbx_business_glossary_term' = 'Assigned Line of Business (ALOB)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `assigned_lob` SET TAGS ('dbx_value_regex' = 'individual|group|employer|government');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('dbx_business_glossary_term' = 'Caseload Capacity (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_weight` SET TAGS ('dbx_business_glossary_term' = 'Caseload Weight (CW)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `certification_codes` SET TAGS ('dbx_business_glossary_term' = 'Certification Codes (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `current_caseload_count` SET TAGS ('dbx_business_glossary_term' = 'Current Caseload Count (CCC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Email Address (CCEA)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_fhir' = 'telecom');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (ES)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator First Name (CCFN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_pii' = 'person_name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_person_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_fhir' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Full Name (CCFN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_pii' = 'person_name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_fhir_element' = 'name.text');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_person_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_fhir' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Last Name (CCLN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii' = 'person_name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_person_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_fhir' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date (LTD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Notes (CN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `organization_unit` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit (OU)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Phone Number (CCPN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{1,3}[ -]?(?[0-9]{3})?[ -]?[0-9]{3}[ -]?[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_fhir' = 'telecom');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (PCM)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|portal');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Role Type (CRT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'care_coordinator|case_manager|disease_management_nurse|health_coach');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `specialty_area` SET TAGS ('dbx_business_glossary_term' = 'Specialty Area (SA)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `specialty_area` SET TAGS ('dbx_value_regex' = 'diabetes|cardiology|oncology|behavioral_health|pediatrics|geriatrics');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `training_certifications` SET TAGS ('dbx_business_glossary_term' = 'Training Certifications (TC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_pii_type' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosing Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Source Claim Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_value_regex' = 'HCC|HEDIS|Behavioral|Other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_pii_type' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code (ICD-10)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9][0-9A-Z]{0,3}$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_pii_type' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_pii_type' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `fhir_clinical_status` SET TAGS ('dbx_fhir' = 'clinicalStatus');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `fhir_code` SET TAGS ('dbx_fhir' = 'code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `fhir_subject` SET TAGS ('dbx_fhir' = 'subject');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_method` SET TAGS ('dbx_business_glossary_term' = 'Identification Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_method` SET TAGS ('dbx_value_regex' = 'claims|ehr|provider_attestation|hra');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `is_chronic` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Condition Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Onset Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `population_segment` SET TAGS ('dbx_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `population_segment` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `raf_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `risk_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Condition Severity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `data_collection_methodology` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `data_collection_methodology` SET TAGS ('dbx_value_regex' = 'administrative|hybrid|survey');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `denominator_definition` SET TAGS ('dbx_business_glossary_term' = 'Denominator Definition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `eligible_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible Population Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_denominator_logic` SET TAGS ('dbx_business_glossary_term' = 'Denominator Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_description` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_domain` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_domain` SET TAGS ('dbx_value_regex' = 'effectiveness_of_care|access_availability|utilization');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_exclusion_logic` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_national_benchmark` SET TAGS ('dbx_business_glossary_term' = 'National Benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_notes` SET TAGS ('dbx_business_glossary_term' = 'Measure Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_numerator_logic` SET TAGS ('dbx_business_glossary_term' = 'Numerator Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_owner` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_raf` SET TAGS ('dbx_business_glossary_term' = 'Related RAF Variables');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measure Reporting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_scoring_method` SET TAGS ('dbx_business_glossary_term' = 'Measure Scoring Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_scoring_method` SET TAGS ('dbx_value_regex' = 'rate|percentage|binary');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_star_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_star_rating_impact` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('dbx_business_glossary_term' = 'State Benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('dbx_business_glossary_term' = 'Measure Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('dbx_value_regex' = 'active|retired|draft|pending');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_target_value` SET TAGS ('dbx_business_glossary_term' = 'Measure Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_url` SET TAGS ('dbx_business_glossary_term' = 'Measure URL');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `numerator_definition` SET TAGS ('dbx_business_glossary_term' = 'Numerator Definition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `hedis_result_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Result Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'administrative|hybrid|survey');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|excluded');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'claim|lab|supplemental|medical_record');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `denominator_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Denominator Criteria Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_value_regex' = 'preventive|chronic|behavioral|screening');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_score` SET TAGS ('dbx_business_glossary_term' = 'Measure Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Measure Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_value_regex' = 'process|outcome|structure');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_version` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `numerator_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Numerator Criteria Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Determination Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Tier ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Recommended Care Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'automated_model|manual_override|clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_type' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `claims_count_last_year` SET TAGS ('dbx_business_glossary_term' = 'Claims Count Last Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_business_glossary_term' = 'Demographic Group');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_value_regex' = 'adult|senior|child|young_adult|teen');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'HCC Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_sensitivity' = 'health');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Tier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Stratification Model Type (Predictive, HCC‑Based, Claims‑Based)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'predictive|hcc_based|claims_based');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reassessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `pmpm_cost_band` SET TAGS ('dbx_business_glossary_term' = 'PMPM Cost Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_factor_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_band` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_band` SET TAGS ('dbx_value_regex' = 'low|rising|high|catastrophic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
