-- Schema for Domain: utilization | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`utilization` COMMENT 'Manages utilization management (UM) and prior authorization (PA) workflows — inpatient concurrent review, retrospective review, medical necessity determination, peer-to-peer processes, and UM turnaround time compliance. Owns PA requests, clinical criteria application (InterQual, MCG), authorization decisions, length-of-stay benchmarks, and denial reasons. Supports NCQA UM accreditation standards and state PA reform mandates. Source system: InterQual or MCG.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`pa_request` (
    `pa_request_id` BIGINT COMMENT 'Unique identifier for the prior authorization request.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: PA requests are submitted for specific covered benefits. Linking PA requests to benefit enables benefit-level PA rate reporting, CMS PA transparency rule compliance (reporting PA rates by benefit/serv',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: PA requests submitted for care-managed members must reference the active care enrollment to apply program-specific authorization rules, gold-card exemptions, and care manager review workflows. This li',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: PA requests are initiated based on services prescribed in an active care plan. UM reviewers and care managers need to link the PA request to the governing care plan for clinical context, authorization',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule applied.',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: PA request intake requires real-time eligibility validation — coverage type, benefit limits, deductible status, and network assignment from the eligibility span determine whether the request is valid.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Employer cost reporting requires associating each prior‑auth request with the sponsoring employer group.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Prior Authorization Request Volume Report groups requests by health plan to monitor utilization and cost.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Utilization Management uses members risk score to prioritize prior auth decisions; the PA Risk Score Review report requires linking each PA request to the member_risk_score record.',
    `plan_election_id` BIGINT COMMENT 'Identifier of the health plan under which the member is covered.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Policy-level PA adjudication: PA requests must be adjudicated against the specific member policys coverage limits, deductible status, and PA requirements. Policy reference is required for accurate be',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member requesting the service.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for Prior Authorization request processing to link each request to the provider entity for reporting, compliance, and performance metrics.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: PA requests must be evaluated against the specific provider contract to determine coverage, prior‑auth requirements, and payment methodology; required for PA decision and compliance reporting.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network relevant to the request.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory reporting of prior authorizations requires linking each PA request to the governing regulatory obligation.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Prior Authorization requests must verify the members active enrollment transaction to determine coverage and cost‑share, required for CMS PA reporting and claim adjudication.',
    `appeal_deadline_date` DATE COMMENT 'Final date by which an appeal must be filed.',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical criteria set applied to the request.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the data warehouse.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated amounts.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `decision_maker_role` STRING COMMENT 'Professional role of the decision maker.. Valid values are `physician|nurse|clinical_reviewer|admin`',
    `denial_reason_code` STRING COMMENT 'Code representing the reason for denial, if applicable.',
    `diagnosis_code` STRING COMMENT 'Diagnosis code supporting the medical necessity of the request.',
    `estimated_adjustment_amount` DECIMAL(18,2) COMMENT 'Estimated adjustments (e.g., discounts, co-pays) applied to the gross amount.',
    `estimated_gross_amount` DECIMAL(18,2) COMMENT 'Initial estimated gross cost of the requested service before adjustments.',
    `estimated_net_amount` DECIMAL(18,2) COMMENT 'Final estimated net cost after adjustments.',
    `is_appealable` BOOLEAN COMMENT 'Indicates whether the member may appeal a denial.',
    `is_duplicate_request` BOOLEAN COMMENT 'Indicates whether this request is a duplicate of an existing request.',
    `last_air_due_date` DATE COMMENT 'Due date for the most recent additional information request.',
    `last_air_received_date` DATE COMMENT 'Date the last additional information request was received.',
    `notes` STRING COMMENT 'Additional comments or notes related to the request.',
    `pa_request_status` STRING COMMENT 'Current lifecycle status of the prior authorization request.. Valid values are `pending|approved|denied|cancelled|in_review|closed`',
    `patient_age_at_request` STRING COMMENT 'Age of the member at the time of request submission.',
    `patient_gender` STRING COMMENT 'Gender of the member at the time of request.. Valid values are `male|female|other|unknown`',
    `prior_auth_decision_date` DATE COMMENT 'Date the prior authorization decision was made.',
    `quantity` STRING COMMENT 'Number of units or sessions requested.',
    `request_number` STRING COMMENT 'Business identifier assigned to the prior authorization request.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the prior authorization request was submitted.',
    `request_type` STRING COMMENT 'Urgency classification of the prior authorization request.. Valid values are `standard|expedited|urgent`',
    `service_code` STRING COMMENT 'Procedure, service, or drug code associated with the request.',
    `service_type` STRING COMMENT 'Category of the service being requested for prior authorization.. Valid values are `procedure|drug|admission|therapy`',
    `source_system` STRING COMMENT 'Originating system that created the request record.. Valid values are `interqual|mcg`',
    `submission_channel` STRING COMMENT 'Channel through which the prior authorization request was submitted.. Valid values are `portal|fax|phone|edi_278`',
    `turnaround_time_days` STRING COMMENT 'Number of days from submission to final decision.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the request record.',
    CONSTRAINT pk_pa_request PRIMARY KEY(`pa_request_id`)
) COMMENT 'Core master entity representing a prior authorization (PA) request submitted by a provider or member for a proposed service, procedure, drug, or admission. Captures requesting provider NPI, member ID, requested service codes (CPT/HCPCS/ICD), urgency type (standard, expedited, urgent), submission channel (portal, fax, phone, EDI 278), submission timestamp, current PA status, and full status transition history. Also tracks additional information requests (AIRs) issued during review — information type requested, requested-from party, due date, received date, and TAT clock extension impact. Authoritative SSOT for all PA requests, their status lifecycle, and associated documentation requests.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`pa_decision` (
    `pa_decision_id` BIGINT COMMENT 'System-generated unique identifier for each prior authorization decision record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: PA decisions must reference the benefit package to confirm coverage scope, apply correct cost-share, and validate that the authorized service falls within package limits. Decision letters reference be',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: PA decisions (approvals/denials) directly affect care plan execution. Care managers must reconcile authorization outcomes against the active care plan to update goals and services. This link supports ',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: A PA decision is made based on specific clinical criteria (InterQual/MCG). pa_decision has clinical_criteria_set and clinical_criteria_version as strings but lacks a FK to the clinical_criteria master',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: PA decisions must be validated against the members active benefit package, coverage limits, and network assignment stored on the eligibility span. This direct link supports benefit coordination, cost',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Employer‑level analytics on prior‑auth decisions need a link to the employer group for regulatory reporting.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: PA Decision Summary Dashboard needs the plan context to calculate approval rates per plan.',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: pa_decision references the medical policy that governs the decision; child (decision) gets FK to parent (medical_policy).',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member/patient associated with the request.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the prior‑authorization request to which this decision belongs.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: UM reviewers and compliance auditors cross-reference PA decisions against the governing provider contract to validate that approved/denied services align with contracted scope, payment methodology, an',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Links PA decision to the originating provider for audit trails, regulatory reporting, and provider‑specific denial analysis.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Prior Authorization decisions require confirming the provider’s participation in a specific network; network_id enables compliance reporting and eligibility checks.',
    `um_reviewer_id` BIGINT COMMENT 'Foreign key linking to utilization.um_reviewer. Business justification: PA decisions are made by UM reviewers (medical directors, physician advisors). pa_decision currently stores reviewer_npi and reviewer_credentials as denormalized strings. Adding um_reviewer_id FK to t',
    `amendment_indicator` STRING COMMENT 'Indicates if this record is the original decision or an amendment/reversal.. Valid values are `original|amended|reversal|override`',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the member is eligible to appeal the decision.',
    `authorization_end_date` DATE COMMENT 'Effective end date of the approved authorization period.',
    `authorization_period_type` STRING COMMENT 'Specifies if the authorization period is a fixed date range or rolling.. Valid values are `fixed|rolling`',
    `authorization_quantity` STRING COMMENT 'Number of units (e.g., days, visits, doses) authorized.',
    `authorization_start_date` DATE COMMENT 'Effective start date of the approved authorization period.',
    `authorization_units` STRING COMMENT 'Unit of measure for the authorized quantity.. Valid values are `days|visits|doses|sessions`',
    `clinical_criteria_set` STRING COMMENT 'Name of the clinical criteria library applied (e.g., InterQual, MCG).',
    `clinical_criteria_version` STRING COMMENT 'Version identifier of the criteria set used for the decision.',
    `clinical_rationale` STRING COMMENT 'Free‑text explanation of the clinical reasoning behind the decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the decision record was first inserted into the data lake.',
    `criteria_effective_date` DATE COMMENT 'Date on which the applied clinical criteria version became effective.',
    `criteria_met_flag` BOOLEAN COMMENT 'Indicates whether the request met all required clinical criteria (true) or not (false).',
    `decision_date` TIMESTAMP COMMENT 'Timestamp when the prior authorization decision was rendered.',
    `decision_number` STRING COMMENT 'External business identifier assigned to the decision, often used in communications and audit trails.',
    `decision_status` STRING COMMENT 'Current lifecycle status of the decision record.. Valid values are `active|amended|reversed|overridden`',
    `decision_type` STRING COMMENT 'Classification of the decision outcome.. Valid values are `approved|denied|partially_approved|pended|withdrawn`',
    `denial_reason_category` STRING COMMENT 'High‑level category of the denial reason.. Valid values are `medical_need|administrative|benefit_exclusion|out_of_network|experimental`',
    `denial_reason_code` STRING COMMENT 'Standardized code representing the specific reason for denial.',
    `denial_regulatory_citation` STRING COMMENT 'Reference to the regulatory or policy citation supporting the denial.',
    `diagnosis_codes` STRING COMMENT 'Pipe‑separated list of ICD‑10 diagnosis codes supporting the medical necessity determination.',
    `is_telehealth` BOOLEAN COMMENT 'True if the service requested is delivered via telehealth.',
    `is_urgent` BOOLEAN COMMENT 'True if the request was marked urgent.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `prior_auth_number` STRING COMMENT 'Business number assigned to the prior‑authorization request.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates compliance with NCQA UM accreditation or state PA regulations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the decision record.',
    CONSTRAINT pk_pa_decision PRIMARY KEY(`pa_decision_id`)
) COMMENT 'Transactional record capturing the authorization decision and underlying medical necessity determination rendered on a PA request. Stores decision date, decision type (approved, denied, partially approved, pended, withdrawn), clinical criteria applied (InterQual/MCG criteria set, version, effective date), criteria met/not met flag, clinical rationale narrative, ICD diagnosis codes supporting the determination, deciding reviewer NPI and credentials (MD, RN, PharmD), denial reason code and category (medical necessity, administrative, benefit exclusion, out-of-network, experimental/investigational), denial regulatory citation, appeal eligibility flag, and effective authorization period (start/end dates). Each PA request may have one or more decision records reflecting amendments, P2P reversals, or appeal overrides. Serves as the single evidentiary record for NCQA audits, state DOI market conduct exams, and denial defense.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` (
    `auth_service_line_id` BIGINT COMMENT 'System-generated unique identifier for each line item within a prior authorization request.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Individual authorized service lines are cited in audit findings for unauthorized services rendered, billing discrepancies, or criteria misapplication. Line-level audit traceability is required for CMS',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Each authorized service line specifies the facility where the service is approved to be rendered. Linking to provider.facility supports network tier pricing, facility credentialing validation, and aut',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Each authorized service line corresponds to a specific covered benefit. Linking auth_service_line to benefit enables benefit-level utilization reporting, cost-share application, and accumulator tracki',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Required for Care Plan Progress Report: authorized service lines must be linked to the members active care plan to track service fulfillment and plan adherence.',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule set (InterQual/MCG) applied to this line.',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: When authorizing a service line, the applicable cost-share rule (copay, coinsurance, deductible) must be identified to communicate member liability and set adjudication expectations. UM and claims tea',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: Each authorized service line uses a fee schedule to calculate allowed amount; linking enables accurate payment calculation and regulatory fee‑schedule reporting.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Employer groups need authorized service line data for benefit cost analytics, stop-loss aggregate calculations, and employer utilization reporting. Domain experts expect group_id on auth_service_line ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Authorization Service Line Cost Tracking per plan supports financial analysis and rate setting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member for whom the service is authorized.',
    `network_provider_id` BIGINT COMMENT 'Foreign key linking to network.network_provider. Business justification: Authorization of a service line requires validating the providers current network participation status (credentialing_status, in_network_flag, tier_id) at time of authorization. UM staff and claims a',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: An authorized service line is the result of a specific PA decision. auth_service_line already links to pa_request, but the direct link to pa_decision establishes which specific authorization decision ',
    `pa_request_id` BIGINT COMMENT 'Identifier of the parent prior authorization request to which this service line belongs.',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Authorized service lines must be validated against reimbursement policies governing modifier rules, NCCI edits, and bundling before adjudication. UM and claims teams use this link to ensure authorized',
    `service_scope_id` BIGINT COMMENT 'Foreign key linking to contract.service_scope. Business justification: Authorized service lines must fall within the contracted service scope (inclusion/exclusion flags, place of service, specialty). Linking auth_service_line to service_scope enables UM-to-contracting re',
    `authorization_status` STRING COMMENT 'Current status of the service line within the prior authorization workflow.. Valid values are `approved|partially_approved|denied|pending|revoked`',
    `authorized_end_date` DATE COMMENT 'Expiration date after which the authorization is no longer valid.',
    `authorized_price` DECIMAL(18,2) COMMENT 'Maximum reimbursable amount per unit for the authorized service.',
    `authorized_quantity` DECIMAL(18,2) COMMENT 'Number of units of the service or product approved for the member.',
    `authorized_start_date` DATE COMMENT 'Effective date when the authorized service may begin.',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical criteria used for medical necessity determination.',
    `cpt_code` STRING COMMENT 'Standard CPT code representing the clinical service or procedure authorized.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the service line record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the authorized price.. Valid values are `USD|CAD|EUR`',
    `decision_timestamp` TIMESTAMP COMMENT 'Date‑time when the authorization decision for this line was made.',
    `denial_reason` STRING COMMENT 'Explanation code or text why the service line was denied or partially approved.',
    `diagnosis_icd_code` STRING COMMENT 'ICD code linking the authorized service to the clinical diagnosis supporting medical necessity.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `hcpcs_code` STRING COMMENT 'HCPCS code (Level II) for services, supplies, or drugs not covered by CPT.. Valid values are `^[A-Z][0-9]{4}$`',
    `is_emergency` BOOLEAN COMMENT 'True if the authorized service is classified as an emergency.',
    `is_experimental` BOOLEAN COMMENT 'True if the service is considered experimental or investigational.',
    `is_partial_approval` BOOLEAN COMMENT 'Indicates whether only a portion of the requested service quantity was approved.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the prior authorization request.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions from the reviewer.',
    `place_of_service` STRING COMMENT 'Location type where the service is to be rendered.. Valid values are `office|hospital|clinic|home|telehealth`',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date‑time when the prior authorization request containing this line was submitted.',
    `service_category` STRING COMMENT 'Broad classification of the authorized service (e.g., inpatient, outpatient, DME, pharmacy).. Valid values are `inpatient|outpatient|dme|pharmacy|behavioral_health|telehealth`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the authorized quantity (e.g., tablets, sessions, days).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the service line record.',
    CONSTRAINT pk_auth_service_line PRIMARY KEY(`auth_service_line_id`)
) COMMENT 'Line-item detail for each service, procedure, or drug authorized within a PA request. Captures CPT/HCPCS code, ICD diagnosis code, authorized quantity, authorized units of service, service category (inpatient, outpatient, DME, pharmacy, behavioral health), place of service, authorized facility NPI, and approved date range. Supports partial approvals where only a subset of requested services are authorized.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` (
    `concurrent_review_id` BIGINT COMMENT 'System-generated unique identifier for the concurrent review record.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Concurrent reviews generate audit findings for LOS outliers not properly reviewed, criteria misapplication, or regulatory non-compliance. concurrent_review already has audit_engagement_id; the direct ',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Concurrent review decisions (approved LOS, discharge planning) must reference the benefit package to apply correct inpatient coverage limits and cost-share rules. Reviewers need this to authorize cont',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Inpatient concurrent reviews for care-managed members must reference the active care enrollment to trigger post-discharge follow-up, care transitions, and program-specific protocols. Health plans requ',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Concurrent inpatient review is guided by the members active care plan. Care coordinators use the care plan to drive discharge planning and post-acute service authorization during concurrent review — ',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: Concurrent reviews apply specific clinical criteria (InterQual/MCG) to evaluate continued medical necessity during inpatient stays. concurrent_review has criteria_version as a string but no FK to the ',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to the member for this episode.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Employers monitor concurrent reviews of their members; linking enables employer‑specific review metrics.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Concurrent Review Utilization Management reports require linking each review to the members health plan.',
    `inpatient_admission_id` BIGINT COMMENT 'Identifier of the inpatient admission linked to this review.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Concurrent inpatient review uses member risk scores to drive readmission risk assessment and discharge planning. The existing readmission_risk_score and readmission_risk_category columns are denormali',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose stay is under review.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the originating prior‑authorization request.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: Concurrent review of inpatient stays must validate that continued-stay approvals align with contracted per diem rates, LOS benchmarks, and authorization requirements. UM staff need the provider contra',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Connects concurrent review records to the admitting provider for LOS benchmarking and clinical oversight reporting.',
    `um_case_id` BIGINT COMMENT 'Identifier of the overarching UM case that this review belongs to.',
    `um_reviewer_id` BIGINT COMMENT 'Foreign key linking to utilization.um_reviewer. Business justification: Concurrent reviews are conducted by UM clinical reviewers. concurrent_review currently stores clinical_reviewer_npi as a string, which is denormalized. Adding um_reviewer_id FK to the um_reviewer mast',
    `actual_discharge_date` DATE COMMENT 'Date the member actually left the hospital.',
    `admission_date` DATE COMMENT 'Date the member was admitted to the hospital.',
    `approved_length_of_stay` STRING COMMENT 'Maximum number of days approved for continued stay based on the review.',
    `authorized_post_acute_service` STRING COMMENT 'Post‑acute care service(s) approved during the review (e.g., physical therapy, home health).',
    `benchmark_source` STRING COMMENT 'Source of the LOS benchmark values.. Valid values are `cms|milliman|plan_actuarial`',
    `benchmark_source_detail` STRING COMMENT 'Free‑text description of the benchmark source (e.g., specific CMS report or Milliman model).',
    `concurrent_review_status` STRING COMMENT 'Current state of the review workflow.. Valid values are `pending|in_progress|approved|denied|closed`',
    `criteria_version` STRING COMMENT 'Version of InterQual or MCG criteria applied.',
    `current_length_of_stay` STRING COMMENT 'Number of days the member has been hospitalized to date.',
    `discharge_barriers` STRING COMMENT 'Identified obstacles preventing timely discharge (e.g., equipment, placement).',
    `discharge_destination` STRING COMMENT 'Intended location after hospital discharge.. Valid values are `home|snf|ltac|home_health|hospice`',
    `is_critical` BOOLEAN COMMENT 'True if the review is flagged as critical due to high acuity or risk.',
    `justification` STRING COMMENT 'Narrative explanation for why continued stay is medically necessary.',
    `los_benchmark_mean` DECIMAL(18,2) COMMENT 'Average LOS for the DRG or service line used as a benchmark.',
    `los_benchmark_outlier_threshold` DECIMAL(18,2) COMMENT 'Threshold beyond which the stay is considered an outlier.',
    `los_benchmark_target` DECIMAL(18,2) COMMENT 'Plan‑specific target LOS for the case.',
    `next_review_date` DATE COMMENT 'Scheduled date for the subsequent concurrent review.',
    `planned_discharge_date` DATE COMMENT 'Projected date for member discharge as determined by the reviewer.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    `review_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the review was completed or closed.',
    `review_notes` STRING COMMENT 'Additional free‑text comments entered by the reviewer.',
    `review_number` STRING COMMENT 'Human‑readable unique code assigned to the review for tracking and communication.',
    `review_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the concurrent review was initiated.',
    `review_type` STRING COMMENT 'Specifies whether the review is concurrent (ongoing) or retrospective.. Valid values are `concurrent|retrospective`',
    `social_work_involved` BOOLEAN COMMENT 'Indicates whether a social worker was consulted for discharge planning.',
    CONSTRAINT pk_concurrent_review PRIMARY KEY(`concurrent_review_id`)
) COMMENT 'Manages inpatient concurrent review records for admitted members — the ongoing UM review process evaluating continued medical necessity during a hospital stay. Captures admission date, current and approved length of stay (LOS), LOS benchmarks by DRG (geometric/arithmetic mean LOS, plan-specific target, outlier threshold, benchmark source — CMS, Milliman, plan actuarial), next review date, clinical reviewer NPI, InterQual/MCG criteria version applied, continued stay justification. Includes integrated discharge planning: planned discharge date, discharge destination (home, SNF, LTAC, home health, hospice), post-acute services authorized, barriers to discharge, social work involvement, care coordinator assigned, actual discharge date, and readmission risk score. Links to the originating PA request, UM case, and inpatient admission.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` (
    `retrospective_review_id` BIGINT COMMENT 'System-generated unique identifier for each retrospective utilization review record.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Retrospective reviews are frequently conducted as part of formal audit engagements (NCQA, CMS, state DOI). Linking retro reviews to the governing audit engagement enables audit scope tracking and is e',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Retrospective reviews that identify medical necessity or documentation failures are escalated into formal audit findings (CMS RAC, state DOI audits). Compliance teams create audit_finding records dire',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Retrospective reviews assess whether a service was covered under the members specific benefit. Linking to benefit enables benefit-level retro denial analysis, regulatory reporting of denial rates by ',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Retrospective medical necessity reviews require the care plan as clinical context to assess whether services rendered aligned with the documented treatment plan. This link supports clinical documentat',
    `header_id` BIGINT COMMENT 'Identifier of the claim associated with the service being retrospectively reviewed.',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: Retrospective reviews apply specific clinical criteria (InterQual/MCG) to determine medical necessity. retrospective_review has clinical_criteria_applied as a string capturing the criteria name/code. ',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Retrospective reviews require confirming the member had active coverage on the date of service. The eligibility span provides coverage dates, benefit package, and plan details essential for medical ne',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Retrospective reviews are frequently facility-based (post-discharge hospital stay reviews). Linking to provider.facility enables facility-level retro review reporting, compliance audits, and network p',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: Retrospective review calculates adjusted_amount for services under review. The fee schedule provides the contracted allowed amount needed to determine financial adjustments. Auditors and UM staff requ',
    `fwa_case_id` BIGINT COMMENT 'Foreign key linking to compliance.fwa_case. Business justification: Retrospective reviews that uncover billing fraud, upcoding, or abuse patterns are directly linked to FWA cases. This is a named health insurance process: retro review findings feeding FWA investigatio',
    `gap_id` BIGINT COMMENT 'Foreign key linking to care.care_gap. Business justification: Retrospective Review Closure Report uses review findings to close identified care gaps; linking each review to its care_gap provides auditability.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Regulatory audit of retrospective reviews is performed per employer; FK provides required grouping.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Retrospective Review Audit needs plan context to assess compliance and cost impact.',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: Retrospective reviews apply medical policy to determine medical necessity for services rendered without prior authorization. Adding medical_policy_id to retrospective_review establishes the governing ',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member whose service is being reviewed.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: A retrospective review is often triggered when a PA was not obtained prior to service. Linking retrospective_review to the associated pa_request (if one exists or was submitted late) is a valid busine',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Retrospective reviews assess claims against contract terms to identify over‑payments and ensure contractual compliance; required for audit and reimbursement adjustments.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider who delivered the service under review.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Retrospective claim reviews assess compliance with network contracts; linking to network provides contract‑specific audit data.',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Retrospective review denials and adjustments are frequently triggered by reimbursement policy rules (NCCI edits, global surgery periods, bundling). Linking to reimbursement_policy creates an audit tra',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: A retrospective review is a UM workflow activity that should be tracked under the overarching UM case container. um_case is the master workflow entity for all UM activities including retro reviews. Th',
    `um_reviewer_id` BIGINT COMMENT 'Identifier of the clinical reviewer who made the final decision.',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment resulting from the review decision (e.g., denied amount, approved reimbursement).',
    `compliance_state` STRING COMMENT 'Overall compliance status of the review with regulatory timelines.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the retrospective review record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the adjusted amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|JPY|AUD|CHF|CNY|MXN|INR — promote to reference product]',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating why a service was denied after retrospective review.',
    `denial_reason_description` STRING COMMENT 'Human‑readable description of the denial reason.',
    `documentation_completeness_flag` BOOLEAN COMMENT 'Indicates whether all required documentation was complete and sufficient.',
    `documentation_received_date` DATE COMMENT 'Date the required clinical documentation was received for the review.',
    `medical_necessity_outcome` STRING COMMENT 'Result of the medical necessity determination for the reviewed service.. Valid values are `approved|denied|partial`',
    `retro_review_deadline_flag` BOOLEAN COMMENT 'Indicates whether the review was completed within the state‑mandated retro‑review deadline.',
    `review_completion_date` DATE COMMENT 'Date the review decision was finalized.',
    `review_initiation_date` DATE COMMENT 'Date the retrospective review process was started.',
    `review_notes` STRING COMMENT 'Free‑form comments entered by the reviewer regarding the decision.',
    `review_number` STRING COMMENT 'External reference number assigned to the review for tracking and reporting.',
    `review_status` STRING COMMENT 'Current workflow state of the retrospective review.. Valid values are `pending|in_review|completed|closed`',
    `review_type` STRING COMMENT 'Classification of the review; typically retrospective when prior authorization was not obtained.. Valid values are `retrospective|post_admission`',
    `service_date` DATE COMMENT 'Calendar date on which the medical service was provided.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    CONSTRAINT pk_retrospective_review PRIMARY KEY(`retrospective_review_id`)
) COMMENT 'Records retrospective (post-service) UM reviews conducted when prior authorization was not obtained before service delivery. Captures service date, review initiation date, clinical documentation received date, medical necessity outcome, denial or approval result, and applicable state retro-review deadline compliance flag. Supports NCQA UM accreditation standards for retrospective review turnaround time (TAT) compliance.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`um_case` (
    `um_case_id` BIGINT COMMENT 'System-generated unique identifier for the UM case.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: UM cases are opened for specific benefits (e.g., inpatient surgery, home health). Linking to benefit enables benefit-level case volume reporting, denial rate analysis by benefit category, and regulato',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: UM cases are managed within the context of a members benefit package — the package determines covered services, cost-shares, and applicable UM rules. Case managers need this to apply correct coverage',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: UM cases for high-risk members are co-managed with care management programs. Linking um_case to care_enrollment enables integrated case management reporting, NCQA UM/CM coordination standards complian',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Case Management Dashboard needs to reference the members care plan to align interventions and report case outcomes against the plan.',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.care_coordinator. Business justification: Case Management Process assigns a care coordinator to each utilization case; linking enables case‑to‑coordinator reporting and workload tracking.',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: UM cases managed under delegated UM arrangements must reference the delegation agreement to support NCQA/URAC oversight reporting and regulatory compliance audits. Identifies which delegated entity pe',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: UM case management requires confirming active coverage, benefit package, network assignment, and OOP limits before making authorization decisions. The eligibility span is the authoritative coverage re',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: UM cases for inpatient episodes are associated with a specific facility for case management, network compliance monitoring, and facility-level UM reporting. Health insurance UM operations track which ',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Case management dashboards for employers require tying each utilization case to the employer sponsoring the member.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: UM Case Management Dashboard aggregates cases by health plan to monitor utilization trends.',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: A UM case applies medical policy in its clinical determination workflow. um_case has clinical_criteria_set as a string but no direct medical_policy_id FK. Adding medical_policy_id establishes the gove',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the case.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: UM case management uses member risk scores to set case_priority and case_severity, determine intensity of management, and allocate clinical resources. Health insurance UM workflows universally risk-st',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: um_case may be initiated by a PA request; child (um_case) gets FK to parent (pa_request).',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: UM cases are managed against a members elected plan. The plan election determines benefit package, network, FSA/HSA elections, and cost-sharing rules that govern clinical criteria selection and autho',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: UM case policy context: UM case management requires the specific policys authorized benefits, coverage limits, and benefit structure to determine authorized services and appeals eligibility. Policy r',
    `provider_id` BIGINT COMMENT 'Identifier of the provider who rendered the service under review.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Utilization Management cases are governed by the providers contract terms (coverage criteria, cost‑share); linking supports case review, compliance, and audit.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Case management reports attribute each case to the primary provider’s network for network adequacy analysis and cost allocation.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Utilization management cases are frequently initiated to satisfy specific regulatory obligations (e.g., CMS guidelines).',
    `um_program_id` BIGINT COMMENT 'Foreign key linking to utilization.um_program. Business justification: um_case belongs to a UM program configuration; child (case) gets FK to parent (um_program).',
    `um_reviewer_id` BIGINT COMMENT 'Foreign key linking to utilization.um_reviewer. Business justification: A UM case is assigned to a UM reviewer (nurse, medical director, or physician advisor). um_case currently stores assigned_nurse_name as a denormalized string. Adding um_reviewer_id FK to the um_review',
    `appeal_indicator` BOOLEAN COMMENT 'True if the case has been appealed.',
    `case_close_date` DATE COMMENT 'Date the UM case was closed or completed; null if still open.',
    `case_number` STRING COMMENT 'Business-visible case number used for tracking and communication.',
    `case_open_date` DATE COMMENT 'Date the UM case was opened and became active.',
    `case_priority` STRING COMMENT 'Priority level assigned to the case for workload management.. Valid values are `high|medium|low`',
    `case_severity` STRING COMMENT 'Severity rating reflecting clinical urgency and complexity.. Valid values are `critical|moderate|minor`',
    `case_status` STRING COMMENT 'Current lifecycle status of the UM case.. Valid values are `open|closed|in_review|denied|approved|pending`',
    `case_type` STRING COMMENT 'Category of the case based on care setting or service type.. Valid values are `inpatient|outpatient|behavioral|dme|pharmacy|other`',
    `clinical_criteria_set` STRING COMMENT 'Source set of clinical criteria applied (InterQual or MCG).. Valid values are `InterQual|MCG`',
    `clinical_criteria_version` STRING COMMENT 'Version identifier of the clinical criteria set used for the case.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the case meets NCQA UM accreditation requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the UM case record was first created in the system.',
    `denial_reason_code` STRING COMMENT 'Code indicating why a prior authorization or claim was denied.',
    `denial_reason_description` STRING COMMENT 'Textual explanation of the denial reason.',
    `disposition_code` STRING COMMENT 'Standard code representing the final outcome of the case.',
    `disposition_description` STRING COMMENT 'Human‑readable description of the case outcome.',
    `length_of_stay_actual` STRING COMMENT 'Observed length of stay for the episode, expressed in days.',
    `length_of_stay_target` STRING COMMENT 'Planned maximum length of stay for the episode, expressed in days.',
    `notes` STRING COMMENT 'Free‑text field for clinical or administrative comments.',
    `primary_diagnosis_code` STRING COMMENT 'ICD code representing the principal diagnosis driving the case.',
    `primary_diagnosis_description` STRING COMMENT 'Text description of the principal diagnosis.',
    `primary_provider_npi` STRING COMMENT 'National Provider Identifier of the primary provider.',
    `prior_authorization_decision_date` DATE COMMENT 'Date the prior authorization decision was rendered.',
    `prior_authorization_number` STRING COMMENT 'Reference number for the prior authorization request linked to the case.',
    `prior_authorization_status` STRING COMMENT 'Current status of the prior authorization request.. Valid values are `pending|approved|denied|expired`',
    `turnaround_time_days` STRING COMMENT 'Number of days from case open to final disposition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the UM case record.',
    `urgency_flag` BOOLEAN COMMENT 'True if the case requires expedited review per clinical criteria.',
    CONSTRAINT pk_um_case PRIMARY KEY(`um_case_id`)
) COMMENT 'Master entity representing a utilization management (UM) case — the overarching workflow container grouping all UM activities (PA requests, concurrent reviews, retrospective reviews, P2P reviews, appeals) for a single member episode of care. Captures case type (inpatient, outpatient, behavioral health, DME, pharmacy), case open/close dates, assigned UM nurse or case manager, episode of care identifier, primary diagnosis, and case disposition. Enables end-to-end UM workflow tracking, workload management, and NCQA UM accreditation reporting.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` (
    `um_reviewer_id` BIGINT COMMENT 'Unique surrogate key for the utilization management reviewer.',
    `city` STRING COMMENT 'City of reviewer’s address.',
    `compliance_state` STRING COMMENT 'Current compliance status of the reviewer with internal and external UM regulations.. Valid values are `compliant|non_compliant|pending|under_review`',
    `country` STRING COMMENT 'Country of reviewer’s residence.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reviewer record was first created in the system.',
    `credential_type` STRING COMMENT 'Professional credential held by the reviewer.. Valid values are `RN|MD|PharmD|LCSW|NP|PA`',
    `date_of_birth` DATE COMMENT 'Reviewer’s birth date.',
    `delegation_authority_level` STRING COMMENT 'Level of authority the reviewer has to delegate or approve utilization decisions.. Valid values are `none|review|approve|escalate|admin`',
    `email_address` STRING COMMENT 'Primary email for reviewer communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `first_name` STRING COMMENT 'Reviewer’s given name.',
    `full_name` STRING COMMENT 'Concatenated full legal name of the reviewer.',
    `hire_date` DATE COMMENT 'Date the reviewer was hired by the health plan.',
    `last_name` STRING COMMENT 'Reviewer’s family name.',
    `last_training_date` DATE COMMENT 'Date of the most recent required UM/PA training completed by the reviewer.',
    `license_expiration_date` DATE COMMENT 'Date when the reviewer’s professional license expires.',
    `license_number` STRING COMMENT 'State-issued license number for the reviewer.',
    `license_state` STRING COMMENT 'State that issued the professional license.',
    `middle_name` STRING COMMENT 'Reviewer’s middle name, if any.',
    `ncqa_qualified_flag` BOOLEAN COMMENT 'Indicates whether the reviewer meets NCQA accreditation qualifications.',
    `next_training_due_date` DATE COMMENT 'Scheduled date for the reviewer’s next required training.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations about the reviewer.',
    `npi` STRING COMMENT 'Unique identifier assigned to the reviewer by the National Provider Identifier system.',
    `phone_number` STRING COMMENT 'Primary contact phone number.',
    `reviewer_status` STRING COMMENT 'Current lifecycle status of the reviewer within UM operations.. Valid values are `active|inactive|suspended|retired|pending`',
    `specialty` STRING COMMENT 'Medical specialty area of the reviewer (e.g., cardiology, oncology).',
    `state` STRING COMMENT 'State of reviewer’s address.',
    `street_address` STRING COMMENT 'Reviewer’s mailing street address.',
    `termination_date` DATE COMMENT 'Date the reviewer’s employment ended, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reviewer record.',
    `urac_qualified_flag` BOOLEAN COMMENT 'Indicates whether the reviewer meets URAC accreditation qualifications.',
    `version_number` STRING COMMENT 'Incremental version number for optimistic concurrency control.',
    `zip_code` STRING COMMENT 'Postal code of reviewer’s address.',
    CONSTRAINT pk_um_reviewer PRIMARY KEY(`um_reviewer_id`)
) COMMENT 'Master entity for UM clinical reviewers — nurses, medical directors, and physician advisors who conduct UM and PA reviews. Captures reviewer NPI (if applicable), reviewer name, credential type (RN, MD, PharmD, LCSW), specialty, active status, state licensure details, URAC/NCQA reviewer qualification status, assigned review queues, and delegation authority level. Distinct from the provider domain — this entity represents internal plan staff performing UM functions.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` (
    `inpatient_admission_id` BIGINT COMMENT 'System-generated unique identifier for the inpatient admission record.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: The admitting/attending physician drives length-of-stay benchmarks, UM decisions, and quality reporting for inpatient episodes. Role-prefix admitting_ distinguishes this from the existing pa_provide',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Inpatient admission review requires knowing the members benefit package to determine covered days, applicable cost-share, and network requirements. Concurrent review and LOS benchmarking depend on be',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: For capitated providers, inpatient admissions must be tracked against the capitation arrangement to determine whether the admission falls within capitated scope or triggers individual/aggregate stop-l',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Inpatient admissions trigger care management enrollment or escalation for high-risk members. This link supports hospital notification workflows, post-discharge outreach programs, and CMS/NCQA care tra',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule used for concurrent review.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Inpatient admissions occur at a specific credentialed facility. Linking to provider.facility enables network adequacy reporting, facility-tier utilization analysis, and claims adjudication validation.',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: The fee schedule determines DRG base rates and per diem rates used to calculate expected_cost_amount vs actual_cost_amount on inpatient admissions. UM and finance teams use this link for cost variance',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Employer groups require inpatient admission utilization reports for cost management and stop-loss aggregate tracking under TPA arrangements. A health insurance domain expert would expect group_id on i',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Inpatient Admission Utilization reports are generated per health plan for network adequacy analysis.',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Admission eligibility verification: inpatient admission authorization and concurrent review require confirmation of the members active eligibility span covering the admission dates; LOS management an',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Inpatient admission expected_cost_amount and expected_los_days benchmarks are risk-adjusted using member risk scores. CMS risk adjustment reconciliation and inpatient cost variance reporting require l',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the insured member associated with the admission.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: An inpatient admission subject to UM review is linked to the PA request that authorized the admission. inpatient_admission has authorization_number as a string but no FK to pa_request. Adding pa_reque',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Inpatient policy coverage: admission cost management, DRG payment validation, and LOS authorization require the specific policys coverage terms, deductible status, and out-of-pocket limits. Policy re',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: Inpatient admissions are governed by provider contracts specifying DRG/per diem payment methodology, LOS benchmarks, and authorization requirements. Claims adjudication and UM both require the contrac',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Inpatient admission authorization and cost-sharing determination require knowing which provider network the admitting facility belongs to. Network status drives coverage rules, authorization requireme',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: An inpatient admission is the subject of a UM case. While concurrent_review bridges inpatient_admission and um_case, a direct FK from inpatient_admission to um_case enables efficient case management q',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Final cost incurred for the admission after discharge.',
    `actual_los_days` STRING COMMENT 'Number of days the member actually stayed in the facility.',
    `admission_date` DATE COMMENT 'Date the member was admitted to the facility.',
    `admission_number` STRING COMMENT 'Business identifier assigned to the admission by the health plan.',
    `admission_status` STRING COMMENT 'Current lifecycle status of the admission.. Valid values are `admitted|discharged|cancelled|transferred`',
    `admission_type` STRING COMMENT 'Classification of the admission based on urgency.. Valid values are `elective|urgent|emergent|other`',
    `authorization_number` STRING COMMENT 'Unique identifier of the payers authorization for this admission.',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical criteria set (e.g., InterQual v2023) applied to the admission.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the admission record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `denial_reason_code` STRING COMMENT 'Standardized code representing why the admission was denied.',
    `denial_reason_description` STRING COMMENT 'Narrative description of the denial reason.',
    `discharge_date` DATE COMMENT 'Date the member was discharged from the facility.',
    `discharge_disposition` STRING COMMENT 'Post‑discharge destination of the member.. Valid values are `home|snf|rehab|expired|other`',
    `drg_code` STRING COMMENT 'DRG assignment for the admission used for payment and benchmarking.',
    `expected_cost_amount` DECIMAL(18,2) COMMENT 'Projected cost of the admission before services are rendered.',
    `expected_los_days` STRING COMMENT 'Projected number of days the member is expected to stay, based on clinical criteria.',
    `is_critical_care` BOOLEAN COMMENT 'Indicates whether the admission involved critical care services.',
    `is_readmission` BOOLEAN COMMENT 'True if the admission is a readmission within the defined look‑back period.',
    `los_benchmark_met_flag` BOOLEAN COMMENT 'Indicates whether actual LOS met the benchmark target.',
    `los_target_days` STRING COMMENT 'Benchmark target days for LOS based on plan and diagnosis.',
    `payer_authorization_status` STRING COMMENT 'Current status of the payers prior‑authorization for the admission.. Valid values are `authorized|pending|denied|not_required`',
    `primary_diagnosis_code` STRING COMMENT 'ICD code representing the principal diagnosis for the admission.',
    `readmission_within_30_days` BOOLEAN COMMENT 'True if the admission occurs within 30 days of a prior discharge.',
    `review_decision` STRING COMMENT 'Outcome of the utilization management review.. Valid values are `approved|denied|partial|pending`',
    `review_decision_date` DATE COMMENT 'Date the UM reviewer rendered a decision.',
    `review_status` STRING COMMENT 'Current status of the utilization management review.. Valid values are `pending|completed|escalated`',
    `source_system` STRING COMMENT 'Originating system for the admission data (e.g., InterQual, MCG).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the admission record.',
    CONSTRAINT pk_inpatient_admission PRIMARY KEY(`inpatient_admission_id`)
) COMMENT 'UM-managed inpatient admission record for admissions subject to concurrent review. Captures admitting facility NPI, admitting physician NPI, admission date, admission type (elective, urgent, emergent), primary admitting diagnosis (ICD), DRG assignment, expected LOS, actual discharge date, discharge disposition (home, SNF, rehab, expired), and payer authorization status. Serves as the anchor for concurrent review workflows and LOS benchmark comparisons. Distinct from the claim domains institutional claim — this is the clinical/UM view of the admission, not the billing view.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`um_program` (
    `um_program_id` BIGINT COMMENT 'System-generated unique identifier for each UM program definition.',
    `accreditation_program_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_program. Business justification: UM programs are directly evaluated under accreditation programs (NCQA UM accreditation, URAC). The um_program.accreditation_status and accreditation_survey_date are denormalized from accreditation_pro',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: UM programs are configured per benefit package to define which package members are subject to which UM program (e.g., case management, disease management). NCQA/URAC accreditation requires documenting',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: UM programs are frequently delegated to IPAs, ACOs, or TPAs under formal delegation agreements. Linking um_program to delegation_agreement is required for NCQA accreditation oversight, annual delegati',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Large self-funded employer groups with TPA arrangements often have customized UM programs. UM operations and compliance teams need group_id on um_program to manage group-specific UM program configurat',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: UM Program Enrollment reports require associating programs with the health plans they serve.',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: UM programs are governed by formal compliance policy documents (UM program descriptions, criteria policies, delegation policies). NCQA and URAC accreditation require UM programs to reference their gov',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: UM programs (e.g., transplant UM, oncology UM) are operationally paired with care management programs. Health plans link these to coordinate clinical criteria, care protocols, and member management. R',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: UM programs define PA requirements, review criteria, and service scope for specific network configurations (e.g., narrow network, tiered network products). Linking um_program to provider_network enabl',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Programs are designed to meet regulatory requirements; the FK supports program‑to‑obligation reporting.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: UM programs are versioned annually — clinical criteria, PA requirements, and accreditation standards change each plan year. Linking um_program to plan year enables year-over-year UM program comparison',
    `accreditation_category` STRING COMMENT 'Specific NCQA/URAC accreditation domain the program addresses (Turn‑Around‑Time, Criteria, Notification, Delegation, Peer‑to‑Peer).. Valid values are `tat|criteria|notification|delegation|p2p`',
    `clinical_criteria_set` STRING COMMENT 'Name of the InterQual or MCG criteria set assigned to the program.',
    `compliance_notes` STRING COMMENT 'Free‑text field for additional compliance observations or exceptions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the UM program record was first created in the data lake.',
    `criteria_effective_date` DATE COMMENT 'Date on which the assigned clinical criteria become effective for the program.',
    `criteria_version` STRING COMMENT 'Version identifier of the clinical criteria set (e.g., v2024.1).',
    `effective_from` DATE COMMENT 'Date when the UM program becomes operational.',
    `effective_until` DATE COMMENT 'Date when the UM program is retired or superseded (null if open‑ended).',
    `gap_analysis_date` DATE COMMENT 'Date when the most recent gap analysis was completed.',
    `gap_analysis_status` STRING COMMENT 'Current state of the gap analysis performed against accreditation requirements.. Valid values are `open|closed|in_progress`',
    `line_of_business` STRING COMMENT 'Business segment(s) to which the UM program is applicable.. Valid values are `individual|group|medicare|medicaid|exchange|self_funded`',
    `next_review_due_date` DATE COMMENT 'Planned date for the next formal program review or update.',
    `pa_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization is mandatory for services under this program.',
    `program_notes` STRING COMMENT 'Additional internal comments or documentation about the UM program.',
    `program_type` STRING COMMENT 'Category of services the UM program applies to.. Valid values are `inpatient|outpatient|behavioral|pharmacy|specialty`',
    `program_version` STRING COMMENT 'Version label for the program definition (e.g., v1.0, v2.3).',
    `regulatory_reference` STRING COMMENT 'Citation to the specific NCQA, URAC, or state DOI regulation governing the program.',
    `review_type_scope` STRING COMMENT 'Scope of review types covered by the program.. Valid values are `concurrent|retrospective|both`',
    `services_covered` STRING COMMENT 'Free‑text list or coded reference of clinical services that require UM review under this program.',
    `um_program_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and key features of the UM program.',
    `um_program_status` STRING COMMENT 'Current lifecycle status of the UM program.. Valid values are `active|inactive|retired|draft`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the UM program record.',
    CONSTRAINT pk_um_program PRIMARY KEY(`um_program_id`)
) COMMENT 'Master reference for the health plans UM program configurations — the formal UM program definitions required by NCQA, URAC, and state DOI. Captures program name, program type (inpatient UM, outpatient UM, behavioral health UM, pharmacy UM, specialty drug UM), applicable lines of business, clinical criteria set assigned (InterQual/MCG version and effective date), review type scope, NCQA/URAC accreditation compliance status by standard category (TAT, criteria, notification, delegation, P2P), accreditation survey dates, and current gap analysis. Governs which services require PA and which clinical criteria apply.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` (
    `pa_required_service_id` BIGINT COMMENT 'Unique surrogate key for each PA requirement record.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: PA required service rules are configured at the benefit level — specific benefits (e.g., MRI, inpatient surgery) trigger PA requirements. CMS PA transparency rules and NCQA accreditation require benef',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: PA requirements are scoped to benefit packages — HMO packages may require PA for services that PPO packages do not. UM configuration teams define PA rules per benefit package. This link enables packag',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: PA required service entries reference clinical criteria sets to determine PA necessity. pa_required_service has clinical_criteria_set as a string but no FK to the clinical_criteria master. Adding clin',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: PA required service rules are frequently customized per employer group — large groups negotiate PA exemptions or gold-card arrangements. Benefit configuration and compliance teams need group_id on pa_',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: PA required service rules are configured at the plan offering level — an employers PPO offering may have different PA requirements than their HMO offering. Benefit configuration teams manage PA rules',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan to which this PA rule applies.',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: PA required service definitions are governed by medical policies. The medical policy determines whether PA is required for a given service. Linking pa_required_service to medical_policy establishes th',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: pa_required_service defines services required for a specific PA request; child (required_service) gets FK to parent (pa_request).',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: PA required service lists are formally governed by compliance policy documents (PA criteria policies, coverage determination policies). The regulatory_citation on pa_required_service is a denormalized',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Reimbursement policies contain PA override and auth requirements (override_requires_auth flag). Linking pa_required_service to reimbursement_policy ensures PA configuration in UM aligns with adjudicat',
    `service_scope_id` BIGINT COMMENT 'Foreign key linking to contract.service_scope. Business justification: PA-required service configurations must align with contracted service scope to avoid authorizing services outside contracted coverage. Contracting and UM teams use this link to validate PA rules again',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: PA required service rules include specialty-based exemptions (provider_specialty_exemption_flag, gold_card_flag). Linking to provider.specialty enables automated gold card eligibility determination an',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Tiered network products have different PA requirements per tier (network.tier.prior_authorization_required_flag). pa_required_service must reference the specific tier to model tier-differentiated PA r',
    `um_program_id` BIGINT COMMENT 'Foreign key linking to utilization.um_program. Business justification: PA required service rules are defined within the context of a UM program. um_program is the master configuration entity for UM programs, and PA requirements are program-specific. Adding um_program_id ',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: PA required service lists are updated annually per plan year — CMS and state mandates change PA requirements each year. Linking to plan year enables year-specific PA requirement tracking, annual regul',
    `clinical_criteria_set` STRING COMMENT 'Name of the clinical criteria set (e.g., InterQual, MCG) used for evaluation.',
    `effective_date` DATE COMMENT 'Date when the PA requirement becomes effective.',
    `exemption_type` STRING COMMENT 'Reason why PA may be exempted for this service.. Valid values are `state_mandate|cms_requirement|gold_card|plan_policy|none`',
    `expiration_date` DATE COMMENT 'Date when the PA requirement ends; null if indefinite.',
    `gold_card_approval_rate_met_flag` BOOLEAN COMMENT 'Indicates if the provider met the approval rate threshold.',
    `gold_card_approval_rate_threshold` DECIMAL(18,2) COMMENT 'Minimum approval rate percentage required for gold card eligibility.',
    `gold_card_effective_date` DATE COMMENT 'Start date of gold card exemption.',
    `gold_card_expiration_date` DATE COMMENT 'End date of gold card exemption.',
    `gold_card_flag` BOOLEAN COMMENT 'Indicates if a gold card exemption applies.',
    `gold_card_provider_npi` STRING COMMENT 'National Provider Identifier of the provider granted gold card status.',
    `gold_card_revocation_reason` STRING COMMENT 'Reason for revoking gold card status.',
    `line_of_business` STRING COMMENT 'Business segment for the plan (e.g., commercial, Medicare Advantage).. Valid values are `commercial|medicare_advantage|medicaid|group|individual`',
    `pa_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization is required for the service.',
    `pa_required_service_status` STRING COMMENT 'Current lifecycle status of the PA requirement record.. Valid values are `active|inactive|retired|pending`',
    `pa_type` STRING COMMENT 'Type of PA process applicable.. Valid values are `standard|expedited|concurrent|none`',
    `provider_specialty_exemption_flag` BOOLEAN COMMENT 'Indicates if the providers specialty grants an exemption.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `service_code` STRING COMMENT 'The standardized code representing the medical service or procedure.',
    `service_description` STRING COMMENT 'Human readable description of the service.',
    `updated_by` STRING COMMENT 'Identifier of the user who last updated the record.',
    `created_by` STRING COMMENT 'Identifier of the user who created the record.',
    CONSTRAINT pk_pa_required_service PRIMARY KEY(`pa_required_service_id`)
) COMMENT 'Unified reference master defining PA requirements, exemptions, and gold card overrides by service, provider, plan, and line of business. Captures CPT/HCPCS code or service category, plan ID, line of business (commercial, Medicare Advantage, Medicaid), effective date, PA required/exempt flag, exemption type (state mandate, CMS requirement, gold card, plan policy), PA type (standard, expedited, concurrent), applicable clinical criteria set, regulatory citation, and provider specialty exemption criteria. For gold card entries: provider NPI, gold card effective/expiration dates, approval rate threshold met, qualifying performance period, and revocation reason. Drives PA intake routing, provider-facing PA requirement lookups, state PA reform compliance, and gold card mandate tracking.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`medical_policy` (
    `medical_policy_id` BIGINT COMMENT 'System-generated unique identifier for the medical policy record.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Medical policies govern coverage decisions for specific benefits (e.g., bariatric surgery policy maps to bariatric surgery benefit). Clinical policy teams link policies to benefits for coverage determ',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Medical policies may be scoped to specific benefit packages — a policy may apply to HMO but not PPO packages. This link enables package-level policy management, ensures correct policy application duri',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: Medical policies are based on clinical criteria (InterQual/MCG guidelines). medical_policy has clinical_criteria_source and clinical_criteria_version as strings but no FK to the clinical_criteria mast',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Certain medical policies are employer‑specific; linking enables policy applicability checks per employer.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Medical Policy Applicability Matrix links each policy to the plans it governs for compliance reporting.',
    `parent_medical_policy_id` BIGINT COMMENT 'Self-referencing FK on medical_policy (parent_medical_policy_id)',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Medical policies are formally governed by compliance policy documents (coverage determination policies, clinical coverage bulletins). Linking medical_policy to its governing policy_document is require',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Medical policies must align with regulatory obligations; linking provides traceability for compliance audits.',
    `applicable_cpt_codes` STRING COMMENT 'Comma‑separated list of CPT procedure codes covered under the policy.',
    `applicable_hcpcs_codes` STRING COMMENT 'Comma‑separated list of HCPCS codes (including drugs) covered under the policy.',
    `clinical_category` STRING COMMENT 'High‑level clinical grouping (e.g., cardiology, orthopedics) to which the policy applies.',
    `clinical_criteria_version` STRING COMMENT 'Version identifier of the clinical criteria set applied.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the policy with respect to external regulations.. Valid values are `compliant|non‑compliant|pending|exempt`',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Monetary cap applied to the total covered amount for the policy period.',
    `coverage_limit_currency` STRING COMMENT 'Three‑letter ISO currency code for the coverage limit amount.',
    `coverage_limit_units` STRING COMMENT 'Unit of measure for the coverage limit (e.g., visits, days).. Valid values are `visits|days|doses|sessions|procedures`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the policy becomes binding for members.',
    `effective_until` DATE COMMENT 'Date on which the policy ceases to be binding; null for open‑ended policies.',
    `is_emergency_covered` BOOLEAN COMMENT 'Indicates whether emergency services are covered without prior authorization.',
    `is_exempt` BOOLEAN COMMENT 'True if the policy includes exemptions for specific services or member groups.',
    `is_experimental_covered` BOOLEAN COMMENT 'True if experimental or investigational services are permitted under the policy.',
    `is_prior_auth_required` BOOLEAN COMMENT 'Indicates whether a prior authorization must be obtained for services covered by this policy.',
    `is_telehealth_covered` BOOLEAN COMMENT 'Indicates whether telehealth services are covered under the policy.',
    `last_reviewed_by` STRING COMMENT 'Identifier of the user who performed the most recent policy review.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy was last reviewed for clinical or regulatory updates.',
    `medical_policy_status` STRING COMMENT 'Current lifecycle state of the policy.. Valid values are `active|inactive|suspended|pending|draft|terminated`',
    `notes` STRING COMMENT 'Free‑form text for additional comments, special considerations, or audit remarks.',
    `policy_name` STRING COMMENT 'Human‑readable name of the policy for reporting and UI display.',
    `policy_number` STRING COMMENT 'External business identifier assigned to the policy, used in member communications and claim adjudication.',
    `policy_type` STRING COMMENT 'Category of the policy indicating the primary clinical domain it governs.. Valid values are `medical|surgical|behavioral|pharmacy|diagnostic`',
    `prior_auth_approval_timeframe_days` STRING COMMENT 'Maximum number of calendar days allowed to approve a prior authorization request.',
    `regulatory_reference` STRING COMMENT 'Citation to the regulatory rule or guideline that mandates this policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the policy record.',
    `version_effective_date` DATE COMMENT 'Date when this version of the policy became effective.',
    `version_expiration_date` DATE COMMENT 'Date when this version of the policy was superseded or retired.',
    `version_number` STRING COMMENT 'Sequential version identifier for policy revisions.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the policy record.',
    CONSTRAINT pk_medical_policy PRIMARY KEY(`medical_policy_id`)
) COMMENT 'Master reference for medical policies and clinical criteria used in utilization management decisions — including medical necessity criteria, clinical guidelines, evidence-based medicine references, and policy effective dates. Captures policy ID, policy name, clinical category, applicable CPT/HCPCS codes, review criteria source (InterQual, MCG, internal), and version history.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`clinical_criteria` (
    `clinical_criteria_id` BIGINT COMMENT 'Primary key for clinical_criteria',
    `parent_clinical_criteria_id` BIGINT COMMENT 'Self-referencing FK on clinical_criteria (parent_clinical_criteria_id)',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Clinical criteria (InterQual, MCG, proprietary) are formally documented in compliance policy documents. The criteria_reference on clinical_criteria is a denormalized reference to policy_document. NCQA',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `criteria_category` STRING COMMENT 'Broad category indicating the clinical setting or context of the criteria.',
    `criteria_code` STRING COMMENT 'Unique code assigned to the clinical criteria, used for lookup and integration.',
    `criteria_description` STRING COMMENT 'Detailed description of the clinical criteria, including its purpose and application.',
    `criteria_detail` STRING COMMENT 'Textual or structured detail of the rule or logic that defines the criteria.',
    `criteria_effective_date` DATE COMMENT 'Date when the clinical criteria becomes effective and applicable.',
    `criteria_expiration_date` DATE COMMENT 'Date when the clinical criteria is no longer valid or applicable.',
    `criteria_limit_unit` STRING COMMENT 'Unit of measurement for the limit value (e.g., days, dollars).',
    `criteria_limit_value` DECIMAL(18,2) COMMENT 'Numeric limit value used in the criteria rule (e.g., maximum allowed).',
    `criteria_name` STRING COMMENT 'Human-readable name of the clinical criteria.',
    `criteria_notes` STRING COMMENT 'Additional notes or comments about the clinical criteria.',
    `criteria_rule_expression` STRING COMMENT 'Formal expression or logic that defines how the criteria is evaluated.',
    `criteria_source` STRING COMMENT 'Originating system or authority that defines the clinical criteria.',
    `criteria_status` STRING COMMENT 'Current lifecycle status of the clinical criteria.',
    `criteria_subcategory` STRING COMMENT 'More specific classification within the category to refine the criteria context.',
    `criteria_threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value (e.g., days, dollars).',
    `criteria_threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value used in the criteria rule (e.g., maximum days, minimum cost).',
    `criteria_type` STRING COMMENT 'Category of the clinical criteria indicating the type of clinical element it applies to.',
    `criteria_version` STRING COMMENT 'Version identifier of the clinical criteria to track updates and revisions.',
    `record_status` STRING COMMENT 'Current status of the record for data lifecycle management.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated in the system.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_clinical_criteria PRIMARY KEY(`clinical_criteria_id`)
) COMMENT 'Master reference table for clinical_criteria. Referenced by clinical_criteria_id.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` (
    `reviewer_program_assignment_id` BIGINT COMMENT 'Primary key for the reviewer_program_assignment association',
    `um_program_id` BIGINT COMMENT 'Foreign key linking to the UM program under which the reviewer is authorized.',
    `um_reviewer_id` BIGINT COMMENT 'Foreign key linking to the UM reviewer who is authorized under this program assignment.',
    `assigned_review_queue` STRING COMMENT 'Primary review queue to which the reviewer is assigned. [Moved from um_reviewer: The review queue a reviewer works in is program-specific — a reviewer may work different queues under different UM programs. This attribute is more accurately a property of the reviewer-program assignment than a single static attribute on the reviewer master record. However, if the business treats assigned_review_queue as the reviewers primary/default queue independent of program context, it may remain on um_reviewer. Flag for business stakeholder confirmation.]',
    `assignment_end_date` DATE COMMENT 'The date on which the reviewers authorization under this UM program expires or is revoked. Null if the assignment is currently active. Enables historical compliance queries.',
    `assignment_start_date` DATE COMMENT 'The date on which the reviewers authorization to conduct reviews under this UM program becomes effective. Required for NCQA/URAC compliance auditing to confirm reviewer qualification was in place at time of review.',
    `reviewer_role_in_program` STRING COMMENT 'The specific functional role the reviewer performs within this UM program (e.g., primary clinical reviewer, peer-to-peer reviewer, medical director sign-off). A reviewer may hold different roles across different programs, so this attribute belongs to the assignment, not the reviewer.',
    CONSTRAINT pk_reviewer_program_assignment PRIMARY KEY(`reviewer_program_assignment_id`)
) COMMENT 'This association product represents the formal Assignment between um_reviewer and um_program. It captures the authorization of a qualified UM reviewer to conduct reviews under a specific UM program, as required by NCQA and URAC accreditation standards. Each record links one um_reviewer to one um_program and carries the effective dates and role of the assignment — data that exists only in the context of this reviewer-program authorization and is essential for compliance auditing and accreditation documentation.. Existence Justification: In health insurance UM operations, reviewers are formally assigned to specific UM programs based on their credentials, specialty, and licensure — a single reviewer (e.g., an RN with oncology specialty) may be authorized under multiple UM programs (e.g., inpatient UM and specialty drug UM), and each UM program requires multiple qualified reviewers to meet NCQA/URAC staffing standards. This assignment is an actively managed, compliance-critical business concept: health plans must document which reviewers are authorized under which programs, with effective dates, to satisfy accreditation audits. The relationship carries its own data (assignment start/end dates, reviewer role within the program) that belongs to neither the reviewer nor the program alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `health_insurance_ecm`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_um_reviewer_id` FOREIGN KEY (`um_reviewer_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_reviewer`(`um_reviewer_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `health_insurance_ecm`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_um_reviewer_id` FOREIGN KEY (`um_reviewer_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_reviewer`(`um_reviewer_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `health_insurance_ecm`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_um_reviewer_id` FOREIGN KEY (`um_reviewer_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_reviewer`(`um_reviewer_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `health_insurance_ecm`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_um_reviewer_id` FOREIGN KEY (`um_reviewer_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_reviewer`(`um_reviewer_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `health_insurance_ecm`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_parent_medical_policy_id` FOREIGN KEY (`parent_medical_policy_id`) REFERENCES `health_insurance_ecm`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_parent_clinical_criteria_id` FOREIGN KEY (`parent_clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ADD CONSTRAINT `fk_utilization_reviewer_program_assignment_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ADD CONSTRAINT `fk_utilization_reviewer_program_assignment_um_reviewer_id` FOREIGN KEY (`um_reviewer_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_reviewer`(`um_reviewer_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`utilization` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `health_insurance_ecm`.`utilization` SET TAGS ('dbx_domain' = 'utilization');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` SET TAGS ('dbx_subdomain' = 'authorization_management');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request Identifier (PA Request ID)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Identifier (Clinical Criteria ID)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Member Plan Identifier (Plan ID)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Identifier (Network ID)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date (Appeal Deadline)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version Used (Clinical Criteria Version)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code for Estimated Amounts (Currency Code)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `decision_maker_role` SET TAGS ('dbx_business_glossary_term' = 'Role of Decision Maker (Decision Maker Role)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `decision_maker_role` SET TAGS ('dbx_value_regex' = 'physician|nurse|clinical_reviewer|admin');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code (Denial Reason)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Associated Diagnosis Code (ICD Diagnosis Code)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `estimated_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Adjustment Amount (Estimated Adjustment)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `estimated_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Cost (Estimated Gross Amount)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `estimated_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Cost (Estimated Net Amount)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `is_appealable` SET TAGS ('dbx_business_glossary_term' = 'Flag Indicating if Request is Appealable (Appealable Flag)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `is_duplicate_request` SET TAGS ('dbx_business_glossary_term' = 'Flag Indicating Duplicate Prior Authorization Request (Duplicate Flag)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `last_air_due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date of Last Additional Information Request (Last AIR Due Date)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `last_air_received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date of Last Additional Information Request (Last AIR Received Date)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free-text Notes and Comments (Notes)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `pa_request_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request Status (PA Request Status)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `pa_request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|cancelled|in_review|closed');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('dbx_business_glossary_term' = 'Member Age at Request Submission (Member Age)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Member Gender at Request Submission (Member Gender)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `prior_auth_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date for Prior Authorization (Decision Date)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Quantity (Quantity)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request Number (PA Request Number)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request Submission Timestamp (PA Request Timestamp)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Urgency Type of Prior Authorization Request (PA Urgency Type)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Code (CPT/HCPCS/Procedure Code)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Category (Service Type)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'procedure|drug|admission|therapy');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System for Prior Authorization Request (Source System)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'interqual|mcg');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel for Prior Authorization Request (PA Submission Channel)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'portal|fax|phone|edi_278');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time in Days (TAT Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` SET TAGS ('dbx_subdomain' = 'authorization_management');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Decision ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID (MEMBER_ID)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request ID (PA_REQ_ID)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `um_reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Um Reviewer Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator (AMEND_IND)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_value_regex' = 'original|amended|reversal|override');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligibility Flag (APPEAL_ELIG)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `authorization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization End Date (AUTH_END_DT)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `authorization_period_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization Period Type (AUTH_PERIOD_TYPE)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `authorization_period_type` SET TAGS ('dbx_value_regex' = 'fixed|rolling');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `authorization_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Quantity (AUTH_QTY)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `authorization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Start Date (AUTH_START_DT)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `authorization_units` SET TAGS ('dbx_business_glossary_term' = 'Authorization Units (AUTH_UNITS)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `authorization_units` SET TAGS ('dbx_value_regex' = 'days|visits|doses|sessions');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `clinical_criteria_set` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Set (CRIT_SET)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version (CRIT_VER)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale Narrative (CLIN_RAT)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `criteria_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Criteria Effective Date (CRIT_EFF_DT)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `criteria_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Criteria Met Flag (CRIT_MET)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date and Time (DECISION_DT)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `decision_number` SET TAGS ('dbx_business_glossary_term' = 'Decision Number (DECISION_NUM)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Decision Status (DECISION_STATUS)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'active|amended|reversed|overridden');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type (DECISION_TYPE)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_value_regex' = 'approved|denied|partially_approved|pended|withdrawn');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Category (DENIAL_CAT)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_category` SET TAGS ('dbx_value_regex' = 'medical_need|administrative|benefit_exclusion|out_of_network|experimental');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code (DENIAL_CODE)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `denial_regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Denial Regulatory Citation (DENIAL_REG_CIT)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Codes (ICD_CODES)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Flag (TELEHEALTH_FLG)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Urgent Flag (URGENT_FLG)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `prior_auth_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number (PA_NUM)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (REG_COMP_FLG)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` SET TAGS ('dbx_subdomain' = 'authorization_management');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `auth_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Service Line ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `service_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'approved|partially_approved|denied|pending|revoked');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_end_date` SET TAGS ('dbx_business_glossary_term' = 'Authorized Service End Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_price` SET TAGS ('dbx_business_glossary_term' = 'Authorized Price');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Quantity');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_start_date` SET TAGS ('dbx_business_glossary_term' = 'Authorized Service Start Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `cpt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Diagnosis Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{4}$');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Service Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `is_experimental` SET TAGS ('dbx_business_glossary_term' = 'Experimental Service Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `is_partial_approval` SET TAGS ('dbx_business_glossary_term' = 'Partial Approval Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `place_of_service` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `place_of_service` SET TAGS ('dbx_value_regex' = 'office|hospital|clinic|home|telehealth');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|dme|pharmacy|behavioral_health|telehealth');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` SET TAGS ('dbx_subdomain' = 'clinical_review');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_id` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `inpatient_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Admission ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `um_reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Um Reviewer Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `actual_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Discharge Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `approved_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Approved Length of Stay (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `authorized_post_acute_service` SET TAGS ('dbx_business_glossary_term' = 'Authorized Post‑Acute Service');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_value_regex' = 'cms|milliman|plan_actuarial');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source_detail` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source Detail');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_status` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|denied|closed');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `current_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Current Length of Stay (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_barriers` SET TAGS ('dbx_business_glossary_term' = 'Discharge Barriers');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_business_glossary_term' = 'Discharge Destination');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_value_regex' = 'home|snf|ltac|home_health|hospice');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Review Indicator');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Stay Continuation Justification');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_mean` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Benchmark Mean (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_outlier_threshold` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Outlier Threshold (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_target` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Benchmark Target (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `planned_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Discharge Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review End Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'concurrent|retrospective');
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ALTER COLUMN `social_work_involved` SET TAGS ('dbx_business_glossary_term' = 'Social Work Involvement Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` SET TAGS ('dbx_subdomain' = 'clinical_review');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `retrospective_review_id` SET TAGS ('dbx_business_glossary_term' = 'Retrospective Review ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `fwa_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fwa Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `um_reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `um_reviewer_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `um_reviewer_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `compliance_state` SET TAGS ('dbx_business_glossary_term' = 'Compliance State');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `compliance_state` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `documentation_completeness_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Completeness Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `documentation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Documentation Received Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `medical_necessity_outcome` SET TAGS ('dbx_business_glossary_term' = 'Medical Necessity Outcome');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `medical_necessity_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|partial');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `medical_necessity_outcome` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `medical_necessity_outcome` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `retro_review_deadline_flag` SET TAGS ('dbx_business_glossary_term' = 'Retro Review Deadline Compliance Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `review_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Review Initiation Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Retrospective Review Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed|closed');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'retrospective|post_admission');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Service');
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` SET TAGS ('dbx_subdomain' = 'clinical_review');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `um_program_id` SET TAGS ('dbx_business_glossary_term' = 'Um Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `um_reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Um Reviewer Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `appeal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_severity` SET TAGS ('dbx_value_regex' = 'critical|moderate|minor');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_review|denied|approved|pending');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case Type');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|behavioral|dme|pharmacy|other');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_set` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Set');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_set` SET TAGS ('dbx_value_regex' = 'InterQual|MCG');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Case Disposition Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `disposition_description` SET TAGS ('dbx_business_glossary_term' = 'Case Disposition Description');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `length_of_stay_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Length of Stay (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `length_of_stay_target` SET TAGS ('dbx_business_glossary_term' = 'Target Length of Stay (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (ICD)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Description');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `primary_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider NPI');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Decision Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|expired');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Case Turnaround Time (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `um_reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'UM Reviewer ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `compliance_state` SET TAGS ('dbx_business_glossary_term' = 'Compliance State');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `compliance_state` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|under_review');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'RN|MD|PharmD|LCSW|NP|PA');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB) (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `delegation_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Delegation Authority Level');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `delegation_authority_level` SET TAGS ('dbx_value_regex' = 'none|review|approve|escalate|admin');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Professional License Number (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `ncqa_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'NCQA Qualification Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `next_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `reviewer_status` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `reviewer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|pending');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specialty');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `urac_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'URAC Qualification Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code (PII)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_reviewer` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` SET TAGS ('dbx_subdomain' = 'clinical_review');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `inpatient_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Admission ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Admitting Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_los_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Length of Stay (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_number` SET TAGS ('dbx_business_glossary_term' = 'Admission Number (ADM_NUM)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_status` SET TAGS ('dbx_business_glossary_term' = 'Admission Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_status` SET TAGS ('dbx_value_regex' = 'admitted|discharged|cancelled|transferred');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|other');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `authorization_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `authorization_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_value_regex' = 'home|snf|rehab|expired|other');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Related Group (DRG) Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Cost Amount');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_los_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Length of Stay (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `is_critical_care` SET TAGS ('dbx_business_glossary_term' = 'Critical Care Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `is_readmission` SET TAGS ('dbx_business_glossary_term' = 'Readmission Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `los_benchmark_met_flag` SET TAGS ('dbx_business_glossary_term' = 'LOS Benchmark Met Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `los_target_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Target (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `payer_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `payer_authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|pending|denied|not_required');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (ICD)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `readmission_within_30_days` SET TAGS ('dbx_business_glossary_term' = '30‑Day Readmission Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision` SET TAGS ('dbx_business_glossary_term' = 'Review Decision');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|partial|pending');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Review Decision Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|escalated');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `um_program_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Program Identifier (UM Program ID)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `accreditation_category` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Category (UM Accreditation Category)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `accreditation_category` SET TAGS ('dbx_value_regex' = 'tat|criteria|notification|delegation|p2p');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `clinical_criteria_set` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Set (UM Clinical Criteria)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (UM Compliance Notes)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (UM Record Created)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `criteria_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Criteria Effective Date (UM Criteria Effective Date)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Criteria Version (UM Criteria Version)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (UM Effective From)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (UM Effective Until)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `gap_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Analysis Date (UM Gap Analysis Date)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `gap_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Analysis Status (UM Gap Analysis Status)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `gap_analysis_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'individual|group|medicare|medicaid|exchange|self_funded');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date (UM Review Due Date)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `pa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required (PA Required)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes (UM Program Notes)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type (UM Program Type)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|behavioral|pharmacy|specialty');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Program Version (UM Program Version)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (UM Regulatory Reference)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `review_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Review Type Scope (UM Review Scope)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `review_type_scope` SET TAGS ('dbx_value_regex' = 'concurrent|retrospective|both');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `services_covered` SET TAGS ('dbx_business_glossary_term' = 'Services Covered (UM Services Covered)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `um_program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description (UM Program Description)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `um_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status (UM Program Status)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `um_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UM Record Updated)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` SET TAGS ('dbx_subdomain' = 'authorization_management');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `pa_required_service_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Service ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `service_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `um_program_id` SET TAGS ('dbx_business_glossary_term' = 'Um Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `clinical_criteria_set` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Set');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'Exemption Type');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `exemption_type` SET TAGS ('dbx_value_regex' = 'state_mandate|cms_requirement|gold_card|plan_policy|none');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_approval_rate_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Gold Card Approval Rate Met Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_approval_rate_threshold` SET TAGS ('dbx_business_glossary_term' = 'Gold Card Approval Rate Threshold (%)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Gold Card Effective Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Gold Card Expiration Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_flag` SET TAGS ('dbx_business_glossary_term' = 'Gold Card Override Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Gold Card Provider NPI');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Gold Card Revocation Reason');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|medicare_advantage|medicaid|group|individual');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `pa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `pa_required_service_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `pa_required_service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `pa_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Type');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `pa_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|concurrent|none');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `provider_specialty_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Exemption Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) or Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description (Full Name)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `applicable_cpt_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable CPT Codes');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `applicable_hcpcs_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable HCPCS Codes');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `clinical_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Category');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non‑compliant|pending|exempt');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Units');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_units` SET TAGS ('dbx_value_regex' = 'visits|days|doses|sessions|procedures');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `is_emergency_covered` SET TAGS ('dbx_business_glossary_term' = 'Emergency Service Coverage Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Exemption Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `is_experimental_covered` SET TAGS ('dbx_business_glossary_term' = 'Experimental Service Coverage Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `is_prior_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `is_telehealth_covered` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Coverage Flag');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By User ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Status');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|draft|terminated');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Name');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Type');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'medical|surgical|behavioral|pharmacy|diagnostic');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `prior_auth_approval_timeframe_days` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Approval Timeframe (Days)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `version_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiration Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `health_insurance_ecm`.`utilization`.`clinical_criteria` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`clinical_criteria` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `health_insurance_ecm`.`utilization`.`clinical_criteria` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Identifier');
ALTER TABLE `health_insurance_ecm`.`utilization`.`clinical_criteria` ALTER COLUMN `parent_clinical_criteria_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `health_insurance_ecm`.`utilization`.`clinical_criteria` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` SET TAGS ('dbx_association_edges' = 'utilization.um_reviewer,utilization.um_program');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ALTER COLUMN `reviewer_program_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Program Assignment - Reviewer Program Assignment Id');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ALTER COLUMN `um_program_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Program Assignment - Um Program Id');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ALTER COLUMN `um_reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Program Assignment - Um Reviewer Id');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ALTER COLUMN `assigned_review_queue` SET TAGS ('dbx_business_glossary_term' = 'Assigned Review Queue');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `health_insurance_ecm`.`utilization`.`reviewer_program_assignment` ALTER COLUMN `reviewer_role_in_program` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role in Program');
