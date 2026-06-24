-- Schema for Domain: enrollment | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-23 01:34:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`enrollment` COMMENT 'Manages the end-to-end enrollment and eligibility lifecycle — open enrollment, special enrollment periods, qualifying life events, 834 EDI transactions, effective dates, terminations, reinstatements, and retroactive adjustments. Owns eligibility spans, coverage periods, and enrollment event history. Interfaces with CMS EDPS/RAPS for government program enrollment and supports 270/271 real-time eligibility verification.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` (
    `eligibility_span_id` BIGINT COMMENT 'System-generated unique identifier for the enrollment eligibility span record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Needed for eligibility reporting to show which benefit package a members coverage span belongs to, essential for benefit design analysis.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: An enrollment eligibility span is the coverage record that results from a subscribers plan election. Linking the span back to the plan_election master record enables direct retrieval of coverage tier',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.care_program. Business justification: Eligibility Span determines member eligibility for specific Care Programs; required for Care Program Eligibility Reporting and program enrollment tracking.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: An eligibility span initiated by a SEP must reference the qualifying life event that triggered it. The existing qualifying_life_event_code STRING column is a denormalized code that is replaced by this',
    `raps_submission_id` BIGINT COMMENT 'Foreign key linking to risk.raps_submission. Business justification: RAPS reconciliation requires knowing which eligibility spans were included in which CMS submission batch. Plans must confirm that each active MA eligibility span was captured in a RAPS submission for ',
    `benefit_designation` STRING COMMENT 'Design of the benefit plan (e.g., HMO, PPO).. Valid values are `HMO|PPO|EPO|POS|HDHP`',
    `benefit_period_end` DATE COMMENT 'End date of the benefit period (often same as termination_date).',
    `benefit_period_start` DATE COMMENT 'Start date of the benefit period (often same as effective_date).',
    `benefit_year` STRING COMMENT 'Calendar year for which the benefit amounts apply.',
    `coverage_category` STRING COMMENT 'Classification of the covered individual (e.g., employee, spouse).. Valid values are `Employee|Spouse|Dependent|Retiree|Other`',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum allowable amount for a specific benefit within the span.',
    `coverage_limit_units` STRING COMMENT 'Unit of measure for the coverage limit (e.g., visits, days).. Valid values are `visits|days|sessions|units|claims`',
    `coverage_type` STRING COMMENT 'Type of coverage provided in this span (e.g., medical, dental).. Valid values are `Medical|Dental|Vision|Pharmacy|Wellness`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility span record was first created.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount applicable for this span.',
    `deductible_reset_date` DECIMAL(18,2) COMMENT 'Date when the deductible accumulator resets (usually start of benefit year).',
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
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Indicates whether the span was created or modified retroactively.',
    `retroactive_adjustment_reason` STRING COMMENT 'Explanation for a retroactive change to the eligibility span.',
    `subscriber_relationship` STRING COMMENT 'Relationship of the covered individual to the subscriber.. Valid values are `Self|Spouse|Child|OtherDependent`',
    `termination_date` DATE COMMENT 'Date when the eligibility span ends; null if still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `utilization_reset_date` DATE COMMENT 'Date when utilization counters (e.g., visit counts) reset.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `waiver_type` STRING COMMENT 'Type of waiver applied, if any.. Valid values are `HSA|FSA|HRA|None`',
    CONSTRAINT pk_eligibility_span PRIMARY KEY(`eligibility_span_id`)
) COMMENT 'Core master record representing a members continuous coverage period under a specific health plan, including benefit year boundaries, deductible/OOP accumulator reset dates, and MOOP thresholds. Captures effective date, termination date, coverage type, line of business (commercial, Medicare, Medicaid), plan code, subscriber relationship, eligibility status, and benefit period attributes. This is the authoritative SSOT for is this member covered? and what benefit period applies? at any point in time. One enrollment_transaction may produce one or more eligibility_spans. Sourced from Facets/QNXT enrollment module and CMS EDPS for government programs. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Primary key for transaction',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Enrollment transactions (adds, terms, retroactive changes) directly trigger capitation payment adjustments. Linking transactions to the capitation arrangement enables automated enrollment adjustment p',
    `eligibility_span_id` BIGINT COMMENT 'Identifier of the eligibility span generated from this transaction.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Each enrollment transaction occurs within a defined open enrollment period; linking transaction to period enables period‑based reporting and ensures the period is not a silo.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: An enrollment transaction triggered by a Special Enrollment Period (SEP) must reference the qualifying life event (QLE) that opened that SEP window. This FK captures the causal link between the QLE an',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.plan_rate. Business justification: Required for premium audit reports that must trace each enrollment transaction to the exact rate applied for regulatory compliance.',
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
    `source` STRING COMMENT 'Source of the enrollment transaction record, e.g., EDI 834 feed, web portal, batch load, or API.. Valid values are `edi_834|web_portal|batch|api`',
    `termination_date` DATE COMMENT 'Date on which coverage ends for a disenrollment or termination event (nullable if not applicable).',
    `termination_reason` STRING COMMENT 'Standardized reason why the enrollment was terminated.. Valid values are `voluntary|involuntary|nonpayment|eligibility|other`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the enrollment transaction.. Valid values are `pending|processed|failed|cancelled|completed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment transaction record.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_transaction PRIMARY KEY(`transaction_id`)
) COMMENT 'Transactional record capturing every enrollment action for a member — initial enrollment, re-enrollment, plan change, disenrollment (voluntary/involuntary termination), reinstatement, and retroactive adjustment. Tracks enrollment source, enrollment period type (open enrollment, SEP, auto-enrollment), effective date, submitted date, processing status, and transaction-type-specific attributes: termination reason/last day of coverage/grace period status for disenrollments; original termination reference/reinstatement effective date/approving authority for reinstatements; adjusted dates/financial impact flag/claims reprocessing trigger for retro adjustments. One enrollment_transaction may produce one or more eligibility_spans. Sourced from Facets/QNXT and 834 EDI transactions via Availity/Change Healthcare. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` (
    `qualifying_life_event_id` BIGINT COMMENT 'System-generated unique identifier for the qualifying life event record.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who reported the qualifying life event.',
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
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_qualifying_life_event PRIMARY KEY(`qualifying_life_event_id`)
) COMMENT 'Master record of a qualifying life event (QLE) that triggers a special enrollment period (SEP), including the full SEP verification lifecycle. Captures event type (marriage, birth, loss of coverage, relocation, divorce, adoption), event date, SEP window open/close dates, CMS SEP category codes, submitted documentation type and artifacts (birth certificate, marriage license, loss of coverage letter), verification status, verifier ID, verification date, CMS SEP verification outcome, pend/denial reason, and appeal reference. This is the authoritative SSOT for both QLE registration and SEP verification — no separate verification record exists. Required for ACA compliance, CMS SEP eligibility determinations, and SEP integrity program compliance. Sourced from Facets/QNXT pend workflow and member portal document uploads. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` (
    `open_enrollment_period_id` BIGINT COMMENT 'Primary key for open_enrollment_period',
    `service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: ACA and CMS regulations require open enrollment periods to be scoped to specific geographic service areas and exchange markets. This FK supports state exchange OEP compliance reporting, enrollment cap',
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
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_open_enrollment_period PRIMARY KEY(`open_enrollment_period_id`)
) COMMENT 'Master record defining each open enrollment window — annual employer group OE, ACA marketplace OE, Medicare Annual Enrollment Period (AEP), and Medicaid continuous enrollment periods. Captures period start/end dates, eligible population segment, LOB, exchange type (SHOP, individual marketplace, off-exchange), and enrollment volume targets. Used to govern when enrollment_records are accepted without a QLE. Sourced from CMS plan year calendars and employer group contracts. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` (
    `edi_transaction_id` BIGINT COMMENT 'Primary key for edi_transaction',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.party. Business justification: 834 EDI enrollment files are submitted by contracted trading partners (employers, TPAs, exchanges). Linking edi_transaction to the contract party identifies the submitting entity for file reconciliati',
    `transaction_id` BIGINT COMMENT 'External identifier supplied by the sender to uniquely identify the transaction (e.g., control number from the senders system).',
    `average_record_size_bytes` DECIMAL(18,2) COMMENT 'Average size of each member record within the file, calculated as file_size_bytes divided by member_count.',
    `effective_date` DATE COMMENT 'Date on which the enrollment coverage becomes effective for the member(s).',
    `enrollment_action_code` STRING COMMENT 'Standard X12 834 code indicating Add (A), Delete (D), Modify (M), or Correct (C) action.. Valid values are `A|D|M|C`',
    `error_code` STRING COMMENT 'Standardized error code returned when processing fails (e.g., X12 validation error).',
    `error_description` STRING COMMENT 'Human‑readable description of the processing error.',
    `file_name` STRING COMMENT 'Original filename of the inbound 834 transaction as received from the EDI gateway.',
    `file_received_timestamp` TIMESTAMP COMMENT 'Date‑time when the 834 file was first ingested into the lakehouse.',
    `file_size_bytes` BIGINT COMMENT 'Total size of the inbound 834 file in bytes.',
    `group_control_number` STRING COMMENT 'Control number identifying the GS functional group for the transaction.',
    `interchange_control_number` STRING COMMENT 'Control number identifying the ISA interchange envelope for the transaction.',
    `last_attempt_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent processing attempt.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the transaction from ingestion to final disposition.. Valid values are `new|in_progress|completed|failed|cancelled`',
    `member_count` STRING COMMENT 'Number of individual member enrollment records contained in the 834 file.',
    `processing_attempts` STRING COMMENT 'Number of times the transaction has been attempted for processing.',
    `processing_status` STRING COMMENT 'Current workflow status of the transaction within the ingestion pipeline.. Valid values are `received|queued|processing|completed|error|rejected`',
    `receiver_code` STRING COMMENT 'Identifier of the trading partner that receives the 834 file (typically the health insurer).',
    `reconciliation_status` STRING COMMENT 'Result of matching the transaction to internal enrollment records.. Valid values are `unmatched|matched|partial|pending`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    `termination_date` DATE COMMENT 'Date on which the enrollment coverage ends, if applicable.',
    `transaction_set_control_number` STRING COMMENT 'Control number that uniquely identifies the 834 transaction set within the interchange.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp representing the business event time encoded in the 834 transaction (e.g., effective date of the enrollment action).',
    `transaction_type` STRING COMMENT 'Indicates whether the 834 file adds new enrollments, changes existing ones, terminates coverage, or corrects prior data.. Valid values are `add|change|terminate|correction`',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_edi_transaction PRIMARY KEY(`edi_transaction_id`)
) COMMENT 'Raw and processed 834 EDI transaction records received from employer groups, exchanges, and CMS — the primary electronic mechanism for enrollment adds, changes, and terminations. Captures ISA/GS envelope metadata, transaction set control number, sender/receiver IDs, transaction type (full file vs. change only), processing status, error codes, and reconciliation status. Sourced from Availity/Change Healthcare EDI gateway. Distinct from enrollment_record (the business outcome) — this is the inbound EDI artifact. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` (
    `eligibility_verification_id` BIGINT COMMENT 'Primary key for eligibility_verification',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Real-time eligibility verification (270/271 transactions) must return benefit package-specific cost-sharing details (copays, deductibles, OOP limits) to providers. This FK enables direct benefit packa',
    `contract_network_participation_id` BIGINT COMMENT 'Foreign key linking to contract.network_participation. Business justification: 270/271 eligibility verification transactions explicitly return in-network status for a provider. Linking eligibility_verification to network_participation records which participation record was evalu',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: A 270/271 real-time eligibility verification request is performed against a specific member eligibility span. This direct FK enables immediate span-level eligibility lookup without traversing through ',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled.',
    `identity_id` BIGINT COMMENT 'Unique member identifier used in the eligibility request (e.g., member number, SSN, MRN).',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for automated provider credential checks during eligibility verification; the process matches providers to member eligibility inquiries.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the eligibility record.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_eligibility_verification PRIMARY KEY(`eligibility_verification_id`)
) COMMENT 'Transactional record of real-time 270/271 eligibility verification requests and responses. Captures requesting provider NPI, member identifier used, inquiry date/time, response status, coverage details returned, deductible/OOP balances returned, and response time SLA. Supports provider-facing eligibility verification at point of care. Sourced from Availity/Change Healthcare 270/271 gateway and Facets real-time eligibility API. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` (
    `plan_election_id` BIGINT COMMENT 'Unique surrogate identifier for the plan election record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: When a member elects a plan, they select a specific benefit package (e.g., HMO Gold, PPO Silver). This FK supports premium billing, benefit adjudication, and ACA metal-tier reporting. A health insuran',
    `offering_id` BIGINT COMMENT 'Foreign key linking to plan.offering. Business justification: Employer group plan elections are made against a specific offering that defines contribution tiers and eligible plans. This FK supports employer contribution reconciliation, benefits administration re',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: A plan election made during an open enrollment window must reference the open_enrollment_period that governed it. This FK enables OEP-level analytics (volume_actual vs volume_target tracking, complian',
    `prior_plan_election_id` BIGINT COMMENT 'Reference to the previous election record when this election is a change or reinstatement.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: A plan election made outside of open enrollment (SEP election) must reference the qualifying life event that opened the special enrollment window. This FK captures the regulatory basis for the off-cyc',
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
    `premium_frequency` DECIMAL(18,2) COMMENT 'Billing frequency for the premium (e.g., monthly).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the election record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the election record.',
    `termination_date` DATE COMMENT 'Date the elected coverage ends, if applicable.',
    `vision_rider_flag` BOOLEAN COMMENT 'Indicates if a vision coverage rider was elected.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_plan_election PRIMARY KEY(`plan_election_id`)
) COMMENT 'Master record of a subscribers specific plan selection, coverage tier, and covered member roster during an enrollment or plan change event. Captures elected plan ID, coverage tier (employee-only, employee+spouse, employee+children, family), effective date, prior plan reference, premium contribution split (employer vs. employee), HSA/HRA/FSA election flag, dental/vision rider elections, and the roster of covered individuals with their relationship codes, age-out dates, and COBRA continuation eligibility. References member domain for person identity — this product owns the enrollment-specific election and roster, not the person demographics. Represents the members choice artifact — distinct from eligibility_span (the resulting coverage). Sourced from Facets/QNXT benefits election module. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` (
    `medicaid_eligibility_id` BIGINT COMMENT 'System-generated unique identifier for the Medicaid eligibility record.',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: A Medicaid eligibility determination results in an enrollment eligibility span for the managed care member. Linking medicaid_eligibility to the corresponding enrollment_eligibility_span enables direct',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Medicaid eligibility category (LTSS, HCBS waiver, managed long-term care) directly drives assignment to a specific care management program per state Medicaid contract requirements. This is a regulator',
    `prior_eligibility_medicaid_eligibility_id` BIGINT COMMENT 'Reference to the previous eligibility record for continuity tracking.',
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
    `income_verification_status` DECIMAL(18,2) COMMENT 'Result of the income verification process for eligibility.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the eligibility record.',
    `medicaid_program_type` STRING COMMENT 'Type of Medicaid program the member is enrolled in.. Valid values are `fee_for_service|managed_care|other`',
    `medical_need_flag` BOOLEAN COMMENT 'Indicates whether the member qualifies based on medical need criteria.',
    `redetermination_due_date` DATE COMMENT 'Date by which the member must be re-evaluated for continued eligibility.',
    `special_program_indicator` STRING COMMENT 'Identifies enrollment in special Medicaid programs (e.g., pregnant, disability).. Valid values are `pregnant|disability|elderly|none`',
    `state_agency` STRING COMMENT 'Two-letter code of the state Medicaid agency governing the eligibility.. Valid values are `^[A-Z]{2}$`',
    `state_medicaid_number` STRING COMMENT 'State-assigned Medicaid identification number for the member.',
    `termination_date` DATE COMMENT 'Date on which the Medicaid coverage ends or is scheduled to end.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_medicaid_eligibility PRIMARY KEY(`medicaid_eligibility_id`)
) COMMENT 'Master record tracking Medicaid and CHIP eligibility determinations for members enrolled in managed Medicaid plans. Captures Medicaid eligibility category (MAGI, SSI, CHIP, dual-eligible), state Medicaid ID, eligibility determination date, redetermination due date, income verification status, household size, FPL percentage, and dual-eligible Medicare coordination flag. Interfaces with state Medicaid agency eligibility systems and CMS EDPS. Sourced from state 834 files and Facets Medicaid module. [FHIR-aligned]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` (
    `medicare_entitlement_id` BIGINT COMMENT 'Unique surrogate key for the Medicare entitlement record.',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Medicare Advantage capitation (PMPM) applies RAF risk scores from member entitlement records. Linking medicare_entitlement to capitation_arrangement enables RAF-adjusted PMPM calculation, Part D premi',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: A Medicare entitlement record for a Medicare Advantage member corresponds to an enrollment eligibility span representing their MA coverage period. This FK links the CMS entitlement data (Part A/B date',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: CMS requires Medicare Advantage SNP members (identified by entitlement type: ESRD, chronic condition, dual eligible) to be enrolled in specific care management programs per contract. The entitlement t',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: A Medicare entitlement record is created or updated as a result of an enrollment transaction (e.g., MA enrollment, Part D enrollment, CMS EDPS/RAPS submission). Linking medicare_entitlement to the ori',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the entitlement record was first created in the lakehouse.',
    `eligibility_span_end` DATE COMMENT 'End date of the members overall Medicare eligibility period (null if ongoing).',
    `eligibility_span_start` DATE COMMENT 'Start date of the members overall Medicare eligibility period.',
    `entitlement_number` STRING COMMENT 'External reference number used by business partners to identify this entitlement.',
    `entitlement_status` STRING COMMENT 'Overall lifecycle status of the Medicare entitlement record.. Valid values are `active|inactive|terminated|suspended`',
    `entitlement_type` STRING COMMENT 'Category of Medicare coverage (e.g., Medicare Advantage, Part D, Dual Eligible).. Valid values are `MA|PartD|Dual|Other`',
    `extra_help_effective_date` DATE COMMENT 'Date the Extra Help status became effective.',
    `extra_help_status` STRING COMMENT 'Eligibility status for the Extra Help program (assists with Part D costs).. Valid values are `eligible|ineligible|pending`',
    `irmaa_effective_date` DATE COMMENT 'Date the IRMAA status became effective.',
    `irmaa_income_bracket` DECIMAL(18,2) COMMENT 'Income bracket used to calculate the members IRMAA surcharge.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the entitlement record.',
    `verification_status` STRING COMMENT 'Current verification state of the entitlement data.. Valid values are `verified|unverified|pending`',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_medicare_entitlement PRIMARY KEY(`medicare_entitlement_id`)
) COMMENT 'Master record capturing Medicare entitlement and enrollment details for members in Medicare Advantage (MA) and Part D plans. Captures Medicare Beneficiary Identifier (MBI), Part A/B entitlement dates, MA enrollment effective date, Part D enrollment effective date, Low Income Subsidy (LIS) status, Extra Help level, IRMAA status, and CMS contract/PBP assignment. Sourced from CMS MARx system data and EDPS enrollment confirmations. [FHIR-aligned]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ADD CONSTRAINT `fk_enrollment_eligibility_span_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ADD CONSTRAINT `fk_enrollment_eligibility_span_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_prior_plan_election_id` FOREIGN KEY (`prior_plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_prior_eligibility_medicaid_eligibility_id` FOREIGN KEY (`prior_eligibility_medicaid_eligibility_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility`(`medicaid_eligibility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`enrollment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`enrollment` SET TAGS ('dbx_domain' = 'enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` SET TAGS ('dbx_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Raps Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `benefit_designation` SET TAGS ('dbx_business_glossary_term' = 'Benefit Designation (TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `benefit_designation` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `benefit_period_end` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `benefit_period_start` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `benefit_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `coverage_category` SET TAGS ('dbx_business_glossary_term' = 'Coverage Category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `coverage_category` SET TAGS ('dbx_value_regex' = 'Employee|Spouse|Dependent|Retiree|Other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `coverage_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Units');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `coverage_limit_units` SET TAGS ('dbx_value_regex' = 'visits|days|sessions|units|claims');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type (TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'Medical|Dental|Vision|Pharmacy|Wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `deductible_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Deductible Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `enrollment_eligibility_span_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `enrollment_eligibility_span_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `enrollment_eligibility_span_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'OpenEnrollment|SpecialEnrollment|QualifyingLifeEvent|Retroactive|ManualAdjustment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'EDI_834|WebPortal|CallCenter|BatchUpload');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `is_primary_coverage` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `is_waiver_applied` SET TAGS ('dbx_business_glossary_term' = 'Waiver Applied Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'Commercial|Medicare|Medicaid|Exchange|Group');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `moop_reset_date` SET TAGS ('dbx_business_glossary_term' = 'MOOP Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `moop_threshold` SET TAGS ('dbx_business_glossary_term' = 'Maximum‑Of‑Pay Threshold (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `oop_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Maximum (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `oop_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `plan_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `plan_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `prior_coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `prior_coverage_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `prior_coverage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prior Coverage Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `retroactive_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_value_regex' = 'Self|Spouse|Child|OtherDependent');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `utilization_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Utilization Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `waiver_type` SET TAGS ('dbx_business_glossary_term' = 'Waiver Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ALTER COLUMN `waiver_type` SET TAGS ('dbx_value_regex' = 'HSA|FSA|HRA|None');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code (ADJ_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'premium_change|plan_change|error_correction|regulatory|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_business_glossary_term' = 'Audit User Role');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_value_regex' = 'admin|operator|system');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `claims_reprocess_flag` SET TAGS ('dbx_business_glossary_term' = 'Claims Reprocess Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('dbx_value_regex' = 'continuous|intermittent|gap');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_comment` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Comment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Origin (ENROLL_ORIGIN)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('dbx_value_regex' = 'online|call_center|mail|agent|broker');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction Number (ETN)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ENROLL_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'open|sep|auto|special|manual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `financial_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_fhir_element' = 'extension.us-core-race');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_special_category' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_pii' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount (GROSS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_fhir_element' = 'extension.us-core-race');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_special_category' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_pii' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `original_termination_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Termination Transaction Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status (PROC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `reactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Reactivation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Transaction Source (TXN_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'edi_834|web_portal|batch|api');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|nonpayment|eligibility|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction Status (ENROLL_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|cancelled|completed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `appeal_reference` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('dbx_business_glossary_term' = 'CMS SEP Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('dbx_value_regex' = 'birth_certificate|marriage_license|loss_of_coverage_letter|relocation_proof|divorce_decree|adoption_order');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'marriage|birth|loss_of_coverage|relocation|divorce|adoption');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('dbx_business_glossary_term' = 'CMS SEP Category Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_end` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_start` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_business_glossary_term' = 'SEP Window Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_value_regex' = 'open|closed|expired');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|denied|appealed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Segment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('dbx_value_regex' = 'Group|Individual|Medicare|Medicaid|Marketplace');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cutoff Time (HH:MM)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Type (Annual, Special, Continuous)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'Annual|Special|Continuous');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Type (SHOP, Individual, Off-Exchange, Medicare, Medicaid)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('dbx_value_regex' = 'SHOP|Individual|Off-Exchange|Medicare|Medicaid');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Recurrence Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_retrospective_allowed` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Enrollment Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'Medical|Dental|Vision|Pharmacy|Wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_value_regex' = 'upcoming|open|closed|cancelled|postponed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Code (OEP)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Name (OEP)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_actual` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Volume Actual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Volume Target');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target_met` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Target Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `edi_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Edi Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Business Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `average_record_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Average Record Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Action Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_value_regex' = 'A|D|M|C');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Processing Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'File Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_control_number` SET TAGS ('dbx_business_glossary_term' = 'Group Control Number (GS08)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_control_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_control_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Control Number (ISA13)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `last_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Processing Attempt Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'new|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_attempts` SET TAGS ('dbx_business_glossary_term' = 'Processing Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'received|queued|processing|completed|error|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('dbx_business_glossary_term' = 'Receiver EDI Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unmatched|matched|partial|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Control Number (ST02)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'add|change|terminate|correction');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('dbx_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `contract_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'External Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_limit` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_remaining` SET TAGS ('dbx_business_glossary_term' = 'Benefit Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_used` SET TAGS ('dbx_business_glossary_term' = 'Benefit Used Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `deductible_remaining` SET TAGS ('dbx_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_fhir_element' = 'Condition.code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_fhir' = 'code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|error|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('dbx_value_regex' = 'ssn|mrn|member_id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `oop_remaining` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket (OOP) Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_message` SET TAGS ('dbx_business_glossary_term' = 'Response Message');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time (Seconds)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `prior_plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `cobra_eligibility_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `dental_rider_flag` SET TAGS ('dbx_business_glossary_term' = 'Dental Rider Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Number (PLAN_ELECTION_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('dbx_business_glossary_term' = 'Election Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('dbx_value_regex' = 'new|change|termination|reinstatement');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|special_enrollment|qualifying_life_event');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online|call_center|broker|mail');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fsa_election_flag` SET TAGS ('dbx_business_glossary_term' = 'FSA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `hra_election_flag` SET TAGS ('dbx_business_glossary_term' = 'HRA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `hsa_election_flag` SET TAGS ('dbx_business_glossary_term' = 'HSA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `is_cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Election Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_business_glossary_term' = 'Election Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `vision_rider_flag` SET TAGS ('dbx_business_glossary_term' = 'Vision Rider Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('dbx_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligibility Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Care Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `prior_eligibility_medicaid_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Eligibility ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `assets_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `dual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_category` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_category` SET TAGS ('dbx_value_regex' = 'MAGI|SSI|CHIP|Dual-Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_determination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_notes` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_number` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_reason_code` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|phone');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = '834_file|facets|manual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `federal_program_indicator` SET TAGS ('dbx_business_glossary_term' = 'Federal Program Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Income Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_program_type` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_program_type` SET TAGS ('dbx_value_regex' = 'fee_for_service|managed_care|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Need Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `redetermination_due_date` SET TAGS ('dbx_business_glossary_term' = 'Redetermination Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `special_program_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Program Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `special_program_indicator` SET TAGS ('dbx_value_regex' = 'pregnant|disability|elderly|none');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('dbx_business_glossary_term' = 'State Agency Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('dbx_fhir' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'State Medicaid ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('dbx_fhir' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('dbx_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `medicare_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Medicare Entitlement ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Medicare Care Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `eligibility_span_end` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `eligibility_span_start` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'MA|PartD|Dual|Other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Extra Help Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_status` SET TAGS ('dbx_business_glossary_term' = 'Extra Help Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_effective_date` SET TAGS ('dbx_business_glossary_term' = 'IRMAA Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_income_bracket` SET TAGS ('dbx_business_glossary_term' = 'IRMAA Income Bracket');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_status` SET TAGS ('dbx_business_glossary_term' = 'Income‑Related Monthly Adjustment Amount (IRMAA) Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `is_dual_eligible` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `is_retired` SET TAGS ('dbx_business_glossary_term' = 'Retired Entitlement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_effective_date` SET TAGS ('dbx_business_glossary_term' = 'LIS Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_status` SET TAGS ('dbx_business_glossary_term' = 'Low Income Subsidy (LIS) Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_status` SET TAGS ('dbx_fhir_element' = 'status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `ma_enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Medicare Advantage Enrollment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `ma_enrollment_effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('dbx_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('dbx_ssot' = 'owning_entity_via_fk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_a_entitlement_date` SET TAGS ('dbx_business_glossary_term' = 'Part A Entitlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_a_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Part A Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_a_termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_b_entitlement_date` SET TAGS ('dbx_business_glossary_term' = 'Part B Entitlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_b_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Part B Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_b_termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_d_enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Part D Enrollment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_d_enrollment_effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `pbp_assignment` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Partner (PBP) Assignment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `verification_status` SET TAGS ('dbx_fhir_element' = 'status');
