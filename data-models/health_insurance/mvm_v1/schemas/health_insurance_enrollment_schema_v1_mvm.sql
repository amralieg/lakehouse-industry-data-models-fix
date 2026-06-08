-- Schema for Domain: enrollment | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`enrollment` COMMENT 'Manages the end-to-end enrollment and eligibility lifecycle — open enrollment, special enrollment periods, qualifying life events, 834 EDI transactions, effective dates, terminations, reinstatements, and retroactive adjustments. Owns eligibility spans, coverage periods, and enrollment event history. Interfaces with CMS EDPS/RAPS for government program enrollment and supports 270/271 real-time eligibility verification.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` (
    `enrollment_eligibility_span_id` BIGINT COMMENT 'System-generated unique identifier for the enrollment eligibility span record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Needed for eligibility reporting to show which benefit package a members coverage span belongs to, essential for benefit design analysis.',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: In capitation-based plans, each member eligibility span is attributed to a capitation arrangement driving PMPM payments. Capitation payment processing requires this link to calculate attributed_member',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: Delegation agreements govern which entity performs UM, credentialing, or claims functions for enrolled members. An eligibility span subject to a delegated IPA or medical group requires this link for N',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: Claims adjudication for an enrolled member requires knowing which fee schedule governs allowed amounts for their eligibility span. Health plan operations teams and actuaries use this link to determine',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Large employers apply division‑specific eligibility rules; linking enables division‑level eligibility analytics.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group for group enrollments.',
    `group_location_id` BIGINT COMMENT 'Foreign key linking to employer.group_location. Business justification: Eligibility calculations depend on employers primary location to apply network rules and state‑specific regulations.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health plan associated with this eligibility span.',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Eligibility reconciliation report requires linking each enrollment eligibility span to the members eligibility span to compare periods and resolve discrepancies.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom this eligibility span applies.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Needed to assign a primary care provider to each member’s coverage span for network compliance and care coordination reports.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network associated with the plan.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: A members eligibility span is bound to a specific network tier (e.g., Tier 1 preferred, Tier 2 standard) that governs cost-sharing differentials (copay, coinsurance) applied during claims adjudicatio',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: benefit_year on enrollment_eligibility_span is a denormalized plan.year reference. The year_id FK enables accumulator reset scheduling (deductible_reset_date, moop_reset_date, oop_reset_date), MLR rep',
    `benefit_designation` STRING COMMENT 'Design of the benefit plan (e.g., HMO, PPO).. Valid values are `HMO|PPO|EPO|POS|HDHP`',
    `benefit_period_end` DATE COMMENT 'End date of the benefit period (often same as termination_date).',
    `benefit_period_start` DATE COMMENT 'Start date of the benefit period (often same as effective_date).',
    `coverage_category` STRING COMMENT 'Classification of the covered individual (e.g., employee, spouse).. Valid values are `Employee|Spouse|Dependent|Retiree|Other`',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum allowable amount for a specific benefit within the span.',
    `coverage_limit_units` STRING COMMENT 'Unit of measure for the coverage limit (e.g., visits, days).. Valid values are `visits|days|sessions|units|claims`',
    `coverage_type` STRING COMMENT 'Type of coverage provided in this span (e.g., medical, dental).. Valid values are `Medical|Dental|Vision|Pharmacy|Wellness`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility span record was first created.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount applicable for this span.',
    `deductible_reset_date` DATE COMMENT 'Date when the deductible accumulator resets (usually start of benefit year).',
    `effective_date` DATE COMMENT 'Date when the eligibility span becomes active.',
    `eligibility_status` STRING COMMENT 'Eligibility determination for the member during this span.. Valid values are `eligible|ineligible|pending`',
    `enrollment_eligibility_span_status` STRING COMMENT 'Current lifecycle status of the eligibility span.. Valid values are `active|inactive|terminated|pending`',
    `enrollment_event_type` STRING COMMENT 'Category of enrollment event that created or modified this span.. Valid values are `OpenEnrollment|SpecialEnrollment|QualifyingLifeEvent|Retroactive|ManualAdjustment`',
    `enrollment_source` STRING COMMENT 'System or channel through which the enrollment was received.. Valid values are `EDI_834|WebPortal|CallCenter|BatchUpload`',
    `is_primary_coverage` BOOLEAN COMMENT 'True if this span represents the members primary coverage.',
    `is_waiver_applied` BOOLEAN COMMENT 'Indicates if a cost‑sharing waiver (e.g., HSA) is applied to this span.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the status field last changed.',
    `line_of_business` STRING COMMENT 'Business line under which the enrollment is processed.. Valid values are `Commercial|Medicare|Medicaid|Exchange|Group`',
    `moop_reset_date` DATE COMMENT 'Date when the MOOP threshold resets.',
    `moop_threshold` DECIMAL(18,2) COMMENT 'Combined deductible and OOP limit for this span.',
    `oop_maximum` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense the member can incur.',
    `oop_reset_date` DATE COMMENT 'Date when the OOP accumulator resets.',
    `plan_code` STRING COMMENT 'External plan identifier used in contracts and communications.',
    `prior_coverage_end_date` DATE COMMENT 'Termination date of the preceding coverage period, if any.',
    `prior_coverage_indicator` BOOLEAN COMMENT 'True if the member had coverage immediately before this span.',
    `qualifying_life_event_code` STRING COMMENT 'Code representing the life event that triggered a special enrollment.. Valid values are `MARRIAGE|DIVORCE|BIRTH|ADOPTION|DEATH|EMPLOYER_CHANGE`',
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Indicates whether the span was created or modified retroactively.',
    `retroactive_adjustment_reason` STRING COMMENT 'Explanation for a retroactive change to the eligibility span.',
    `subscriber_relationship` STRING COMMENT 'Relationship of the covered individual to the subscriber.. Valid values are `Self|Spouse|Child|OtherDependent`',
    `termination_date` DATE COMMENT 'Date when the eligibility span ends; null if still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `utilization_reset_date` DATE COMMENT 'Date when utilization counters (e.g., visit counts) reset.',
    `waiver_type` STRING COMMENT 'Type of waiver applied, if any.. Valid values are `HSA|FSA|HRA|None`',
    CONSTRAINT pk_enrollment_eligibility_span PRIMARY KEY(`enrollment_eligibility_span_id`)
) COMMENT 'Core master record representing a members continuous coverage period under a specific health plan, including benefit year boundaries, deductible/OOP accumulator reset dates, and MOOP thresholds. Captures effective date, termination date, coverage type, line of business (commercial, Medicare, Medicaid), plan code, subscriber relationship, eligibility status, and benefit period attributes. This is the authoritative SSOT for is this member covered? and what benefit period applies? at any point in time. One enrollment_transaction may produce one or more eligibility_spans. Sourced from Facets/QNXT enrollment module and CMS EDPS for government programs.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Primary key for transaction',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Enrollment transactions (new enrollment, termination, plan change) trigger capitation payment adjustments. The capitation payment run must reference the enrollment transaction that caused the member c',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Identifier of the eligibility span generated from this transaction.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Each enrollment transaction occurs within a defined open enrollment period; linking transaction to period enables period‑based reporting and ensures the period is not a silo.',
    `group_contact_id` BIGINT COMMENT 'Foreign key linking to employer.group_contact. Business justification: Required for audit of enrollment approvals: employers designated contact must be recorded per ACA compliance reporting.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Financial reconciliation requires associating each enrollment transaction with the employers renewal cycle.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group or line of business to which the member belongs.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with this enrollment transaction.',
    `open_enrollment_window_id` BIGINT COMMENT 'Foreign key linking to employer.open_enrollment_window. Business justification: Group market enrollment transactions processed during an employer OE window must reference that window for participation threshold monitoring, submission deadline compliance, and group enrollment audi',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network enrollment reporting for quarterly compliance requires linking each transaction to the provider network.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: An enrollment transaction triggered by a Special Enrollment Period must reference the qualifying life event (QLE) that opened that SEP window. This links the transactional action back to its triggerin',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.plan_rate. Business justification: Required for premium audit reports that must trace each enrollment transaction to the exact rate applied for regulatory compliance.',
    `risk_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_underwriting_case. Business justification: Group enrollment transactions directly implement underwriting case decisions on rates and coverage terms. Operations and compliance teams require this link to reconcile enrollment transactions against',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment (e.g., discount, surcharge) applied to the gross premium.',
    `adjustment_reason_code` STRING COMMENT 'Standard code describing why a financial or coverage adjustment was made.. Valid values are `premium_change|plan_change|error_correction|regulatory|other`',
    `approving_authority` STRING COMMENT 'Name or role of the individual or system that approved the enrollment change.',
    `audit_user_role` STRING COMMENT 'Role of the audit user (e.g., admin, operator, system).. Valid values are `admin|operator|system`',
    `claims_reprocess_flag` BOOLEAN COMMENT 'True if the enrollment change requires downstream claims to be re‑processed.',
    `compliance_status` STRING COMMENT 'Current compliance status of the transaction with applicable regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `coverage_period_type` STRING COMMENT 'Indicates whether the coverage is continuous, intermittent, or contains a gap.. Valid values are `continuous|intermittent|gap`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment transaction record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values in this transaction.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `effective_date` DATE COMMENT 'Date on which the members coverage under the new enrollment becomes effective.',
    `effective_end_date` DATE COMMENT 'Scheduled end date of the coverage period associated with this enrollment (may differ from termination_date).',
    `enrollment_comment` STRING COMMENT 'Free‑form text field for notes or comments entered by the processor.',
    `enrollment_origin` STRING COMMENT 'Channel through which the enrollment was initiated.. Valid values are `online|call_center|mail|agent|broker`',
    `enrollment_transaction_number` STRING COMMENT 'External business identifier assigned to the enrollment transaction, used for tracking and reference.',
    `enrollment_type` STRING COMMENT 'Category of enrollment event: open enrollment, special enrollment period, automatic enrollment, special manual enrollment, or other.. Valid values are `open|sep|auto|special|manual`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the enrollment event occurred in the source system.',
    `financial_impact_flag` BOOLEAN COMMENT 'True when the enrollment change has a direct impact on premium billing or financial reporting.',
    `grace_period_end_date` DATE COMMENT 'Date when the applicable grace period expires.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total premium amount before any adjustments for the enrollment period.',
    `health_plan_type` STRING COMMENT 'Classification of the health plan (e.g., HMO, PPO, EPO, POS, HDHP).. Valid values are `hmo|ppo|epo|pos|hdhp`',
    `is_grace_period` BOOLEAN COMMENT 'True if the enrollment is being processed within a grace period after termination.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final premium amount after adjustments, representing the amount to be billed.',
    `original_termination_reference` BIGINT COMMENT 'Reference to the prior termination transaction that is being reinstated.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether the enrollment change triggers a prior authorization requirement.',
    `processing_status` STRING COMMENT 'Current processing stage of the transaction within the enrollment workflow.. Valid values are `draft|submitted|under_review|approved|rejected`',
    `reactivation_date` DATE COMMENT 'Effective date of coverage reactivation for reinstatement events.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this transaction must be reported to a regulatory body (e.g., CMS, NAIC).',
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Flag indicating whether the transaction represents a retroactive adjustment to prior coverage dates.',
    `source_system` STRING COMMENT 'Originating system that generated the enrollment transaction record.. Valid values are `facets|qnxt|edi|custom`',
    `termination_date` DATE COMMENT 'Date on which coverage ends for a disenrollment or termination event (nullable if not applicable).',
    `termination_reason` STRING COMMENT 'Standardized reason why the enrollment was terminated.. Valid values are `voluntary|involuntary|nonpayment|eligibility|other`',
    `transaction_source` STRING COMMENT 'Source of the enrollment transaction record, e.g., EDI 834 feed, web portal, batch load, or API.. Valid values are `edi_834|web_portal|batch|api`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the enrollment transaction.. Valid values are `pending|processed|failed|cancelled|completed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment transaction record.',
    CONSTRAINT pk_transaction PRIMARY KEY(`transaction_id`)
) COMMENT 'Transactional record capturing every enrollment action for a member — initial enrollment, re-enrollment, plan change, disenrollment (voluntary/involuntary termination), reinstatement, and retroactive adjustment. Tracks enrollment source, enrollment period type (open enrollment, SEP, auto-enrollment), effective date, submitted date, processing status, and transaction-type-specific attributes: termination reason/last day of coverage/grace period status for disenrollments; original termination reference/reinstatement effective date/approving authority for reinstatements; adjusted dates/financial impact flag/claims reprocessing trigger for retro adjustments. One enrollment_transaction may produce one or more eligibility_spans. Sourced from Facets/QNXT and 834 EDI transactions via Availity/Change Healthcare.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`event` (
    `event_id` BIGINT COMMENT 'System-generated unique identifier for each enrollment event record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group linked to the enrollment, if applicable.',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: Event tracking reports must reference the exact plan offering the change relates to for employer‑level reporting.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with the enrollment event.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network change audit log records which network triggered an enrollment event for regulatory audit.',
    `risk_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_underwriting_case. Business justification: Event‑driven underwriting decisions are recorded; linking supports the Underwriting Decision Audit report.',
    `transaction_id` BIGINT COMMENT 'Identifier of the enrollment to which this event belongs.',
    `actor_type` STRING COMMENT 'Classifies the party that triggered the event.. Valid values are `member|employer|system|cms|provider`',
    `effective_date` DATE COMMENT 'Date on which the new enrollment status becomes effective.',
    `event_description` STRING COMMENT 'Free‑text narrative providing additional context for the event.',
    `event_source` STRING COMMENT 'System or interface that generated the event record.. Valid values are `core_admin|provider_system|member_portal|edi_gateway|batch_process`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the enrollment event occurred in the source system.',
    `event_type` STRING COMMENT 'Categorizes the nature of the state transition (e.g., submitted, approved).. Valid values are `submitted|approved|rejected|terminated|reinstated|adjusted`',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the event was entered manually (True) or generated automatically (False).',
    `new_status` STRING COMMENT 'Enrollment status after the event was applied.. Valid values are `pending|active|terminated|reinstated|cancelled`',
    `previous_status` STRING COMMENT 'Enrollment status before the event was applied.. Valid values are `pending|active|terminated|reinstated|cancelled`',
    `reason_code` STRING COMMENT 'Standardized code explaining why the event was generated (e.g., QLE‑DIVORCE, SYSTEM‑ERROR).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first persisted in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the event record.',
    `termination_date` DATE COMMENT 'Date the enrollment was terminated, if applicable.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Granular audit log of every state transition in the enrollment lifecycle — submitted, pended, approved, rejected, effectuated, terminated, reinstated, retroactively adjusted. Each event captures the triggering action, actor (member, employer, CMS, system), timestamp, reason code, and before/after state. Supports regulatory audit trails required by CMS, state DOI, and HIPAA administrative simplification. Distinct from enrollment_transaction (which is the business action) — this is the immutable event history of that actions processing lifecycle.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` (
    `qualifying_life_event_id` BIGINT COMMENT 'System-generated unique identifier for the qualifying life event record.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who reported the qualifying life event.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: SEP processing is directly governed by ACA/CMS regulatory obligations defining valid SEP categories, 60-day election windows, and documentation requirements. Compliance teams audit QLE processing agai',
    `appeal_reference` STRING COMMENT 'Reference number of any appeal filed against a denial.',
    `cms_sep_outcome` STRING COMMENT 'Result of the CMS SEP eligibility determination.. Valid values are `eligible|ineligible|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualifying life event record was first created in the system.',
    `denial_reason` STRING COMMENT 'Explanation why the SEP request was denied, if applicable.',
    `documentation_type` STRING COMMENT 'Type of supporting document submitted for the event.. Valid values are `birth_certificate|marriage_license|loss_of_coverage_letter|relocation_proof|divorce_decree|adoption_order`',
    `event_date` DATE COMMENT 'Calendar date on which the qualifying life event occurred.',
    `event_type` STRING COMMENT 'Category of the life event that triggers a special enrollment period.. Valid values are `marriage|birth|loss_of_coverage|relocation|divorce|adoption`',
    `qualifying_life_event_status` STRING COMMENT 'Overall lifecycle status of the qualifying life event record.. Valid values are `active|inactive|archived`',
    `sep_category_code` STRING COMMENT 'CMS‑defined code that classifies the SEP category for the qualifying life event.',
    `sep_window_end` DATE COMMENT 'Last date the special enrollment period (SEP) is open for this event.',
    `sep_window_start` DATE COMMENT 'First date the special enrollment period (SEP) is open for this event.',
    `sep_window_status` STRING COMMENT 'Current state of the SEP window based on dates and actions.. Valid values are `open|closed|expired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualifying life event record.',
    `verification_date` DATE COMMENT 'Date the verification decision was recorded.',
    `verification_status` STRING COMMENT 'Current status of the CMS SEP verification process.. Valid values are `pending|verified|denied|appealed`',
    CONSTRAINT pk_qualifying_life_event PRIMARY KEY(`qualifying_life_event_id`)
) COMMENT 'Master record of a qualifying life event (QLE) that triggers a special enrollment period (SEP), including the full SEP verification lifecycle. Captures event type (marriage, birth, loss of coverage, relocation, divorce, adoption), event date, SEP window open/close dates, CMS SEP category codes, submitted documentation type and artifacts (birth certificate, marriage license, loss of coverage letter), verification status, verifier ID, verification date, CMS SEP verification outcome, pend/denial reason, and appeal reference. This is the authoritative SSOT for both QLE registration and SEP verification — no separate verification record exists. Required for ACA compliance, CMS SEP eligibility determinations, and SEP integrity program compliance. Sourced from Facets/QNXT pend workflow and member portal document uploads.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` (
    `open_enrollment_period_id` BIGINT COMMENT 'Primary key for open_enrollment_period',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Each OEP is governed by a specific policy document defining enrollment rules, eligibility criteria, and procedures (especially for state-specific exchanges). Compliance teams must link OEPs to their g',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Open enrollment periods are directly mandated by ACA/CMS regulatory obligations specifying OEP dates, exchange filing deadlines, and reporting requirements. Compliance teams track which regulatory obl',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Every open enrollment period is governed by a specific plan year (ACA annual OEP, Medicare AEP). Enrollment operations teams and regulators track OEP windows by plan year for compliance reporting and ',
    `compliance_status` STRING COMMENT 'Current compliance verification outcome for the enrollment period.. Valid values are `compliant|non-compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the enrollment period record was first created in the system.',
    `eligibility_segment` STRING COMMENT 'Population segment eligible for this enrollment period (e.g., group, individual, Medicare).. Valid values are `Group|Individual|Medicare|Medicaid|Marketplace`',
    `end_date` DATE COMMENT 'Last calendar day for submitting enrollment applications; after this date the window closes.',
    `enrollment_cutoff_time` TIMESTAMP COMMENT 'Daily cut‑off time (in local time) after which submissions on the deadline date are rejected.',
    `enrollment_deadline_date` DATE COMMENT 'Final calendar date by which all enrollment submissions must be received.',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment window based on its recurrence and purpose.. Valid values are `Annual|Special|Continuous`',
    `exchange_type` STRING COMMENT 'Marketplace or exchange through which the enrollment is offered.. Valid values are `SHOP|Individual|Off-Exchange|Medicare|Medicaid`',
    `is_annual` BOOLEAN COMMENT 'True if the enrollment period recurs each year on the same schedule.',
    `is_retrospective_allowed` BOOLEAN COMMENT 'True if members may submit enrollment changes that become effective prior to the submission date.',
    `lob` STRING COMMENT 'Business line to which the enrollment period applies.. Valid values are `Medical|Dental|Vision|Pharmacy|Wellness`',
    `notes` STRING COMMENT 'Free‑form text for additional remarks, exceptions, or operational comments.',
    `open_enrollment_period_status` STRING COMMENT 'Current lifecycle status of the enrollment window.. Valid values are `upcoming|open|closed|cancelled|postponed`',
    `period_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the enrollment window across systems.',
    `period_name` STRING COMMENT 'Descriptive name of the enrollment window, e.g., "2025 Individual Marketplace OE".',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this enrollment period triggers mandatory regulatory reporting (e.g., CMS filings).',
    `start_date` DATE COMMENT 'First calendar day on which members may submit enrollment applications.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the enrollment period record.',
    `volume_actual` STRING COMMENT 'Actual count of enrollments captured within the window.',
    `volume_target` STRING COMMENT 'Planned number of enrollments the organization aims to achieve during the window.',
    `volume_target_met` BOOLEAN COMMENT 'Indicates whether the actual enrollment volume met or exceeded the target.',
    CONSTRAINT pk_open_enrollment_period PRIMARY KEY(`open_enrollment_period_id`)
) COMMENT 'Master record defining each open enrollment window — annual employer group OE, ACA marketplace OE, Medicare Annual Enrollment Period (AEP), and Medicaid continuous enrollment periods. Captures period start/end dates, eligible population segment, LOB, exchange type (SHOP, individual marketplace, off-exchange), and enrollment volume targets. Used to govern when enrollment_records are accepted without a QLE. Sourced from CMS plan year calendars and employer group contracts.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` (
    `eligibility_verification_id` BIGINT COMMENT 'Primary key for eligibility_verification',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Real-time eligibility verification (HIPAA 270/271 transactions) must return accurate benefit limits, cost-share, and coverage details from the specific benefit_package. benefit_category, benefit_limit',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: A 270/271 real-time eligibility verification resolves against a specific enrollment eligibility span — the span is the authoritative source of coverage data that the verification response is based on.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled.',
    `identity_id` BIGINT COMMENT 'Unique member identifier used in the eligibility request (e.g., member number, SSN, MRN).',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: Real-time eligibility verification (HIPAA 270/271) validates whether the members service location falls within an approved network service area. This link supports point-of-care eligibility checks an',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for automated provider credential checks during eligibility verification; the process matches providers to member eligibility inquiries.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: HIPAA 270/271 eligibility responses return the members active network tier so providers know which cost-sharing schedule applies at point of care. This link is essential for real-time benefit verific',
    `transaction_id` BIGINT COMMENT 'Identifier assigned by the source system for the eligibility transaction.',
    `authorization_number` STRING COMMENT 'Authorization number returned when prior authorization is required.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required for the service.',
    `benefit_category` STRING COMMENT 'High‑level category of benefits being queried (e.g., medical, dental).. Valid values are `medical|dental|vision|rx|wellness`',
    `benefit_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount allowed for the queried benefit.',
    `benefit_remaining` DECIMAL(18,2) COMMENT 'Remaining dollar amount of the benefit available.',
    `benefit_used` DECIMAL(18,2) COMMENT 'Dollar amount of the benefit already utilized in the current period.',
    `coverage_type` STRING COMMENT 'Level of coverage returned (full, partial, or none).. Valid values are `full|partial|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility record was first persisted in the data lake.',
    `deductible_remaining` DECIMAL(18,2) COMMENT 'Members remaining deductible balance for the benefit period.',
    `diagnosis_code` STRING COMMENT 'ICD diagnosis code associated with the request, if applicable.',
    `eligibility_status` STRING COMMENT 'Overall result of the eligibility check (eligible, ineligible, error, or pending).. Valid values are `eligible|ineligible|error|pending`',
    `error_code` STRING COMMENT 'Technical or business error code returned in a failed eligibility response.',
    `error_description` STRING COMMENT 'Human‑readable description of the error condition.',
    `inquiry_reference_number` STRING COMMENT 'External reference number assigned by the source system (e.g., Availity) for the eligibility request.',
    `inquiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the eligibility request was sent to the payer.',
    `member_identifier_type` STRING COMMENT 'Type of identifier supplied for the member (SSN, MRN, or internal member ID).. Valid values are `ssn|mrn|member_id`',
    `oop_remaining` DECIMAL(18,2) COMMENT 'Remaining out‑of‑pocket amount before maximum OOP is reached.',
    `response_message` STRING COMMENT 'Free‑form message returned by the payer providing additional context.',
    `response_time_seconds` DECIMAL(18,2) COMMENT 'Elapsed time between request and response, measured in seconds.',
    `response_timestamp` TIMESTAMP COMMENT 'Date‑time when the eligibility response was received.',
    `service_code` STRING COMMENT 'CPT code of the service/procedure for which eligibility is being checked.',
    `source_system` STRING COMMENT 'EDI gateway or clearinghouse that supplied the eligibility response.. Valid values are `availity|change_healthcare`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the eligibility record.',
    CONSTRAINT pk_eligibility_verification PRIMARY KEY(`eligibility_verification_id`)
) COMMENT 'Transactional record of real-time 270/271 eligibility verification requests and responses. Captures requesting provider NPI, member identifier used, inquiry date/time, response status, coverage details returned, deductible/OOP balances returned, and response time SLA. Supports provider-facing eligibility verification at point of care. Sourced from Availity/Change Healthcare 270/271 gateway and Facets real-time eligibility API.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` (
    `cobra_election_id` BIGINT COMMENT 'System-generated unique identifier for the COBRA election record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: COBRA continuation requires the exact benefit package from active coverage to calculate the 102% premium and confirm coverage design. COBRA administrators must reference the specific benefit_package f',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: A COBRA election produces a continuous coverage period tracked as an enrollment eligibility span. Linking cobra_election to enrollment_eligibility_span connects the COBRA administrative record to the ',
    `group_id` BIGINT COMMENT 'Identifier of the employer group from which the member lost group coverage.',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: COBRA elections continue a specific group plan offering at 102% of the group premium rate. The group_plan_offering determines COBRA premium calculation, coverage terms, and continuation eligibility. C',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health benefit plan associated with the COBRA election.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is electing COBRA continuation coverage.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: A COBRA election results in a specific plan election — the member selects a plan to continue under COBRA continuation coverage. Linking cobra_election to plan_election connects the COBRA administrativ',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: A COBRA election is triggered by a qualifying event (termination of employment, reduction in hours, divorce, etc.). Linking cobra_election to the qualifying_life_event master record provides the forma',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: COBRA elections are governed by specific ERISA/DOL regulatory obligations covering notice timelines, election windows, and premium rules. Compliance teams audit COBRA administration against these obli',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: COBRA elections generate enrollment transactions (initial election, premium payment status changes, early termination). Linking cobra_election to the enrollment transaction provides the operational au',
    `business_identifier` STRING COMMENT 'External reference number or code used by the business to identify the election.',
    `classification_or_type` STRING COMMENT 'Category of the agreement; identifies it as a COBRA continuation election.. Valid values are `cobra_election|cobra_continuation`',
    `cobra_premium_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount for COBRA coverage (typically 102% of the full premium).',
    `coverage_end_date` DATE COMMENT 'Date when COBRA coverage terminates.',
    `coverage_start_date` DATE COMMENT 'Effective date when COBRA coverage begins.',
    `coverage_type` STRING COMMENT 'Classification of COBRA coverage (individual, family, or dependent only).. Valid values are `individual|family|dependent`',
    `dependent_count` STRING COMMENT 'Count of dependents included in the COBRA election.',
    `early_termination_flag` BOOLEAN COMMENT 'Indicates if the COBRA coverage was terminated before the scheduled end date.',
    `early_termination_notice_sent_flag` BOOLEAN COMMENT 'True when an early termination notice has been sent to the member.',
    `election_decision` STRING COMMENT 'Members decision regarding COBRA continuation coverage.. Valid values are `elected|declined|pending`',
    `election_notice_sent_flag` BOOLEAN COMMENT 'True when the election notice has been dispatched to the member.',
    `election_status` STRING COMMENT 'Current status of the COBRA election process.. Valid values are `pending|elected|declined|terminated|expired`',
    `last_payment_date` DATE COMMENT 'Date of the most recent premium payment received for the COBRA coverage.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the COBRA election record.. Valid values are `active|inactive|terminated|cancelled|pending`',
    `notes` STRING COMMENT 'Free‑form text for any additional comments or special instructions.',
    `notice_date_election` DATE COMMENT 'Date the election-specific notice (reminder) was sent to the member.',
    `notice_date_initial` DATE COMMENT 'Date the initial COBRA continuation coverage notice was sent to the member.',
    `notice_deadline` DATE COMMENT 'Last date by which the member must elect COBRA coverage.',
    `payment_method` STRING COMMENT 'Method used by the member to pay the COBRA premium.. Valid values are `payroll|credit_card|bank_transfer|check`',
    `payment_status` STRING COMMENT 'Current status of premium payment for the COBRA election.. Valid values are `paid|unpaid|partial|failed`',
    `premium_currency` STRING COMMENT 'Three‑letter ISO currency code for the COBRA premium.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `premium_frequency` STRING COMMENT 'Frequency at which the COBRA premium is billed.. Valid values are `monthly|quarterly|annual`',
    `qualifying_event_date` DATE COMMENT 'Date on which the qualifying event occurred.',
    `qualifying_event_type` STRING COMMENT 'Type of qualifying event that triggered COBRA eligibility.. Valid values are `termination|reduction_of_hours|divorce|death|aging_off`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the COBRA election record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COBRA election record.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the COBRA election data.. Valid values are `Facets|QNXT`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the subsidy applied to the premium.',
    `subsidy_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the member qualifies for an ARP COBRA subsidy.',
    `subsidy_type` STRING COMMENT 'Type of subsidy applied to the COBRA premium.. Valid values are `arp|none`',
    CONSTRAINT pk_cobra_election PRIMARY KEY(`cobra_election_id`)
) COMMENT 'Master record tracking COBRA continuation coverage elections for members who have lost group health coverage due to a qualifying event (termination, reduction in hours, divorce, death, aging off dependent). Captures qualifying event type, election notice date, election deadline, election status, COBRA premium amount (102% of full premium), coverage start/end dates, subsidy eligibility (ARP COBRA subsidy), and COBRA-specific notice tracking (initial notice, election notice, early termination notice). Governed by ERISA Section 601-608 and DOL COBRA regulations. Sourced from Facets/QNXT COBRA module.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`plan_election` (
    `plan_election_id` BIGINT COMMENT 'Unique surrogate identifier for the plan election record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Plan election captures the members specific benefit package selection during open enrollment or QLE. Enrollment systems need benefit_package_id to configure the eligibility span correctly, enforce co',
    `contribution_strategy_id` BIGINT COMMENT 'Foreign key linking to employer.contribution_strategy. Business justification: The contribution strategy governs employee/employer premium split for each plan election, directly driving payroll deduction setup and ACA affordability testing. A health insurance domain expert expec',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: A plan election is the precursor to an enrollment eligibility span — the election decision drives the creation of the coverage period. Linking plan_election to enrollment_eligibility_span enables trac',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Plan elections are made within a specific employer group context. Group determines available plans, eligibility rules, and ACA employer mandate compliance. Group enrollment reporting and premium billi',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: A plan election is fundamentally a members selection of a specific employer group plan offering. Group_plan_offering defines available plans, contribution tiers, and ACA affordability criteria. Essen',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Plan elections made during a renewal cycle must reference the group renewal for renewal participation reporting, rate change impact analysis, and retention tracking. Group renewals drive the annual pl',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan that was elected.',
    `hsa_hra_config_id` BIGINT COMMENT 'Foreign key linking to plan.hsa_hra_config. Business justification: plan_election has fsa_election_flag, hra_election_flag, hsa_election_flag but no FK to hsa_hra_config. IRS contribution limit enforcement, employer HSA/HRA funding setup, and ACA HDHP compliance requi',
    `subscriber_id` BIGINT COMMENT 'Identifier of the subscriber who made the election.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: A plan election is made within the context of an open enrollment period (annual employer OE, ACA marketplace OE, Medicare AEP). Linking plan_election to open_enrollment_period establishes the enrollme',
    `open_enrollment_window_id` BIGINT COMMENT 'Foreign key linking to employer.open_enrollment_window. Business justification: Employer open enrollment windows govern when group members may make plan elections. Linking plan elections to the employer OE window enables participation rate tracking, submission deadline compliance',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: PCP selection is a core business process at plan election time for HMO/PCP-required plans. Members designate their Primary Care Provider when electing coverage. This drives care coordination, network ',
    `prior_plan_election_id` BIGINT COMMENT 'Reference to the previous election record when this election is a change or reinstatement.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: When a plan election is made during a Special Enrollment Period, it is triggered by a qualifying life event. Linking plan_election to qualifying_life_event captures the SEP trigger for the election, e',
    `risk_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_underwriting_case. Business justification: Group plan elections are executed based on underwriting case decisions that set rates and risk classification. Underwriters and actuaries must trace which underwriting case authorized a plan election',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: During open enrollment or SEP, members elect a plan at a specific network tier (tiered HMO/PPO). The plan election must reference the tier to calculate premium contributions, cost-sharing obligations,',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: A plan election generates an enrollment transaction that processes the election through the enrollment lifecycle. Linking plan_election to transaction connects the plan selection record to its process',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: In ACO and VBC programs, member attribution flows from plan election to a VBC contract for performance period measurement. Health plans use this link to attribute members to VBC arrangements and calcu',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Plan elections are scoped to a plan year for ACA annual reporting, employer W-2 reporting, and premium reconciliation. Enrollment reporting systems require a direct plan year reference on elections to',
    `cobra_eligibility_end_date` DATE COMMENT 'Date when COBRA eligibility expires.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected (e.g., employee only, employee + spouse, employee + children, family).. Valid values are `employee_only|employee_spouse|employee_children|family`',
    `dental_rider_flag` BOOLEAN COMMENT 'Indicates if a dental coverage rider was elected.',
    `effective_date` DATE COMMENT 'Date the elected coverage becomes effective.',
    `election_number` STRING COMMENT 'External reference number assigned to the election by the enrollment system.',
    `election_type` STRING COMMENT 'Nature of the election event (new enrollment, change, termination, reinstatement).. Valid values are `new|change|termination|reinstatement`',
    `enrollment_event_type` STRING COMMENT 'Type of enrollment event that triggered the election.. Valid values are `open_enrollment|special_enrollment|qualifying_life_event`',
    `enrollment_source` STRING COMMENT 'Channel through which the election was submitted.. Valid values are `online|call_center|broker|mail`',
    `fsa_election_flag` BOOLEAN COMMENT 'Indicates if a Flexible Spending Account was elected.',
    `hra_election_flag` BOOLEAN COMMENT 'Indicates if a Health Reimbursement Arrangement was elected.',
    `hsa_election_flag` BOOLEAN COMMENT 'Indicates if a Health Savings Account was elected.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Indicates if the election is eligible for COBRA continuation coverage.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions related to the election.',
    `plan_election_status` STRING COMMENT 'Current processing status of the election record.. Valid values are `active|pending|terminated|cancelled`',
    `premium_contribution_employee` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employee.',
    `premium_contribution_employer` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employer.',
    `premium_frequency` STRING COMMENT 'Billing frequency for the premium (e.g., monthly).. Valid values are `monthly|quarterly|annually`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the election record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the election record.',
    `termination_date` DATE COMMENT 'Date the elected coverage ends, if applicable.',
    `total_premium` DECIMAL(18,2) COMMENT 'Total premium amount for the elected coverage (employer + employee).',
    `vision_rider_flag` BOOLEAN COMMENT 'Indicates if a vision coverage rider was elected.',
    CONSTRAINT pk_plan_election PRIMARY KEY(`plan_election_id`)
) COMMENT 'Master record of a subscribers specific plan selection, coverage tier, and covered member roster during an enrollment or plan change event. Captures elected plan ID, coverage tier (employee-only, employee+spouse, employee+children, family), effective date, prior plan reference, premium contribution split (employer vs. employee), HSA/HRA/FSA election flag, dental/vision rider elections, and the roster of covered individuals with their relationship codes, age-out dates, and COBRA continuation eligibility. References member domain for person identity — this product owns the enrollment-specific election and roster, not the person demographics. Represents the members choice artifact — distinct from eligibility_span (the resulting coverage). Sourced from Facets/QNXT benefits election module.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` (
    `medicaid_eligibility_id` BIGINT COMMENT 'System-generated unique identifier for the Medicaid eligibility record.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Medicaid managed care programs require PCP assignment for every beneficiary for care coordination, state reporting, and capitation payment. This is a named regulatory and operational requirement. A Me',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Medicaid managed care is predominantly capitation-based. Each Medicaid eligibility record must be tied to a capitation arrangement so the MCO can generate accurate PMPM payments to the state and to de',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Medicaid eligibility determination directly drives enrollment into care management programs (LTSS, disease management for dual eligibles). Managed Medicaid organizations must link eligibility records ',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: A Medicaid eligibility determination drives the creation of an enrollment eligibility span for managed Medicaid/CHIP members. Linking medicaid_eligibility to enrollment_eligibility_span connects the g',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Medicaid eligibility determinations are tied to a specific Medicaid health plan for state reporting and compliance.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom this eligibility applies.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: Medicaid managed care enrollment is county/zip-bound — state agencies assign members to MCOs based on network service area. This link supports auto-assignment logic, state MMIS reporting, CMS complian',
    `prior_eligibility_medicaid_eligibility_id` BIGINT COMMENT 'Reference to the previous eligibility record for continuity tracking.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: Medicaid eligibility determinations (new enrollment, redetermination, termination) generate enrollment transactions that process the eligibility change through the enrollment system. Linking medicaid_',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: Medicaid VBC/ACO programs (e.g., state-based ACOs, Medicaid MCO VBC arrangements) attribute Medicaid members to VBC contracts for quality and cost performance measurement. State reporting and VBC sett',
    `assets_amount` DECIMAL(18,2) COMMENT 'Total countable assets reported for eligibility assessment.',
    `coverage_end_date` DATE COMMENT 'Date when Medicaid coverage under this eligibility ends, if known.',
    `coverage_start_date` DATE COMMENT 'Date when Medicaid coverage under this eligibility begins.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility record was first created in the system.',
    `dual_eligible_flag` BOOLEAN COMMENT 'Indicates whether the member is also eligible for Medicare.',
    `effective_date` DATE COMMENT 'Date on which the Medicaid coverage becomes effective.',
    `eligibility_category` STRING COMMENT 'Classification of Medicaid eligibility based on income and other criteria.. Valid values are `MAGI|SSI|CHIP|Dual-Eligible`',
    `eligibility_determination_timestamp` TIMESTAMP COMMENT 'Exact date and time when the eligibility determination was made.',
    `eligibility_notes` STRING COMMENT 'Free-text notes captured by eligibility staff during determination.',
    `eligibility_number` STRING COMMENT 'Business reference number for the eligibility determination, used in reporting and external communications.',
    `eligibility_reason_code` STRING COMMENT 'Standard code indicating the reason for eligibility determination (e.g., income, disability).',
    `eligibility_status` STRING COMMENT 'Current lifecycle status of the eligibility record.. Valid values are `active|inactive|pending|terminated`',
    `eligibility_verification_date` DATE COMMENT 'Date on which eligibility information was verified.',
    `eligibility_verification_method` STRING COMMENT 'Method used to verify eligibility information.. Valid values are `electronic|paper|phone`',
    `enrollment_source` STRING COMMENT 'Origin of the eligibility record (e.g., EDI 834 file, Facets system, manual entry).. Valid values are `834_file|facets|manual`',
    `federal_program_indicator` BOOLEAN COMMENT 'True if the eligibility is linked to a federal program such as Medicare.',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Members income expressed as a percentage of the Federal Poverty Level.',
    `household_size` STRING COMMENT 'Number of individuals in the members household used for eligibility calculations.',
    `income_amount` DECIMAL(18,2) COMMENT 'Reported annual income used for eligibility calculation.',
    `income_verification_status` STRING COMMENT 'Result of the income verification process for eligibility.. Valid values are `verified|unverified|pending`',
    `last_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the eligibility record.',
    `medicaid_program_type` STRING COMMENT 'Type of Medicaid program the member is enrolled in.. Valid values are `fee_for_service|managed_care|other`',
    `medical_need_flag` BOOLEAN COMMENT 'Indicates whether the member qualifies based on medical need criteria.',
    `redetermination_due_date` DATE COMMENT 'Date by which the member must be re-evaluated for continued eligibility.',
    `special_program_indicator` STRING COMMENT 'Identifies enrollment in special Medicaid programs (e.g., pregnant, disability).. Valid values are `pregnant|disability|elderly|none`',
    `state_agency` STRING COMMENT 'Two-letter code of the state Medicaid agency governing the eligibility.. Valid values are `^[A-Z]{2}$`',
    `state_medicaid_number` STRING COMMENT 'State-assigned Medicaid identification number for the member.',
    `termination_date` DATE COMMENT 'Date on which the Medicaid coverage ends or is scheduled to end.',
    CONSTRAINT pk_medicaid_eligibility PRIMARY KEY(`medicaid_eligibility_id`)
) COMMENT 'Master record tracking Medicaid and CHIP eligibility determinations for members enrolled in managed Medicaid plans. Captures Medicaid eligibility category (MAGI, SSI, CHIP, dual-eligible), state Medicaid ID, eligibility determination date, redetermination due date, income verification status, household size, FPL percentage, and dual-eligible Medicare coordination flag. Interfaces with state Medicaid agency eligibility systems and CMS EDPS. Sourced from state 834 files and Facets Medicaid module.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` (
    `medicare_entitlement_id` BIGINT COMMENT 'Unique surrogate key for the Medicare entitlement record.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Medicare Advantage plans require PCP assignment for care coordination, CMS Stars reporting, and HEDIS measures. Tracking the assigned PCP on medicare_entitlement is a standard MA operational requireme',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Medicare Advantage plans pay provider groups via capitation. Each Medicare entitlement record for an MA member must link to the capitation arrangement governing PMPM payments to the attributed IPA or ',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Medicare entitlement status (dual-eligible, LIS, SNP) directly drives enrollment into specific CMS-mandated care management programs. MA plans must track care program enrollment relative to Medicare e',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Medicare entitlement drives the enrollment eligibility span for Medicare Advantage and Part D members. Linking medicare_entitlement to enrollment_eligibility_span connects the CMS entitlement record t',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Medicare Advantage members are enrolled in specific MA health plans identified by CMS contract number and PBP. Linking medicare_entitlement to health_plan enables CMS RAPS/EDPS submissions, risk adjus',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Medicare Advantage HCC risk scores are calculated per entitlement period and submitted to CMS to determine plan payment rates. A domain expert expects the entitlement record to reference the risk scor',
    `subscriber_id` BIGINT COMMENT 'Identifier of the member to whom this entitlement belongs.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: CMS requires Medicare Advantage enrollment only within CMS-approved network service areas. This link validates MA/MAPD enrollment eligibility by service area, supports PBP assignment logic, and is req',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Medicare entitlement records are governed by CMS regulatory obligations covering Part A/B/D enrollment rules, IRMAA determinations, and LIS/Extra Help requirements. MA/PDP compliance teams link entitl',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: Medicare entitlement changes (initial MA enrollment, disenrollment, Part D enrollment) generate enrollment transactions. Linking medicare_entitlement to transaction connects the CMS entitlement record',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: CMS ACO/REACH and Medicare Advantage VBC programs attribute Medicare beneficiaries to VBC contracts for performance measurement. This link is required for CMS reporting, shared savings calculations, a',
    `cms_contract_number` STRING COMMENT 'Identifier of the CMS contract under which the members Medicare coverage is administered.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the entitlement record was first created in the lakehouse.',
    `eligibility_span_end` DATE COMMENT 'End date of the members overall Medicare eligibility period (null if ongoing).',
    `eligibility_span_start` DATE COMMENT 'Start date of the members overall Medicare eligibility period.',
    `entitlement_number` STRING COMMENT 'External reference number used by business partners to identify this entitlement.',
    `entitlement_status` STRING COMMENT 'Overall lifecycle status of the Medicare entitlement record.. Valid values are `active|inactive|terminated|suspended`',
    `entitlement_type` STRING COMMENT 'Category of Medicare coverage (e.g., Medicare Advantage, Part D, Dual Eligible).. Valid values are `MA|PartD|Dual|Other`',
    `extra_help_effective_date` DATE COMMENT 'Date the Extra Help status became effective.',
    `extra_help_status` STRING COMMENT 'Eligibility status for the Extra Help program (assists with Part D costs).. Valid values are `eligible|ineligible|pending`',
    `irmaa_effective_date` DATE COMMENT 'Date the IRMAA status became effective.',
    `irmaa_income_bracket` STRING COMMENT 'Income bracket used to calculate the members IRMAA surcharge.',
    `irmaa_status` STRING COMMENT 'Current IRMAA status indicating whether the member pays an income‑based surcharge.. Valid values are `eligible|ineligible|pending`',
    `is_dual_eligible` BOOLEAN COMMENT 'Indicates whether the member is eligible for both Medicare and Medicaid.',
    `is_retired` BOOLEAN COMMENT 'True if the entitlement has been retired (e.g., member deceased or moved to non‑Medicare coverage).',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Date‑time when the entitlement information was last verified against CMS.',
    `lis_effective_date` DATE COMMENT 'Date on which the LIS status became effective.',
    `lis_status` STRING COMMENT 'Current status of the members Low Income Subsidy eligibility.. Valid values are `eligible|ineligible|pending`',
    `ma_enrollment_effective_date` DATE COMMENT 'Date the members Medicare Advantage (MA) plan enrollment became effective.',
    `mbi` STRING COMMENT 'Unique 11‑character identifier assigned to each Medicare beneficiary.',
    `notes` STRING COMMENT 'Free‑form text for any additional remarks or audit comments.',
    `part_a_entitlement_date` DATE COMMENT 'Effective date on which the member became entitled to Medicare Part A benefits.',
    `part_a_termination_date` DATE COMMENT 'Date on which Part A entitlement ended, if applicable.',
    `part_b_entitlement_date` DATE COMMENT 'Effective date on which the member became entitled to Medicare Part B benefits.',
    `part_b_termination_date` DATE COMMENT 'Date on which Part B entitlement ended, if applicable.',
    `part_d_enrollment_effective_date` DATE COMMENT 'Date the members Medicare Part D prescription drug coverage became effective.',
    `pbp_assignment` STRING COMMENT 'Code representing the primary business partner (e.g., health plan) assigned to the member.',
    `source_record_reference` STRING COMMENT 'Unique identifier of the source record in the originating system.',
    `source_system` STRING COMMENT 'System that supplied the entitlement data (e.g., MARx, EDPS).. Valid values are `MARx|EDPS|CMS`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the entitlement record.',
    `verification_status` STRING COMMENT 'Current verification state of the entitlement data.. Valid values are `verified|unverified|pending`',
    CONSTRAINT pk_medicare_entitlement PRIMARY KEY(`medicare_entitlement_id`)
) COMMENT 'Master record capturing Medicare entitlement and enrollment details for members in Medicare Advantage (MA) and Part D plans. Captures Medicare Beneficiary Identifier (MBI), Part A/B entitlement dates, MA enrollment effective date, Part D enrollment effective date, Low Income Subsidy (LIS) status, Extra Help level, IRMAA status, and CMS contract/PBP assignment. Sourced from CMS MARx system data and EDPS enrollment confirmations.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` (
    `exchange_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the exchange enrollment record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Marketplace enrollments require the specific benefit_package to apply CSR variant adjustments, calculate APTC reconciliation, and generate accurate 1095-A forms. The csr_variant on exchange_enrollment',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: An ACA exchange enrollment drives the creation of an enrollment eligibility span for the members coverage period. Linking exchange_enrollment to enrollment_eligibility_span connects the marketplace e',
    `enrollment_original_exchange_enrollment_id` BIGINT COMMENT 'Identifier of the original enrollment record that this renewal references.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original transaction received from the ACA exchange gateway.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group (if group coverage) linked to the enrollment.',
    `health_plan_id` BIGINT COMMENT 'Health Insurance Oversight System (HIOS) plan identifier as provided by the marketplace.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with this enrollment.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: ACA exchange enrollments are geographically constrained — CMS requires QHP enrollment only within approved network service areas. This link supports 1095-A reporting, SEP eligibility validation (e.g.,',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: ACA exchange enrollments occur within defined open enrollment periods (ACA marketplace OE windows). Linking exchange_enrollment to open_enrollment_period establishes the enrollment window context, ena',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: ACA marketplace HMO and EPO plans require PCP selection at enrollment. This drives network adequacy compliance, provider directory accuracy, and 1095-A reporting support. A marketplace enrollment doma',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: An ACA exchange enrollment results in a specific plan election — the subscribers plan selection made through the FFE or SBE marketplace. Linking exchange_enrollment to plan_election connects the exch',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: ACA marketplace reporting requires associating each exchange enrollment with the provider network for network‑level statistics.',
    `qualifying_life_event_id` BIGINT COMMENT 'Reference to the qualifying life event that triggered a special enrollment, if any.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Exchange enrollments are governed by ACA regulatory obligations covering APTC reconciliation, 1095-A reporting deadlines, effectuation requirements, and CSR rules. The existing reporting_1095a_flag co',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Exchange enrollments are strictly annual; plan_year and marketplace_year are denormalized plan.year references. The year_id FK enables ACA marketplace annual reporting, 1095-A generation, and CMS reco',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the advance premium tax credit applied to the members premium.',
    `coverage_type` STRING COMMENT 'Indicates whether the enrollment is for an individual, family, or group coverage.. Valid values are `individual|family|group`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exchange enrollment record was first created in the lakehouse.',
    `csr_variant` STRING COMMENT 'Indicates the level of cost‑sharing reduction applied (none, full, or partial).. Valid values are `none|full|partial`',
    `effective_date` DATE COMMENT 'Date on which the enrollment coverage becomes effective.',
    `effectuation_deadline` DATE COMMENT 'Latest date by which the enrollment must be effectuated to avoid loss of coverage.',
    `effectuation_status` STRING COMMENT 'Status of the enrollment effectuation process with the marketplace.. Valid values are `pending|effectuated|failed`',
    `enrollment_effectuation_timestamp` TIMESTAMP COMMENT 'Exact time when the enrollment was effectuated with the marketplace.',
    `enrollment_renewal_indicator` BOOLEAN COMMENT 'True if this enrollment record represents a renewal of a prior enrollment.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `pending|active|terminated|cancelled|reinstated`',
    `enrollment_termination_initiator` STRING COMMENT 'Entity that initiated the termination of the enrollment.. Valid values are `member|employer|system|regulator`',
    `enrollment_termination_reason_code` STRING COMMENT 'Standardized code representing the reason for enrollment termination.',
    `enrollment_termination_type` STRING COMMENT 'Classifies the termination as voluntary or involuntary.. Valid values are `voluntary|involuntary`',
    `enrollment_type` STRING COMMENT 'Nature of the enrollment event (e.g., new enrollment, renewal, reinstatement, termination).. Valid values are `new|renewal|reinstatement|termination`',
    `exchange_eligibility_determination_reference` STRING COMMENT 'Reference number linking to the eligibility determination used for this enrollment.',
    `marketplace_source` STRING COMMENT 'Origin of the enrollment: Federally Facilitated Marketplace (FFM), State-Based Marketplace (SBM), or Small Business Health Options Program (SHOP).. Valid values are `FFM|SBM|SHOP`',
    `marketplace_state` STRING COMMENT 'Two‑letter state code where the marketplace enrollment originated (if applicable).. Valid values are `^[A-Z]{2}$`',
    `payment_due_date` DATE COMMENT 'Date by which the premium payment must be received.',
    `payment_method` STRING COMMENT 'Method used to collect the premium payment.. Valid values are `credit_card|bank_transfer|check|auto_debit`',
    `payment_status` STRING COMMENT 'Current status of premium payment for the enrollment.. Valid values are `paid|unpaid|partial|failed`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly (or applicable frequency) premium amount for the enrollment.',
    `premium_frequency` STRING COMMENT 'Billing frequency for the premium (e.g., monthly, quarterly, annually).. Valid values are `monthly|quarterly|annually`',
    `reporting_1095a_flag` BOOLEAN COMMENT 'Indicates whether this enrollment must be reported on Form 1095‑A.',
    `reporting_1095a_generated_date` DATE COMMENT 'Date on which the 1095‑A form was generated for this enrollment.',
    `source_system` STRING COMMENT 'EDI gateway or clearinghouse that supplied the enrollment data.. Valid values are `Availity|ChangeHealthcare`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Total subsidy amount (APTC + CSR) applied to the premium.',
    `subsidy_type` STRING COMMENT 'Type of subsidy applied (APTC, Cost Sharing Reduction, or none).. Valid values are `aptc|csc|none`',
    `tax_credit_reconciliation_status` STRING COMMENT 'Status of the reconciliation of tax credits (APTC/CSR) with the IRS.. Valid values are `reconciled|pending|error`',
    `termination_date` DATE COMMENT 'Date on which the enrollment coverage ends, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exchange enrollment record.',
    CONSTRAINT pk_exchange_enrollment PRIMARY KEY(`exchange_enrollment_id`)
) COMMENT 'Master record for enrollments originating from ACA health insurance exchanges — Federally Facilitated Marketplace (FFM), State-Based Marketplaces (SBM), and SHOP exchange. Captures exchange transaction ID, marketplace plan ID (HIOS ID), APTC amount and reconciliation status, CSR variant, eligibility determination reference, effectuation status, 1095-A reporting flag, and premium payment effectuation deadline. Interfaces with CMS FFM enrollment data feeds. Critical for ACA compliance, APTC reconciliation with IRS, and annual 1095-A generation. Sourced from Availity/Change Healthcare exchange gateway and CMS 834 files.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_prior_plan_election_id` FOREIGN KEY (`prior_plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_prior_eligibility_medicaid_eligibility_id` FOREIGN KEY (`prior_eligibility_medicaid_eligibility_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`medicaid_eligibility`(`medicaid_eligibility_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_enrollment_original_exchange_enrollment_id` FOREIGN KEY (`enrollment_original_exchange_enrollment_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`exchange_enrollment`(`exchange_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`enrollment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `health_insurance_ecm`.`enrollment` SET TAGS ('dbx_domain' = 'enrollment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('dbx_subdomain' = 'member_eligibility');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `group_location_id` SET TAGS ('dbx_business_glossary_term' = 'Group Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_designation` SET TAGS ('dbx_business_glossary_term' = 'Benefit Designation (TYPE)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_designation` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_period_end` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_period_start` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_category` SET TAGS ('dbx_business_glossary_term' = 'Coverage Category');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_category` SET TAGS ('dbx_value_regex' = 'Employee|Spouse|Dependent|Retiree|Other');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Units');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_limit_units` SET TAGS ('dbx_value_regex' = 'visits|days|sessions|units|claims');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type (TYPE)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'Medical|Dental|Vision|Pharmacy|Wellness');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `deductible_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Deductible Reset Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_eligibility_span_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_eligibility_span_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'OpenEnrollment|SpecialEnrollment|QualifyingLifeEvent|Retroactive|ManualAdjustment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'EDI_834|WebPortal|CallCenter|BatchUpload');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `is_primary_coverage` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `is_waiver_applied` SET TAGS ('dbx_business_glossary_term' = 'Waiver Applied Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'Commercial|Medicare|Medicaid|Exchange|Group');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `moop_reset_date` SET TAGS ('dbx_business_glossary_term' = 'MOOP Reset Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `moop_threshold` SET TAGS ('dbx_business_glossary_term' = 'Maximum‑Of‑Pay Threshold (USD)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `oop_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Maximum (USD)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `oop_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Reset Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `prior_coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Coverage End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `prior_coverage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prior Coverage Indicator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `qualifying_life_event_code` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Code (QLE)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `qualifying_life_event_code` SET TAGS ('dbx_value_regex' = 'MARRIAGE|DIVORCE|BIRTH|ADOPTION|DEATH|EMPLOYER_CHANGE');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `retroactive_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Reason');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_value_regex' = 'Self|Spouse|Child|OtherDependent');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `utilization_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Utilization Reset Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `waiver_type` SET TAGS ('dbx_business_glossary_term' = 'Waiver Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `waiver_type` SET TAGS ('dbx_value_regex' = 'HSA|FSA|HRA|None');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` SET TAGS ('dbx_subdomain' = 'plan_enrollment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `group_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Group Contact Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Member Group Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `open_enrollment_window_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code (ADJ_REASON)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'premium_change|plan_change|error_correction|regulatory|other');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_business_glossary_term' = 'Audit User Role');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_value_regex' = 'admin|operator|system');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `claims_reprocess_flag` SET TAGS ('dbx_business_glossary_term' = 'Claims Reprocess Indicator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('dbx_value_regex' = 'continuous|intermittent|gap');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `enrollment_comment` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Comment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Origin (ENROLL_ORIGIN)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('dbx_value_regex' = 'online|call_center|mail|agent|broker');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction Number (ETN)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ENROLL_TYPE)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'open|sep|auto|special|manual');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `financial_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Indicator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount (GROSS_AMT)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type (PLAN_TYPE)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Indicator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount (NET_AMT)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `original_termination_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Termination Transaction Reference');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status (PROC_STATUS)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `reactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Reactivation Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'facets|qnxt|edi|custom');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|nonpayment|eligibility|other');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `transaction_source` SET TAGS ('dbx_business_glossary_term' = 'Transaction Source (TXN_SRC)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `transaction_source` SET TAGS ('dbx_value_regex' = 'edi_834|web_portal|batch|api');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction Status (ENROLL_STATUS)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|cancelled|completed');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` SET TAGS ('dbx_subdomain' = 'plan_enrollment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier (Employer Group ID)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `group_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'member|employer|system|cms|provider');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date of Status Change');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `event_source` SET TAGS ('dbx_value_regex' = 'core_admin|provider_system|member_portal|edi_gateway|batch_process');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'submitted|approved|rejected|terminated|reinstated|adjusted');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Enrollment Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'pending|active|terminated|reinstated|cancelled');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Enrollment Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'pending|active|terminated|reinstated|cancelled');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` SET TAGS ('dbx_subdomain' = 'plan_enrollment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `appeal_reference` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reference');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('dbx_business_glossary_term' = 'CMS SEP Outcome');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_review');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('dbx_value_regex' = 'birth_certificate|marriage_license|loss_of_coverage_letter|relocation_proof|divorce_decree|adoption_order');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'marriage|birth|loss_of_coverage|relocation|divorce|adoption');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('dbx_business_glossary_term' = 'CMS SEP Category Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_end` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_start` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period Start Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_business_glossary_term' = 'SEP Window Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_value_regex' = 'open|closed|expired');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|denied|appealed');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` SET TAGS ('dbx_subdomain' = 'plan_enrollment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Segment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('dbx_value_regex' = 'Group|Individual|Medicare|Medicaid|Marketplace');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cutoff Time (HH:MM)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deadline Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Type (Annual, Special, Continuous)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'Annual|Special|Continuous');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Type (SHOP, Individual, Off-Exchange, Medicare, Medicaid)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('dbx_value_regex' = 'SHOP|Individual|Off-Exchange|Medicare|Medicaid');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Recurrence Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_retrospective_allowed` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Enrollment Allowed Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'Medical|Dental|Vision|Pharmacy|Wellness');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Notes');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_value_regex' = 'upcoming|open|closed|cancelled|postponed');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Code (OEP)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Name (OEP)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Start Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_actual` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Volume Actual');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Volume Target');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target_met` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Target Met Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` SET TAGS ('dbx_subdomain' = 'member_eligibility');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'External Transaction ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx|wellness');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_limit` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_remaining` SET TAGS ('dbx_business_glossary_term' = 'Benefit Remaining Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_used` SET TAGS ('dbx_business_glossary_term' = 'Benefit Used Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `deductible_remaining` SET TAGS ('dbx_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|error|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Reference Number');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('dbx_value_regex' = 'ssn|mrn|member_id');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `oop_remaining` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket (OOP) Remaining Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_message` SET TAGS ('dbx_business_glossary_term' = 'Response Message');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time (Seconds)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'availity|change_healthcare');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` SET TAGS ('dbx_subdomain' = 'member_eligibility');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `cobra_election_id` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `business_identifier` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Business Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Classification');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_value_regex' = 'cobra_election|cobra_continuation');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `cobra_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'COBRA Premium Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `cobra_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `cobra_premium_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'individual|family|dependent');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Dependents Covered');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `early_termination_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `early_termination_notice_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Notice Sent Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `election_decision` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Decision');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `election_decision` SET TAGS ('dbx_value_regex' = 'elected|declined|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `election_notice_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Election Notice Sent Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `election_status` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `election_status` SET TAGS ('dbx_value_regex' = 'pending|elected|declined|terminated|expired');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Premium Payment Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Lifecycle Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|cancelled|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Notes');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `notice_date_election` SET TAGS ('dbx_business_glossary_term' = 'Election Notice Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `notice_date_initial` SET TAGS ('dbx_business_glossary_term' = 'Initial COBRA Notice Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `notice_deadline` SET TAGS ('dbx_business_glossary_term' = 'Election Deadline Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Method');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'payroll|credit_card|bank_transfer|check');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial|failed');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Type (COBRA)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_value_regex' = 'termination|reduction_of_hours|divorce|death|aging_off');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Facets|QNXT');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'arp|none');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` SET TAGS ('dbx_subdomain' = 'plan_enrollment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `hsa_hra_config_id` SET TAGS ('dbx_business_glossary_term' = 'Hsa Hra Config Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `open_enrollment_window_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `prior_plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Plan Election ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `cobra_eligibility_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `dental_rider_flag` SET TAGS ('dbx_business_glossary_term' = 'Dental Rider Election Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Number (PLAN_ELECTION_NUM)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('dbx_business_glossary_term' = 'Election Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('dbx_value_regex' = 'new|change|termination|reinstatement');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|special_enrollment|qualifying_life_event');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online|call_center|broker|mail');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `fsa_election_flag` SET TAGS ('dbx_business_glossary_term' = 'FSA Election Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `hra_election_flag` SET TAGS ('dbx_business_glossary_term' = 'HRA Election Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `hsa_election_flag` SET TAGS ('dbx_business_glossary_term' = 'HSA Election Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `is_cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Election Notes');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_business_glossary_term' = 'Election Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|cancelled');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `premium_contribution_employee` SET TAGS ('dbx_business_glossary_term' = 'Employee Premium Contribution');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `premium_contribution_employer` SET TAGS ('dbx_business_glossary_term' = 'Employer Premium Contribution');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `total_premium` SET TAGS ('dbx_business_glossary_term' = 'Total Premium');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ALTER COLUMN `vision_rider_flag` SET TAGS ('dbx_business_glossary_term' = 'Vision Rider Election Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` SET TAGS ('dbx_subdomain' = 'member_eligibility');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligibility Record ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Pcp Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `prior_eligibility_medicaid_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Eligibility ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `assets_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `dual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligible Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_category` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Category');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_category` SET TAGS ('dbx_value_regex' = 'MAGI|SSI|CHIP|Dual-Eligible');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_determination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_notes` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Notes');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_number` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Number');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Reason Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|phone');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = '834_file|facets|manual');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `federal_program_indicator` SET TAGS ('dbx_business_glossary_term' = 'Federal Program Indicator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level Percentage');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Income Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_program_type` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Program Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_program_type` SET TAGS ('dbx_value_regex' = 'fee_for_service|managed_care|other');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Need Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `redetermination_due_date` SET TAGS ('dbx_business_glossary_term' = 'Redetermination Due Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `special_program_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Program Indicator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `special_program_indicator` SET TAGS ('dbx_value_regex' = 'pregnant|disability|elderly|none');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('dbx_business_glossary_term' = 'State Agency Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'State Medicaid ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Termination Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` SET TAGS ('dbx_subdomain' = 'member_eligibility');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `medicare_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Medicare Entitlement ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Pcp Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `eligibility_span_end` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span End Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `eligibility_span_start` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Start Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Number');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'MA|PartD|Dual|Other');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Extra Help Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_status` SET TAGS ('dbx_business_glossary_term' = 'Extra Help Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_effective_date` SET TAGS ('dbx_business_glossary_term' = 'IRMAA Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_income_bracket` SET TAGS ('dbx_business_glossary_term' = 'IRMAA Income Bracket');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_status` SET TAGS ('dbx_business_glossary_term' = 'Income‑Related Monthly Adjustment Amount (IRMAA) Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `is_dual_eligible` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `is_retired` SET TAGS ('dbx_business_glossary_term' = 'Retired Entitlement Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_effective_date` SET TAGS ('dbx_business_glossary_term' = 'LIS Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_status` SET TAGS ('dbx_business_glossary_term' = 'Low Income Subsidy (LIS) Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `ma_enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Medicare Advantage Enrollment Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('dbx_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_a_entitlement_date` SET TAGS ('dbx_business_glossary_term' = 'Part A Entitlement Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_a_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Part A Termination Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_b_entitlement_date` SET TAGS ('dbx_business_glossary_term' = 'Part B Entitlement Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_b_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Part B Termination Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_d_enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Part D Enrollment Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `pbp_assignment` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Partner (PBP) Assignment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MARx|EDPS|CMS');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` SET TAGS ('dbx_subdomain' = 'plan_enrollment');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `exchange_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Enrollment ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `exchange_enrollment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `exchange_enrollment_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_original_exchange_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Enrollment ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Transaction ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Plan ID (HIOS ID)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event ID');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `aptc_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `aptc_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `aptc_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'individual|family|group');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `csr_variant` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Reduction (CSR) Variant');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `csr_variant` SET TAGS ('dbx_value_regex' = 'none|full|partial');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effectuation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Effectuation Deadline');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effectuation_status` SET TAGS ('dbx_business_glossary_term' = 'Effectuation Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effectuation_status` SET TAGS ('dbx_value_regex' = 'pending|effectuated|failed');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_effectuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effectuation Timestamp');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_renewal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Renewal Indicator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|terminated|cancelled|reinstated');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_initiator` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Initiator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_initiator` SET TAGS ('dbx_value_regex' = 'member|employer|system|regulator');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Reason Code');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'new|renewal|reinstatement|termination');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `exchange_eligibility_determination_reference` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination Reference');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_source` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Source');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_source` SET TAGS ('dbx_value_regex' = 'FFM|SBM|SHOP');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_state` SET TAGS ('dbx_business_glossary_term' = 'Marketplace State');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|auto_debit');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial|failed');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `reporting_1095a_flag` SET TAGS ('dbx_business_glossary_term' = '1095‑A Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `reporting_1095a_generated_date` SET TAGS ('dbx_business_glossary_term' = '1095‑A Generation Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Availity|ChangeHealthcare');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'aptc|csc|none');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `tax_credit_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Reconciliation Status');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `tax_credit_reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|error');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
