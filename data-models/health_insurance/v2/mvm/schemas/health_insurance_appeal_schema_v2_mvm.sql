-- Schema for Domain: appeal | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-23 01:34:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`appeal` COMMENT 'Manages member and provider appeals and grievances including claim denials, coverage disputes, utilization management appeals, external review requests, and state fair hearing processes. Tracks appeal status, resolution timelines, overturn rates, and compliance with state and federal appeal rights (ACA, ERISA). Distinct from compliance (which owns regulatory audit and reporting) and utilization (which owns initial authorization decisions).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` (
    `grievance_id` BIGINT COMMENT 'Primary key for appeal grievance record.',
    `adverse_determination_id` BIGINT COMMENT 'Foreign key linking to appeal.adverse_determination. Business justification: A grievance or appeal is filed directly in response to a specific adverse benefit determination. This is a core business relationship in health insurance appeals: the adverse_determination is the prox',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Grievances are filed against specific benefit package determinations. Appeals operations teams must identify which benefit package rules governed the disputed service. Regulatory grievance tracking an',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: NCQA/URAC grievance tracking requires direct linkage from a grievance filing to the specific claim denial that prompted it. Grievance analysts and compliance officers need to identify the originating ',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Grievances are frequently filed about coverage eligibility disputes (e.g., wrongful termination, incorrect benefit period). Linking the grievance directly to the eligibility span enables grievance roo',
    `party_id` BIGINT COMMENT 'FK to the filing party.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Grievances are filed in the context of a specific policy — regulatory grievance reporting (NCQA, CMS) requires tracking grievances by policy type and coverage period. Adjudicators need the policy reco',
    `practice_location_id` BIGINT COMMENT 'FK to provider.',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Members file grievances about mandatory care management program participation or program-related service denials. Linking appeal_grievance to the specific care program enables grievance trend analysis',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Providers file grievances directly against health plans (e.g., payment disputes, network issues). filing_party_type=PROVIDER is a common scenario. A direct provider_id FK supports provider relations',
    `term_id` BIGINT COMMENT 'Foreign key linking to contract.term. Business justification: Provider grievances are frequently filed disputing a specific contract term (payment methodology, reduction percentage, dispute_resolution_method). Contract administrators and appeal coordinators must',
    `acknowledgment_date` DATE COMMENT 'Date the grievance was acknowledged.',
    `appeal_grievance_status` STRING COMMENT 'Current status of the grievance.',
    `appeal_reference_number` STRING COMMENT 'Reference number for the appeal.',
    `case_notes` STRING COMMENT 'Free-text notes on the case.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates compliance status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `escalation_level` STRING COMMENT 'Level of escalation for the grievance.',
    `external_review_outcome` STRING COMMENT 'Outcome of external review if requested.',
    `external_review_requested` BOOLEAN COMMENT 'Whether external review was requested.',
    `filing_channel` STRING COMMENT 'Channel through which grievance was filed.',
    `filing_date` DATE COMMENT 'Date the grievance was filed.',
    `filing_party_type` STRING COMMENT 'Type of party filing the grievance.',
    `grievance_number` STRING COMMENT 'Unique grievance identifier number.',
    `grievance_type` STRING COMMENT 'Classification type of the grievance.',
    `investigation_end_date` DATE COMMENT 'Date investigation ended.',
    `investigation_start_date` DATE COMMENT 'Date investigation started.',
    `is_appeal` BOOLEAN COMMENT 'Whether this record is an appeal vs grievance.',
    `is_confidential` BOOLEAN COMMENT 'Whether the grievance is confidential.',
    `priority` STRING COMMENT 'Priority level of the grievance.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification code.',
    `resolution_date` DATE COMMENT 'Date the grievance was resolved.',
    `resolution_detail` STRING COMMENT 'Details of the resolution.',
    `resolution_type` STRING COMMENT 'Type of resolution applied.',
    `state_code` STRING COMMENT 'State jurisdiction code.',
    `title` STRING COMMENT 'Title of the grievance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `zip_code` STRING COMMENT 'Zip code of the filing party.',
    CONSTRAINT pk_grievance PRIMARY KEY(`grievance_id`)
) COMMENT 'Records grievances and appeals filed by members, providers, or other parties against health plan decisions. SSOT for appeal-side grievances with reference to member.member_grievance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`case` (
    `case_id` BIGINT COMMENT 'Primary key for appeal case.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: Appeal reviewers must examine the exact adjudication decision being contested. Linking claim.case directly to claim.adjudication supports the appeal review workflow — reviewers need adjudication deta',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Appeal cases are opened to dispute specific benefit package determinations. Case management workflows require direct access to the benefit package under dispute for applying correct clinical criteria ',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.coordinator. Business justification: When a member appeals a care management decision, the responsible care coordinator is a named party in the case. Role-prefix care_coordinator distinguishes from party_id. Enables coordinator perform',
    `header_id` BIGINT COMMENT 'FK to related claim.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: ERISA/ACA appeal tracking requires direct traceability from an appeal case to the specific claim denial that triggered it. Appeal processors and regulators need to identify which denial originated eac',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Appeal cases are primarily triggered by PA denials. Linking case to pa_request enables appeal-to-PA workflow tracking, NCQA/CMS regulatory reporting on denial appeal rates, and overturn analysis by PA',
    `party_id` BIGINT COMMENT 'FK to contract party.',
    `pharmacy_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_claim. Business justification: When a member appeals a pharmacy claim denial (e.g., rejected fill, incorrect cost-sharing), the appeal case must directly reference the specific pharmacy claim. CMS Part D grievance and appeal report',
    `plan_election_id` BIGINT COMMENT 'FK to plan election.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Appeals cases are adjudicated against specific policy terms — benefit limits, deductibles, and coverage rules are policy-specific. Appeals coordinators and compliance teams require direct policy linka',
    `premium_invoice_id` DECIMAL(18,2) COMMENT 'FK to premium invoice.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Provider-level appeal tracking: health plans must report overturn rates and appeal volumes by treating provider for network management, credentialing review triggers, and CMS/state regulatory reportin',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: Appeals frequently arise from UM case decisions including concurrent review denials and discharge planning disputes. Linking utilization.case to um_case enables UM-to-appeal tracking, regulatory reporting ',
    `appeal_assigned_to` STRING COMMENT 'Name/ID of person assigned to the appeal.',
    `appeal_escalation_flag` BOOLEAN COMMENT 'Whether the appeal has been escalated.',
    `appeal_number` STRING COMMENT 'Unique appeal case number.',
    `appeal_priority` STRING COMMENT 'Priority level of the appeal.',
    `appeal_review_cycle_days` STRING COMMENT 'Number of days in the review cycle.',
    `appeal_status` STRING COMMENT 'Current status of the appeal case.',
    `appeal_type` STRING COMMENT 'Type/category of the appeal.',
    `completeness_determination` STRING COMMENT 'Whether the appeal submission is complete.',
    `decision_author_npi` STRING COMMENT 'NPI of the decision author.',
    `decision_rationale` DECIMAL(18,2) COMMENT 'Rationale for the decision.',
    `decision_timestamp` TIMESTAMP COMMENT 'Timestamp of the decision.',
    `decision_type` STRING COMMENT 'Type of decision rendered.',
    `effective_benefit_change_date` DATE COMMENT 'Date benefit change takes effect.',
    `expedited_clinical_urgency_basis` STRING COMMENT 'Clinical basis for expedited processing.',
    `expedited_trigger` BOOLEAN COMMENT 'Whether expedited processing was triggered.',
    `filing_channel` STRING COMMENT 'Channel used to file the appeal.',
    `filing_method` STRING COMMENT 'Method used to file the appeal.',
    `filing_party_type` STRING COMMENT 'Type of party filing the appeal.',
    `filing_timestamp` TIMESTAMP COMMENT 'Timestamp when appeal was filed.',
    `line_of_business` STRING COMMENT 'Line of business for the appeal.',
    `member_notification_date` DATE COMMENT 'Date member was notified.',
    `original_claim_number` STRING COMMENT 'Original claim number being appealed.',
    `overturn_reason` STRING COMMENT 'Reason for overturning the decision.',
    `provider_notification_date` DATE COMMENT 'Date provider was notified.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `regulatory_tier` STRING COMMENT 'Regulatory tier classification.',
    `supporting_documentation_checklist` STRING COMMENT 'Checklist of supporting documents.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Represents an appeal case encompassing all related reviews, documents, communications, and outcomes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` (
    `adverse_determination_id` BIGINT COMMENT 'Primary key.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: An adverse determination is a formal output of an adjudication decision. Regulatory reporting (NCQA, URAC) and clinical review require direct linkage between the adverse determination and the specific',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: An adverse determination (denial) is issued against a specific covered benefit. Clinical reviewers and appeals processors must reference the exact benefit definition and coverage rules when evaluating',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Adverse determinations are governed by the benefit package in effect at time of service. Appeals reviewers must apply the correct cost-sharing and coverage rules from the specific benefit package. ERI',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.case. Business justification: An adverse determination is the triggering event for an appeal case. When a member or provider files an appeal, a case is opened to track the full lifecycle of that appeal against the adverse determin',
    `header_id` BIGINT COMMENT 'FK to claim header.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: Regulatory adverse determination reporting (ACA, ERISA) requires linking each adverse determination to the originating claim denial. An adverse determination is the formal escalation of a denial; revi',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: CMS Part D adverse determination reporting requires drug-level identification (NDC/drug class) on each denial record. adverse_determination has service_code but no structured drug reference. Direct dr',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: Adverse determinations cite the specific medical policy under which coverage was denied. This link supports regulatory compliance reporting, appeal overturn analysis by policy version, and NCQA/URAC a',
    `identity_id` BIGINT COMMENT 'FK to member identity.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: An adverse determination is the formal denial record generated from a pa_decision. Linking to pa_decision (not just pa_request) captures the clinical rationale, denial reason category, and reviewer cr',
    `pa_request_id` BIGINT COMMENT 'FK to PA request.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Adverse determinations (denials) are issued under a specific policy — the denial reason, appeal rights, and monetary amounts denied are all policy-dependent. URAC and state regulatory reporting of adv',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Adverse determinations are issued against a specific treating providers service. Provider-level denial rate reporting, credentialing review triggers (high denial rates), and HEDIS/regulatory audits a',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Adverse determinations (claim denials) are directly driven by reimbursement policy rules (NCCI edits, bundling, max procedures). Appeal reviewers must trace denial_reason_code back to the governing re',
    `appeal_deadline_date` DATE COMMENT 'Deadline to file an appeal.',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Whether the determination is eligible for appeal.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed.',
    `appeal_outcome` STRING COMMENT 'Outcome of the appeal if filed.',
    `appeal_resolution_date` DATE COMMENT 'Date appeal was resolved.',
    `appeal_status` STRING COMMENT 'Status of the appeal.',
    `basis_of_denial` STRING COMMENT 'Basis for the denial.',
    `clinical_criteria_version` STRING COMMENT 'Version of clinical criteria used.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code for monetary amounts.',
    `denial_reason_code` STRING COMMENT 'Code for the denial reason.',
    `denial_reason_description` STRING COMMENT 'Description of the denial reason.',
    `determination_date` DATE COMMENT 'Date of the determination.',
    `determination_number` STRING COMMENT 'Unique determination number.',
    `determination_status` STRING COMMENT 'Status of the determination.',
    `determination_type` STRING COMMENT 'Type of determination.',
    `diagnosis_code` STRING COMMENT 'Related diagnosis code.',
    `effective_date` DATE COMMENT 'Effective date of the determination.',
    `monetary_amount_adjusted` DECIMAL(18,2) COMMENT 'Amount adjusted.',
    `monetary_amount_denied` DECIMAL(18,2) COMMENT 'Amount denied.',
    `network_status` STRING COMMENT 'In/out of network status.',
    `notes` STRING COMMENT 'Additional notes.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Whether PA was required.',
    `reviewer_name` STRING COMMENT 'Name of the reviewer.',
    `reviewer_npi` STRING COMMENT 'NPI of the reviewer.',
    `service_code` STRING COMMENT 'Service/procedure code.',
    `service_date` DATE COMMENT 'Date of service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_adverse_determination PRIMARY KEY(`adverse_determination_id`)
) COMMENT 'Records adverse benefit determinations that may trigger member appeal rights.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`review` (
    `review_id` BIGINT COMMENT 'Primary key.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: A clinical review evaluates whether a specific benefit was correctly denied or approved. Linking review to the specific benefit enables benefit-level review analytics (e.g., overturn rates by benefit ',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Clinical reviewers must apply the specific benefit packages coverage rules and clinical criteria during a review. Without this FK, reviewers cannot directly retrieve the applicable benefit package te',
    `case_id` BIGINT COMMENT 'FK to appeal case.',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: Appeal reviews apply specific clinical criteria to evaluate whether the original denial was appropriate. Linking review to clinical_criteria enables criteria-level appeal outcome analysis, policy impr',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: Clinical appeal reviewers validate whether ICD-10 diagnosis codes are correctly mapped to HCC categories when evaluating denials. Linking review to hcc_mapping records which specific HCC mapping versi',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Appeal reviewers must reference the reimbursement policy governing the original denial to assess correct application of policy rules. The reviews criteria_version and cpt_codes_reviewed map directly ',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Internal appeal reviewers must be credentialed providers. Linking reviewer to provider.provider supports credentialing validation of reviewers, audit trails for regulatory compliance (URAC, NCQA), and',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: State regulations (e.g., NAIC model act) require specialty-matched reviewers for clinical appeals. Linking reviewer_specialty_id to provider.specialty enables specialty-match validation, NCQA/URAC aud',
    `appeal_case_number` STRING COMMENT 'Appeal case number reference.',
    `appeal_reason_code` STRING COMMENT 'Reason code for the appeal.',
    `appeal_status_at_review` STRING COMMENT 'Status of appeal at time of review.',
    `appeal_submission_date` DATE COMMENT 'Date appeal was submitted.',
    `clinical_rationale` DECIMAL(18,2) COMMENT 'Clinical rationale for the review decision.',
    `compliance_flag` BOOLEAN COMMENT 'Compliance status flag.',
    `cpt_codes_reviewed` STRING COMMENT 'CPT codes reviewed.',
    `drg_code` STRING COMMENT 'DRG code if applicable.',
    `duration_minutes` STRING COMMENT 'Duration of the review in minutes.',
    `icd_codes_reviewed` STRING COMMENT 'ICD codes reviewed.',
    `is_independent_reviewer` BOOLEAN COMMENT 'Whether reviewer is independent.',
    `location` STRING COMMENT 'Location of the review.',
    `notes` STRING COMMENT 'Review notes.',
    `outcome` STRING COMMENT 'Outcome of the review.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `review_number` STRING COMMENT 'Unique review number.',
    `review_status` STRING COMMENT 'Current status of the review.',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp of the review.',
    `review_type` STRING COMMENT 'Type of review conducted.',
    `reviewer_npi` STRING COMMENT 'NPI of the reviewer.',
    `reviewer_type` STRING COMMENT 'Type of reviewer.',
    CONSTRAINT pk_review PRIMARY KEY(`review_id`)
) COMMENT 'Records individual reviews conducted as part of an appeal case, including internal and peer reviews.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` (
    `external_review_id` BIGINT COMMENT 'Primary key.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Independent Review Organizations (IROs) conducting external reviews must evaluate the denial against the specific benefit package terms. State and federal regulations require external review decisions',
    `case_id` BIGINT COMMENT 'FK to appeal case.',
    `header_id` BIGINT COMMENT 'FK to claim header.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: IRO (Independent Review Organization) regulatory reporting requires direct reference to the specific claim denial being externally reviewed. State mandates and ACA external review rules require tracki',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Independent external reviewers require the members coverage details (benefit limits, OOP, deductible) from the eligibility span to render binding determinations. State external review regulations req',
    `subscriber_id` BIGINT COMMENT 'FK to member subscriber.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: External IRO reviews are triggered by PA denials escalated beyond internal appeal. Linking external_review to pa_request supports state regulatory reporting on external review outcomes by PA type, bin',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: External reviews are triggered by disputes over a treating providers denied service. Provider-level external review tracking is required for state regulatory reporting, network adequacy analysis, and',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Financial adjustment amount.',
    `appeal_reason_code` STRING COMMENT 'Reason code for the appeal.',
    `appeal_reason_description` STRING COMMENT 'Description of appeal reason.',
    `binding_determination_flag` BOOLEAN COMMENT 'Whether the determination is binding.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Original claim amount.',
    `compliance_action_taken` STRING COMMENT 'Compliance action taken.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `deadline_date` DATE COMMENT 'Deadline for external review.',
    `decision` STRING COMMENT 'Decision rendered.',
    `decision_date` DATE COMMENT 'Date of decision.',
    `decision_rationale` DECIMAL(18,2) COMMENT 'Rationale for the decision.',
    `diagnosis_code` STRING COMMENT 'Related diagnosis code.',
    `external_review_status` STRING COMMENT 'Status of the external review.',
    `external_review_type` STRING COMMENT 'Type of external review.',
    `iro_accreditation_status` STRING COMMENT 'Accreditation status of the IRO.',
    `is_urgent` BOOLEAN COMMENT 'Whether the review is urgent.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of last status change.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net financial amount.',
    `notes` STRING COMMENT 'Additional notes.',
    `overdue_flag` BOOLEAN COMMENT 'Whether the review is overdue.',
    `patient_relationship` STRING COMMENT 'Patient relationship to subscriber.',
    `procedure_code` STRING COMMENT 'Related procedure code.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Whether regulatory reporting is required.',
    `reporting_status` STRING COMMENT 'Status of regulatory reporting.',
    `reporting_submission_date` DATE COMMENT 'Date of regulatory submission.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp of the review request.',
    `review_category` STRING COMMENT 'Category of the review.',
    `review_number` STRING COMMENT 'Unique review number.',
    `review_priority` STRING COMMENT 'Priority of the review.',
    `service_date` DATE COMMENT 'Date of service.',
    `source` STRING COMMENT 'Source of the external review.',
    `state` STRING COMMENT 'State jurisdiction.',
    `transmission_date` DATE COMMENT 'Date of transmission to IRO.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_external_review PRIMARY KEY(`external_review_id`)
) COMMENT 'Records external/independent reviews conducted by IROs as part of the appeal process.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`document` (
    `document_id` BIGINT COMMENT 'Primary key.',
    `case_id` BIGINT COMMENT 'FK to appeal case.',
    `identity_id` BIGINT COMMENT 'FK to member identity.',
    `appeal_document_description` STRING COMMENT 'Description of the document.',
    `appeal_document_status` STRING COMMENT 'Status of the document.',
    `audit_trail` STRING COMMENT 'Audit trail information.',
    `considered_in_decision` BOOLEAN COMMENT 'Whether document was considered in decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `document_number` STRING COMMENT 'Unique document number.',
    `document_type` STRING COMMENT 'Type of document.',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes.',
    `format` STRING COMMENT 'File format.',
    `is_confidential` BOOLEAN COMMENT 'Whether document is confidential.',
    `is_redacted` BOOLEAN COMMENT 'Whether document is redacted.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Last access timestamp.',
    `phi_classification` STRING COMMENT 'PHI classification level.',
    `receipt_date` DATE COMMENT 'Date document was received.',
    `redaction_status` STRING COMMENT 'Redaction status.',
    `retention_period_years` STRING COMMENT 'Retention period in years.',
    `source` STRING COMMENT 'Source of the document.',
    `storage_path` STRING COMMENT 'Storage path/URI.',
    `title` STRING COMMENT 'Document title.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `version_number` STRING COMMENT 'Document version number.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Documents associated with appeal cases. SSOT reference to credential.credential_document for cross-domain deduplication.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` (
    `expedited_review_id` BIGINT COMMENT 'Primary key.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Expedited reviews are time-sensitive clinical reviews (72-hour turnaround) that must apply the specific benefit packages coverage rules. Regulatory compliance tracking for expedited review timeliness',
    `case_id` BIGINT COMMENT 'FK to appeal case.',
    `header_id` BIGINT COMMENT 'FK to claim header.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: The 72-hour expedited review regulatory requirement (ACA, ERISA) mandates tracking which specific denial triggered an urgent review. Compliance monitoring of expedited review timelines requires direct',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Expedited reviews involve urgent clinical situations where active coverage must be confirmed within 72-hour regulatory windows. Linking to the eligibility span enables real-time coverage validation du',
    `subscriber_id` BIGINT COMMENT 'FK to member subscriber.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Expedited reviews are almost exclusively triggered by urgent PA denials (concurrent review denials for ongoing inpatient care). Linking to pa_request supports CMS 72-hour turnaround compliance reporti',
    `parent_expedited_review_id` BIGINT COMMENT 'Self-referencing FK for parent expedited review.',
    `practice_location_id` BIGINT COMMENT 'FK to provider.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Expedited reviews involve clinically urgent services tied to a specific treating provider. Provider-level expedited review tracking supports network management, credentialing review, and CMS/state reg',
    `actual_decision_date` DATE COMMENT 'Actual date of decision.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Financial adjustment amount.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Original claim amount.',
    `clinical_urgency_classification` STRING COMMENT 'Classification of clinical urgency.',
    `compliance_flag` BOOLEAN COMMENT 'Compliance status flag.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `decision_due_date` DATE COMMENT 'Due date for decision.',
    `decision_outcome` STRING COMMENT 'Outcome of the decision.',
    `decision_rationale` DECIMAL(18,2) COMMENT 'Rationale for the decision.',
    `expedited_notification_required` BOOLEAN COMMENT 'Whether expedited notification is required.',
    `expedited_reason` STRING COMMENT 'Reason for expedited processing.',
    `expedited_review_status` STRING COMMENT 'Status of the expedited review.',
    `is_confidential` BOOLEAN COMMENT 'Whether review is confidential.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net financial amount.',
    `notes` STRING COMMENT 'Additional notes.',
    `notification_method` STRING COMMENT 'Method of notification.',
    `notified_timestamp` TIMESTAMP COMMENT 'Timestamp of notification.',
    `regulatory_body` STRING COMMENT 'Regulatory body.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp of the request.',
    `review_request_number` STRING COMMENT 'Unique review request number.',
    `state_code` STRING COMMENT 'State code.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_expedited_review PRIMARY KEY(`expedited_review_id`)
) COMMENT 'Expedited reviews for urgent appeal cases requiring accelerated processing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` (
    `outcome_id` BIGINT COMMENT 'Primary key.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Appeal outcomes (overturn, uphold, partial) are rendered in the context of a specific benefit package. Benefit-package-level outcome reporting is required for CMS and state regulatory submissions. Pla',
    `case_id` BIGINT COMMENT 'FK to appeal case.',
    `header_id` BIGINT COMMENT 'FK to claim header.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: Denial resolution tracking and regulatory reporting on appeal outcomes require direct linkage from the appeal outcome to the specific denial it resolves. Compliance reports (denial overturn rates, res',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Appeal outcomes that overturn denials or reinstate coverage must reference the specific eligibility span to trigger retroactive enrollment adjustments. The downstream_action field on outcome drives en',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Appeal outcome financial remediation targets specific invoice line charges. When an outcome reverses a line-level charge, the downstream_action and financial_impact_amount on outcome must trace to the',
    `identity_id` BIGINT COMMENT 'FK to member identity.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Appeal outcomes that overturn PA denials must link back to the originating PA request to trigger re-authorization workflows, update authorization status, and support financial reconciliation of adjust',
    `parent_outcome_id` BIGINT COMMENT 'Self-referencing FK for parent outcome.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Appeal outcomes that overturn denials trigger downstream policy actions — benefit reinstatements, premium adjustments, or coverage amendments. Policy administration teams require direct policy linkage',
    `premium_payment_id` DECIMAL(18,2) COMMENT 'Foreign key linking to billing.premium_payment. Business justification: Appeal outcome financial remediation process: when an outcome overturns a denial or billing dispute, the specific premium payment under dispute must be referenced to execute refunds, credits, or reall',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Appeal outcomes must be communicated to the treating provider within regulatory timeframes (ACA, state mandates). provider_notification_timestamp already exists on outcome, confirming this business pr',
    `compliance_flag` BOOLEAN COMMENT 'Compliance status flag.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `downstream_action` STRING COMMENT 'Downstream action required.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact amount.',
    `jurisdiction_state` STRING COMMENT 'State jurisdiction.',
    `member_notification_timestamp` TIMESTAMP COMMENT 'Timestamp member was notified.',
    `notes` STRING COMMENT 'Additional notes.',
    `outcome_number` STRING COMMENT 'Unique outcome number.',
    `outcome_status` STRING COMMENT 'Status of the outcome.',
    `outcome_timestamp` TIMESTAMP COMMENT 'Timestamp of the outcome.',
    `outcome_type` STRING COMMENT 'Type of outcome.',
    `provider_notification_timestamp` TIMESTAMP COMMENT 'Timestamp provider was notified.',
    `reason_code` STRING COMMENT 'Reason code.',
    `reason_description` STRING COMMENT 'Description of reason.',
    `regulatory_body` STRING COMMENT 'Regulatory body.',
    `source_system_record_code` STRING COMMENT 'Source system record code.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_outcome PRIMARY KEY(`outcome_id`)
) COMMENT 'Records the final outcomes of appeal cases including financial impacts and notifications.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ADD CONSTRAINT `fk_appeal_document_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_parent_expedited_review_id` FOREIGN KEY (`parent_expedited_review_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`expedited_review`(`expedited_review_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_parent_outcome_id` FOREIGN KEY (`parent_outcome_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`outcome`(`outcome_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`appeal` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`appeal` SET TAGS ('dbx_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Grievance ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Party ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `appeal_grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Grievance Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `appeal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `external_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'External Review Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `external_review_requested` SET TAGS ('dbx_business_glossary_term' = 'External Review Requested');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `filing_channel` SET TAGS ('dbx_business_glossary_term' = 'Filing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `grievance_number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `is_appeal` SET TAGS ('dbx_business_glossary_term' = 'Is Appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `resolution_detail` SET TAGS ('dbx_business_glossary_term' = 'Resolution Detail');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `pharmacy_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Appeal Assigned To');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_priority` SET TAGS ('dbx_business_glossary_term' = 'Appeal Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Appeal Review Cycle Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `completeness_determination` SET TAGS ('dbx_business_glossary_term' = 'Completeness Determination');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_business_glossary_term' = 'Decision Author NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `effective_benefit_change_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Benefit Change Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `expedited_clinical_urgency_basis` SET TAGS ('dbx_business_glossary_term' = 'Expedited Clinical Urgency Basis');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `expedited_trigger` SET TAGS ('dbx_business_glossary_term' = 'Expedited Trigger');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_channel` SET TAGS ('dbx_business_glossary_term' = 'Filing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `member_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `original_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `overturn_reason` SET TAGS ('dbx_business_glossary_term' = 'Overturn Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `regulatory_tier` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `supporting_documentation_checklist` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Checklist');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'PA Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `basis_of_denial` SET TAGS ('dbx_business_glossary_term' = 'Basis of Denial');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_number` SET TAGS ('dbx_business_glossary_term' = 'Determination Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_status` SET TAGS ('dbx_business_glossary_term' = 'Determination Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_type` SET TAGS ('dbx_business_glossary_term' = 'Determination Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `monetary_amount_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Monetary Amount Adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `monetary_amount_denied` SET TAGS ('dbx_business_glossary_term' = 'Monetary Amount Denied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Specialty Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_status_at_review` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status at Review');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `cpt_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'CPT Codes Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `icd_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'ICD Codes Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `is_independent_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Is Independent Reviewer');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_type` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_id` SET TAGS ('dbx_business_glossary_term' = 'External Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `appeal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `appeal_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `binding_determination_flag` SET TAGS ('dbx_business_glossary_term' = 'Binding Determination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `compliance_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action Taken');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Decision');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_status` SET TAGS ('dbx_business_glossary_term' = 'External Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_type` SET TAGS ('dbx_business_glossary_term' = 'External Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'IRO Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Is Urgent');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `patient_relationship` SET TAGS ('dbx_business_glossary_term' = 'Patient Relationship');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_category` SET TAGS ('dbx_business_glossary_term' = 'Review Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'External Review Source');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `transmission_date` SET TAGS ('dbx_business_glossary_term' = 'Transmission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `appeal_document_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Document Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `appeal_document_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `considered_in_decision` SET TAGS ('dbx_business_glossary_term' = 'Considered in Decision');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Format');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `is_redacted` SET TAGS ('dbx_business_glossary_term' = 'Is Redacted');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `phi_classification` SET TAGS ('dbx_business_glossary_term' = 'PHI Classification');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `redaction_status` SET TAGS ('dbx_business_glossary_term' = 'Redaction Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Source');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_review_id` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `parent_expedited_review_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Expedited Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `actual_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `clinical_urgency_classification` SET TAGS ('dbx_business_glossary_term' = 'Clinical Urgency Classification');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_due_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Expedited Notification Required');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_reason` SET TAGS ('dbx_business_glossary_term' = 'Expedited Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_review_status` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notified Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `review_request_number` SET TAGS ('dbx_business_glossary_term' = 'Review Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Outcome ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `parent_outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Outcome ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `downstream_action` SET TAGS ('dbx_business_glossary_term' = 'Downstream Action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `member_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_number` SET TAGS ('dbx_business_glossary_term' = 'Outcome Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Outcome Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outcome Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `provider_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provider Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
