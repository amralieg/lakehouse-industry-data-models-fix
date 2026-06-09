-- Schema for Domain: care | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`care` COMMENT 'Manages care management, disease management, and case management programs — chronic condition registries, care gaps, care plans, population health stratification, high-risk member outreach, and health risk assessments (HRA). Owns HCC/RAF-relevant clinical data, HEDIS measure tracking, CAHPS survey results, SNF/DME post-acute coordination, and care coordinator assignments. Source system: Casenet TruCare or Altruista. Distinct from utilization which owns UM/PA authorization workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`program` (
    `program_id` BIGINT COMMENT 'System-generated unique identifier for the care program.',
    `accreditation_program_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_program. Business justification: Care programs (disease management, wellness) require NCQA/URAC accreditation tracked in compliance.accreditation_program. accreditation_body and accreditation_status on care.program are denormalized f',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Care management programs (disease management, case management) are funded and scoped under capitation arrangements. The capitation arrangement defines the PMPM that funds the program and the attribute',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: Care management programs are frequently delegated functions under NCQA-required delegation agreements. The delegation agreement governs program oversight, audit requirements, and performance standards',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Care management programs (post-discharge, disease management) are often delivered at or coordinated with specific facilities. Program enrollment, outcome tracking, and facility partnership reporting r',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: CMS requires linking each care program to its owning provider group for program ownership reporting and reimbursement audits.',
    `incentive_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.incentive_arrangement. Business justification: Care programs are designed to meet quality targets defined in incentive arrangements (e.g., a diabetes management program tied to a quality withhold). Quality operations teams track program performanc',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Care programs operate under governing policy documents (care management policies, clinical protocol policies). Program managers and auditors reference the policy_document that defines program protocol',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Contracts specify which provider contracts cover each care program; needed for eligibility, reimbursement, and program performance reporting.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Regulatory and operational policies assign a specific provider as program manager, enabling accountability and performance tracking.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Care management programs (disease management, case management) are scoped to specific provider networks. Program eligibility, enrollment caps, and clinical protocols vary by network. Health plan opera',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Wellness and disease management programs are linked to rate schedules to apply wellness_discount_rate and program-specific premium adjustments. Actuarial pricing teams require this link to apply progr',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Care programs (Medicare Advantage disease management, Medicaid case management) are mandated by specific CMS/state regulatory obligations. Program managers must reference the governing regulatory obli',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: Care programs are designed to support VBC contract performance objectives. The VBC contract defines quality and cost targets that programs are built to achieve. VBC program managers require this link ',
    `vbc_program_id` BIGINT COMMENT 'Foreign key linking to network.vbc_program. Business justification: Care management programs are frequently components of VBC programs (e.g., a diabetes management program embedded in an ACO quality initiative). Linking program to vbc_program enables performance track',
    `clinical_protocol` STRING COMMENT 'Standardized clinical pathway or guideline applied within the program.',
    `contact_email` STRING COMMENT 'Primary email address for program inquiries.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for program inquiries.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the program record was first created.',
    `data_source_system` STRING COMMENT 'Operational system that provides the master program data (e.g., Casenet TruCare).',
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
    `line_of_business` STRING COMMENT 'Business line to which the program applies.. Valid values are `individual|group|medicare|medicaid|exchange|government`',
    `outcome_actual` STRING COMMENT 'Most recent observed value for the outcome measure.',
    `outcome_measure` STRING COMMENT 'Key performance indicator used to evaluate program effectiveness.',
    `outcome_target` STRING COMMENT 'Target value or threshold for the outcome measure.',
    `program_category` STRING COMMENT 'More granular category within the program type (e.g., diabetes, CHF, COPD).',
    `program_code` STRING COMMENT 'Internal code used to reference the program in operational systems.',
    `program_description` STRING COMMENT 'Detailed narrative describing the programs purpose, services, and scope.',
    `program_name` STRING COMMENT 'Human‑readable name of the care program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|suspended|retired|draft`',
    `program_type` STRING COMMENT 'Broad classification of the program offering.. Valid values are `disease_management|case_management|maternity|behavioral_health|wellness|chronic_care`',
    `review_frequency` STRING COMMENT 'How often the program is scheduled for review.. Valid values are `annual|biennial|quarterly|monthly|semiannual`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk‑adjusted payment calculations (e.g., 0.1234).',
    `start_date` DATE COMMENT 'Date the program becomes effective and available to members.',
    `target_population` STRING COMMENT 'Demographic or clinical segment the program is designed for.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the program record.',
    `version_number` STRING COMMENT 'Version identifier for the program definition.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master registry of all care management, disease management, and case management programs offered by the health plan — including chronic condition programs (diabetes, CHF, COPD, asthma), complex case management, maternity management, behavioral health programs, and population health initiatives. Tracks program type, eligibility criteria, clinical protocols, accreditation standards (NCQA/URAC), program status, and line-of-business applicability. Source: Casenet TruCare or Altruista program configuration.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`care_enrollment` (
    `care_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for each care enrollment record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Care program enrollment costs are tracked against billing accounts for PMPM cost-of-care reporting and care management financial reconciliation. Health insurance actuaries and care managers routinely ',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Care management enrollment must identify the attributed PCP for HEDIS measure attribution, gap closure responsibility, and population health reporting. No existing FK on care_enrollment points to prov',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Care coordinators must know the members benefit package to determine covered services, prior auth requirements, and cost-sharing when enrolling members in care management programs. Plan benefit desig',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Care management enrollment must be attributed to the capitation arrangement funding the members PMPM. Actuaries and care managers reconcile enrolled populations against capitation payment pools; this',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to the member for this enrollment.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for Employer‑Sponsored Program Enrollment reporting and ACA employer‑level enrollment compliance; employers need to see which members enrolled via their group.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Care program enrollment is health-plan-specific — program eligibility criteria, funding, and regulatory reporting (e.g., Medicare Advantage care management requirements) all depend on the health plan.',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Care enrollment is valid only within an active eligibility span. Care managers and compliance teams must confirm coverage is active when enrolling members in disease management programs. This FK enabl',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to member.member_enrollment. Business justification: Plan enrollment (member_enrollment) triggers eligibility for care management programs. Care coordinators use this link to confirm the members active plan enrollment when initiating care program enrol',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Underwriting uses a members risk score at enrollment; linking provides audit trail for premium determination.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member enrolled in the care program.',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Care management enrollment is attributed to the members PCP practice location for network adequacy reporting, care coordination routing, and population health management. Enrollment-to-practice-locat',
    `program_id` BIGINT COMMENT 'Identifier of the care, disease, or case management program to which the member is enrolled.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Care management enrollment is network-scoped — coordinators must know which provider network the enrolled member belongs to for referral routing, gap closure, and ACO attribution. This is a standard o',
    `vbc_arrangement_id` BIGINT COMMENT 'Foreign key linking to network.vbc_arrangement. Business justification: In ACO/VBC arrangements, member attribution to care management is directly tied to a specific VBC arrangement. Care coordinators and performance analysts must know which VBC arrangement a member is at',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: Members enrolled in care management are attributed to VBC contracts (ACO, PCMH). The VBC contract drives care management obligations, quality targets, and shared savings calculations. Care managers mu',
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
    CONSTRAINT pk_care_enrollment PRIMARY KEY(`care_enrollment_id`)
) COMMENT 'Tracks member enrollment into specific care management, disease management, or case management programs — capturing enrollment date, disenrollment date, enrollment source (outreach, referral, self-referral, claims-triggered, HRA-triggered), consent status, program tier, enrollment status, and acuity level. Represents the active participation record linking a member to a care program. Coordinator assignment details are maintained on the care_coordinator product. Distinct from health plan enrollment (owned by the enrollment domain). Source: Casenet TruCare or Altruista.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`care_plan` (
    `care_plan_id` BIGINT COMMENT 'System-generated unique identifier for the care plan record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Care plans are built around covered benefits — care managers reference the benefit package to identify covered services, prior auth rules, and cost-sharing when setting care plan goals and interventio',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: A care plan is created for a member enrolled in a specific care management program. Linking care_plan directly to care_enrollment (rather than only to program) captures the precise enrollment context ',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to manage the plan.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Post-discharge and inpatient care plans are anchored to the discharging or treating facility. Transitions-of-care workflows and utilization management require knowing which facility the care plan is a',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Care managers must verify drug formulary coverage when recommending medications in a care plan. Linking care_plan to the applicable formulary enables real-time formulary checks during care planning, s',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Care plans are constructed within a specific health plan context — covered services, network constraints, and benefit design all shape the care plan. Care management reporting and quality audits requi',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Care plan creation and stratification is directly driven by the members calculated risk score. Care managers use member_risk_score to set plan intensity and goals. This FK formalizes the risk-stratif',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Care plans are operationally tied to the practice location where the primary provider delivers care. Care coordinators use this for referral routing, gap closure, and transitions-of-care workflows. A ',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member for whom the care plan is created.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Care plans must be overseen by a designated primary care provider to ensure care coordination and meet NCQA quality measures.',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Plan belongs to a program; adding program_id FK establishes parent-child relationship and enables join to program attributes.',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: Care plans for members attributed to VBC contracts must align with the contracts quality and cost targets. Care managers reference the VBC contract to ensure care plan goals support shared savings ob',
    `barriers_to_care` STRING COMMENT 'Identified obstacles that may impede goal achievement (e.g., transportation, language).',
    `care_plan_status` STRING COMMENT 'Current lifecycle status of the care plan.. Valid values are `active|inactive|completed|abandoned|draft`',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the care plan record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the care plan expires or is terminated; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the care plan becomes effective for the member.',
    `high_risk_flag` BOOLEAN COMMENT 'Indicates whether the member meets high‑risk criteria for intensive management.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the care plan, e.g., "Diabetes Management Plan".',
    `plan_number` STRING COMMENT 'External business identifier assigned to the care plan, used in member communications and reporting.',
    `plan_type` STRING COMMENT 'Category of the care plan indicating its primary focus area.. Valid values are `clinical|behavioral|sdoh|social|pharmacologic`',
    `privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the member has consented to share health information for care planning.',
    `progress_notes` STRING COMMENT 'Free‑text notes documenting progress toward the goal.',
    `source_system` STRING COMMENT 'Name of the operational system that originated the care plan record.',
    `version` STRING COMMENT 'Incremental version number tracking revisions to the care plan.',
    CONSTRAINT pk_care_plan PRIMARY KEY(`care_plan_id`)
) COMMENT 'Individualized care plan created for a member enrolled in a care or case management program — documenting clinical and behavioral goals (goal description, category, target value, target date, status: active/achieved/abandoned, progress notes), interventions, barriers to care, target dates, care coordinator assignments, plan status, and clinical/progress notes. Goals are modeled as embedded detail records within the care plan with independent status tracking, enabling multi-dimensional progress measurement across clinical, behavioral, and SDOH goal categories. Single source of truth for all care plan goal lifecycle management. Supports longitudinal tracking of member health outcomes. Aligns with NCQA care management standards and CMS chronic care management (CCM) requirements. Source: Casenet TruCare or Altruista.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`plan_goal` (
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
    CONSTRAINT pk_plan_goal PRIMARY KEY(`plan_goal_id`)
) COMMENT 'Individual clinical or behavioral goals defined within a member care plan — including goal description, goal category (clinical, behavioral, social determinants), target value, target date, goal status (active, achieved, abandoned), and progress notes. Each goal has its own lifecycle independent of the parent care plan, enabling granular tracking of member progress across multiple care dimensions.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`gap` (
    `gap_id` BIGINT COMMENT 'Unique identifier for the care gap record.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to address the gap.',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Care gaps are identified and managed within the context of a members care management program enrollment. Linking gap to care_enrollment enables program-level gap closure rate reporting, supports care',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Post-discharge and inpatient-related HEDIS gaps (e.g., follow-up after hospitalization) are associated with a specific facility. Facility-level gap management and quality reporting require this link. ',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: Gaps in care are predominantly HCC-driven — a gap is opened to close an HCC condition for risk adjustment. Linking gap to hcc_mapping supports HCC closure workflows, risk adjustment gap management pro',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Required for HEDIS gap analysis reports that aggregate gaps by health plan, a regulatory reporting need.',
    `hedis_measure_id` BIGINT COMMENT 'FK to care.hedis_measure',
    `incentive_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.incentive_arrangement. Business justification: HEDIS/quality gaps are directly tied to incentive arrangements — closing gaps earns quality bonuses or avoids withholds. Quality operations teams track gap closure against incentive arrangement thresh',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: HEDIS gap identification requires continuous enrollment validation against a specific eligibility span. Gaps are only actionable for members enrolled during the measurement period. This FK is essentia',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Care gap prioritization incorporates the members risk score; FK ties gap records to the underlying risk score.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with the care gap.',
    `network_provider_id` BIGINT COMMENT 'Foreign key linking to network.network_provider. Business justification: Clinical care gaps are assigned to the responsible in-network provider for outreach and closure. Provider-level gap reporting (e.g., HEDIS gap closure by PCP) requires linking the gap to the specific ',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: HEDIS gaps are tracked at the practice location level for provider-site performance reporting and targeted outreach. Gap closure workflows require knowing which practice location is responsible. Stand',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network‑adequacy reports require linking each care gap to the provider network of the members primary provider to assess coverage gaps.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: HEDIS gaps in care are attributed to a specific responsible provider for gap closure outreach, provider performance scorecards, and value-based contract reporting. Existing gap FKs cover network and c',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: Care gaps (e.g., missing diabetes screenings, overdue preventive services) trigger UM case opening for outreach and intervention. This link supports HEDIS gap closure workflows where UM cases are open',
    `actual_resolution_date` DATE COMMENT 'Date when the care gap was actually resolved.',
    `clinical_category` STRING COMMENT 'Clinical domain or condition associated with the gap (e.g., diabetes, cardiovascular).',
    `close_date` DATE COMMENT 'Date when the care gap was resolved or closed (nullable if still open).',
    `closure_method` STRING COMMENT 'Method by which the care gap was closed.. Valid values are `claim|supplemental|attestation|provider_update|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care gap record was created in the lakehouse.',
    `documentation_status` STRING COMMENT 'Status of required documentation for the care gap.. Valid values are `complete|pending|missing`',
    `gap_description` STRING COMMENT 'Narrative description of the identified care gap.',
    `gap_status` STRING COMMENT 'Current lifecycle status of the care gap.. Valid values are `open|closed|in_progress|resolved`',
    `gap_type` STRING COMMENT 'Category of the care gap (e.g., preventive service, chronic condition management).. Valid values are `preventive|chronic|medication|screening|followup|other`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the gap is considered critical for member health.',
    `measure_target_value` DECIMAL(18,2) COMMENT 'Expected target value for the measure (e.g., HbA1c <7%).',
    `open_date` DATE COMMENT 'Date when the care gap was first identified.',
    `priority_level` STRING COMMENT 'Business-assigned priority for addressing the care gap.. Valid values are `high|medium|low`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score associated with the gap (e.g., based on HCC/RAF).',
    `source_system` STRING COMMENT 'Originating system that generated the care gap record.. Valid values are `Casenet|Altruista|Custom`',
    `target_date` DATE COMMENT 'Desired date by which the care gap should be closed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care gap record.',
    CONSTRAINT pk_gap PRIMARY KEY(`gap_id`)
) COMMENT 'Registry of identified care gaps for members — preventive services, chronic condition management measures, and HEDIS-aligned quality measures that have not been completed (e.g., HbA1c testing, mammography, colorectal cancer screening, medication adherence). Tracks gap type, HEDIS measure code, gap open date, gap close date, closure method (claim, supplemental data, attestation), and gap status. Core to HEDIS performance and Star Ratings improvement programs.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`coordinator` (
    `coordinator_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each care coordinator record.',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: Care coordinators operating under delegated care management functions are governed by delegation agreements. The delegation agreement defines the scope of coordinator authority, oversight requirements',
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
    CONSTRAINT pk_coordinator PRIMARY KEY(`coordinator_id`)
) COMMENT 'Master record for care coordinators, case managers, disease management nurses, and health coaches — capturing demographics, credentials (RN, LCSW, CHW), certifications (CCM, ACM), caseload capacity, specialty focus areas, assigned LOB, active status, and supervisor hierarchy. Single source of truth for coordinator-to-member assignment history including assignment date, assignment type (primary, backup, specialist), assignment reason, caseload weight, assignment status, reassignment/handoff tracking, and continuity-of-care documentation. Enables caseload management, workload balancing, continuity-of-care reporting, and coordinator performance analytics. Source: Casenet TruCare or Altruista workforce configuration.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` (
    `coordinator_assignment_id` BIGINT COMMENT 'System-generated unique identifier for each coordinator assignment record.',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: The care_coordinator_assignment description explicitly states it links a coordinator to a specific member care enrollment or case. Adding care_enrollment_id directly captures the enrollment context ',
    `coordinator_id` BIGINT COMMENT 'Unique identifier of the care coordinator assigned to the member or case.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member receiving care coordination.',
    `um_case_id` BIGINT COMMENT 'Identifier of the specific care case or enrollment to which the coordinator is assigned.',
    `assignment_date` DATE COMMENT 'Date on which the coordinator assignment became effective.',
    `assignment_priority` STRING COMMENT 'Priority level indicating urgency of the assignment.. Valid values are `high|medium|low`',
    `assignment_reason` STRING COMMENT 'Business reason for creating the assignment (e.g., new diagnosis, care gap, member request).',
    `assignment_source` STRING COMMENT 'Origin of the assignment record (e.g., entered manually by staff, generated by system rules).. Valid values are `manual|system|automated`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment.. Valid values are `active|inactive|completed|terminated|pending`',
    `assignment_type` STRING COMMENT 'Role of the coordinator in this assignment.. Valid values are `primary|backup|specialist|consultant`',
    `caseload_weight` DECIMAL(18,2) COMMENT 'Relative workload weight assigned to the coordinator for this case (e.g., 1.00 = standard, >1.00 = higher complexity).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created in the system.',
    `effective_from` DATE COMMENT 'Start date of the assignments validity period.',
    `effective_until` DATE COMMENT 'End date of the assignments validity period; null if open-ended.',
    `notes` STRING COMMENT 'Free-text field for additional comments or contextual information about the assignment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    CONSTRAINT pk_coordinator_assignment PRIMARY KEY(`coordinator_assignment_id`)
) COMMENT 'Assignment record linking a care coordinator to a specific member care enrollment or case — capturing assignment date, assignment type (primary, backup, specialist), assignment reason, caseload weight, and assignment status. Tracks the full history of coordinator-to-member assignments including reassignments and handoffs. Enables caseload management, workload balancing, and continuity-of-care reporting.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`member_outreach` (
    `member_outreach_id` BIGINT COMMENT 'Unique identifier for each outreach activity record.',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Outreach activities are conducted to engage members enrolled in care management programs. Linking member_outreach to care_enrollment contextualizes each outreach attempt within the specific program en',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.coordinator. Business justification: Outreach activities are conducted BY care coordinators. Adding coordinator_id to member_outreach captures who performed the outreach, enabling coordinator performance metrics, caseload analysis, and a',
    `gap_id` BIGINT COMMENT 'Foreign key linking to care.gap. Business justification: Outreach is frequently conducted specifically to close identified care gaps (e.g., reminding a member to schedule a preventive screening). Linking member_outreach to gap captures the gap-closure conte',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Employer groups sponsor population-level outreach campaigns (wellness enrollment drives, preventive care reminders) tracked against the sponsoring group for ROI reporting and contractual wellness prog',
    `hipaa_privacy_request_id` BIGINT COMMENT 'Foreign key linking to compliance.hipaa_privacy_request. Business justification: Member outreach must respect active HIPAA privacy requests (restrictions on contact, opt-outs). Care operations staff must reference the governing hipaa_privacy_request to ensure outreach complies wit',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member who was contacted.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: Member outreach is routinely triggered by PA decisions (approval, denial, or pend) to inform members of next steps and appeal rights. Linking member_outreach to the specific prior_authorization that t',
    `channel` STRING COMMENT 'Communication channel through which the outreach was performed.. Valid values are `phone|mail|sms|portal`',
    `compliance_consent_obtained` BOOLEAN COMMENT 'True when required consent for contacting the member was documented.',
    `consent_obtained_date` DATE COMMENT 'Date on which the member gave consent for outreach communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outreach record was first created in the lakehouse.',
    `follow_up_due_date` DATE COMMENT 'Target date for completing any required follow‑up.',
    `follow_up_required` BOOLEAN COMMENT 'True when additional contact or action is needed after the outreach.',
    `is_automated` BOOLEAN COMMENT 'True if the outreach was generated by an automated workflow; false if manual.',
    `language_preference` STRING COMMENT 'Preferred language of the member for outreach communications.. Valid values are `en|es|fr|other`',
    `member_outreach_status` STRING COMMENT 'Lifecycle state of the outreach activity record.. Valid values are `pending|completed|cancelled`',
    `outcome` STRING COMMENT 'Observed outcome of the outreach interaction.. Valid values are `reached|voicemail|refused|enrolled|no_answer|partial`',
    `outcome_timestamp` TIMESTAMP COMMENT 'Date and time when the outcome of the outreach was logged.',
    `outreach_duration_seconds` STRING COMMENT 'Length of the phone call or interaction measured in seconds.',
    `outreach_notes` STRING COMMENT 'Additional comments or details recorded about the outreach.',
    `outreach_timestamp` TIMESTAMP COMMENT 'Date and time when the outreach attempt occurred.',
    `purpose` STRING COMMENT 'Reason for contacting the member, such as enrolling in a program or closing a care gap.. Valid values are `program_enrollment|care_gap_closure|hra_completion|medication_adherence|wellness_education|other`',
    `source_system` STRING COMMENT 'System of record that originated the outreach activity (e.g., Casenet TruCare, Altruista, Member Portal).. Valid values are `Casenet|Altruista|CRM|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the outreach record.',
    CONSTRAINT pk_member_outreach PRIMARY KEY(`member_outreach_id`)
) COMMENT 'Records of outreach activities conducted by care coordinators or automated systems to engage high-risk members in care management programs — including outreach date, outreach channel (phone, mail, SMS, portal), outreach purpose (program enrollment, care gap closure, HRA completion, medication adherence), outcome (reached, left voicemail, refused, enrolled), and follow-up requirements. Supports population health engagement tracking and HEDIS outreach documentation.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`hra` (
    `hra_id` BIGINT COMMENT 'Unique surrogate key for each health risk assessment record.',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Health Risk Assessments are administered to members enrolled in care management programs. Linking hra to care_enrollment contextualizes the HRA within the specific program enrollment, enabling program',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Employer wellness incentive programs require tracking HRA completion by employer group for ACA Section 2705 wellness program compliance and incentive administration. HRAs are often mandated by employe',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: HRAs are administered as part of health plan wellness programs and are required by CMS for Medicare Advantage plans. HRA completion rates and outcomes are reported at the health plan level for Stars r',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member who completed the assessment.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: HRA completion triggers or updates a members risk score calculation. Health plans track which risk score was generated or refreshed from each HRA for CMS Stars and HEDIS reporting. This FK formalizes',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: HRA administration follows specific policy documents (HRA administration policy, CMS compliance policy, privacy consent policy). Care managers and auditors reference the governing policy_document to v',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: HRAs are administered at or attributed to the members PCP practice location for HEDIS/Stars reporting and care management workflows. CMS Medicare Advantage requires HRA attribution to the practice si',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: HRAs are mandated by CMS for Medicare Advantage plans (Annual Wellness Visit, Initial Health Risk Assessment requirements). Compliance officers track HRA completion rates against the governing CMS reg',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: HRA completion for high-risk members frequently triggers UM case opening for disease management or complex case management. This link supports the clinical workflow where HRA risk scores drive UM case',
    `answered_questions` STRING COMMENT 'Number of questions answered by the member.',
    `assessment_date` DATE COMMENT 'Date when the health risk assessment was performed.',
    `assessment_status` STRING COMMENT 'Current processing status of the assessment record.. Valid values are `completed|in_progress|cancelled|pending_review`',
    `assessment_type` STRING COMMENT 'Indicates whether the record is a Health Risk Assessment or a Social Determinants of Health screening.. Valid values are `HRA|SDOH`',
    `assessment_version` STRING COMMENT 'Version identifier of the assessment questionnaire used.',
    `community_resource_referrals` STRING COMMENT 'List of community resources referred to the member based on assessment findings.',
    `completion_channel` STRING COMMENT 'Channel through which the member completed the assessment.. Valid values are `portal|phone|mail|in_person`',
    `compliance_cms_required` BOOLEAN COMMENT 'Indicates if the assessment is required for CMS reporting.',
    `compliance_ncqa_required` BOOLEAN COMMENT 'Indicates if the assessment satisfies NCQA SDOH standards.',
    `identified_health_risks` STRING COMMENT 'Free‑text list of clinical health risks identified in the assessment.',
    `notes` STRING COMMENT 'Free‑form notes captured by the assessor.',
    `questionnaire_version` STRING COMMENT 'Version string of the questionnaire definition.',
    `recommended_programs` STRING COMMENT 'Care programs or interventions recommended for the member.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the data warehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `risk_score_percentile` DECIMAL(18,2) COMMENT 'Members risk score percentile compared to the plan population.',
    `risk_tier` STRING COMMENT 'Risk tier derived from the risk score.. Valid values are `low|moderate|high|very_high`',
    `screening_tool` STRING COMMENT 'Name of the questionnaire or tool used for the assessment.. Valid values are `plan_specific|ahc_hrs|prapare|hunger_vital|custom`',
    `sdoh_education` BOOLEAN COMMENT 'Indicates if the member reported education-related barriers.',
    `sdoh_financial_strain` BOOLEAN COMMENT 'Indicates if the member reported financial strain.',
    `sdoh_food_insecurity` BOOLEAN COMMENT 'Indicates if the member reported food insecurity.',
    `sdoh_housing_instability` BOOLEAN COMMENT 'Indicates if the member reported housing instability.',
    `sdoh_social_isolation` BOOLEAN COMMENT 'Indicates if the member reported social isolation.',
    `sdoh_transportation` BOOLEAN COMMENT 'Indicates if the member reported transportation barriers.',
    `source_system` STRING COMMENT 'Operational system of record that supplied the assessment data.. Valid values are `Casenet|Altruista`',
    `total_questions` STRING COMMENT 'Total number of questions in the questionnaire.',
    CONSTRAINT pk_hra PRIMARY KEY(`hra_id`)
) COMMENT 'Health Risk Assessment (HRA) and Social Determinants of Health (SDOH) screening records completed by members — capturing assessment date, assessment type (HRA, SDOH screening), assessment version, screening tool (plan-specific HRA, AHC HRSN, PRAPARE, Hunger Vital Sign), completion channel (portal, phone, mail), risk score, risk tier (low, moderate, high, very high), identified health risks, SDOH domain flags (food insecurity, housing instability, transportation, social isolation, financial strain, education), community resource referrals, recommended programs, and assessment status. Includes the versioned questionnaire catalog (question text, category, response type, scoring weight) and individual member responses with clinical flag triggers. Single source of truth for all member health risk and SDOH assessments. HRAs are a CMS-required data element for Medicare Advantage plans and drive care program enrollment and risk stratification. SDOH screenings support CMS health equity requirements and NCQA SDOH standards. Source: Casenet TruCare or Altruista.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`condition_registry` (
    `condition_registry_id` BIGINT COMMENT 'System-generated unique identifier for each condition registry record.',
    `care_plan_id` BIGINT COMMENT 'Identifier of the care plan linked to this condition, if any.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Conditions in the registry are confirmed by a specific provider for HCC coding and risk adjustment. CMS risk adjustment and RADV audit requirements mandate knowing which provider confirmed each condit',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: Condition registry entries are mapped to HCC codes for CMS risk adjustment. The hcc_mapping table is the authoritative HCC reference. This FK replaces the denormalized hcc_code plain attribute and sup',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Condition registry entries drive HCC risk adjustment submissions to CMS, which are health-plan-specific. RAF scores and HCC codes on condition_registry are submitted per health plan for risk adjustmen',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: Condition registry entries drive medical policy applicability for PA decisions and coverage determinations. UM reviewers reference the condition registry to validate which medical policies apply to a ',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the condition applies.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to claim.diagnosis. Business justification: Condition registry population from claims is a core chronic disease identification process. When a condition is identified via a claim diagnosis (ICD code), the registry entry must reference the origi',
    `pharmacy_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_claim. Business justification: Claims-based condition identification: a specific pharmacy claim (e.g., insulin, antidiabetic) triggers or confirms a condition registry entry. HEDIS and risk adjustment auditors must trace which phar',
    `procedure_id` BIGINT COMMENT 'Foreign key linking to claim.procedure. Business justification: Conditions are confirmed via procedure evidence (e.g., dialysis procedure confirming ESRD). The condition registry must trace back to the originating claim procedure for HCC risk adjustment audits and',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the condition is currently active for the member.',
    `condition_category` STRING COMMENT 'Business classification of the condition (e.g., HCC‑mapped, HEDIS chronic, behavioral health).. Valid values are `HCC|HEDIS|Behavioral|Other`',
    `condition_code` STRING COMMENT 'Standard ICD-10 diagnosis code representing the clinical condition.. Valid values are `^[A-Z][0-9][0-9A-Z]{0,3}$`',
    `condition_description` STRING COMMENT 'Human‑readable description of the condition.',
    `confirmation_status` STRING COMMENT 'Current confirmation state of the condition record.. Valid values are `confirmed|pending|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition record was first created.',
    `data_quality_status` STRING COMMENT 'Current data quality assessment of the condition record.. Valid values are `valid|invalid|pending_review`',
    `effective_end_date` DATE COMMENT 'Date the condition ceased to be effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date the condition became effective for care program eligibility.',
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
    `source_system` STRING COMMENT 'Originating system that supplied the condition data.. Valid values are `casenet|tru_care|altruista`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the condition record.',
    CONSTRAINT pk_condition_registry PRIMARY KEY(`condition_registry_id`)
) COMMENT 'Chronic condition registry identifying members with specific diagnosed conditions — including ICD-10 condition code, condition category (HCC-mapped, HEDIS chronic condition, behavioral health), identification method (claims-based, EHR, provider attestation, HRA), identification date, confirmation status, and active/inactive flag. Serves as the authoritative clinical condition roster within the care domain for care program targeting, population health stratification, and HEDIS measure eligibility determination. References the risk domain for authoritative HCC/RAF scoring. Source: Casenet TruCare or Altruista clinical data.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`hedis_measure` (
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the HEDIS measure. [_canonical_skip_reason: REFERENCE_LOOKUP - catalog of HEDIS quality measures]',
    `accreditation_program_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_program. Business justification: HEDIS measures are core components of NCQA accreditation programs. The accreditation_program.measures attribute is a denormalization signal. Compliance officers must link each hedis_measure to its pri',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: HEDIS measures are mandated by CMS and NCQA under specific regulatory obligations (ACA quality reporting, Medicare Star Ratings). Compliance officers must link each HEDIS measure to its governing regu',
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
    `measure_related_raf` STRING COMMENT 'Comma‑separated list of Risk Adjustment Factor (RAF) variables linked to the measure.',
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
    `source_system` STRING COMMENT 'Originating system that maintains the measure definition (e.g., Casenet TruCare, Altruista).',
    `version_number` STRING COMMENT 'Version of the measure definition, incremented on each change.',
    CONSTRAINT pk_hedis_measure PRIMARY KEY(`hedis_measure_id`)
) COMMENT 'Reference catalog of HEDIS (Healthcare Effectiveness Data and Information Set) quality measures maintained by NCQA — including measure ID, measure name, measure domain (effectiveness of care, access/availability, utilization), measurement year, eligible population criteria, numerator definition, denominator definition, exclusion criteria, and data collection methodology (administrative, hybrid, survey). Authoritative reference for HEDIS performance tracking and Star Ratings.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`hedis_result` (
    `hedis_result_id` BIGINT COMMENT 'System-generated unique identifier for each HEDIS result record.',
    `accreditation_survey_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_survey. Business justification: HEDIS results are submitted as evidence during NCQA accreditation surveys. Compliance officers must trace which hedis_results supported a specific accreditation_survey. This is a core NCQA accreditati',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: NCQA HEDIS Compliance Audits are a specific type of audit_engagement that validates hedis_results. Compliance officers must trace which audit_engagement validated specific HEDIS results for audit defe',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Facility-based HEDIS measures (e.g., inpatient follow-up, maternity) must be attributed to the specific facility for NCQA reporting and facility quality scorecards. Existing hedis_result.provider_id d',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: HEDIS results are aggregated at the group practice level for group-level quality scorecards and value-based contract performance reporting. CMS and NCQA require group practice attribution for quality ',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled.',
    `hedis_measure_id` BIGINT COMMENT 'Standard code for the HEDIS quality measure (e.g., HM-001).',
    `incentive_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.incentive_arrangement. Business justification: HEDIS results are the primary measurement input for quality-based incentive arrangements. Payers use HEDIS results to calculate earned incentives, withholds, and shared savings. A health insurance dom',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: HEDIS methodology mandates continuous enrollment criteria — results are calculated against specific eligibility spans. Regulatory NCQA reporting requires linking each HEDIS result to the eligibility s',
    `identity_id` BIGINT COMMENT 'Unique identifier for the member to whom the HEDIS result applies.',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: HEDIS results are reported at the practice location level for provider-site performance scorecards and NCQA regulatory reporting. Existing hedis_result.provider_id identifies the provider but not the ',
    `provider_id` BIGINT COMMENT 'Identifier of the provider associated with the source claim or service.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: HEDIS results are filed with NCQA and CMS as regulatory submissions. Compliance officers must trace each hedis_result to its primary regulatory_submission for audit defense, submission status tracking',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: HEDIS numerator criteria are met by specific claim service lines (e.g., a mammogram claim line satisfying Breast Cancer Screening measure). NCQA HEDIS audit requires structured traceability from resul',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: HEDIS results determine quality gate met status in VBC contracts. VBC settlement and shared savings calculations depend on HEDIS performance. This link enables direct traceability from member-level HE',
    `vbc_performance_period_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_performance_period. Business justification: HEDIS results are reported against specific VBC performance periods for settlement. The link enables direct traceability from a member-level HEDIS result to the performance period in which it was meas',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: HEDIS results are reported per measurement year aligned to plan year for NCQA accreditation and CMS regulatory submissions. measurement_year is a denormalized representation of the plan year entity; y',
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
    `numerator_criteria_met` BOOLEAN COMMENT 'Indicates whether the member satisfied the numerator condition for the measure.',
    `result_timestamp` TIMESTAMP COMMENT 'Date and time when the HEDIS result was calculated.',
    `source_record_type` STRING COMMENT 'Type of the source record that supplied data for the result.. Valid values are `claim|lab|medical_record`',
    CONSTRAINT pk_hedis_result PRIMARY KEY(`hedis_result_id`)
) COMMENT 'Single source of truth for HEDIS (Healthcare Effectiveness Data and Information Set) quality measure definitions and member-level compliance results. Contains the authoritative NCQA-published measure catalog (measure ID, name, domain: effectiveness of care/access/availability/utilization, measurement year, eligible population criteria, numerator/denominator definitions, exclusion criteria, data collection methodology: administrative/hybrid/survey) and member-level results indicating whether each member met numerator criteria for a given measurement year. Tracks data source (claim, lab, supplemental, medical record), compliance status (compliant, non-compliant, excluded), and hybrid audit trail. Aggregated to produce plan-level HEDIS rates submitted to NCQA for Star Ratings, accreditation, and quality bonus payments.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`cahps_survey` (
    `cahps_survey_id` BIGINT COMMENT 'Unique system-generated identifier for each CAHPS survey record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: CAHPS surveys are administered and reported at the health plan level for CMS Star Ratings and NCQA accreditation. Regulatory submission of CAHPS results requires explicit health plan attribution — a d',
    `member_enrollment_id` BIGINT COMMENT 'Identifier of the health plan the member was enrolled in during the survey.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the member who completed the survey.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: CAHPS survey results are reported by network for CMS star ratings and NCQA accreditation. Network-level CAHPS performance is a regulatory reporting requirement; plans must stratify member experience s',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: CAHPS survey results are submitted to CMS as regulatory submissions for Medicare Star Ratings. Compliance officers must trace cahps_survey records to their regulatory_submission for filing status trac',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: CAHPS surveys are tied to a specific plan year for CMS Star Ratings reporting and year-over-year trend analysis. survey_year is a denormalized representation of the plan year entity; replacing it with',
    `administration_method` STRING COMMENT 'Method used to deliver the survey to members.. Valid values are `mail|phone|mixed|electronic`',
    `composite_score_flag` BOOLEAN COMMENT 'Indicates whether the overall score is a composite of domain scores.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first loaded into the warehouse.',
    `customer_service_score` DECIMAL(18,2) COMMENT 'Average score for the "Customer Service" domain.',
    `data_source_system` STRING COMMENT 'Name of the operational system that supplied the survey data (e.g., "Casenet TruCare").',
    `doctor_communication_score` DECIMAL(18,2) COMMENT 'Average score for the "Doctor Communication" domain.',
    `external_survey_code` STRING COMMENT 'External identifier used by the survey vendor or regulatory reporting (e.g., vendor‑assigned code).',
    `getting_care_quickly_score` DECIMAL(18,2) COMMENT 'Average score for the "Getting Care Quickly" domain.',
    `getting_needed_care_score` DECIMAL(18,2) COMMENT 'Average score for the "Getting Needed Care" domain.',
    `is_test_survey` BOOLEAN COMMENT 'Flag indicating whether the record represents a test or pilot survey.',
    `member_age` STRING COMMENT 'Age of the member at the time of survey administration.',
    `member_gender` STRING COMMENT 'Gender of the member.. Valid values are `male|female|other`',
    `member_state` STRING COMMENT 'Two‑letter state code of the members residence.',
    `member_zip` STRING COMMENT 'Five‑digit ZIP code of the members residence.',
    `notes` STRING COMMENT 'Free‑text field for any additional comments or observations about the survey.',
    `overall_satisfaction_score` DECIMAL(18,2) COMMENT 'Composite overall satisfaction rating derived from the survey.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the survey results are included in CMS Star Ratings reporting.',
    `response_deadline` DATE COMMENT 'Final date by which members could submit responses.',
    `response_rate` DECIMAL(18,2) COMMENT 'Percentage of sampled members who returned a completed survey.',
    `sample_size` STRING COMMENT 'Number of members selected for the survey sample.',
    `sampling_frame` STRING COMMENT 'Description of the member population from which the sample was drawn.',
    `star_rating_impact_score` DECIMAL(18,2) COMMENT 'Score representing the contribution of this survey to the plans Star Rating.',
    `survey_end_date` DATE COMMENT 'Date when the survey administration closed.',
    `survey_language` STRING COMMENT 'Language in which the survey was presented to the member.. Valid values are `english|spanish|other`',
    `survey_mode` STRING COMMENT 'Indicates whether the survey was self‑administered or conducted by an interviewer.. Valid values are `self_administered|interviewer_administered`',
    `survey_name` STRING COMMENT 'Human‑readable name of the CAHPS survey (e.g., "2023 Health Plan CAHPS").',
    `survey_start_date` DATE COMMENT 'Date when the survey administration began.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey.. Valid values are `pending|in_progress|completed|closed`',
    `survey_type` STRING COMMENT 'Classification of the CAHPS survey variant.. Valid values are `health_plan|medicare|pcmh`',
    `survey_version` STRING COMMENT 'Version identifier for the survey instrument.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey record.',
    CONSTRAINT pk_cahps_survey PRIMARY KEY(`cahps_survey_id`)
) COMMENT 'CAHPS (Consumer Assessment of Healthcare Providers and Systems) survey administration and response records — capturing survey type (Health Plan CAHPS, Medicare CAHPS, PCMH CAHPS), survey year, administration method (mail, phone, mixed), member sampling frame, survey vendor, response status, overall satisfaction score, and individual member responses by question with composite score contribution flags. CAHPS results feed directly into CMS Star Ratings and NCQA accreditation. Enables drill-down analysis of member experience drivers across CAHPS domains (getting needed care, getting care quickly, doctor communication, customer service). Source: Survey vendor data.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`member_risk_tier` (
    `member_risk_tier_id` BIGINT COMMENT 'System‑generated unique identifier for each risk‑tier record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Member risk tier assignments are health-plan-specific for risk adjustment submissions to CMS and internal care management targeting. Risk stratification reports and population health dashboards are al',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Risk tier assignments are plan-year specific — a members risk stratification is evaluated per benefit period for premium setting and care intervention targeting. Linking risk tier to eligibility span',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to which the tier assignment applies.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Risk tier assignment is directly derived from the members calculated risk score. Care management systems assign members to tiers (e.g., high/medium/low) based on member_risk_score values. This FK for',
    `premium_rate_id` BIGINT COMMENT 'Foreign key linking to billing.premium_rate. Business justification: Risk tier assignment (tier_code, risk_score) directly determines which premium rate applies to a member. This is a core actuarial rating process — risk stratification feeds premium calculation. Health',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: member_risk_tier contains a recommended_care_program STRING field that stores the name of the recommended care management program for a member at a given risk tier. Normalizing this to a program_id FK',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Risk tier assignments reset annually and are used for year-over-year risk stratification reporting and plan year budget forecasting. Linking to plan year enables accurate annual risk adjustment reconc',
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
    `pmpm_cost_band` STRING COMMENT 'Per‑Member‑Per‑Month cost band associated with the tier.. Valid values are `low|medium|high`',
    `risk_factor_weight` DECIMAL(18,2) COMMENT 'Weight applied to the risk factor in the predictive model.',
    `risk_score_source` STRING COMMENT 'Origin of the risk score used for the assignment.. Valid values are `model|clinical_review|manual`',
    `segment_description` STRING COMMENT 'Detailed description of the segment criteria.',
    `segment_name` STRING COMMENT 'Name of the population segment definition linked to this tier.',
    `source_system` STRING COMMENT 'System of record that supplied the tier data.. Valid values are `Casenet TruCare|Altruista`',
    `tier_band` STRING COMMENT 'Broad risk band classification.. Valid values are `low|rising|high|catastrophic`',
    `tier_code` STRING COMMENT 'Business identifier/code used to reference the tier in downstream systems.',
    `tier_name` STRING COMMENT 'Human‑readable name of the risk tier (e.g., "High Risk").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tier record.',
    `version_number` STRING COMMENT 'Version of the tier definition for change tracking.',
    CONSTRAINT pk_member_risk_tier PRIMARY KEY(`member_risk_tier_id`)
) COMMENT 'Member-level risk tier assignment and population health stratification — containing population segment definitions (segment name, stratification model: predictive risk model/HCC-based/claims-based, risk tier bands: low/rising risk/high/catastrophic, inclusion criteria, recommended care program, PMPM cost band, effective date) and member-specific tier assignments (risk score, assignment date, assignment method: automated model/manual override/clinical review, next reassessment date). Single source of truth for both population segment configuration and member-level risk tier history. Tracks risk tier changes over time to support longitudinal population health management and care program targeting. Distinct from CMS RAF scores (owned by the risk domain) — this covers all LOBs and internal stratification models. Source: Casenet TruCare or Altruista population health module.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` (
    `sdoh_assessment_id` BIGINT COMMENT 'Unique identifier for the SDOH assessment record.',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: SDOH assessments are conducted for members in care management programs. Linking sdoh_assessment to care_enrollment contextualizes the assessment within the specific program enrollment, enabling progra',
    `grace_period_id` BIGINT COMMENT 'Foreign key linking to billing.grace_period. Business justification: SDOH assessments identifying financial strain (sdoh_financial_strain) directly inform grace period extension decisions per CMS and state regulatory requirements. Care coordinators document SDOH findin',
    `hra_id` BIGINT COMMENT 'Foreign key linking to care.hra. Business justification: SDOH assessments are frequently triggered by or conducted in conjunction with HRA screenings. The HRA captures SDOH flags (sdoh_food_insecurity, sdoh_housing_instability, sdoh_transportation, etc.) th',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member being assessed.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: SDOH assessments contribute SDOH factors to CMS risk adjustment models. Health plans must track which member_risk_score incorporates SDOH inputs for regulatory submission accuracy. sdoh_assessment alr',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: SDOH assessments identifying high social risk (food insecurity, housing instability) trigger UM case opening for complex case management and community resource coordination. Required for CMS value-bas',
    `assessment_date` DATE COMMENT 'Date when the SDOH assessment was conducted.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score summarizing assessment risk (if applicable).',
    `assessment_version` STRING COMMENT 'Version number of the assessment instrument used.',
    `confidentiality_consent_flag` BOOLEAN COMMENT 'Members consent for sharing SDOH data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was created.',
    `follow_up_due_date` DATE COMMENT 'Date by which follow-up should be completed.',
    `follow_up_status` STRING COMMENT 'Current status of follow-up actions.. Valid values are `pending|completed|not_needed`',
    `notes` STRING COMMENT 'Free-text notes captured during assessment.',
    `referral_made_flag` BOOLEAN COMMENT 'Indicates whether a referral to community resources was made.',
    `referral_resource` STRING COMMENT 'Name or code of the community resource referred.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk adjustment calculations (e.g., HCC).',
    `risk_level` STRING COMMENT 'Risk level determined from the assessment.. Valid values are `low|moderate|high`',
    `screening_tool` STRING COMMENT 'Standardized tool used to conduct the assessment.. Valid values are `AHC_HRSN|PRAPARE|HUNGER_VITAL_SIGN`',
    `sdoh_assessment_status` STRING COMMENT 'Current lifecycle status of the assessment record.. Valid values are `active|inactive|archived`',
    `sdoh_domain` STRING COMMENT 'Domain of social determinant assessed.. Valid values are `food_insecurity|housing_instability|transportation|social_isolation|financial_strain|education`',
    `source_system` STRING COMMENT 'System of record where the assessment originated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    CONSTRAINT pk_sdoh_assessment PRIMARY KEY(`sdoh_assessment_id`)
) COMMENT 'Social Determinants of Health (SDOH) assessment records capturing non-clinical factors affecting member health outcomes — including assessment date, SDOH domain (food insecurity, housing instability, transportation, social isolation, financial strain, education), screening tool used (AHC HRSN, PRAPARE, Hunger Vital Sign), risk level, referral to community resource made flag, and follow-up status. Supports CMS health equity requirements, NCQA SDOH standards, and targeted care management interventions.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`team` (
    `team_id` BIGINT COMMENT 'Unique system-generated identifier for the care team.',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Care teams are organized around capitation arrangements — the arrangement defines the attributed population and PMPM funding that supports the team. Finance and operations teams require this link to a',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: Care teams performing delegated functions (UM, CM, credentialing) are governed by delegation agreements. The delegation agreement defines team scope, oversight requirements, and audit standards. NCQA ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Multidisciplinary care teams are anchored to specific facilities (hospitals, clinics) in health insurance operations. Care team management, provider directory operations, and facility-based care coord',
    `coordinator_id` BIGINT COMMENT 'Identifier of the primary care coordinator leading the team.',
    `parent_team_id` BIGINT COMMENT 'Self-referencing FK on team (parent_team_id)',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Community-based and primary care teams are associated with specific practice locations. Care coordination workflows, provider directory operations, and network adequacy reporting require knowing which',
    `program_id` BIGINT COMMENT 'Identifier of the care program to which the team is linked.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Care teams operate under specific provider contracts that dictate service scope and payment; linking supports team‑level cost and quality reporting.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Multidisciplinary care teams are organized around specific provider networks, particularly in ACO and VBC arrangements. Network-specific team configuration is standard in managed care operations; care',
    `vbc_arrangement_id` BIGINT COMMENT 'Foreign key linking to network.vbc_arrangement. Business justification: In value-based care, multidisciplinary care teams are directly tied to VBC arrangements (ACO, PCMH). The team supports the arrangements care coordination requirements and quality targets. VBC operati',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: Care teams are organized to support VBC contract performance. The VBC contract defines quality targets and cost benchmarks the team is responsible for achieving. VBC program managers require this link',
    `audit_created_by` STRING COMMENT 'System user identifier that created the record.',
    `audit_updated_by` STRING COMMENT 'System user identifier that performed the most recent update.',
    `behavioral_health_provider_count` STRING COMMENT 'Count of behavioral health clinicians (psychologists, counselors) on the team.',
    `communication_preference` STRING COMMENT 'Preferred method for the team to receive communications.. Valid values are `email|phone|portal|mail|sms`',
    `community_health_worker_count` STRING COMMENT 'Count of community health workers on the team.',
    `consent_obtained_date` DATE COMMENT 'Date on which privacy consent was obtained.',
    `contact_email` STRING COMMENT 'Email address used for team communications.',
    `contact_method` STRING COMMENT 'Primary way the team is contacted for operational matters.. Valid values are `email|phone|portal`',
    `contact_phone` STRING COMMENT 'Phone number used for team communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care team record was first created.',
    `data_quality_status` STRING COMMENT 'Assessment of the data quality for this record.. Valid values are `good|questionable|bad`',
    `effective_end_date` DATE COMMENT 'Date when the care team was deactivated or retired.',
    `effective_start_date` DATE COMMENT 'Date when the care team became operational.',
    `hcc_included` BOOLEAN COMMENT 'True if HCCs are included in the team’s risk profile.',
    `hcc_version` STRING COMMENT 'Version of the HCC model applied to the team’s risk calculations.',
    `is_multidisciplinary` BOOLEAN COMMENT 'True if the team includes multiple professional disciplines.',
    `is_primary_care_team` BOOLEAN COMMENT 'True if this team is the members primary care team.',
    `last_review_date` DATE COMMENT 'Date when the record’s data quality was last reviewed.',
    `lead_coordinator_end_date` DATE COMMENT 'Date the lead coordinators assignment ended, if applicable.',
    `lead_coordinator_start_date` DATE COMMENT 'Date the lead coordinator began their assignment.',
    `member_count` STRING COMMENT 'Count of members currently assigned to this care team.',
    `notes` STRING COMMENT 'Free‑form notes about the care team.',
    `pharmacist_count` STRING COMMENT 'Count of pharmacists participating in the care team.',
    `privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the team has documented privacy consent for handling PHI.',
    `provider_count` STRING COMMENT 'Total number of provider‑type members (PCP, specialists, etc.) on the team.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used in risk adjustment calculations for the team.',
    `social_worker_count` STRING COMMENT 'Count of social workers on the team.',
    `source_system` STRING COMMENT 'Originating operational system (e.g., Casenet TruCare).',
    `specialist_count` STRING COMMENT 'Count of specialist clinicians on the team.',
    `status_reason` STRING COMMENT 'Narrative explanation for the current status of the team.',
    `team_code` STRING COMMENT 'Business code used to reference the care team in external systems.',
    `team_name` STRING COMMENT 'Human‑readable name of the care team.',
    `team_status` STRING COMMENT 'Current lifecycle status of the care team.. Valid values are `active|inactive|pending|closed`',
    `team_type` STRING COMMENT 'Classification of the team based on its functional focus.. Valid values are `clinical|non_clinical|behavioral|pharmacy|social`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care team record.',
    `version_number` STRING COMMENT 'Version number for optimistic concurrency control.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Multi-disciplinary care team composition for members enrolled in care management programs — documenting team members by role (PCP, specialist, behavioral health provider, pharmacist, social worker, community health worker), their NPI or staff ID, team role start/end dates, lead coordinator designation, and communication preferences. Supports NCQA care management standards requiring documented care team composition, CMS chronic care management (CCM) billing requirements, and care coordination across clinical and non-clinical team members. Enables care team roster reporting, role gap identification, and team-based care analytics.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` (
    `team_enrollment_assignment_id` BIGINT COMMENT 'Primary key for the team_enrollment_assignment association',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to the member care enrollment being served by the team.',
    `team_id` BIGINT COMMENT 'Foreign key linking to the care team assigned to the enrollment.',
    `assignment_date` DATE COMMENT 'The date on which the care team was formally assigned to the members care enrollment. Sourced from detection phase relationship data.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the team-enrollment assignment. Sourced from detection phase relationship data.',
    `effective_end_date` DATE COMMENT 'Date when the teams active management of this enrollment ended. Null if the assignment is currently active. Sourced from detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when the teams active management of this enrollment began. Sourced from detection phase relationship data.',
    `role_on_team` STRING COMMENT 'The functional role or service type the team provides for this specific enrollment (e.g., PRIMARY_CARE, BEHAVIORAL_HEALTH, COMPLEX_CARE, CCM). Sourced from detection phase relationship data.',
    CONSTRAINT pk_team_enrollment_assignment PRIMARY KEY(`team_enrollment_assignment_id`)
) COMMENT 'This association product represents the Assignment between care.team and care.care_enrollment. It captures the operational record of a multi-disciplinary care team being assigned to manage a specific member care enrollment, including the assignment lifecycle (dates, status) and the teams functional role for that enrollment. Each record links one team to one care enrollment with attributes that exist only in the context of this assignment relationship. Supports NCQA care management standards and CMS chronic care management (CCM) billing requirements for documented team-based care.. Existence Justification: In care management operations, multi-disciplinary care teams are actively assigned to member care enrollments as a managed business process. One team can serve many enrolled members simultaneously (e.g., a behavioral health team managing 50 enrolled members), and one enrolled member can be served by multiple teams concurrently (e.g., a primary care team plus a behavioral health team plus a complex care team). This team-enrollment assignment is a recognized operational entity in care management platforms like Casenet TruCare, carrying its own lifecycle data including assignment dates, status, and role that cannot be stored on either parent entity alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `health_insurance_ecm`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ADD CONSTRAINT `fk_care_coordinator_assignment_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ADD CONSTRAINT `fk_care_coordinator_assignment_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `health_insurance_ecm`.`care`.`gap`(`gap_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `health_insurance_ecm`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_hra_id` FOREIGN KEY (`hra_id`) REFERENCES `health_insurance_ecm`.`care`.`hra`(`hra_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_parent_team_id` FOREIGN KEY (`parent_team_id`) REFERENCES `health_insurance_ecm`.`care`.`team`(`team_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ADD CONSTRAINT `fk_care_team_enrollment_assignment_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ADD CONSTRAINT `fk_care_team_enrollment_assignment_team_id` FOREIGN KEY (`team_id`) REFERENCES `health_insurance_ecm`.`care`.`team`(`team_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`care` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `health_insurance_ecm`.`care` SET TAGS ('dbx_domain' = 'care');
ALTER TABLE `health_insurance_ecm`.`care`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`care`.`program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `incentive_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `vbc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `clinical_protocol` SET TAGS ('dbx_business_glossary_term' = 'Clinical Protocol');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `enrollment_cap` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `enrollment_current` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('dbx_business_glossary_term' = 'Included HCC Codes');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Version');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `is_evidence_based` SET TAGS ('dbx_business_glossary_term' = 'Evidence‑Based Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'individual|group|medicare|medicaid|exchange|government');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `outcome_actual` SET TAGS ('dbx_business_glossary_term' = 'Outcome Actual');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `outcome_measure` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `outcome_target` SET TAGS ('dbx_business_glossary_term' = 'Outcome Target');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Care Program Category');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Care Program Code');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Care Program Name');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|draft');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Care Program Type');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'disease_management|case_management|maternity|behavioral_health|wellness|chronic_care');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly|monthly|semiannual');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Program Version Number');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment ID');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Attributed Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Manager ID');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program ID');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `acuity_level` SET TAGS ('dbx_business_glossary_term' = 'Acuity Level (ACUITY_LEVEL)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `acuity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `care_manager_assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Care Manager Assigned Date');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status (CONSENT_STATUS)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|declined|pending');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENROLLMENT_NUMBER)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ENROLLMENT_SOURCE)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'outreach|referral|self_referral|claims_triggered|hra_triggered');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLLMENT_STATUS)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|disenrolled|pending');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ENROLLMENT_TYPE)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'disease_management|case_management|population_health|wellness');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Score');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Tier (PROGRAM_TIER)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_value_regex' = 'standard|enhanced|premium');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Reason');
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `barriers_to_care` SET TAGS ('dbx_business_glossary_term' = 'Barriers to Care');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Status (STATUS)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|abandoned|draft');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `high_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Name (PLAN_NAME)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Number (PLAN_NUMBER)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Type (PLAN_TYPE)');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'clinical|behavioral|sdoh|social|pharmacologic');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Version');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `plan_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Goal Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Care Plan Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Measurement Date');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'clinical|behavioral|social_determinant|pharmacologic|nutrition');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `goal_code` SET TAGS ('dbx_business_glossary_term' = 'Goal Code');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_business_glossary_term' = 'Goal Name');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'lab|vital|self_report|clinical_assessment');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('dbx_value_regex' = 'active|achieved|abandoned|on_hold|cancelled');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Goal Priority');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'mg/dL|mmol/L|%|mmHg|kg|steps');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `health_insurance_ecm`.`care`.`plan_goal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Identifier (CGID)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (CCI)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `incentive_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (MID)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date (ARD)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `clinical_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Category (CCAT)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Close Date (GCD)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_business_glossary_term' = 'Gap Closure Method (GCM)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_value_regex' = 'claim|supplemental|attestation|provider_update|none');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Status (DOCS)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('dbx_value_regex' = 'complete|pending|missing');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `gap_description` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Description (CGD)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Status (CGS)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|resolved');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Type (CGT)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_value_regex' = 'preventive|chronic|medication|screening|followup|other');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag (CRIT)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `measure_target_value` SET TAGS ('dbx_business_glossary_term' = 'Measure Target Value (MTV)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Open Date (GOD)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PRIO)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Casenet|Altruista|Custom');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date (TRD)');
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (CCID)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `assigned_lob` SET TAGS ('dbx_business_glossary_term' = 'Assigned Line of Business (ALOB)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `assigned_lob` SET TAGS ('dbx_value_regex' = 'individual|group|employer|government');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('dbx_business_glossary_term' = 'Caseload Capacity (CC)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `caseload_weight` SET TAGS ('dbx_business_glossary_term' = 'Caseload Weight (CW)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `certification_codes` SET TAGS ('dbx_business_glossary_term' = 'Certification Codes (CC)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RS)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `current_caseload_count` SET TAGS ('dbx_business_glossary_term' = 'Current Caseload Count (CCC)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Email Address (CCEA)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (ES)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator First Name (CCFN)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Full Name (CCFN)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HD)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Last Name (CCLN)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date (LTD)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Notes (CN)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `organization_unit` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit (OU)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Phone Number (CCPN)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{1,3}[ -]?(?[0-9]{3})?[ -]?[0-9]{3}[ -]?[0-9]{4}$');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (PCM)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|portal');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Role Type (CRT)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'care_coordinator|case_manager|disease_management_nurse|health_coach');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `specialty_area` SET TAGS ('dbx_business_glossary_term' = 'Specialty Area (SA)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `specialty_area` SET TAGS ('dbx_value_regex' = 'diabetes|cardiology|oncology|behavioral_health|pediatrics|geriatrics');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ALTER COLUMN `training_certifications` SET TAGS ('dbx_business_glossary_term' = 'Training Certifications (TC)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `coordinator_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Assignment ID');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Care Case Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'manual|system|automated');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type (Primary/Backup/Specialist/Consultant)');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|backup|specialist|consultant');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `caseload_weight` SET TAGS ('dbx_business_glossary_term' = 'Caseload Weight');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `member_outreach_id` SET TAGS ('dbx_business_glossary_term' = 'Member Outreach ID');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `gap_id` SET TAGS ('dbx_business_glossary_term' = 'Gap Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `hipaa_privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Privacy Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Outreach Channel');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|mail|sms|portal');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `compliance_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `consent_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Outreach Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|other');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `member_outreach_status` SET TAGS ('dbx_business_glossary_term' = 'Outreach Record Status');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `member_outreach_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outreach Outcome');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'reached|voicemail|refused|enrolled|no_answer|partial');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `outcome_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outcome Recorded Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `outreach_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Outreach Duration (Seconds)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `outreach_notes` SET TAGS ('dbx_business_glossary_term' = 'Outreach Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `outreach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outreach Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Outreach Purpose');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'program_enrollment|care_gap_closure|hra_completion|medication_adherence|wellness_education|other');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Casenet|Altruista|CRM|Other');
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `hra_id` SET TAGS ('dbx_business_glossary_term' = 'Health Risk Assessment ID (HRA_ID)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member_ID)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `answered_questions` SET TAGS ('dbx_business_glossary_term' = 'Answered Questions');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled|pending_review');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type (HRA or SDOH Screening)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'HRA|SDOH');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `community_resource_referrals` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Referrals');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `completion_channel` SET TAGS ('dbx_business_glossary_term' = 'Completion Channel');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `completion_channel` SET TAGS ('dbx_value_regex' = 'portal|phone|mail|in_person');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `compliance_cms_required` SET TAGS ('dbx_business_glossary_term' = 'CMS Required Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `compliance_ncqa_required` SET TAGS ('dbx_business_glossary_term' = 'NCQA Required Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_business_glossary_term' = 'Identified Health Risks');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `questionnaire_version` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Version');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `recommended_programs` SET TAGS ('dbx_business_glossary_term' = 'Recommended Programs');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `risk_score_percentile` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Percentile');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `risk_score_percentile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `risk_score_percentile` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier (Low, Moderate, High, Very High)');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `screening_tool` SET TAGS ('dbx_business_glossary_term' = 'Screening Tool');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `screening_tool` SET TAGS ('dbx_value_regex' = 'plan_specific|ahc_hrs|prapare|hunger_vital|custom');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_business_glossary_term' = 'Education Barrier Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_business_glossary_term' = 'Financial Strain Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_business_glossary_term' = 'Food Insecurity Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_business_glossary_term' = 'Housing Instability Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_business_glossary_term' = 'Social Isolation Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_business_glossary_term' = 'Transportation Barrier Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Casenet|Altruista');
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ALTER COLUMN `total_questions` SET TAGS ('dbx_business_glossary_term' = 'Total Questions');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Confirming Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Source Diagnosis Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `pharmacy_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Source Pharmacy Claim Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Source Procedure Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_value_regex' = 'HCC|HEDIS|Behavioral|Other');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code (ICD-10)');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9][0-9A-Z]{0,3}$');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|rejected');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending_review');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `identification_method` SET TAGS ('dbx_business_glossary_term' = 'Identification Method');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `identification_method` SET TAGS ('dbx_value_regex' = 'claims|ehr|provider_attestation|hra');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `is_chronic` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Indicator');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Condition Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Onset Date');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `population_segment` SET TAGS ('dbx_business_glossary_term' = 'Population Segment');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `population_segment` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `raf_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `risk_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Condition Severity');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|critical');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'casenet|tru_care|altruista');
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure ID');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `data_collection_methodology` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methodology');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `data_collection_methodology` SET TAGS ('dbx_value_regex' = 'administrative|hybrid|survey');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `denominator_definition` SET TAGS ('dbx_business_glossary_term' = 'Denominator Definition');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `eligible_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible Population Criteria');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Code');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_denominator_logic` SET TAGS ('dbx_business_glossary_term' = 'Denominator Logic');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_description` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Description');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_domain` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Domain');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_domain` SET TAGS ('dbx_value_regex' = 'effectiveness_of_care|access_availability|utilization');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_exclusion_logic` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Logic');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Name');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_national_benchmark` SET TAGS ('dbx_business_glossary_term' = 'National Benchmark');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_notes` SET TAGS ('dbx_business_glossary_term' = 'Measure Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_numerator_logic` SET TAGS ('dbx_business_glossary_term' = 'Numerator Logic');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_owner` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_related_raf` SET TAGS ('dbx_business_glossary_term' = 'Related RAF Variables');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measure Reporting Frequency');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_scoring_method` SET TAGS ('dbx_business_glossary_term' = 'Measure Scoring Method');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_scoring_method` SET TAGS ('dbx_value_regex' = 'rate|percentage|binary');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_star_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('dbx_business_glossary_term' = 'State Benchmark');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('dbx_business_glossary_term' = 'Measure Status');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('dbx_value_regex' = 'active|retired|draft|pending');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_target_value` SET TAGS ('dbx_business_glossary_term' = 'Measure Target Value');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measure_url` SET TAGS ('dbx_business_glossary_term' = 'Measure URL');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `numerator_definition` SET TAGS ('dbx_business_glossary_term' = 'Numerator Definition');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `hedis_result_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Result Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `accreditation_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Survey Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `incentive_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Source Claim Line Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `vbc_performance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Performance Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'administrative|hybrid|survey');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|excluded');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'claim|lab|supplemental|medical_record');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `denominator_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Denominator Criteria Met Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Category');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_value_regex' = 'preventive|chronic|behavioral|screening');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `measure_score` SET TAGS ('dbx_business_glossary_term' = 'Measure Score');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Measure Type');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_value_regex' = 'process|outcome|structure');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `measure_version` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Version');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `numerator_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Numerator Criteria Met Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Determination Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `source_record_type` SET TAGS ('dbx_business_glossary_term' = 'Source Record Type');
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ALTER COLUMN `source_record_type` SET TAGS ('dbx_value_regex' = 'claim|lab|medical_record');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `cahps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'CAHPS Survey ID');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Plan ID');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `administration_method` SET TAGS ('dbx_business_glossary_term' = 'Administration Method');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `administration_method` SET TAGS ('dbx_value_regex' = 'mail|phone|mixed|electronic');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `composite_score_flag` SET TAGS ('dbx_business_glossary_term' = 'Composite Score Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `customer_service_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Score');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `doctor_communication_score` SET TAGS ('dbx_business_glossary_term' = 'Doctor Communication Score');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `external_survey_code` SET TAGS ('dbx_business_glossary_term' = 'External Survey Code');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `getting_care_quickly_score` SET TAGS ('dbx_business_glossary_term' = 'Getting Care Quickly Score');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `getting_needed_care_score` SET TAGS ('dbx_business_glossary_term' = 'Getting Needed Care Score');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `is_test_survey` SET TAGS ('dbx_business_glossary_term' = 'Test Survey Indicator');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_age` SET TAGS ('dbx_business_glossary_term' = 'Member Age');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_age` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_age` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('dbx_business_glossary_term' = 'Member Gender');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('dbx_value_regex' = 'male|female|other');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('dbx_business_glossary_term' = 'Member State');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('dbx_business_glossary_term' = 'Member ZIP Code');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `overall_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Satisfaction Score');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `response_rate` SET TAGS ('dbx_business_glossary_term' = 'Response Rate (Percent)');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `sampling_frame` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frame Description');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `star_rating_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact Score');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_end_date` SET TAGS ('dbx_business_glossary_term' = 'Survey End Date');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_language` SET TAGS ('dbx_value_regex' = 'english|spanish|other');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_mode` SET TAGS ('dbx_business_glossary_term' = 'Survey Mode');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_mode` SET TAGS ('dbx_value_regex' = 'self_administered|interviewer_administered');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_start_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type (Health Plan CAHPS, Medicare CAHPS, PCMH CAHPS)');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'health_plan|medicare|pcmh');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Tier ID');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'automated_model|manual_override|clinical_review');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `claims_count_last_year` SET TAGS ('dbx_business_glossary_term' = 'Claims Count Last Year');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_business_glossary_term' = 'Demographic Group');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_value_regex' = 'adult|senior|child|young_adult|teen');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'HCC Score');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Tier Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Status');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Stratification Model Type (Predictive, HCC‑Based, Claims‑Based)');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'predictive|hcc_based|claims_based');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reassessment Date');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `pmpm_cost_band` SET TAGS ('dbx_business_glossary_term' = 'PMPM Cost Band');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `pmpm_cost_band` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `risk_factor_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Weight');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_value_regex' = 'model|clinical_review|manual');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Description');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Name');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Casenet TruCare|Altruista');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `tier_band` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Band');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `tier_band` SET TAGS ('dbx_value_regex' = 'low|rising|high|catastrophic');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Code');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Name');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'SDOH Assessment ID');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `hra_id` SET TAGS ('dbx_business_glossary_term' = 'Hra Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `confidentiality_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Consent Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Due Date');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Status');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_needed');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `referral_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Made Flag');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `referral_resource` SET TAGS ('dbx_business_glossary_term' = 'Referral Resource');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `screening_tool` SET TAGS ('dbx_business_glossary_term' = 'Screening Tool Used');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `screening_tool` SET TAGS ('dbx_value_regex' = 'AHC_HRSN|PRAPARE|HUNGER_VITAL_SIGN');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_domain` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health Domain');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_domain` SET TAGS ('dbx_value_regex' = 'food_insecurity|housing_instability|transportation|social_isolation|financial_strain|education');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`care`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`care`.`team` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Identifier (CTID)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Care Coordinator Identifier (LCCI)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `parent_team_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Care Program Identifier (ACPI)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `audit_created_by` SET TAGS ('dbx_business_glossary_term' = 'User Who Created Record (UCR)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `audit_updated_by` SET TAGS ('dbx_business_glossary_term' = 'User Who Last Updated Record (ULUR)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Behavioral Health Providers (NBHP)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel for Team (PCCT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|portal|mail|sms');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Community Health Workers (NCHW)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `consent_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Date Privacy Consent Obtained (DPCO)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Team Contact Email Address (TCEA)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method for Team (PCM)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|portal');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Team Contact Phone Number (TCPN)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status of Team Record (DQST)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Effective End Date (CTEED)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Effective Start Date (CTESD)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `hcc_included` SET TAGS ('dbx_business_glossary_term' = 'Flag Indicating Inclusion of HCCs (FIHCC)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `hcc_version` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Version (HCCV)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `is_multidisciplinary` SET TAGS ('dbx_business_glossary_term' = 'Indicator if Team is Multidisciplinary (IMD)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `is_primary_care_team` SET TAGS ('dbx_business_glossary_term' = 'Indicator if Team is Primary Care Team (IPCT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Last Data Quality Review (DLR)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `lead_coordinator_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lead Coordinator Assignment End Date (LCAED)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `lead_coordinator_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lead Coordinator Assignment Start Date (LCASD)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Members Assigned to Team (NMAT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes Regarding Team (ANRT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `pharmacist_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Pharmacists (NP)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag for Team Data (PCFTD)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Providers in Team (NPT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor for Team (RAFT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `social_worker_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Social Workers (NSW)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record (SSR)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `specialist_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Specialist Providers (NSP)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Current Team Status (RTS)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Care Team Code (CTC)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Care Team Name (CTN)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Care Team Lifecycle Status (CTLS)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Type (CTT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_value_regex' = 'clinical|non_clinical|behavioral|pharmacy|social');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RLUT)');
ALTER TABLE `health_insurance_ecm`.`care`.`team` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Team Record Version Number (TVN)');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` SET TAGS ('dbx_association_edges' = 'care.team,care.care_enrollment');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ALTER COLUMN `team_enrollment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Team Enrollment Assignment - Team Enrollment Assignment Id');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Team Enrollment Assignment - Care Enrollment Id');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Enrollment Assignment - Team Id');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`care`.`team_enrollment_assignment` ALTER COLUMN `role_on_team` SET TAGS ('dbx_business_glossary_term' = 'Team Role for Enrollment');
