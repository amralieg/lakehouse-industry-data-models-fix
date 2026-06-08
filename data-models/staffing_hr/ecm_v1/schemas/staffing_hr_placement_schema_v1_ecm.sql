-- Schema for Domain: placement | Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm`.`placement` COMMENT 'Owns the full placement and assignment lifecycle for both temporary and permanent hires. Manages temporary assignments, contract-to-hire, temp-to-perm, and direct hire placement records. Tracks assignment start/end dates, extensions, backfill tracking, conversions, conversion fees, job details, work location, supervisor, fall-off rate monitoring, redeployment events, and assignment status. SSOT for active worker assignment status connecting candidates to job orders.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique system-generated identifier for each worker assignment record. Primary key of the assignment data product and the SSOT for active worker assignment status in the placement domain. Serves as the backbone of the Bullhorn ATS placement record.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for whom the worker is placed. Enables direct client-level reporting without requiring a join through the job order.',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement governing the terms and conditions of this assignment, including rate terms, conversion fees, and liability provisions. Sourced from DocuSign CLM.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) that this assignment fulfills. Links the assignment to the clients open requisition in the Bullhorn ATS job order entity.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate (worker) placed on this assignment. Links the assignment to the candidate master record in the Bullhorn ATS candidate entity.',
    `right_to_represent_id` BIGINT COMMENT 'Foreign key linking to candidate.right_to_represent. Business justification: Assignments must reference the RTR that authorized the candidates placement with the client for compliance audit trail, fee dispute resolution, and regulatory reporting (OFCCP, EEOC). Staffing operat',
    `staff_profile_id` BIGINT COMMENT 'FK to employee.staff_profile.staff_profile_id — Critical for recruiter accountability: every assignment must identify the responsible recruiter/AM for commission calculation, performance tracking, and operational reporting.',
    `supervisor_id` BIGINT COMMENT 'Foreign key linking to placement.supervisor. Business justification: Assignment currently has supervisor_name and supervisor_email as denormalized text fields. The supervisor product is the authoritative source for client-side supervisor information (contact details, a',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Assignments are fulfilled by staffing suppliers who provide the contingent worker. Core operational link for supplier performance tracking, invoice reconciliation, VMS routing, and MSP program managem',
    `tier_classification_id` BIGINT COMMENT 'Foreign key linking to vendor.tier_classification. Business justification: VMS programs route assignments to suppliers based on tier classification (preferred/tier 1/tier 2). Direct link enables tier-based workflow automation, allocation enforcement, and supplier performance',
    `work_location_id` BIGINT COMMENT 'Reference to the specific client work location where the worker is physically assigned. Supports workforce scheduling, dispatch, and geographic workforce analytics.',
    `actual_end_date` DATE COMMENT 'The date the assignment actually ended, which may differ from the scheduled end date due to early termination, extension, or conversion. Null if the assignment is still active. Used for fall-off rate and tenure analytics.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the assignment. Active = worker currently on assignment; Ended = assignment completed or terminated; Extended = original end date extended; Converted = temp-to-perm or CTH conversion completed; Cancelled = assignment cancelled before start or during placement.. Valid values are `active|ended|extended|converted|cancelled`',
    `assignment_type` STRING COMMENT 'Classification of the assignment engagement model. Temp = short-term temporary placement; Contract = fixed-duration contract; Contract-to-Hire (CTH) = contract with intent to convert; Temp-to-Perm = temporary placement with conversion pathway; Direct Hire = permanent placement.. Valid values are `temp|contract|contract_to_hire|temp_to_perm|direct_hire`',
    `bgc_status` STRING COMMENT 'Current status of the background check (BGC) for this assignment. Clear = passed; Adverse = failed or flagged; Waived = client waived requirement. Sourced from Sterling Background Check. Required for FCRA compliance and client credentialing.. Valid values are `not_initiated|pending|clear|adverse|waived`',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate charged to the client for the workers services. Core financial field used in invoicing, gross margin calculation, and rate card compliance. Expressed in USD per hour unless otherwise noted.',
    `bullhorn_placement_reference` STRING COMMENT 'The externally-known placement record identifier from the Bullhorn ATS/CRM system of record. Used for cross-system reconciliation and audit traceability back to the source ATS.',
    `conversion_date` DATE COMMENT 'The date on which a temp-to-perm or contract-to-hire worker was formally converted to a permanent employee of the client. Null if no conversion has occurred. Triggers conversion fee billing and assignment status change to converted.',
    `conversion_fee` DECIMAL(18,2) COMMENT 'The fee charged to the client upon conversion of a temp-to-perm or contract-to-hire worker to a permanent employee. Applicable only for CTH and temp-to-perm assignment types. Governed by the clients MSA terms.',
    `cost_center` STRING COMMENT 'The clients internal cost center or department code to which the workers costs are allocated. Used for client billing, PO matching, and workforce cost allocation reporting in the clients ERP system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the assignment record was first created in the system. Used for audit trail, data lineage, and Time to Fill (TTF) / Time to Start (TTS) KPI calculations. Conforms to ISO 8601 format.',
    `department` STRING COMMENT 'The clients department or business unit where the worker is placed. Supports workforce analytics, headcount reporting by department, and client billing allocation.',
    `drug_screen_status` STRING COMMENT 'Current status of the pre-placement drug screening for this assignment. Negative = passed; Positive = failed; Waived = client waived requirement. Sourced from Sterling Background Check. Required for client compliance and OSHA safety standards.. Valid values are `not_initiated|pending|negative|positive|waived`',
    `end_reason` STRING COMMENT 'The reason code for why the assignment ended. Used for fall-off rate analysis, quality of service reporting, and client relationship management. [ENUM-REF-CANDIDATE: assignment_completed|client_terminated|worker_resigned|converted_to_perm|cancelled|no_show — promote to reference product if additional values are needed]. Valid values are `assignment_completed|client_terminated|worker_resigned|converted_to_perm|cancelled|no_show`',
    `extension_count` STRING COMMENT 'The number of times this assignments end date has been extended. Used to track assignment longevity, client satisfaction, and redeployment planning. Incremented each time a new scheduled end date is set beyond the prior one.',
    `flsa_classification` STRING COMMENT 'Workers FLSA overtime exemption status for this assignment. Non-Exempt workers are entitled to overtime pay; Exempt workers are not. Critical for payroll compliance, DOL audit readiness, and co-employment risk management.. Valid values are `exempt|non_exempt`',
    `i9_verified` BOOLEAN COMMENT 'Indicates whether the workers I-9 Employment Eligibility Verification form has been completed and verified for this assignment. Required by the Immigration and Nationality Act (INA) before work commencement.',
    `is_backfill` BOOLEAN COMMENT 'Indicates whether this assignment was created to backfill a position vacated by a previous worker. Used for workforce analytics, fall-off rate tracking, and client relationship management.',
    `is_redeployment_eligible` BOOLEAN COMMENT 'Indicates whether the worker is eligible for redeployment to another assignment upon completion of this one. Used by recruiters to proactively manage bench workers and reduce time-to-fill on new requisitions.',
    `is_remote` BOOLEAN COMMENT 'Indicates whether the worker performs the assignment remotely (True) or on-site at the client location (False). Affects workers comp classification, state tax nexus, and workforce scheduling.',
    `job_title` STRING COMMENT 'The job title or position title for the role the worker is filling on this assignment. Used for workforce reporting, job classification, and EEOC/OFCCP compliance reporting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the assignment record was most recently modified. Used for change data capture (CDC), data freshness monitoring, and audit compliance. Conforms to ISO 8601 format.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied over the pay rate to arrive at the bill rate, expressed as a decimal (e.g., 0.45 = 45%). Used for rate card compliance, margin analysis, and client pricing governance.',
    `onboarding_status` STRING COMMENT 'Current status of the workers onboarding process for this assignment. Tracks completion of I-9, E-Verify, background check, drug screen, and orientation steps required before the worker can begin. Sourced from SAP SuccessFactors Onboarding.. Valid values are `not_started|in_progress|completed|blocked`',
    `ot_bill_rate` DECIMAL(18,2) COMMENT 'The hourly bill rate charged to the client for overtime hours worked by the placed worker. Typically 1.5x the standard bill rate per FLSA requirements. Required for accurate client invoicing and OT cost tracking.',
    `ot_pay_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate paid to the worker for overtime hours. Typically 1.5x the standard pay rate per FLSA requirements. Required for payroll processing and FLSA compliance auditing.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate paid to the worker for services rendered. Core financial field used in payroll processing, spread calculation, and markup analysis. Expressed in USD per hour unless otherwise noted.',
    `per_diem_eligible` BOOLEAN COMMENT 'Indicates whether the worker is eligible to receive per diem allowances (meals, lodging, incidentals) for this assignment. Typically applies to travel assignments or placements away from the workers tax home. Affects payroll tax treatment.',
    `po_number` STRING COMMENT 'The client-issued purchase order number authorizing spend for this assignment. Required for invoice matching and accounts payable processing at the client. Sourced from Beeline VMS or client ERP.',
    `scheduled_end_date` DATE COMMENT 'The originally contracted or currently scheduled end date of the assignment. Used for proactive redeployment planning, extension tracking, and workforce bench management.',
    `scheduled_hours_per_week` DECIMAL(18,2) COMMENT 'The standard number of hours per week the worker is scheduled to work on this assignment. Used for FTE calculation, workforce planning, and prorated billing. Typically 40 for full-time placements.',
    `spread` DECIMAL(18,2) COMMENT 'The gross spread per hour calculated as bill rate minus pay rate. Represents the staffing firms gross revenue per hour before burden costs. Key profitability metric tracked at the assignment level per ASA industry standards.',
    `start_date` DATE COMMENT 'The actual date the worker began the assignment at the client work location. Used for tenure calculations, billing cycle initiation, and Time to Start (TTS) KPI measurement.',
    `vms_req_number` STRING COMMENT 'The requisition or assignment identifier assigned by the clients Vendor Management System (VMS), typically Beeline. Used for cross-system reconciliation between the staffing firms ATS and the clients VMS for MSP-managed programs.',
    `worker_classification` STRING COMMENT 'Tax and employment classification of the worker for this assignment. W-2 = employee of the staffing firm; 1099 = independent contractor; Corp-to-Corp = contractor through their own entity; EOR = employer of record arrangement. Drives payroll tax treatment and IRS compliance.. Valid values are `w2|1099|corp_to_corp|eor`',
    `workers_comp_code` STRING COMMENT 'The NCCI or state-specific workers compensation class code assigned to this placement based on the job duties performed. Determines the workers comp insurance premium rate applied to the assignment. Required for accurate burden rate calculation and insurance compliance.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'Core master record for every temporary, contract, contract-to-hire, and temp-to-perm worker assignment. Serves as the SSOT for active worker assignment status, connecting a candidate to a job order at a specific client work location. Tracks assignment type (temp, CTH, temp-to-perm), start date, scheduled end date, actual end date, assignment status (active, ended, extended, converted, cancelled), supervisor name, work location, bill rate, pay rate, spread, markup percentage, FLSA classification, workers comp code, cost center, PO number, and redeployment eligibility flag. Primary operational entity of the placement domain and the backbone of the Bullhorn ATS placement record.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`direct_hire` (
    `direct_hire_id` BIGINT COMMENT 'Unique system-generated identifier for the direct hire permanent placement record. Primary key for this entity. TRANSACTION_HEADER role — serves as the anchor for all permanent placement lifecycle data.',
    `envelope_id` BIGINT COMMENT 'Foreign key linking to contract.envelope. Business justification: Direct hire placements require separate e-signed placement agreements documenting fee terms, guarantee periods, and replacement obligations—distinct from the client MSA. Tracks execution of the specif',
    `bgc_order_id` BIGINT COMMENT 'Foreign key linking to credentialing.bgc_order. Business justification: Direct hire placements require pre-employment background checks. Links permanent placement to BGC order for offer contingency tracking and compliance audit trail. Standard staffing workflow gates offe',
    `client_account_id` BIGINT COMMENT 'Reference to the client account (hiring organization) for whom the permanent placement is being made. Links to the client master record in the Client domain.',
    `invoice_id` BIGINT COMMENT 'Reference to the accounts receivable invoice generated for the conversion fee associated with this direct hire placement. Links to the billing record in Salesforce Revenue Cloud / Oracle NetSuite ERP.',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement (MSA) governing the terms of this direct hire placement, including fee percentage, guarantee period, and payment terms. Links to the contract record in DocuSign CLM.',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Direct hire placements require onboarding (I9, BGC, orientation, tax forms) but lack assignment_id path. Staffing operations track onboarding completion before start_date. Links direct hire placement ',
    `order_header_id` BIGINT COMMENT 'Reference to the originating job order or requisition (Req) that this direct hire placement fulfills. Links to the Job Order domain master record.',
    `placement_compliance_check_id` BIGINT COMMENT 'Foreign key linking to compliance.placement_compliance_check. Business justification: Direct hires require pre-employment compliance clearance (BGC, drug screen, I-9, credential verification) before start date. Links permanent placement to its compliance validation record for onboardin',
    `primary_replacement_placement_direct_hire_id` BIGINT COMMENT 'Reference to the new direct hire placement record created to fulfill the replacement obligation after a fall-off. Null if no replacement has been initiated. Enables tracking of replacement lineage and fall-off resolution.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate (job seeker) who is being placed in the direct hire engagement. Links to the candidate master record in the Candidate domain. PARTY_REFERENCE per TRANSACTION_HEADER canonical role.',
    `readiness_status_id` BIGINT COMMENT 'Foreign key linking to credentialing.readiness_status. Business justification: Direct hire start dates depend on credential package completion. Links permanent placement to readiness evaluation for onboarding workflow and client compliance verification. Enables placement-eligibl',
    `right_to_represent_id` BIGINT COMMENT 'Foreign key linking to candidate.right_to_represent. Business justification: Direct hire placements require RTR authorization to place candidate with client. Linking to specific RTR provides compliance audit trail for fee disputes, validates exclusive vs non-exclusive represen',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal recruiter or staffing consultant responsible for sourcing and placing the candidate in this direct hire engagement.',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to recruitment.submittal. Business justification: Direct hire placements must track originating submittal for fee calculation (percentage of salary), guarantee period enforcement, recruiter commission attribution, and time-to-fill metrics. Essential ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Direct hire placements are often sourced through recruiting agencies/suppliers. Tracks sourcing partner for fee attribution, supplier performance measurement, and preferred supplier list management. C',
    `work_location_id` BIGINT COMMENT 'Reference to the physical or remote work location where the placed candidate will perform their duties. Links to the client location record in the Client domain.',
    `accepted_date` DATE COMMENT 'The date on which the candidate formally accepted the employment offer. Used to calculate offer acceptance cycle time and track placement progression from offered to accepted status.',
    `base_salary` DECIMAL(18,2) COMMENT 'The annual base salary (in USD) agreed upon for the permanent placement. Used as the basis for conversion fee calculation (fee_percentage × base_salary). Classified as confidential financial data. MONETARY_TRIPLET component per TRANSACTION_HEADER canonical role.',
    `bgc_status` STRING COMMENT 'Current status of the pre-employment background check (BGC) for the candidate in this direct hire placement. Sourced from Sterling Background Check integration. Required for compliance with FCRA and client onboarding requirements.. Valid values are `not_initiated|pending|passed|failed|adjudicated`',
    `bullhorn_placement_reference` STRING COMMENT 'External identifier from the Bullhorn ATS/CRM permanent placement module. Used to trace this record back to the originating system of record for reconciliation and audit purposes.',
    `conversion_fee_amount` DECIMAL(18,2) COMMENT 'The gross dollar amount of the placement fee charged to the client for the direct hire engagement. Typically calculated as fee_percentage × base_salary. This is the primary revenue line for direct hire placements. MONETARY_TRIPLET component per TRANSACTION_HEADER canonical role.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this direct hire placement record was first created in the system. RECORD_AUDIT_CREATED per TRANSACTION_HEADER canonical role. Used for data lineage, audit trails, and SLA compliance tracking.',
    `department` STRING COMMENT 'The department or business unit within the client organization where the candidate will be permanently placed. Used for workforce planning analytics and client reporting.',
    `drug_screen_status` STRING COMMENT 'Current status of the pre-employment drug screening for the candidate in this direct hire placement. Sourced from Sterling Background Check integration. Required for compliance with client-specific and DOT/OSHA regulated positions.. Valid values are `not_required|pending|passed|failed|waived`',
    `eeoc_job_category` STRING COMMENT 'The EEOC EEO-1 job category code assigned to the placed position (e.g., Officials and Managers, Professionals, Technicians). Required for EEOC and OFCCP regulatory reporting on workforce composition.',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement for the direct hire placement. Full-Time Equivalent (FTE) is the standard for direct hire; part-time direct hire is less common but supported.. Valid values are `full_time|part_time`',
    `exempt_status` STRING COMMENT 'Fair Labor Standards Act (FLSA) classification of the placed position as exempt (salaried, not eligible for overtime) or non-exempt (eligible for overtime pay). Critical for client compliance and workforce analytics.. Valid values are `exempt|non_exempt`',
    `fall_off_date` DATE COMMENT 'The date on which the placed candidate left or was terminated from the client, triggering a fall-off event within the guarantee period. Null if the placement has not fallen off. Used to calculate fall-off rate KPI and assess recruiter performance.',
    `fall_off_reason` STRING COMMENT 'The categorized reason why a direct hire placement fell off within the guarantee period. Used for root cause analysis, recruiter coaching, and quality of submission (QoS) reporting. Null if placement has not fallen off. [ENUM-REF-CANDIDATE: candidate_resigned|candidate_terminated|offer_rescinded|failed_bgc|failed_drug_screen|personal_reasons|compensation_mismatch|other — promote to reference product]',
    `fee_collected` BOOLEAN COMMENT 'Indicates whether the conversion fee has been fully collected (payment received) from the client for this direct hire placement. Used for cash flow reporting and accounts receivable aging analysis.',
    `fee_invoiced` BOOLEAN COMMENT 'Indicates whether the conversion fee invoice has been generated and sent to the client for this direct hire placement. Used to track billing completeness and revenue recognition readiness.',
    `fee_payment_terms` STRING COMMENT 'The agreed-upon payment terms for the conversion fee invoice. Defines when the client is obligated to remit payment after the placement start date or invoice date. Sourced from the client MSA.. Valid values are `net_30|net_45|net_60|upon_start|split`',
    `fee_percentage` DECIMAL(18,2) COMMENT 'The agreed-upon percentage of the candidates first-year base salary charged as the conversion fee. Typically ranges from 15% to 30% for direct hire placements. Defined in the clients Master Service Agreement (MSA).',
    `guarantee_end_date` DATE COMMENT 'The calculated date on which the guarantee period expires (start_date + guarantee_period_days). After this date, the staffing firm has no replacement obligation. Used for fall-off risk monitoring and financial liability tracking.',
    `guarantee_period_days` STRING COMMENT 'The number of calendar days from the candidates start date during which the staffing firm is obligated to provide a free replacement if the candidate leaves or is terminated (fall-off window). Typically 30, 60, or 90 days. Defined in the client MSA.',
    `i9_verified` BOOLEAN COMMENT 'Indicates whether the candidates I-9 Employment Eligibility Verification has been completed and verified for this direct hire placement. Mandatory under the Immigration and Nationality Act (INA) for all U.S. employees.',
    `job_title` STRING COMMENT 'The job title of the position the candidate is being permanently placed into at the client organization. Captured at time of placement as the agreed-upon title.',
    `notes` STRING COMMENT 'Free-text field for recruiter or account manager notes related to this direct hire placement, including special client requirements, candidate considerations, or placement context not captured in structured fields.',
    `offer_date` DATE COMMENT 'The date on which the formal employment offer was extended to the candidate by the client. BUSINESS_EVENT_TIMESTAMP (date precision) per TRANSACTION_HEADER canonical role. Key metric for Time to Fill (TTF) calculation.',
    `onboarding_status` STRING COMMENT 'Current status of the candidate onboarding process for this direct hire placement, including I-9 verification, document collection, and system provisioning. Tracked to ensure readiness for the confirmed start date.. Valid values are `not_started|in_progress|completed|blocked`',
    `placement_number` STRING COMMENT 'Human-readable, externally-known business identifier for this direct hire placement record (e.g., DH-2024-00123). Used in client communications, invoicing, and reporting. BUSINESS_IDENTIFIER per TRANSACTION_HEADER canonical role.',
    `placement_status` STRING COMMENT 'Current lifecycle state of the direct hire placement. Tracks the progression from offer through active employment or fall-off. LIFECYCLE_STATUS per TRANSACTION_HEADER canonical role. Values: offered (offer extended to candidate), accepted (candidate accepted offer), started (candidate began employment), fell_off (candidate did not start or left within guarantee period), replaced (replacement candidate provided per guarantee obligation).. Valid values are `offered|accepted|started|fell_off|replaced`',
    `placement_type` STRING COMMENT 'Classification of the permanent placement engagement type. Direct Hire is a full-time permanent placement from the outset; Temp-to-Perm and Contract-to-Hire indicate a conversion from a temporary or contract assignment to permanent employment.. Valid values are `direct_hire|temp_to_perm|contract_to_hire`',
    `replacement_obligation` BOOLEAN COMMENT 'Indicates whether the staffing firm is currently obligated to provide a free replacement candidate due to a fall-off within the guarantee period. True when placement_status is fell_off and the guarantee period has not expired.',
    `salary_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the base salary (e.g., USD, CAD, GBP). Supports multi-currency operations for international placements. MONETARY_TRIPLET component per TRANSACTION_HEADER canonical role.. Valid values are `^[A-Z]{3}$`',
    `sourcing_channel` STRING COMMENT 'The channel or method through which the candidate was originally sourced for this direct hire placement. Used for sourcing effectiveness analytics and recruiter performance reporting. [ENUM-REF-CANDIDATE: job_board|referral|linkedin|direct_sourcing|internal_database|rpo|other — promote to reference product]',
    `start_date` DATE COMMENT 'The confirmed date on which the candidate begins employment with the client. Used to calculate Time to Start (TTS) and triggers the guarantee period window. Key operational milestone for billing and fall-off monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this direct hire placement record was most recently modified. RECORD_AUDIT_UPDATED per TRANSACTION_HEADER canonical role. Used for change detection, incremental ETL processing, and audit compliance.',
    `work_arrangement` STRING COMMENT 'The agreed-upon work location arrangement for the permanent placement. Onsite requires physical presence at the client location; remote is fully off-site; hybrid is a combination. Captured at time of placement.. Valid values are `onsite|remote|hybrid`',
    CONSTRAINT pk_direct_hire PRIMARY KEY(`direct_hire_id`)
) COMMENT 'Master record for permanent placement and direct hire engagements where a candidate is placed full-time with a client. Distinct from temporary assignment lifecycle — tracks offer date, accepted date, start date, base salary, conversion fee amount, fee percentage, fee payment terms, guarantee period (fall-off window), fall-off date if applicable, replacement obligation flag, and placement status (offered, accepted, started, fell-off, replaced). Owned by the placement domain as the SSOT for permanent placement outcomes. Sourced from Bullhorn permanent placement module.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` (
    `assignment_extension_id` BIGINT COMMENT 'Unique surrogate primary key for each assignment extension event record in the placement domain. Globally unique identifier for this transactional record.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for whom the worker is assigned. Supports client-level extension analytics and SLA tracking.',
    `envelope_id` BIGINT COMMENT 'The DocuSign envelope identifier for the executed extension agreement or amendment document. Provides traceability to the signed contract artifact in the DocuSign CLM system.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) under which the assignment extension is being processed. Links the extension to the client demand record.',
    `assignment_id` BIGINT COMMENT 'Reference to the parent temporary or contract assignment record that is being extended. Core linkage to the placement assignment lifecycle.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal user or manager who approved or rejected the extension request. Required for approval workflow audit trail.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate (worker) whose assignment is being extended. Enables fall-off rate monitoring and redeployment planning at the worker level.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Extensions need direct supplier link for supplier scorecard metrics (extension approval rate, time-to-extend). While inherited from parent assignment, direct link enables supplier performance reportin',
    `approval_date` DATE COMMENT 'The business date on which the extension request was formally approved or rejected by the designated approver. Used for SLA measurement and approval cycle time reporting.',
    `bullhorn_extension_reference` STRING COMMENT 'The native record identifier assigned to this extension event in the Bullhorn ATS/CRM source system. Used for data lineage, reconciliation, and cross-system traceability between the lakehouse silver layer and the operational system of record.',
    `client_approver_email` STRING COMMENT 'Email address of the client-side manager or supervisor who authorized the extension. Used for extension confirmation communications and audit trail.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `client_approver_name` STRING COMMENT 'Name of the client-side manager or supervisor who authorized the extension request. Captured as a denormalized field from the extension workflow for audit and reporting purposes.',
    `conversion_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker becomes eligible for temp-to-perm conversion upon completion of the extended assignment period. Triggers conversion fee tracking and direct hire workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this extension record was first created in the system, in ISO 8601 format with timezone offset. Provides the audit trail entry point for the extension lifecycle.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the bill rate and pay rate fields on this extension record (e.g., USD, CAD, GBP). Supports multi-currency staffing operations.. Valid values are `^[A-Z]{3}$`',
    `executed_date` DATE COMMENT 'The business date on which the approved extension was formally executed and the new end date was applied to the assignment record. Marks the completion of the extension lifecycle.',
    `extension_duration_days` STRING COMMENT 'Number of calendar days added to the assignment by this extension event, calculated as new_end_date minus prior_end_date. Stored as a business field to support workforce planning and analytics without requiring date arithmetic at query time.',
    `extension_number` STRING COMMENT 'Externally-known business identifier for this extension event, generated by the Bullhorn assignment extension workflow. Used for cross-system reference and client communication.. Valid values are `^EXT-[0-9]{6,12}$`',
    `extension_reason_code` STRING COMMENT 'Standardized reason code categorizing why the assignment extension was requested. Supports analytics on extension drivers and workforce planning. [ENUM-REF-CANDIDATE: project_continuation|headcount_backfill|client_request|worker_request|sow_extension|other — promote to reference product]. Valid values are `project_continuation|headcount_backfill|client_request|worker_request|sow_extension|other`',
    `extension_reason_notes` STRING COMMENT 'Free-text narrative providing additional context or justification for the extension beyond the standardized reason code. Captured from the client or staffing coordinator during the extension request workflow.',
    `extension_sequence_number` STRING COMMENT 'Ordinal position of this extension event within the full extension history of the assignment (e.g., 1 = first extension, 2 = second extension). Enables tracking of cumulative extensions per assignment for fall-off rate and redeployment analytics.',
    `extension_status` STRING COMMENT 'Current lifecycle state of the extension request within the approval and execution workflow. Drives operational actions such as rate renegotiation, onboarding updates, and redeployment planning.. Valid values are `pending|approved|rejected|executed|cancelled`',
    `fall_off_risk_flag` BOOLEAN COMMENT 'Indicates whether this extension event has been flagged as at risk of fall-off (early termination before the new end date). Supports fall-off rate monitoring and proactive account management.',
    `msp_program_flag` BOOLEAN COMMENT 'Indicates whether this extension is managed under a Managed Service Provider (MSP) program, requiring VMS workflow compliance and additional approval routing.',
    `new_end_date` DATE COMMENT 'The revised assignment end date established by this extension event. Becomes the active end date on the parent assignment record upon execution. Drives redeployment planning and workforce scheduling.',
    `prior_bill_rate` DECIMAL(18,2) COMMENT 'The hourly bill rate charged to the client that was in effect on the assignment immediately before this extension event. Stored for rate change audit and spread analysis.',
    `prior_end_date` DATE COMMENT 'The assignment end date that was in effect immediately before this extension event was applied. Critical for auditing the extension history and calculating the duration of each extension increment.',
    `prior_pay_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate paid to the worker that was in effect on the assignment immediately before this extension event. Stored for rate change audit and gross margin analysis.',
    `rate_change_flag` BOOLEAN COMMENT 'Indicates whether this extension event included a renegotiation of the bill rate or pay rate. True when either revised_bill_rate or revised_pay_rate differs from the prior rate. Enables quick filtering of rate-change extensions for financial impact analysis.',
    `redeployment_candidate_flag` BOOLEAN COMMENT 'Indicates whether the worker has been flagged for redeployment planning as part of this extension review. True when the extension is not approved or when the new end date triggers a redeployment workflow.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when an extension request is rejected. Populated only when extension_status is rejected. Supports process improvement and client communication.',
    `request_date` DATE COMMENT 'The business date on which the extension request was formally submitted by the client or staffing coordinator. Used to measure lead time and SLA compliance for extension processing.',
    `revised_bill_rate` DECIMAL(18,2) COMMENT 'The renegotiated hourly bill rate to be charged to the client effective upon execution of this extension. Null if the bill rate was not renegotiated as part of this extension event.',
    `revised_pay_rate` DECIMAL(18,2) COMMENT 'The renegotiated hourly pay rate to be paid to the worker effective upon execution of this extension. Null if the pay rate was not renegotiated as part of this extension event.',
    `spread_prior` DECIMAL(18,2) COMMENT 'The gross spread (bill rate minus pay rate) in effect on the assignment before this extension event. Stored as a business field to support margin trend analysis across extension history without requiring rate arithmetic at query time.',
    `spread_revised` DECIMAL(18,2) COMMENT 'The gross spread (revised bill rate minus revised pay rate) applicable after this extension event. Null if no rate change occurred. Supports margin impact analysis for renegotiated extensions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this extension record was most recently modified, in ISO 8601 format with timezone offset. Supports incremental data loading, change detection, and audit compliance.',
    `vms_req_number` STRING COMMENT 'The requisition or extension request number assigned by the clients Vendor Management System (VMS) such as Beeline. Required for MSP-managed programs to reconcile extension events between the staffing firms ATS and the clients VMS.',
    `work_location_type` STRING COMMENT 'Classification of the work arrangement for the extended assignment period. May differ from the original assignment if the extension includes a change in work modality.. Valid values are `onsite|remote|hybrid`',
    `worker_classification` STRING COMMENT 'Tax and employment classification of the worker on this assignment at the time of extension. Drives payroll processing, tax withholding, and co-employment compliance requirements.. Valid values are `w2|1099|corp_to_corp`',
    CONSTRAINT pk_assignment_extension PRIMARY KEY(`assignment_extension_id`)
) COMMENT 'Transactional record capturing each extension event on a temporary or contract assignment. Tracks the prior end date, new end date, extension reason, extension request date, approver, revised bill rate (if renegotiated), revised pay rate, extension sequence number, and extension status (pending, approved, rejected, executed). Enables fall-off rate monitoring and redeployment planning by providing a complete extension history per assignment. Sourced from Bullhorn assignment extension workflow.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`conversion` (
    `conversion_id` BIGINT COMMENT 'Unique system-generated identifier for the temp-to-perm or contract-to-hire conversion record. Primary key for the conversion data product.',
    `envelope_id` BIGINT COMMENT 'Foreign key linking to contract.envelope. Business justification: Temp-to-perm conversions require signed conversion fee agreements separate from MSA and original assignment. Staffing firms track envelope completion to trigger invoicing and guarantee period start.',
    `assignment_id` BIGINT COMMENT 'Reference to the original temporary assignment or contract placement record from which this conversion event originated. Links the conversion back to the source assignment in the placement domain.',
    `branch_office_location_id` BIGINT COMMENT 'Foreign key linking to employee.office_location. Business justification: Conversions are owned by a staffing firm branch/office for commission allocation, revenue recognition, territory management, and operational reporting. The existing branch_id(unlinked) represents this',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that is hiring the temporary worker as a permanent employee. Used for billing the conversion fee and tracking client-level conversion rates.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the account manager responsible for the client relationship and conversion fee negotiation. Used for sales performance reporting and commission attribution.',
    `conversion_staff_profile_id` BIGINT COMMENT 'Reference to the internal recruiter responsible for managing the original placement and facilitating the conversion. Used for recruiter performance reporting and commission calculations.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice record generated in Salesforce Revenue Cloud or Oracle NetSuite ERP for the conversion fee billing. Populated once conversion_status transitions to invoiced.',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement governing the conversion fee terms, notice period requirements, and tenure clauses applicable to this conversion event.',
    `office_location_id` BIGINT COMMENT 'Reference to the staffing agency branch office that owns this conversion record. Used for branch-level revenue reporting and operational analytics.',
    `order_header_id` BIGINT COMMENT 'Reference to the original job order or requisition associated with the temporary placement that triggered this conversion event.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate (temporary worker) who is being converted to a permanent employee of the client. Used to link conversion events to the candidate master record.',
    `readiness_status_id` BIGINT COMMENT 'Foreign key linking to credentialing.readiness_status. Business justification: Temp-to-perm conversions trigger credential re-verification for permanent employment classification. Links conversion to readiness evaluation for client-required permanent credential packages (often s',
    `replacement_conversion_id` BIGINT COMMENT 'Self-referencing identifier pointing to the replacement conversion record created when a fell-off conversion is replaced within the guarantee period. Enables tracking of replacement chains and guarantee fulfillment.',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to recruitment.submittal. Business justification: Temp-to-perm conversions must track original submittal for conversion fee calculation per MSA terms, recruiter commission credit, and conversion rate KPI reporting. Critical for revenue recognition an',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Conversions track which supplier originally placed the worker for conversion fee calculation, supplier credit, and supplier performance metrics (conversion rate). Essential for MSA fee terms enforceme',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program (e.g., Beeline) under which the original temporary assignment was managed. Relevant for MSP/VMS-managed programs where conversion fees and processes are governed by the VMS program terms.',
    `work_location_id` BIGINT COMMENT 'Reference to the client work location where the converted worker will be permanently employed. Used for geographic workforce analytics and compliance reporting.',
    `worker_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.worker_classification. Business justification: Conversions from contingent contractor to permanent FTE trigger reclassification from temporary to employee status. Business process: documenting worker classification change for IRS/state compliance ',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Total billable hours worked by the temporary worker on the original assignment prior to the conversion date. Used to validate minimum tenure hour thresholds for fee waiver eligibility and for conversion rate analytics.',
    `assignment_end_date` DATE COMMENT 'The date on which the temporary or contract assignment formally ended as a result of the conversion. Marks the transition point from contingent to permanent employment status.',
    `assignment_start_date` DATE COMMENT 'The start date of the original temporary or contract assignment from which the conversion originated. Used to calculate the total assignment duration prior to conversion and to validate minimum tenure requirements per the MSA.',
    `bullhorn_conversion_reference` STRING COMMENT 'External identifier assigned by Bullhorn ATS/CRM to the placement conversion workflow record. Used for system-of-record traceability and reconciliation with the source system.',
    `client_confirmation_date` DATE COMMENT 'The date on which the client formally confirmed the conversion hire in writing or via the system. Triggers the conversion fee billing process in Salesforce Revenue Cloud.',
    `conversion_date` DATE COMMENT 'The actual date on which the temporary worker officially transitioned to permanent employment with the client. This is the principal business event date for the conversion and is used for KPI calculations such as conversion rate and time-to-convert.',
    `conversion_status` STRING COMMENT 'Current lifecycle state of the conversion event. pending = conversion initiated but not yet confirmed by client; confirmed = client has confirmed the hire; invoiced = conversion fee invoice has been issued; fell_off = conversion did not complete (fall-off event); cancelled = conversion was voided.. Valid values are `pending|confirmed|invoiced|fell_off|cancelled`',
    `conversion_type` STRING COMMENT 'Classifies the nature of the conversion event. temp_to_perm indicates a temporary worker transitioning to permanent employment; contract_to_hire (CTH) indicates a contract worker being hired directly; direct_conversion covers other direct placement conversions.. Valid values are `temp_to_perm|contract_to_hire|direct_conversion`',
    `converted_worker_annual_salary` DECIMAL(18,2) COMMENT 'The first-year annual base salary agreed upon for the converted worker in their new permanent role with the client. Used as the basis for percentage-based conversion fee calculations. Sourced from client confirmation documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this conversion record was first created in the data platform. Used for audit trail, data lineage, and Silver Layer ingestion tracking. Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `fall_off_date` DATE COMMENT 'The date on which a confirmed conversion fell off — i.e., the converted worker left the clients permanent employment within the guarantee period. Populated only when conversion_status is fell_off. Used for fall-off rate KPI monitoring.',
    `fall_off_reason` STRING COMMENT 'The documented reason why a confirmed conversion fell off within the guarantee period. Used for fall-off rate analysis and to determine whether a replacement or fee credit is owed to the client per MSA guarantee terms.. Valid values are `voluntary_resignation|client_termination|role_eliminated|candidate_no_show|other`',
    `fee_amount` DECIMAL(18,2) COMMENT 'The gross conversion fee charged to the client for the temp-to-perm or contract-to-hire conversion. Typically calculated as a percentage of the converted workers first-year annual salary or as a flat fee per the MSA. Critical for revenue recognition and billing in Salesforce Revenue Cloud and Oracle NetSuite ERP.',
    `fee_basis_type` STRING COMMENT 'Indicates the method used to calculate the conversion fee. percentage_of_salary = fee is a percentage of the converted workers first-year annual salary; flat_fee = fixed dollar amount per the MSA rate card; negotiated = custom fee agreed upon for this specific conversion.. Valid values are `percentage_of_salary|flat_fee|negotiated`',
    `fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the conversion fee amount (e.g., USD, CAD, GBP). Supports multi-currency operations for international staffing engagements.. Valid values are `^[A-Z]{3}$`',
    `fee_percentage` DECIMAL(18,2) COMMENT 'The percentage of the converted workers first-year annual salary used to calculate the conversion fee, when fee_basis_type is percentage_of_salary. Expressed as a decimal percentage (e.g., 15.00 = 15%). Null when fee_basis_type is flat_fee.',
    `fee_waiver_approved_by` STRING COMMENT 'Name or identifier of the internal approver (e.g., account manager, branch manager, or VP) who authorized the conversion fee waiver. Required for audit and revenue exception tracking.',
    `fee_waiver_flag` BOOLEAN COMMENT 'Indicates whether the conversion fee has been waived for this conversion event. True = fee waived; False = fee applies. Fee waivers may occur due to MSA terms, client relationship considerations, or minimum tenure provisions.',
    `fee_waiver_reason` STRING COMMENT 'The business reason for waiving the conversion fee when fee_waiver_flag is True. msa_tenure_clause = worker met minimum tenure hours per MSA; client_relationship = strategic client concession; negotiated_waiver = pre-negotiated waiver in contract; minimum_hours_met = minimum billable hours threshold reached; other = other documented reason.. Valid values are `msa_tenure_clause|client_relationship|negotiated_waiver|minimum_hours_met|other`',
    `guarantee_period_days` STRING COMMENT 'The number of days after the permanent start date during which the staffing agency guarantees the placement. If the converted worker leaves within this period, a replacement or fee credit may be owed per the MSA. Sourced from the applicable MSA terms.',
    `invoice_date` DATE COMMENT 'The date on which the conversion fee invoice was issued to the client. Used for accounts receivable aging and revenue recognition timing in Oracle NetSuite ERP.',
    `job_title` STRING COMMENT 'The job title of the permanent position the converted worker is being hired into at the client organization. May differ from the temporary assignment title and is used for workforce planning and conversion analytics.',
    `minimum_tenure_hours` DECIMAL(18,2) COMMENT 'The minimum number of billable hours the temporary worker must have worked on the assignment before the conversion fee is waived per the MSA terms. Used to determine fee_waiver_flag eligibility when fee_waiver_reason is minimum_hours_met.',
    `notes` STRING COMMENT 'Free-text field for documenting additional context, special circumstances, or operational notes related to the conversion event. Examples include negotiation details, client-specific conditions, or exception handling notes.',
    `notice_date` DATE COMMENT 'The date on which the client formally notified the staffing agency of their intent to convert the temporary worker to a permanent employee. Used to calculate notice period compliance per the Master Service Agreement (MSA) terms.',
    `payment_due_date` DATE COMMENT 'The date by which the client is contractually required to remit payment for the conversion fee invoice, per the payment terms defined in the MSA.',
    `payment_received_date` DATE COMMENT 'The date on which payment for the conversion fee was received from the client. Used for cash application, revenue recognition, and accounts receivable reconciliation.',
    `permanent_start_date` DATE COMMENT 'The date on which the converted worker officially begins permanent employment with the client. May differ from conversion_date if there is a gap between conversion confirmation and the first day of permanent employment.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this conversion record was sourced. Supports data lineage tracking and reconciliation in the Silver Layer lakehouse.. Valid values are `bullhorn|beeline|manual|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this conversion record was last modified in the data platform. Used for change data capture (CDC), incremental processing, and audit trail compliance. Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_conversion PRIMARY KEY(`conversion_id`)
) COMMENT 'Transactional record capturing the temp-to-perm or contract-to-hire conversion event when a temporary worker transitions to a permanent employee of the client. Tracks conversion date, conversion type (temp-to-perm, CTH), original assignment reference, conversion fee amount, fee waiver flag, fee waiver reason, conversion notice date, client confirmation date, and conversion status (pending, confirmed, invoiced, fell-off). Critical for billing the conversion fee and monitoring conversion rate KPIs. Sourced from Bullhorn placement conversion workflow.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` (
    `assignment_status_history_id` BIGINT COMMENT 'Unique surrogate identifier for each assignment status history record. Primary key for this audit trail entity. Role: EVENT_LOG — append-only record of immutable status transition events for worker assignments.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which this assignment is being fulfilled. Denormalized to enable direct client-level SLA compliance and fall-off rate reporting without joining through the placement or job order records.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) associated with this assignment. Supports TTF (Time to Fill) and TTS (Time to Start) SLA tracking by linking status transitions back to the originating job order.',
    `assignment_id` BIGINT COMMENT 'Reference to the parent worker assignment record for which this status transition event was recorded. EVENT_SOURCE_REFERENCE — the assignment entity that emitted this status change event.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal user (recruiter, account manager, or system process) who triggered the status transition. Required for regulatory audit trails and SOC 2 Type II access control evidence.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate (worker) whose assignment status changed. Enables candidate-level fall-off rate analysis, redeployment tracking, and SLA compliance reporting across all assignments for a given worker.',
    `quaternary_assignment_approved_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who formally approved this status transition when approval_required_flag is true. Null when no approval was required. Supports SOC 2 Type II segregation of duties and OFCCP audit trail requirements.',
    `tertiary_assignment_account_manager_staff_profile_id` BIGINT COMMENT 'Reference to the account manager responsible for the client relationship at the time of this status transition. Supports account manager-level SLA compliance and client satisfaction reporting.',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS (Vendor Management System) program under which this assignment operates, if applicable. Links to Beeline VMS program configuration for contingent workforce programs. Null for direct-client assignments not managed through a VMS.',
    `actual_transition_hours` DECIMAL(18,2) COMMENT 'The actual elapsed time in hours between the triggering business event and this status transition. Compared against sla_target_hours to determine SLA compliance. Supports TTF and TTS metric calculation in Power BI Analytics dashboards.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this status transition required a formal approval step (e.g., client approval for an extension, manager approval for a conversion). Supports workflow compliance and audit trail requirements.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the status transition was formally approved by the approving user. Null when no approval was required. Used to measure approval cycle time for SLA compliance and process efficiency analytics.',
    `assignment_end_date` DATE COMMENT 'The scheduled or actual end date of the worker assignment at the time of this status transition. Captures the end date as it was known at the moment of the status change, supporting extension tracking and fall-off analysis.',
    `change_reason_code` STRING COMMENT 'Standardized reason code explaining why the status transition occurred. Drives fall-off rate analysis, redeployment eligibility, and regulatory reporting. Values: voluntary_resignation, client_termination, assignment_end, extension_approved, no_show, fall_off, conversion. [ENUM-REF-CANDIDATE: voluntary_resignation|client_termination|assignment_end|extension_approved|no_show|fall_off|conversion|medical_leave|performance|background_check_fail — promote to reference product]',
    `change_reason_description` STRING COMMENT 'Free-text narrative providing additional context for the status transition beyond the standardized change_reason_code. Captures recruiter or account manager notes entered at the time of the change. Supports regulatory audit and dispute resolution.',
    `client_contact_notified_flag` BOOLEAN COMMENT 'Indicates whether the client contact (hiring manager or program manager) was notified of this status transition. Critical for client relationship management and SLA compliance evidence, particularly for fall-off and cancellation events.',
    `compliance_hold_flag` BOOLEAN COMMENT 'Indicates whether this status transition was triggered by or resulted in a compliance hold — for example, a failed background check (BGC), incomplete I-9 verification, E-Verify mismatch, or missing credentialing. Links to compliance domain for regulatory audit.',
    `compliance_hold_reason` STRING COMMENT 'Standardized reason code for a compliance hold when compliance_hold_flag is true. Values: bgc_pending (Background Check pending), bgc_failed, i9_incomplete (I-9 incomplete), everify_mismatch (E-Verify mismatch), credential_missing, drug_screen_pending, drug_screen_failed. [ENUM-REF-CANDIDATE: bgc_pending|bgc_failed|i9_incomplete|everify_mismatch|credential_missing|drug_screen_pending|drug_screen_failed — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'RECORD_AUDIT_CREATED — the date and time when this status history record was first captured in the data platform. Distinct from transition_timestamp (the business event time). Used for data pipeline monitoring and audit trail completeness verification.',
    `days_in_prior_status` STRING COMMENT 'The number of calendar days the assignment spent in the prior_status before this transition. Calculated at ingestion time and stored for efficient SLA compliance analysis (e.g., how long an assignment was in offered before confirmed). Supports TTF and TTS KPI reporting.',
    `effective_date` DATE COMMENT 'The business-effective date on which the new status takes operational effect. May differ from transition_timestamp when a status change is backdated or future-dated (e.g., an extension approved today but effective next Monday).',
    `is_backfill` BOOLEAN COMMENT 'Flag indicating whether this assignment is a backfill — replacing a worker who left a position. Backfill assignments are tracked separately for workforce planning analytics and client relationship management reporting.',
    `is_conversion` BOOLEAN COMMENT 'Flag indicating whether this status transition represents a temp-to-perm or contract-to-hire conversion event, where the temporary worker is being converted to a permanent employee of the client. Triggers conversion fee billing processes.',
    `is_extension` BOOLEAN COMMENT 'Flag indicating whether this status transition represents an assignment extension event, where the original end date has been pushed forward. Extensions are a key revenue retention metric and trigger redeployment planning suppression.',
    `is_fall_off` BOOLEAN COMMENT 'Flag indicating whether this status transition represents a fall-off event — a placement that ended prematurely before the originally scheduled end date. Fall-off rate is a critical KPI (Key Performance Indicator) for staffing firm quality and recruiter performance measurement.',
    `is_redeployment_eligible` BOOLEAN COMMENT 'Flag set at the time of this status transition indicating whether the worker is eligible for redeployment to a new assignment. Drives bench management workflows and proactive candidate outreach to minimize bench time and maximize utilization.',
    `new_status` STRING COMMENT 'The assignment status value after this transition event. This is the EVENT_TYPE_OR_CHANNEL discriminator for the kind of status change. Common values include: offered, confirmed, active, on_hold, extended, ended, cancelled, no_show, fall_off. [ENUM-REF-CANDIDATE: offered|confirmed|active|on_hold|extended|ended|cancelled|no_show|fall_off|pending_start — promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes field capturing any additional context, observations, or instructions associated with this status transition event. Mirrors the Bullhorn ATS/CRM note/comment field attached to status change events. Supports recruiter communication and audit trail documentation.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether automated notifications (to the candidate, client contact, or internal team) were triggered and sent as a result of this status transition. Supports communication audit trails and onboarding/offboarding workflow compliance.',
    `placement_type` STRING COMMENT 'Classification of the placement type at the time of this status transition. Denormalized here to support efficient analytics without joining to the placement record. Values: temporary, contract_to_hire (CTH), temp_to_perm, direct_hire, sow (Statement of Work).. Valid values are `temporary|contract_to_hire|temp_to_perm|direct_hire|sow`',
    `prior_status` STRING COMMENT 'The assignment status value immediately before this transition event. Together with new_status, defines the state transition vector. Common values include: offered, confirmed, active, on_hold, extended, ended, cancelled, no_show, fall_off. [ENUM-REF-CANDIDATE: offered|confirmed|active|on_hold|extended|ended|cancelled|no_show|fall_off|pending_start — promote to reference product]',
    `sequence_number` STRING COMMENT 'Monotonically increasing sequence number for status transitions within a single assignment, starting at 1 for the first transition. Enables ordered reconstruction of the full assignment status lifecycle and identification of the current (latest) status without relying on timestamp ordering alone.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this status transition occurred outside the agreed SLA (Service Level Agreement) window for the associated client program or VMS program. Enables SLA compliance tracking and client reporting for MSP/VMS programs managed through Beeline.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'The SLA target response time in hours for this specific status transition type, as defined in the clients MSA (Master Service Agreement) or VMS program configuration. Used to evaluate whether sla_breach_flag should be set.',
    `source_system` STRING COMMENT 'The operational system of record that originated this status change event. Enables data lineage tracing and reconciliation across Bullhorn ATS/CRM, Beeline VMS, SAP SuccessFactors, TempWorks, and Kronos Workforce Ready.. Valid values are `bullhorn|beeline_vms|sap_successfactors|tempworks|kronos|manual_entry`',
    `source_system_event_reference` STRING COMMENT 'The native event or record identifier from the originating source system (e.g., Bullhorn status change event ID, Beeline VMS transaction ID). Enables exact record traceability back to the system of record for audit and reconciliation purposes.',
    `transition_source` STRING COMMENT 'Indicates how the status transition was initiated. Distinguishes between manual recruiter actions, automated system rules, VMS (Vendor Management System) sync events from Beeline, API integrations, or bulk update operations. Critical for data lineage and audit integrity.. Valid values are `manual|system_automated|vms_sync|api_integration|bulk_update`',
    `transition_timestamp` TIMESTAMP COMMENT 'The exact date and time when the status transition occurred. EVENT_TIMESTAMP — the principal real-world event time for this status change. Used for TTS (Time to Start) and TTF (Time to Fill) SLA calculations and fall-off rate analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'RECORD_AUDIT_UPDATED — the date and time when this status history record was last modified in the data platform. While status history records are ideally immutable, corrections or enrichments may update this field. Supports data quality monitoring.',
    `worker_type` STRING COMMENT 'Classification of the workers employment arrangement at the time of this status transition. Values: w2_employee (W-2), 1099_contractor (independent contractor), corp_to_corp, eor (Employer of Record). Critical for IRS worker classification compliance and co-employment risk management.. Valid values are `w2_employee|1099_contractor|corp_to_corp|eor`',
    CONSTRAINT pk_assignment_status_history PRIMARY KEY(`assignment_status_history_id`)
) COMMENT 'Audit trail of all status transitions for a worker assignment throughout its lifecycle (e.g., offered → confirmed → active → extended → ended, or active → cancelled). Captures prior status, new status, transition timestamp, changed-by user, change reason code, and any associated notes. Enables SLA compliance tracking (TTF, TTS), fall-off rate analysis, and regulatory audit requirements. Supports Bullhorn status change event log.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`redeployment` (
    `redeployment_id` BIGINT COMMENT 'Unique system-generated identifier for each redeployment event record. Primary key for the redeployment data product within the placement domain. Entity role: TRANSACTION_HEADER — tracks a discrete lifecycle event of a worker transitioning off an assignment into the redeployment pipeline.',
    `bench_roster_id` BIGINT COMMENT 'Foreign key linking to placement.bench_roster. Business justification: Redeployment events often originate from bench roster entries when workers become available after assignment end. Linking redeployment to bench_roster enables tracking of bench-to-redeployment pipelin',
    `order_header_id` BIGINT COMMENT 'Reference to the specific job order (requisition) being pursued for this workers redeployment. Null until a specific job order match is identified by the coordinator.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate (worker) who is entering the redeployment pipeline. Links to the candidate master record in the Candidate domain. Serves as the PARTY_REFERENCE required for TRANSACTION_HEADER role.',
    `assignment_id` BIGINT COMMENT 'Reference to the active or recently ended placement/assignment that triggered this redeployment event. Establishes the originating assignment context for bench management tracking.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account associated with the ending assignment. Used to track which client the worker is departing from and to identify potential redeployment opportunities within the same client account.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal recruiter or staffing coordinator responsible for managing this redeployment event and driving the worker back to active placement.',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to recruitment.submittal. Business justification: Redeployment candidates reference original submittal for skills verification, client preference history, and prior RTR agreements. Essential for bench management and rapid redeployment to similar role',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Redeployment tracks original supplier for bench management, redeployment success rate metrics, and supplier obligation to assist in redeployment. Used in MSP programs where suppliers maintain responsi',
    `target_client_client_account_id` BIGINT COMMENT 'Reference to the client account being targeted for the workers next placement during the redeployment process. Null until a specific client opportunity is identified.',
    `target_placement_assignment_id` BIGINT COMMENT 'Reference to the new placement record created as the successful outcome of this redeployment event. Null until the worker is successfully redeployed to a new assignment.',
    `actual_redeploy_date` DATE COMMENT 'The date on which the worker was successfully placed on a new assignment or converted. Null until redeployment outcome is achieved. Used to calculate actual time-to-redeploy against the target.',
    `assignment_end_date` DATE COMMENT 'The actual or scheduled end date of the ending assignment that triggered this redeployment event. Used to calculate days on bench and drive proactive outreach timelines. Serves as the BUSINESS_EVENT_TIMESTAMP anchor for the redeployment lifecycle.',
    `availability_date` DATE COMMENT 'The date on which the candidate becomes fully available for a new assignment. May differ from assignment_end_date due to notice periods, PTO, or contractual obligations. Critical input for redeployment scheduling and coordinator outreach.',
    `bench_cost_risk` DECIMAL(18,2) COMMENT 'Estimated financial exposure (in pay_rate_currency) associated with the worker remaining on bench, calculated as the workers pay rate multiplied by projected bench days. Stored as a point-in-time snapshot for financial risk reporting. Confidential financial data.',
    `conversion_fee` DECIMAL(18,2) COMMENT 'Fee charged to the client when a temporary worker is converted to a permanent hire (temp-to-perm conversion). Applicable when redeployment_type is temp_to_perm. Confidential financial data tied to the MSA/contract terms.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this redeployment record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for the TRANSACTION_HEADER role. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `interviews_count` STRING COMMENT 'Number of client interviews the worker attended during this redeployment event. Used to measure conversion rate from submittal to interview and assess redeployment pipeline health.',
    `is_backfill` BOOLEAN COMMENT 'Indicates whether this redeployment event is associated with a backfill scenario, where the worker is being redeployed to replace another departing worker at the same or different client site.',
    `last_outreach_date` DATE COMMENT 'The most recent date on which the coordinator made contact or attempted contact with the worker regarding redeployment opportunities. Used to identify stale redeployment records requiring follow-up.',
    `notes` STRING COMMENT 'Free-text coordinator notes capturing context, candidate preferences, client feedback, or special circumstances relevant to this redeployment event. Supports qualitative tracking alongside structured fields.',
    `outcome` STRING COMMENT 'Final disposition of the redeployment event. redeployed = placed on new assignment; converted = temp-to-perm conversion; separated = worker left the workforce pool; extended = original assignment extended; declined = worker declined available opportunities; no_show = worker became unresponsive.. Valid values are `redeployed|converted|separated|extended|declined|no_show`',
    `outreach_attempts` STRING COMMENT 'Count of coordinator contact attempts made to the worker during the redeployment process (calls, emails, texts). Used to measure engagement effort and trigger escalation workflows when thresholds are exceeded.',
    `pay_rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the pay rate fields (e.g., USD). Supports multi-currency operations for international staffing engagements.. Valid values are `^[A-Z]{3}$`',
    `pay_rate_min` DECIMAL(18,2) COMMENT 'The minimum hourly or salary pay rate the worker is willing to accept for a new assignment. Used by coordinators to filter job orders and negotiate placements during redeployment. Confidential business data.',
    `preferred_location` STRING COMMENT 'The workers preferred geographic area or city/state for their next assignment. Free-text or structured location string used by coordinators to filter and match available job orders during redeployment outreach.',
    `preferred_work_state` STRING COMMENT 'Two-letter US state code representing the workers preferred state for redeployment. Used for geographic filtering in job order matching and workforce planning analytics.. Valid values are `^[A-Z]{2}$`',
    `preferred_work_type` STRING COMMENT 'The workers stated preference for the type of engagement on their next assignment. Guides coordinator matching and job order targeting during the redeployment process.. Valid values are `temporary|contract|temp_to_perm|direct_hire|per_diem`',
    `primary_skill` STRING COMMENT 'The workers primary professional skill or job title used as the lead matching criterion during redeployment job order search. Sourced from the candidate profile in Bullhorn ATS.',
    `priority_level` STRING COMMENT 'Coordinator-assigned urgency level for this redeployment event. critical = worker at risk of separation or has specialized skills in high demand; high = near-term bench cost risk; medium = standard pipeline; low = worker has indicated flexibility or is not immediately available.. Valid values are `critical|high|medium|low`',
    `redeployment_number` STRING COMMENT 'Externally-visible business identifier for this redeployment event, used in coordinator workflows, reporting, and communications. Format: RDP- followed by 7 digits. Serves as the BUSINESS_IDENTIFIER for the TRANSACTION_HEADER role.. Valid values are `^RDP-[0-9]{7}$`',
    `redeployment_source` STRING COMMENT 'Indicates how this redeployment record was created. bullhorn_workflow = auto-generated by Bullhorn redeployment workflow trigger; manual_entry = coordinator manually created; vms_notification = triggered by Beeline VMS assignment end notification; coordinator_initiated = proactive coordinator action; system_auto = automated rule-based creation.. Valid values are `bullhorn_workflow|manual_entry|vms_notification|coordinator_initiated|system_auto`',
    `redeployment_status` STRING COMMENT 'Current lifecycle state of the redeployment event. bench = worker is unassigned and available; in_process = active outreach and submittal activity underway; redeployed = successfully placed on a new assignment; converted = temp-to-perm conversion occurred; separated = worker exited the workforce pool. Serves as the LIFECYCLE_STATUS for the TRANSACTION_HEADER role.. Valid values are `bench|in_process|redeployed|converted|separated`',
    `redeployment_type` STRING COMMENT 'Classification of the redeployment pathway. internal_transfer = moved to another assignment within same client; new_client = placed with a different client; temp_to_perm = converted to permanent hire; contract_extension = existing assignment extended; reactivation = previously separated worker re-engaged.. Valid values are `internal_transfer|new_client|temp_to_perm|contract_extension|reactivation`',
    `remote_eligible` BOOLEAN COMMENT 'Indicates whether the worker is eligible and willing to accept a fully remote or hybrid assignment. Used to expand redeployment matching to remote job orders.',
    `separation_reason` STRING COMMENT 'Reason code for why the worker separated from the workforce pool when redeployment_outcome is separated. Used for fall-off rate analysis and workforce retention reporting. [ENUM-REF-CANDIDATE: voluntary_resignation|involuntary_termination|retirement|contract_end|declined_opportunities|no_response|other — promote to reference product]',
    `skill_category` STRING COMMENT 'Broad occupational category grouping for the workers primary skill (e.g., Information Technology, Healthcare, Light Industrial, Finance, Administrative). Used for workforce planning segmentation and bench analytics.',
    `source_system_record_reference` STRING COMMENT 'The native identifier of this redeployment record in the originating source system (Bullhorn ATS/CRM). Enables traceability back to the operational system of record for reconciliation and lineage purposes.',
    `submittals_count` STRING COMMENT 'Number of candidate submittals made to client job orders during this redeployment event. Tracks the volume of active placement attempts and supports QoS (Quality of Submission) analytics.',
    `target_redeploy_date` DATE COMMENT 'The goal date by which the coordinator aims to have the worker placed on a new assignment. Used to measure time-to-redeploy KPI performance and drive urgency in the redeployment pipeline.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this redeployment record was last modified. Serves as the RECORD_AUDIT_UPDATED field for the TRANSACTION_HEADER role. Used for incremental data pipeline processing and audit trail compliance. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `willing_to_relocate` BOOLEAN COMMENT 'Indicates whether the worker is open to relocating for a new assignment beyond their preferred location. Expands the matching pool for coordinators when set to true.',
    `worker_classification` STRING COMMENT 'The tax and employment classification of the worker for the redeployment engagement. W-2 = employee on payroll; 1099 = independent contractor; C2C = corp-to-corp; EOR = employer of record arrangement. Drives payroll, tax, and compliance handling for the new assignment.. Valid values are `W2|1099|C2C|EOR`',
    CONSTRAINT pk_redeployment PRIMARY KEY(`redeployment_id`)
) COMMENT 'Tracks redeployment events and pipeline management for workers coming off active assignments (bench management). Records the ending assignment reference, redeployment target date, redeployment status (bench, in-process, redeployed, separated), candidate availability date, preferred work type, preferred location, redeployment coordinator, days on bench, and outcome (redeployed to new assignment, converted, separated). Enables proactive bench management and reduces time-to-redeploy KPI. Sourced from Bullhorn redeployment workflow.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`backfill` (
    `backfill_id` BIGINT COMMENT 'Unique system-generated identifier for the backfill request record. Primary key for the backfill data product in the placement domain.',
    `assignment_id` BIGINT COMMENT 'Reference to the original placement assignment that triggered the backfill request. Links the backfill event to the specific assignment that ended prematurely or requires replacement.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate or worker from the original assignment who is being replaced. Used for fall-off rate monitoring, redeployment tracking, and recruiter performance analysis.',
    `backfill_replacement_assignment_id` BIGINT COMMENT 'Reference to the new placement assignment created to fulfill the backfill request. Populated once a replacement worker has been placed and the backfill is resolved. Null if backfill is still open or cancelled.',
    `backfill_replacement_candidate_profile_id` BIGINT COMMENT 'Reference to the candidate placed as the replacement worker to fulfill the backfill. Populated once a suitable replacement has been identified and placed. Null if backfill is open or cancelled.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account at which the backfill position exists. Used for SLA compliance tracking, client relationship management, and fall-off rate reporting.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order or requisition associated with the position requiring backfill. Used to link the backfill event to the originating client requirement and job details.',
    `osha_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_incident. Business justification: Backfill requests are frequently triggered by workplace injuries/OSHA recordable incidents. Business process: linking replacement staffing needs to safety incidents for root cause tracking, client sit',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to recruitment.submittal. Business justification: Backfill process tracks which submittal successfully filled replacement need for SLA compliance reporting, time-to-backfill metrics, and recruiter performance on urgent fills. Role-prefixed because or',
    `staff_profile_id` BIGINT COMMENT 'Reference to the recruiter responsible for fulfilling the backfill request. Drives recruiter workload prioritization and performance measurement for backfill resolution speed.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Backfill requests are routed to suppliers based on tier classification, allocation rules, and original supplier obligation. Tracks which supplier is responsible for filling the vacancy. Essential for ',
    `work_location_id` BIGINT COMMENT 'Reference to the client work location where the backfill position is based. Used for geographic workforce planning, dispatch coordination, and on-site supervisor notification.',
    `backfill_number` STRING COMMENT 'Externally-visible, human-readable business identifier for the backfill request. Used in client communications, SLA reporting, and recruiter workflow queues. Sourced from Bullhorn backfill workflow numbering.. Valid values are `^BKF-[0-9]{6,10}$`',
    `backfill_status` STRING COMMENT 'Current lifecycle state of the backfill request. open indicates active search for replacement; filled indicates a replacement has been placed; cancelled indicates the position was not refilled; on_hold indicates temporarily paused; escalated indicates elevated priority due to SLA risk.. Valid values are `open|filled|cancelled|on_hold|escalated`',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit bill rate charged to the client for the backfill position. Captured at the time of the backfill request to preserve the rate context for the replacement assignment and financial continuity analysis.',
    `cancelled_date` DATE COMMENT 'The date on which the backfill request was cancelled, indicating the client no longer requires a replacement worker for this position. Null if backfill was filled or remains open.',
    `client_supervisor_name` STRING COMMENT 'Name of the client-side supervisor or hiring manager responsible for the position requiring backfill. Used for direct communication during the backfill process and for on-site coordination of the replacement worker.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the backfill record was first created in the system. Serves as the audit trail creation marker and is used for data lineage, compliance reporting, and SLA measurement baseline.',
    `days_to_backfill` STRING COMMENT 'The number of calendar days elapsed between the backfill request_date and the filled_date. Key operational metric for measuring recruiter responsiveness, SLA compliance, and client service quality. Populated only when backfill_status is filled.',
    `department` STRING COMMENT 'The clients internal department or cost center where the backfill position is assigned. Used for client billing allocation, workforce planning, and headcount reporting.',
    `escalation_date` DATE COMMENT 'The date on which the backfill request was escalated to senior management or account management. Populated only when escalation_flag is True. Used to measure escalation response time and SLA risk management effectiveness.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this backfill request has been escalated to senior management or account management due to SLA risk, client dissatisfaction, or inability to fill within the required timeframe. Triggers escalation workflow notifications.',
    `fall_off_reason_category` STRING COMMENT 'High-level categorization of the root cause for the fall-off event associated with this backfill. Used for recruiter quality analysis, process improvement, and ASA fall-off rate benchmarking. Populated only when is_fall_off is True.. Valid values are `candidate_quality|client_issue|external_factor|recruiter_error|unknown`',
    `filled_date` DATE COMMENT 'The date on which the backfill request was successfully fulfilled by placing a replacement worker. Used to calculate days-to-backfill and assess SLA compliance against the required_fill_date. Null if backfill is still open or was cancelled.',
    `is_fall_off` BOOLEAN COMMENT 'Indicates whether the original assignment termination that triggered this backfill is classified as a fall-off event for recruiter performance and quality metrics. True if the assignment ended before the agreed minimum tenure threshold, contributing to the fall-off rate KPI.',
    `is_redeployment_candidate` BOOLEAN COMMENT 'Indicates whether the original worker from the terminated assignment has been flagged as a candidate for redeployment to another open assignment. Supports bench management and redeployment workflow prioritization.',
    `job_title` STRING COMMENT 'The job title or position title for the role requiring backfill. Captured directly on the backfill record to preserve the position context at the time of the backfill event, independent of any subsequent job order changes.',
    `notes` STRING COMMENT 'Free-text field for recruiter or account manager notes related to the backfill request, including candidate search progress, client communication summaries, and any special requirements for the replacement worker.',
    `original_assignment_end_date` DATE COMMENT 'The actual date the original workers assignment ended, triggering the backfill need. May differ from the originally scheduled assignment end date in cases of early termination, no-show, or injury.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit pay rate for the worker filling the backfill position. Captured at the time of the backfill request to support payroll continuity and spread/margin analysis for the replacement assignment.',
    `placement_type` STRING COMMENT 'The type of placement associated with the original assignment requiring backfill. Determines the nature of the replacement search and applicable fee structures. Aligns with the placement domains assignment classification.. Valid values are `temporary|contract_to_hire|temp_to_perm|direct_hire`',
    `priority_level` STRING COMMENT 'Business-assigned urgency level for the backfill request, used to prioritize recruiter workload and resource allocation. critical indicates immediate client impact or contractual penalty risk; high indicates SLA risk within 24-48 hours; medium and low indicate standard processing timelines.. Valid values are `critical|high|medium|low`',
    `rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the bill_rate and pay_rate fields for this backfill record. Supports multi-currency operations for international staffing engagements.. Valid values are `^[A-Z]{3}$`',
    `request_date` DATE COMMENT 'The calendar date on which the backfill request was formally initiated, typically when the original assignment termination was confirmed. Used as the start point for days-to-backfill metric calculation and SLA compliance measurement.',
    `required_fill_date` DATE COMMENT 'The target date by which the client requires the replacement worker to be on-site and active. Drives SLA compliance tracking and recruiter urgency prioritization. Typically negotiated with the client at time of backfill request.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the backfill was fulfilled within the contractually agreed SLA target days. True if filled_date is on or before required_fill_date and within sla_target_days; False otherwise. Null if backfill is still open or was cancelled.',
    `sla_target_days` STRING COMMENT 'The contractually agreed maximum number of days within which the backfill must be fulfilled per the clients Master Service Agreement (MSA) or SLA terms. Used to determine whether the backfill was completed within SLA compliance thresholds.',
    `source_system` STRING COMMENT 'The operational system of record from which this backfill record originated. Primarily Bullhorn ATS/CRM for standard backfill workflows, Beeline VMS for client-initiated VMS backfill requests, or manual for records entered outside automated workflows.. Valid values are `bullhorn|beeline|manual|other`',
    `source_system_backfill_reference` STRING COMMENT 'The native identifier for this backfill record in the originating operational system (e.g., Bullhorn internal backfill record ID). Supports data lineage, reconciliation, and cross-system traceability between the Silver layer and the system of record.',
    `trigger_detail` STRING COMMENT 'Free-text narrative providing additional context about the specific reason the original assignment ended and the backfill was initiated. Supplements the structured trigger_reason field with qualitative detail for recruiter and account manager review.',
    `trigger_reason` STRING COMMENT 'The business reason that caused the original assignment to end and necessitated the backfill request. Drives fall-off rate categorization, SLA compliance analysis, and recruiter quality metrics. [ENUM-REF-CANDIDATE: early_termination|no_show|client_request|injury|job_abandonment|performance|other — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the backfill record was most recently modified. Used for change tracking, data synchronization between source systems and the Silver layer, and audit compliance.',
    `vms_req_number` STRING COMMENT 'The requisition or work order number assigned by the clients Vendor Management System (VMS) for the backfill position. Required for VMS-managed programs to track the backfill through the clients procurement workflow in systems such as Beeline.',
    CONSTRAINT pk_backfill PRIMARY KEY(`backfill_id`)
) COMMENT 'Transactional record tracking backfill requests and fulfillment when a placed worker must be replaced on an active assignment due to early termination, no-show, client request, or injury. Records original assignment reference, backfill trigger reason, backfill request date, required fill date, backfill status (open, filled, cancelled), replacement assignment reference, and days-to-backfill metric. Drives client SLA compliance, fall-off rate monitoring, and recruiter workload prioritization. Sourced from Bullhorn assignment backfill workflow.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`rate` (
    `rate_id` BIGINT COMMENT 'Primary key for rate',
    `assignment_id` BIGINT COMMENT 'Reference to the parent placement or assignment record to which this rate applies. Links the rate to its associated job order and candidate assignment.',
    `client_rate_card_id` BIGINT COMMENT 'Reference to the client rate card from which this rate was sourced or negotiated. Links to the client.rate_card product for traceability of rate card origin.',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Rate records need to support direct hire placements in addition to temporary assignments. The rate table currently only links to assignment via assignment_id, but direct hire placements also have nego',
    `sow_engagement_id` BIGINT COMMENT 'Foreign key linking to placement.sow_engagement. Business justification: Rate records need to support SOW-based engagements. SOW placements have distinct billing structures (milestone billing, deliverable-based rates) that differ from standard temp assignments. Adding sow_',
    `vendor_rate_card_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_rate_card. Business justification: Placement rates reference negotiated vendor rate cards for bill/pay rate determination and markup validation. Ensures rate compliance with MSA terms and vendor agreements. Critical for rate card enfor',
    `approval_status` STRING COMMENT 'Current workflow approval state of this rate record. Rates must be approved before feeding payroll and billing processes. Pending indicates awaiting review; approved indicates authorized for use; rejected indicates declined; expired indicates the approval window has lapsed.. Valid values are `pending|approved|rejected|expired`',
    `approved_by` STRING COMMENT 'The name or identifier of the individual or role who approved this rate record. Supports audit trail requirements for rate governance and compliance with client SLA and MSA terms.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this rate record was formally approved. Provides a precise audit trail event for rate governance, compliance reporting, and SLA tracking.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate charged to the client for the workers services. Represents the client-facing price component used in invoicing and revenue recognition. Expressed in the applicable currency unit.',
    `burden_rate` DECIMAL(18,2) COMMENT 'The total employer-side cost loading rate applied on top of the pay rate, expressed as a decimal percentage. Encompasses FICA, FUTA, SUTA, workers compensation, and benefits costs. Used in true cost-of-labor calculations.',
    `conversion_fee` DECIMAL(18,2) COMMENT 'The one-time fee charged to the client when a temporary or contract-to-hire worker is converted to a permanent employee. Defined in the client MSA and applicable only for temp-to-perm placement types.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rate record was first created in the system. Provides the foundational audit trail entry for data lineage, compliance, and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary rate fields in this record (e.g., USD, CAD). Supports multi-currency operations for international staffing engagements.. Valid values are `^[A-Z]{3}$`',
    `direct_hire_fee_percentage` DECIMAL(18,2) COMMENT 'The percentage of the placed candidates first-year annual salary charged as the direct hire placement fee. Applicable only for direct hire and permanent placement engagements. Defined in the client MSA.',
    `dt_bill_rate` DECIMAL(18,2) COMMENT 'The hourly bill rate charged to the client for double-time hours, typically applicable on holidays or after extended daily thresholds per client contract or state law. Used in client invoicing for DT hours.',
    `dt_pay_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate for double-time hours, typically 2x the regular pay rate. Applicable per client contract terms or state-mandated double-time rules. Used in payroll processing for DT-eligible hours.',
    `effective_date` DATE COMMENT 'The date on which this rate record becomes active and applicable to payroll and billing calculations. Marks the start of the rates binding period for the associated placement.',
    `expiration_date` DATE COMMENT 'The date on which this rate record ceases to be applicable. Null indicates an open-ended rate with no defined end. Used to manage rate versioning, extensions, and contract renewals.',
    `gross_margin_percentage` DECIMAL(18,2) COMMENT 'The gross margin expressed as a percentage of the bill rate, calculated as (Spread / Bill Rate). Represents the profitability ratio for this rate record and is a primary KPI for financial reporting and account management.',
    `gsa_rate_reference` STRING COMMENT 'The IRS General Services Administration (GSA) per diem rate reference code or location identifier used to validate per diem allowances against federally published rates. Applicable for per_diem rate types to ensure IRS compliance.',
    `holiday_bill_rate` DECIMAL(18,2) COMMENT 'The hourly bill rate charged to the client for hours worked on designated holidays. Defined in the client MSA or SOW and used in holiday billing calculations.',
    `holiday_pay_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate for hours worked on designated holidays. Defined in the workers assignment terms and used in payroll processing for holiday-worked hours.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this rate record is currently active and eligible for use in payroll and billing calculations. A rate may be inactive due to expiration, supersession by a newer rate version, or manual deactivation.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this rate or per diem allowance is subject to federal and state income tax withholding. Per diem amounts at or below GSA rates are typically non-taxable; amounts exceeding GSA rates are taxable as wages.',
    `job_classification_code` STRING COMMENT 'The occupational classification code (e.g., DOL SOC code or client-defined job category code) associated with this rate. Drives workers compensation rate assignment, FLSA exemption status, and rate card categorization.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied over the pay rate to derive the bill rate, expressed as a decimal percentage (e.g., 0.35 = 35%). Used in rate negotiations, client proposals, and margin analysis reporting.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, negotiation history, special conditions, or exceptions associated with this rate record. Used by account managers and recruiters to document rate-specific business decisions.',
    `ot_bill_rate` DECIMAL(18,2) COMMENT 'The hourly bill rate charged to the client for overtime hours worked beyond the standard threshold (typically 40 hours/week under FLSA). Distinct from the standard bill rate to support accurate client invoicing for OT hours.',
    `ot_pay_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate for overtime hours, required to be at least 1.5x the regular pay rate under FLSA. Used in payroll processing for hours exceeding the standard weekly threshold.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate paid to the worker for services rendered. Represents the worker-facing compensation component used in payroll processing. Must comply with applicable minimum wage laws under FLSA.',
    `per_diem_budget_cap` DECIMAL(18,2) COMMENT 'The maximum total per diem budget authorized for this rate record over the assignment period. Used to enforce spending controls and flag overages in per diem reimbursement processing.',
    `per_diem_category` STRING COMMENT 'Sub-classification of per diem rate type indicating the specific allowance category. Applicable only when rate_type = per_diem. Aligns with IRS GSA per diem schedule categories for tax compliance and reimbursement tracking.. Valid values are `travel|lodging|meals|incidentals`',
    `per_diem_daily_allowance` DECIMAL(18,2) COMMENT 'The approved daily monetary allowance for the per diem category (travel, lodging, meals, or incidentals). Represents the maximum reimbursable or taxable daily amount for the applicable per diem category.',
    `placement_type` STRING COMMENT 'The type of placement engagement this rate record supports. Temporary covers standard temp assignments; contract_to_hire (temp-to-perm) includes conversion terms; direct_hire covers permanent placement fees; SOW (Statement of Work) covers project-based engagements.. Valid values are `temporary|contract_to_hire|direct_hire|sow`',
    `rate_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this rate record within the source system (Bullhorn, Beeline VMS, or TempWorks). Used for cross-system reconciliation and rate card referencing.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `rate_source` STRING COMMENT 'The originating system or method from which this rate record was sourced. Bullhorn indicates the ATS rate card; beeline_vms indicates the VMS rate management module; tempworks indicates the payroll per diem configuration; manual indicates a directly entered rate.. Valid values are `bullhorn|beeline_vms|tempworks|manual`',
    `rate_type` STRING COMMENT 'Classification of the rate component this record represents. Standard covers regular bill/pay rates; overtime (OT) and double-time (DT) apply to FLSA-governed hours; holiday covers premium holiday pay; per_diem covers travel/lodging/meals/incidentals allowances; burden covers employer-side cost loading. [ENUM-REF-CANDIDATE: standard|overtime|double_time|holiday|per_diem|burden — promote to reference product if additional types emerge]. Valid values are `standard|overtime|double_time|holiday|per_diem|burden`',
    `reimbursement_method` STRING COMMENT 'The method used to calculate and process per diem reimbursements. Actual expense requires receipts; flat_rate pays a fixed daily amount regardless of actual spend; gsa_rate uses the IRS GSA published rate for the work location.. Valid values are `actual_expense|flat_rate|gsa_rate`',
    `spread_amount` DECIMAL(18,2) COMMENT 'The gross dollar difference between the bill rate and the pay rate (Bill Rate minus Pay Rate). Represents the staffing firms gross revenue per hour before burden costs. A key profitability metric tracked at the placement level.',
    `unit` STRING COMMENT 'The time or work unit basis for the bill and pay rates. Hourly is standard for temporary staffing; daily/weekly/monthly may apply to contract or SOW engagements; fixed applies to direct hire placement fees.. Valid values are `hourly|daily|weekly|monthly|fixed`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this rate record was most recently modified. Used for change tracking, data synchronization across systems, and audit compliance.',
    `version_number` STRING COMMENT 'Sequential version number for this rate record, incremented each time the rate is renegotiated or updated. Supports rate versioning and historical rate tracking for audit and analytics purposes.',
    `vms_rate_reference` STRING COMMENT 'The external rate identifier assigned by the Beeline VMS system for this rate record. Used for cross-system reconciliation between the staffing firms internal systems and the clients VMS program.',
    `work_state_code` STRING COMMENT 'Two-letter US state code for the state where the work is performed. Determines applicable SUTA rate, state minimum wage compliance, workers compensation jurisdiction, and state income tax withholding rules.. Valid values are `^[A-Z]{2}$`',
    `workers_comp_rate` DECIMAL(18,2) COMMENT 'The workers compensation insurance rate applied to this placement, expressed as a decimal percentage of payroll. Varies by job classification code and state. Used in burden rate calculation and insurance cost allocation.',
    CONSTRAINT pk_rate PRIMARY KEY(`rate_id`)
) COMMENT 'Master record for all negotiated rate components associated with a specific assignment or direct hire placement. Each rate record represents a single rate type — standard bill/pay rate, overtime (OT), double-time (DT), holiday, per diem (travel, lodging, meals, incidentals), or burden rate. Tracks effective date, expiration date, rate type, bill rate amount, pay rate amount, spread amount, markup percentage, gross margin percentage, burden rate, workers comp rate, IRS GSA rate reference (for per diem), taxable flag, reimbursement method, per diem daily allowance, per diem budget cap, rate approval status, and rate card source. Serves as the SSOT for all placement-level rate and per diem data feeding payroll and billing domains. Per diem rate types include travel, lodging, meals, and incidentals with IRS GSA compliance tracking. Sourced from Bullhorn rate card, Beeline VMS rate management, and TempWorks Payroll per diem configuration.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`work_location` (
    `work_location_id` BIGINT COMMENT 'Unique surrogate identifier for the work location record. Primary key for the work_location master resource in the placement domain. MASTER_RESOURCE role — canonical entity representing a physical or virtual site where placed workers perform assignments.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that owns or operates this work location. Links the physical or virtual site to the client relationship for billing, SLA measurement, and workforce planning.',
    `credential_requirement_id` BIGINT COMMENT 'Foreign key linking to credentialing.credential_requirement. Business justification: Work locations impose location-specific credential requirements (state licenses for multi-state operations, federal clearances for government sites, facility-specific training for healthcare). Links l',
    `ofccp_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.ofccp_compliance. Business justification: OFCCP compliance audits and affirmative action plans are establishment-specific. Work locations (client sites) must map to OFCCP audit records for federal contractor compliance tracking, AAP coverage ',
    `ot_rule_id` BIGINT COMMENT 'Reference to the overtime rule applicable to workers at this location, as defined in the timesheet.ot_rule product. Overtime rules vary by state (e.g., California daily OT, federal weekly OT) and are driven by the work locations jurisdiction.',
    `location_id` BIGINT COMMENT 'Reference to the client.location master record representing the clients own site definition. Enables cross-domain linkage between the placement work location and the client domains location hierarchy.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: VMS programs and MSPs often define location-specific SLAs for time-to-fill, fill rates, and quality metrics. Staffing operations track performance against location-level SLAs for scorecard reporting a',
    `vms_enrollment_id` BIGINT COMMENT 'Foreign key linking to vendor.vms_enrollment. Business justification: Work locations in VMS programs may restrict requisition visibility to enrolled suppliers only. Links location-specific supplier access rules for compliance and workflow routing. Used in VMS systems to',
    `address_line1` STRING COMMENT 'Primary street address of the work location (street number and street name). Required for on-site and hybrid locations for dispatch, workers compensation jurisdiction, and OSHA incident reporting.',
    `address_line2` STRING COMMENT 'Secondary address detail for the work location such as suite, floor, building, or unit number. Supplements address_line1 for precise dispatch and onboarding instructions.',
    `bgc_level` STRING COMMENT 'Required background check (BGC) level for workers placed at this location, as defined by the clients site security policy. Drives the Sterling Background Check screening package selection during candidate onboarding.. Valid values are `basic|standard|enhanced|federal`',
    `city` STRING COMMENT 'City in which the work location is situated. Used for tax jurisdiction determination, workers compensation rate assignment, SUTA/FUTA reporting, and labor law compliance (e.g., local minimum wage, paid sick leave ordinances).',
    `closure_date` DATE COMMENT 'Date on which this work location was permanently closed or decommissioned. Null for active locations. Used to enforce assignment eligibility rules and to support historical workforce analytics.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the work location (e.g., USA, CAN, GBR). Required for international staffing operations, GDPR applicability determination, and multi-country payroll compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work location record was first created in the system of record. Supports data lineage, audit trail, and SOC 2 Type II compliance requirements.',
    `current_headcount` STRING COMMENT 'Current number of active placed workers assigned to this work location. Maintained as a near-real-time operational count for capacity monitoring and workforce planning dashboards. Not a calculated aggregate — sourced directly from the placement system of record.',
    `dress_code` STRING COMMENT 'Required dress code or attire standard for workers at this location. Communicated to candidates during onboarding and placement. Drives PPE and uniform provisioning requirements for industrial and healthcare placements.. Valid values are `business_formal|business_casual|smart_casual|casual|safety_ppe|uniform_required`',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether a pre-placement or ongoing drug screening is required for workers assigned to this location. Triggers the drug screen workflow in Sterling Background Check during candidate onboarding.',
    `effective_date` DATE COMMENT 'Date on which this work location became or becomes operationally active and eligible to receive worker placements. Used for historical tracking and to prevent assignments to locations not yet open.',
    `federal_contractor_flag` BOOLEAN COMMENT 'Indicates whether this work location is subject to OFCCP federal contractor compliance requirements (Executive Order 11246, Section 503, VEVRAA). When true, affirmative action plan obligations and OFCCP audit readiness requirements apply to placements at this site.',
    `i9_verification_method` STRING COMMENT 'Method required for I-9 Employment Eligibility Verification for workers at this location. Physical requires in-person document inspection; remote_authorized uses DHS-authorized remote verification; e_verify triggers E-Verify case creation. Drives compliance workflow in the compliance domain.. Valid values are `physical|remote_authorized|e_verify`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the work location in decimal degrees (WGS 84). Enables geospatial analytics, proximity-based candidate matching, and mobile dispatch verification.',
    `location_code` STRING COMMENT 'Externally-known, human-readable unique business identifier for the work location (e.g., CHI-LOOP-01, NYC-MIDTOWN-02). Used in job orders, placements, and VMS programs to reference the site without relying on the surrogate key. Sourced from Bullhorn ATS/CRM and Beeline VMS site codes.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `location_name` STRING COMMENT 'Full descriptive name of the work location as recognized by the client and staffing operations (e.g., Acme Corp — Chicago Loop Office, Remote — Pacific Time Zone). Used in placement records, dispatch, and scheduling.',
    `location_status` STRING COMMENT 'Current lifecycle status of the work location record. Active locations are eligible for new placements and assignments. Inactive or closed locations are retained for historical reporting but cannot receive new assignments.. Valid values are `active|inactive|pending|closed|suspended`',
    `location_type` STRING COMMENT 'Classification of the work location by operational mode and physical nature. Drives scheduling, dispatch, per diem eligibility, and remote-work compliance rules. [ENUM-REF-CANDIDATE: on_site|remote|hybrid|client_site|dispatch_center|warehouse|field|data_center — promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the work location in decimal degrees (WGS 84). Used alongside latitude for geospatial workforce analytics and candidate-to-site distance calculations.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code representing the primary industry activity performed at this work location. Used for OSHA recordkeeping, EEOC reporting, OFCCP compliance, and labor market benchmarking.. Valid values are `^[0-9]{6}$`',
    `notes` STRING COMMENT 'Free-text operational notes about the work location, including special access instructions, safety requirements, client-specific onboarding details, or dispatch guidance. Visible to recruiters and account managers in Bullhorn ATS/CRM.',
    `osha_establishment_number` STRING COMMENT 'OSHA-assigned establishment identifier for this work location, required for OSHA 300 Log injury and illness recordkeeping. Enables regulatory reporting of workplace incidents per 29 CFR 1904.',
    `parking_available` BOOLEAN COMMENT 'Indicates whether parking is available at or near the work location. Relevant for candidate placement decisions, onboarding instructions, and per diem or transportation allowance eligibility.',
    `per_diem_eligible` BOOLEAN COMMENT 'Indicates whether workers assigned to this location are eligible for per diem allowances (meals, lodging, incidentals) based on IRS GSA rate tables and distance-from-home criteria. Drives per diem claim processing in TempWorks Payroll.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the work location. Used for geographic labor market analysis, per diem eligibility determination, and tax jurisdiction mapping.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `public_transit_accessible` BOOLEAN COMMENT 'Indicates whether the work location is accessible via public transportation. Used in candidate matching and placement decisions, particularly for light industrial and clerical placements where transportation access affects fill rates.',
    `remote_work_type` STRING COMMENT 'Designates whether the work location supports fully remote, hybrid (partial on-site), or exclusively on-site work arrangements. Drives per diem eligibility, equipment provisioning, and remote-work compliance policy application.. Valid values are `fully_remote|hybrid_remote|not_remote`',
    `shift_pattern` STRING COMMENT 'Primary shift pattern or schedule type supported at this work location. Used by Kronos Workforce Ready for scheduling, overtime rule application, and shift differential pay calculation.. Valid values are `day|evening|night|rotating|split|flexible`',
    `site_contact_email` STRING COMMENT 'Email address for the primary on-site client contact at this work location. Used for timesheet approval notifications, onboarding coordination, and SLA communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `site_contact_name` STRING COMMENT 'Name of the primary on-site client contact or supervisor responsible for the work location. Used by recruiters and account managers for day-to-day placement coordination and issue escalation. Not a direct personal identifier in the PII sense as it is a business role reference.',
    `site_contact_phone` STRING COMMENT 'Phone number for the primary on-site client contact at this work location. Used for dispatch coordination, emergency contact, and worker check-in procedures.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `state_province` STRING COMMENT 'Two-letter US state or Canadian province code for the work location. Drives state-level tax withholding, workers compensation classification, SUTA rates, and state-specific labor law compliance (e.g., California AB5, NY WARN Act).. Valid values are `^[A-Z]{2}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the work location (e.g., America/Chicago, America/New_York). Used by Kronos Workforce Ready for shift scheduling, overtime calculation, and timesheet validation to ensure correct local-time interpretation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this work location record was most recently modified. Used for incremental data pipeline processing, change data capture, and audit trail maintenance in the Databricks Silver Layer.',
    `vms_site_reference` STRING COMMENT 'External site identifier assigned by the clients Vendor Management System (e.g., Beeline VMS) for this work location. Required for VMS-managed programs to match staffing agency location records with the clients VMS site master.',
    `worker_capacity` STRING COMMENT 'Maximum number of placed workers (headcount) that this work location can accommodate at any given time. Used for capacity planning, workforce scheduling, and headcount management in Kronos Workforce Ready and Power BI Analytics.',
    `workers_comp_class_code` STRING COMMENT 'NCCI (National Council on Compensation Insurance) four-digit workers compensation classification code applicable to work performed at this location. Drives workers comp premium calculation in TempWorks Payroll and ensures correct insurance coverage for placed workers.. Valid values are `^[0-9]{4}$`',
    CONSTRAINT pk_work_location PRIMARY KEY(`work_location_id`)
) COMMENT 'Master record for physical or virtual work locations where placed workers perform their assignments, including dispatch and scheduling locations. Tracks location name, address, client site details, remote/hybrid designation, and capacity planning attributes.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`supervisor` (
    `supervisor_id` BIGINT COMMENT 'Unique system-generated identifier for the client-side supervisor or hiring manager record in the placement domain. Primary key for this master party entity.',
    `client_account_id` BIGINT COMMENT 'Reference to the client company (account) that employs this supervisor. Links the supervisor to the client master record for reporting and relationship management.',
    `client_contact_id` BIGINT COMMENT 'The native contact record identifier from Bullhorn ATS/CRM corresponding to this supervisor. Used for system-of-record traceability and bi-directional sync.',
    `nda_id` BIGINT COMMENT 'Foreign key linking to contract.nda. Business justification: Client supervisors receive candidate resumes and assignment details pre-placement, requiring NDAs to protect candidate confidentiality and staffing firm trade secrets. Compliance teams verify NDA stat',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: On-site supervisors may be supplier employees (not client employees) in some MSP/on-premise management models. Tracks supplier responsibility for supervision and timesheet approval authority. Used in ',
    `work_location_id` BIGINT COMMENT 'Reference to the physical or virtual work location where this supervisor oversees placed workers. Used for assignment routing, onboarding coordination, and site-level reporting.',
    `assignment_checkin_contact` BOOLEAN COMMENT 'Indicates whether this supervisor is designated to receive assignment check-in communications (e.g., weekly or mid-assignment quality check calls from the staffing account manager). Supports QoS (Quality of Submission) and SLA monitoring.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether the client requires a background check (BGC) to be completed for workers assigned to this supervisors team or site. Drives Sterling Background Check initiation rules during candidate onboarding.',
    `cost_center_code` STRING COMMENT 'Client-provided cost center code associated with this supervisors department or team. Used for billing allocation, invoice line-item coding, and client financial reporting in Oracle NetSuite ERP.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this supervisor record was first created in the system. Supports audit trail, data lineage, and GDPR/CCPA record-keeping requirements.',
    `current_active_assignments` STRING COMMENT 'The current count of active placed worker assignments under this supervisors oversight. Maintained as an operational snapshot field sourced from Bullhorn. Used for capacity monitoring and assignment routing decisions. Not a calculated aggregate — sourced directly from the system of record.',
    `department` STRING COMMENT 'The client-side department or business unit that the supervisor belongs to (e.g., Engineering, Warehouse Operations, Finance). Used for workforce planning, headcount reporting, and assignment segmentation.',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether the client requires a pre-placement drug screen for workers assigned to this supervisors team or site. Drives drug screening workflow initiation in Sterling Background Check during candidate onboarding.',
    `effective_end_date` DATE COMMENT 'The date on which this supervisor record was deactivated or the supervisors oversight responsibility ended. Null for currently active supervisors. Used for historical reporting and assignment backfill triggers.',
    `effective_start_date` DATE COMMENT 'The date from which this supervisor record became operationally active and eligible to oversee placed workers. Used for historical assignment analysis and supervisor tenure reporting.',
    `email` STRING COMMENT 'Primary business email address of the supervisor. Used for timesheet approval notifications, onboarding coordination, assignment check-in scheduling, and performance escalation communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given (first) name of the client-side supervisor or hiring manager. Used for personalized communication, onboarding coordination, and day-one contact.',
    `full_name` STRING COMMENT 'Concatenated full display name of the supervisor (e.g., Jane M. Smith). Stored as sourced from Bullhorn for display in assignment records, timesheet approvals, and client-facing documents.',
    `i9_verification_contact` BOOLEAN COMMENT 'Indicates whether this supervisor is designated as the authorized representative to physically inspect I-9 (Employment Eligibility Verification) documents for workers at the client site, as permitted under INA regulations.',
    `language_preference` STRING COMMENT 'ISO 639-1 two-letter language code representing the supervisors preferred communication language (e.g., en, es, fr). Used for localized communication templates in multilingual workforce programs.',
    `last_name` STRING COMMENT 'Family (last) name of the client-side supervisor or hiring manager. Combined with first_name to form the full display name for assignment records and timesheet routing.',
    `max_direct_reports` STRING COMMENT 'The maximum number of placed workers (temporary or contract) this supervisor is authorized or operationally capable of overseeing simultaneously. Used for workforce planning, headcount capacity management, and assignment routing constraints.',
    `mobile_phone` STRING COMMENT 'Mobile phone number for the supervisor, used for urgent same-day contact, SMS-based timesheet reminders, and on-site coordination for temporary worker dispatch.. Valid values are `^+?[1-9]d{1,14}$`',
    `msp_program_flag` BOOLEAN COMMENT 'Indicates whether this supervisor operates within a clients MSP (Managed Service Provider) contingent workforce program. When True, additional VMS-based approval workflows and MSP compliance requirements apply to assignments under this supervisor.',
    `nda_on_file` BOOLEAN COMMENT 'Indicates whether a signed Non-Disclosure Agreement (NDA) is on file for this supervisor in the contract management system. Relevant for supervisors overseeing workers in sensitive or proprietary client environments.',
    `notes` STRING COMMENT 'Free-text operational notes about the supervisor, including communication preferences, special instructions for placed workers, site access requirements, or relationship context captured by the staffing account manager.',
    `onboarding_contact` BOOLEAN COMMENT 'Indicates whether this supervisor serves as the primary day-one onboarding contact for newly placed workers at the work location. When True, the supervisor receives onboarding coordination communications and is listed on worker day-one instructions.',
    `performance_escalation_contact` BOOLEAN COMMENT 'Indicates whether this supervisor is the designated point of contact for worker performance escalations, disciplinary issues, or early assignment termination discussions. Used in fall-off risk management workflows.',
    `phone` STRING COMMENT 'Primary business phone number for the supervisor. Used for day-one onboarding calls, assignment check-ins, and urgent escalation contact.. Valid values are `^+?[1-9]d{1,14}$`',
    `preferred_contact_method` STRING COMMENT 'The supervisors preferred channel for receiving communications from the staffing agency (e.g., timesheet reminders, assignment updates, escalation notices). Drives communication routing logic.. Valid values are `email|phone|mobile|vms_portal|text`',
    `safety_orientation_required` BOOLEAN COMMENT 'Indicates whether workers assigned to this supervisors site must complete a safety orientation before beginning work. Relevant for industrial, manufacturing, and warehouse placements subject to OSHA compliance requirements.',
    `secondary_email` STRING COMMENT 'Alternate email address for the supervisor, used when the primary email is unavailable or for specific communication workflows such as VMS notifications or backup timesheet routing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this supervisor record was sourced. Supports data lineage, audit traceability, and ETL reconciliation in the Databricks Silver Layer.. Valid values are `bullhorn|beeline|manual|salesforce|successfactors`',
    `source_system_contact_reference` STRING COMMENT 'The native record identifier for this supervisor in the originating source system (e.g., Bullhorn contact ID, Beeline hiring manager ID). Used for bi-directional sync, deduplication, and cross-system reconciliation.',
    `sow_authority_flag` BOOLEAN COMMENT 'Indicates whether this supervisor has authority to approve or manage Statement of Work (SOW) engagements in addition to standard temporary staffing assignments. Relevant for project-based and professional services placements.',
    `supervisor_status` STRING COMMENT 'Current lifecycle status of the supervisor record. Active supervisors are eligible for assignment routing and timesheet approval. Inactive or terminated supervisors are excluded from new assignment workflows. Supports MASTER_PARTY lifecycle tracking.. Valid values are `active|inactive|on_leave|terminated`',
    `supervisor_type` STRING COMMENT 'Categorical classification of the supervisors role in overseeing placed workers. Drives routing logic for timesheet approvals, performance escalations, and onboarding workflows. Values: direct_manager (day-to-day line manager), site_supervisor (physical site oversight), project_lead (project-scoped oversight), department_head (department-level authority), vms_manager (VMS program manager).. Valid values are `direct_manager|site_supervisor|project_lead|department_head|vms_manager`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the supervisors work location (e.g., America/New_York, America/Chicago). Used for scheduling timesheet approval deadlines, onboarding calls, and assignment check-in windows across multi-region programs.',
    `timesheet_approval_authority` BOOLEAN COMMENT 'Indicates whether this supervisor has authority to approve worker timesheets. When True, the supervisor is included in timesheet routing workflows in Kronos Workforce Ready and VMS timesheet sync. Critical for payroll processing accuracy.',
    `title` STRING COMMENT 'Official job title of the supervisor at the client organization (e.g., Operations Manager, Site Supervisor, Project Lead). Used for escalation routing and client relationship context.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this supervisor record was last modified. Used for change detection, incremental ETL processing, and audit trail maintenance in the Databricks Silver Layer.',
    `vms_contact_flag` BOOLEAN COMMENT 'Indicates whether this supervisor has an active profile in the clients VMS (Vendor Management System) such as Beeline. When True, the supervisors VMS user ID is used for electronic timesheet approval and requisition management.',
    `vms_user_reference` STRING COMMENT 'The supervisors user identifier within the clients VMS platform (e.g., Beeline). Used for electronic timesheet routing, requisition approval, and VMS-to-ATS data synchronization.',
    CONSTRAINT pk_supervisor PRIMARY KEY(`supervisor_id`)
) COMMENT 'Master record for the client-side supervisor or hiring manager who directly oversees placed workers at a work location. Tracks supervisor full name, title, email, phone, client company reference, work location reference, supervisor type (direct manager, site supervisor, project lead), timesheet approval authority flag, onboarding contact flag, and active status. This is the operational assignment supervision relationship — distinct from the client contact master in the client domain. Used for timesheet routing, performance escalation, day-one onboarding coordination, and assignment check-in scheduling. Sourced from Bullhorn contact and assignment supervisor fields.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`fall_off` (
    `fall_off_id` BIGINT COMMENT 'Unique surrogate identifier for the fall-off event record. Primary key for the placement.fall_off data product in the Databricks Silver Layer.',
    `backfill_id` BIGINT COMMENT 'Foreign key linking to placement.backfill. Business justification: Fall-off events (when a placed candidate leaves or is removed from an assignment) often trigger backfill requests to replace the worker. Linking fall_off to the resulting backfill record enables track',
    `client_account_id` BIGINT COMMENT 'Reference to the client account associated with the placement that fell off. Used for client SLA compliance monitoring and fall-off rate reporting by client.',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement governing the client engagement under which this placement was made. Determines guarantee period terms, replacement obligations, and fee credit provisions.',
    `office_location_id` BIGINT COMMENT 'Reference to the staffing branch or business unit that owned the placement. Enables fall-off rate reporting by branch for operational performance management.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) associated with the placement that fell off. Enables fall-off analysis by job order and position type.',
    `assignment_id` BIGINT COMMENT 'Reference to the originating placement record from which this fall-off event was triggered. Links the fall-off to the parent placement lifecycle.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the recruiter accountable for the placement that fell off. Core to recruiter accountability KPI tracking and fall-off rate performance measurement.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate who fell off the assignment or direct hire placement. Used for fall-off rate analytics and recruiter accountability.',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: Early terminations within guarantee period may result from or trigger regulatory violations (misclassification, wage-hour violations, discrimination). Links fall-offs to compliance incidents for root ',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to recruitment.submittal. Business justification: Fall-off tracking requires original submittal reference for guarantee period calculations per MSA, replacement obligation determination, and recruiter quality-of-submission scoring. Critical for clien',
    `assignment_start_date` DATE COMMENT 'The date the candidate began the assignment or direct hire placement that subsequently fell off. Used to calculate days-to-fall-off and assess early fall-off patterns.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit bill rate charged to the client for the temporary or contract placement that fell off. Used to calculate lost billing revenue impact for temporary assignments.',
    `bullhorn_fall_off_reference` STRING COMMENT 'The native identifier of this fall-off event record in the Bullhorn ATS/CRM source system. Used for data lineage, reconciliation, and cross-system traceability.',
    `client_notified_date` DATE COMMENT 'The date on which the client was formally notified of the fall-off event. Used for SLA compliance measurement and client relationship management.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fall-off event record was first created in the data platform. Audit trail field for data governance and SOC 2 compliance.',
    `days_to_fall_off` STRING COMMENT 'Number of calendar days between the assignment start date and the fall-off date. Core KPI metric for fall-off rate analysis, early warning detection, and recruiter performance benchmarking.',
    `escalation_date` DATE COMMENT 'The date on which this fall-off event was escalated to management. Populated only when escalation_flag is True.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this fall-off event has been escalated to management due to client impact, SLA breach risk, or strategic account sensitivity.',
    `fall_off_date` DATE COMMENT 'The actual calendar date on which the candidate left or was removed from the assignment or direct hire placement. The principal business event date for this transaction. Used to calculate days-to-fall-off and guarantee period compliance.',
    `fall_off_number` STRING COMMENT 'Human-readable business reference number for the fall-off event (e.g., FO-2024-00123). Used in client communications, SLA reporting, and operational tracking.',
    `fall_off_status` STRING COMMENT 'Current workflow status of the fall-off event record. Drives operational queues for replacement fulfillment and SLA compliance tracking.. Valid values are `open|confirmed|replacement_in_progress|closed|cancelled`',
    `fee_credit_amount` DECIMAL(18,2) COMMENT 'The placement fee credit or refund amount issued to the client as a result of the fall-off occurring within the guarantee period. Applicable primarily to direct hire and permanent placements.',
    `guarantee_period_days` STRING COMMENT 'Number of calendar days in the contractual guarantee period for this placement as defined in the client MSA or rate card. Determines whether the fall-off triggers a replacement obligation or fee credit.',
    `job_title` STRING COMMENT 'The job title of the position for the placement that fell off. Used for fall-off pattern analysis by role type and for replacement requisition creation.',
    `msp_program_flag` BOOLEAN COMMENT 'Indicates whether the placement that fell off was part of a Managed Service Provider (MSP) contingent workforce program. Affects fall-off reporting obligations and SLA measurement.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit pay rate for the candidate in the placement that fell off. Used alongside bill rate to assess gross margin impact of the fall-off event.',
    `placement_fee_amount` DECIMAL(18,2) COMMENT 'The original placement fee billed to the client for the placement that fell off. Used to calculate fee credit amounts and net revenue impact for direct hire and permanent placements.',
    `placement_type` STRING COMMENT 'Classification of the placement that fell off. Determines guarantee period applicability, replacement obligation rules, and conversion fee impact calculations.. Valid values are `temporary|contract_to_hire|temp_to_perm|direct_hire|permanent`',
    `reason_code` STRING COMMENT 'Standardized reason code categorizing why the fall-off occurred. Drives root-cause analysis, recruiter coaching, and client SLA compliance reporting. Values: candidate_quit (voluntary resignation), client_termination (client-initiated removal), no_show (candidate never reported), performance (performance-related removal), personal (personal circumstances), other.. Valid values are `candidate_quit|client_termination|no_show|performance|personal|other`',
    `reason_detail` STRING COMMENT 'Free-text narrative providing additional context beyond the standardized reason code. Captures recruiter or account manager notes on the specific circumstances of the fall-off.',
    `redeployment_candidate_flag` BOOLEAN COMMENT 'Indicates whether the candidate who fell off has been identified as a candidate for redeployment to another open assignment. Supports bench management and redeployment workflow.',
    `replacement_deadline` DATE COMMENT 'The contractual deadline by which a replacement candidate must be placed to fulfill the replacement obligation. Derived from the fall-off date and MSA replacement terms. Critical for client SLA compliance.',
    `replacement_fulfilled_date` DATE COMMENT 'The date on which the replacement candidate successfully started the assignment, fulfilling the replacement obligation. Used to measure replacement cycle time and SLA compliance.',
    `replacement_obligation` BOOLEAN COMMENT 'Indicates whether the staffing firm is contractually obligated to provide a replacement candidate at no additional fee due to the fall-off occurring within the guarantee period.',
    `replacement_status` STRING COMMENT 'Current status of the replacement fulfillment obligation for this fall-off event. Tracks whether a replacement has been sourced, placed, or if the obligation was waived or failed.. Valid values are `not_required|pending|in_progress|fulfilled|failed|waived`',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'The gross revenue amount lost or at risk due to this fall-off event, expressed in the billing currency. For direct hire placements, represents the placement fee at risk. For temporary placements, represents estimated lost billing revenue. Critical for financial impact reporting.',
    `revenue_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the revenue impact amount (e.g., USD, CAD, GBP). Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this fall-off event record was sourced. Supports data lineage and reconciliation in the Silver Layer.. Valid values are `bullhorn|manual|vms_import|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fall-off event record was last modified in the data platform. Audit trail field for change tracking and data governance compliance.',
    `vms_req_number` STRING COMMENT 'The requisition number from the clients Vendor Management System (VMS) associated with the placement that fell off. Required for VMS-managed programs to report fall-off events back to the clients MSP/VMS platform.',
    `within_guarantee_period` BOOLEAN COMMENT 'Indicates whether the fall-off occurred within the contractual guarantee period (True) or after it expired (False). Determines replacement obligation and revenue impact applicability.',
    `work_location_type` STRING COMMENT 'Classification of the work arrangement for the placement that fell off. Used to analyze fall-off patterns by work modality.. Valid values are `on_site|remote|hybrid`',
    CONSTRAINT pk_fall_off PRIMARY KEY(`fall_off_id`)
) COMMENT 'Transactional record capturing fall-off events where a placed candidate leaves or is removed from an assignment or direct hire within the guarantee period. Tracks fall-off date, fall-off reason code (candidate quit, client termination, no-show, performance, personal), days-to-fall-off, guarantee period days, replacement obligation flag, replacement deadline, replacement status, revenue impact amount, and recruiter accountability reference. Critical for fall-off rate KPI monitoring and client SLA compliance. Sourced from Bullhorn placement fall-off workflow.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` (
    `sow_engagement_id` BIGINT COMMENT 'Primary key for sow_engagement',
    `client_account_id` BIGINT COMMENT 'Reference to the client organization that issued or owns this SOW engagement. Links to the client account master record.',
    `envelope_id` BIGINT COMMENT 'The DocuSign envelope identifier for the executed SOW document. Enables direct linkage to the signed contract in DocuSign CLM for audit, compliance, and legal reference purposes.',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: SOW-based engagements with independent contractors require IC agreements to mitigate co-employment risk and establish proper worker classification. Staffing firms track IC agreement status to ensure c',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement (MSA) under which this SOW engagement operates. The MSA establishes the overarching commercial terms; the SOW defines the specific deliverable scope.',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: SOW contractors require onboarding (I9, BGC, client-specific training, equipment) distinct from contingent assignments. Staffing operations must verify onboarding completion before engagement_start_da',
    `order_header_id` BIGINT COMMENT 'Reference to the originating job order or requisition that this SOW engagement fulfills. Links to the job order master record.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal recruiter responsible for sourcing and placing the worker on this SOW engagement. Used for recruiter performance analytics, commission tracking, and placement attribution.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate or worker engaged under this SOW. Links to the candidate master record in the Candidate domain. Serves as the PARTY_REFERENCE for this transaction.',
    `readiness_status_id` BIGINT COMMENT 'Foreign key linking to credentialing.readiness_status. Business justification: SOW engagements (independent contractor placements) require credential verification for client compliance and co-employment risk mitigation. Links IC engagement to readiness evaluation for MSA-driven ',
    `right_to_represent_id` BIGINT COMMENT 'Foreign key linking to candidate.right_to_represent. Business justification: SOW engagements (statement of work placements) require RTR authorization similar to contingent and direct hire placements. Linking to RTR provides compliance audit trail, validates submission authoriz',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: SOW-based placements are delivered by suppliers under statement-of-work contracts. Tracks supplier for SOW performance management, milestone billing, and independent contractor compliance. Critical fo',
    `vms_program_id` BIGINT COMMENT 'Reference to the Managed Service Provider (MSP) or Vendor Management System (VMS) program under which this SOW engagement is managed, if applicable.',
    `sow_id` BIGINT COMMENT 'The native SOW record identifier assigned by the Beeline VMS system for this engagement. Used for cross-system reconciliation between the Databricks Silver Layer and the Beeline VMS SOW module.',
    `work_location_id` BIGINT COMMENT 'Reference to the physical or virtual work location where the SOW engagement is performed.',
    `worker_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.worker_classification. Business justification: SOW/independent contractor engagements require worker classification determination to assess co-employment risk and ensure proper W2 vs 1099 classification. Critical for IRS/DOL compliance and misclas',
    `actual_end_date` DATE COMMENT 'The actual date the SOW engagement concluded, which may differ from the contractual engagement_end_date due to early termination, extension, or scope completion. Null if engagement is still active.',
    `bgc_status` STRING COMMENT 'Status of the background check (BGC) requirement for the worker on this SOW engagement. Sourced from Sterling Background Check system. Used for compliance credentialing and onboarding verification.. Valid values are `not_required|pending|passed|failed|expired`',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit bill rate charged to the client for the worker under this SOW engagement, where applicable (primarily for time-and-materials SOW types). Used for spread and gross margin calculations.',
    `co_employment_risk_level` STRING COMMENT 'Assessed co-employment risk level for this SOW engagement based on the degree of client control over the worker. Used by compliance teams to monitor joint employment exposure. low = minimal client direction; medium = some client oversight; high = significant client control; critical = requires immediate legal review.. Valid values are `low|medium|high|critical`',
    `co_employment_risk_notes` STRING COMMENT 'Free-text notes from the compliance team documenting the basis for the co-employment risk assessment, specific risk factors identified, and any mitigation actions taken for this SOW engagement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SOW engagement record was first created in the system. Serves as the RECORD_AUDIT_CREATED for this transaction. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this SOW engagement record (e.g., USD, CAD, GBP). Completes the MONETARY_TRIPLET alongside total_sow_value and invoiced_amount.. Valid values are `^[A-Z]{3}$`',
    `deliverable_description` STRING COMMENT 'Narrative description of the primary deliverables, outcomes, or scope of work defined in the SOW. Captures the key work products the worker or vendor is contracted to produce. Sourced from the executed SOW document in DocuSign CLM.',
    `department` STRING COMMENT 'The client department or business unit that the SOW engagement serves. Used for client-side cost allocation, workforce planning analytics, and headcount reporting.',
    `engagement_end_date` DATE COMMENT 'The contractually agreed date on which the SOW engagement is scheduled to conclude. Serves as the EFFECTIVE_UNTIL for this placement record. Nullable for open-ended engagements. Used for redeployment planning and assignment lifecycle management.',
    `engagement_start_date` DATE COMMENT 'The contractually agreed date on which the SOW engagement commences. Serves as the EFFECTIVE_FROM and BUSINESS_EVENT_TIMESTAMP for this placement record. Used for assignment tracking, billing period calculation, and compliance reporting.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the SOW engagement. Tracks the operational state from initial drafting through completion or termination. Serves as the LIFECYCLE_STATUS for this transaction. draft = not yet executed; active = currently in progress; completed = deliverables fulfilled; terminated = ended before completion; on_hold = temporarily paused.. Valid values are `draft|active|completed|terminated|on_hold`',
    `engagement_type` STRING COMMENT 'Classification of the SOW engagement by billing and delivery structure. fixed_price = total price agreed upfront for defined deliverables; time_and_materials = billed on actual hours and costs; milestone_based = payments tied to deliverable milestones; retainer = recurring fixed fee for ongoing availability.. Valid values are `fixed_price|time_and_materials|milestone_based|retainer`',
    `extension_count` STRING COMMENT 'Number of times this SOW engagement has been extended beyond its original engagement_end_date. Used for assignment lifecycle analytics, client relationship management, and redeployment planning.',
    `fall_off_date` DATE COMMENT 'The date on which the fall-off event occurred for this SOW engagement. Populated only when fall_off_flag is True. Used for fall-off rate calculation and placement quality reporting.',
    `fall_off_flag` BOOLEAN COMMENT 'Indicates whether this SOW engagement experienced a fall-off event — where the worker departed or the engagement was terminated prematurely before the contracted end date. Used for fall-off rate KPI monitoring and recruiter performance analytics.',
    `fall_off_reason` STRING COMMENT 'Categorized reason for the fall-off event on this SOW engagement. Used for root cause analysis and placement quality improvement. [ENUM-REF-CANDIDATE: candidate_withdrew|client_terminated|performance|scope_change|budget_cut|other — promote to reference product if additional values needed]. Valid values are `candidate_withdrew|client_terminated|performance|scope_change|budget_cut|other`',
    `i9_verified` BOOLEAN COMMENT 'Indicates whether the workers I-9 Employment Eligibility Verification has been completed and verified for this SOW engagement. Mandatory for all U.S.-based workers under the Immigration and Nationality Act (INA).',
    `ic_classification_flag` BOOLEAN COMMENT 'Indicates whether the worker engaged under this SOW is classified as an Independent Contractor (IC/1099) rather than a W-2 employee. Critical for IRS worker classification compliance, co-employment risk assessment, and FLSA determination.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Cumulative amount invoiced to the client against this SOW engagement to date. Represents the adjustment/progress component of the MONETARY_TRIPLET. Used for billing reconciliation and revenue tracking in Salesforce Revenue Cloud.',
    `job_title` STRING COMMENT 'The job title or role designation of the worker engaged under this SOW. Used for workforce analytics, EEOC reporting, and assignment tracking. May differ from the job order title if the SOW specifies a distinct deliverable-based role.',
    `milestone_billing_flag` BOOLEAN COMMENT 'Indicates whether this SOW engagement uses milestone-based billing tied to deliverable completion events rather than time-and-materials or fixed periodic billing. When True, billing events are triggered by milestone approval in Beeline VMS or Salesforce Revenue Cloud.',
    `msp_managed_flag` BOOLEAN COMMENT 'Indicates whether this SOW engagement is managed through a Managed Service Provider (MSP) program via a Vendor Management System (VMS) such as Beeline. When True, the vms_program_id reference is expected to be populated.',
    `onboarding_status` STRING COMMENT 'Current status of the worker onboarding process for this SOW engagement. Tracks completion of required onboarding steps including I-9 verification, background check, and client-specific requirements. Sourced from SAP SuccessFactors Onboarding module.. Valid values are `not_started|in_progress|completed|blocked`',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit pay rate paid to the worker under this SOW engagement, where applicable. Used with bill_rate to calculate spread (bill rate minus pay rate) and gross margin analytics.',
    `placement_type` STRING COMMENT 'Worker engagement classification under the SOW. sow_ic = Independent Contractor (1099) engaged directly under SOW; sow_w2 = W-2 worker placed under SOW through staffing firm; sow_vendor = third-party vendor supplying resources under SOW.. Valid values are `sow_ic|sow_w2|sow_vendor`',
    `redeployment_candidate_flag` BOOLEAN COMMENT 'Indicates whether the worker on this SOW engagement has been identified as a candidate for redeployment to another assignment upon engagement completion or early termination. Supports bench management and redeployment pipeline analytics.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this SOW engagement record was sourced. Supports data lineage tracking in the Databricks Silver Layer. docusign_clm = DocuSign CLM; beeline_vms = Beeline VMS SOW module; bullhorn = Bullhorn ATS/CRM; manual = manually entered.. Valid values are `docusign_clm|beeline_vms|bullhorn|manual`',
    `sow_number` STRING COMMENT 'Externally-known unique reference number assigned to the Statement of Work document. Sourced from DocuSign CLM or Beeline VMS SOW module. Serves as the BUSINESS_IDENTIFIER for this transaction. Used for cross-system reconciliation and client-facing communication.. Valid values are `^SOW-[A-Z0-9]{4,20}$`',
    `sow_title` STRING COMMENT 'Descriptive title of the Statement of Work engagement as defined in the executed SOW document. Used for identification and reporting purposes (e.g., Q3 Data Migration Project, Network Infrastructure Upgrade Phase 2).',
    `total_hours_budgeted` DECIMAL(18,2) COMMENT 'Total number of hours budgeted for the SOW engagement as defined in the contract. Used for time-and-materials SOW types to track utilization against budget and for workforce planning analytics.',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Cumulative actual hours worked by the worker under this SOW engagement to date. Sourced from Kronos Workforce Ready time and attendance records. Used for budget utilization tracking and billing reconciliation.',
    `total_sow_value` DECIMAL(18,2) COMMENT 'The total contracted monetary value of the SOW engagement as agreed in the executed SOW document. Represents the gross base amount for the MONETARY_TRIPLET. Used for revenue recognition, billing reconciliation, and financial reporting in Oracle NetSuite ERP and Salesforce Revenue Cloud.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this SOW engagement record was last modified. Serves as the RECORD_AUDIT_UPDATED for this transaction. Used for change data capture (CDC) in the Databricks Silver Layer pipeline. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `work_arrangement` STRING COMMENT 'The physical work arrangement for the SOW engagement. onsite = worker performs work at client facility; remote = worker performs work from their own location; hybrid = combination of onsite and remote.. Valid values are `onsite|remote|hybrid`',
    CONSTRAINT pk_sow_engagement PRIMARY KEY(`sow_engagement_id`)
) COMMENT 'Master record for Statement of Work (SOW) based placements where workers are engaged under a defined deliverable-based contract rather than a time-and-materials assignment. Tracks SOW reference number, SOW title, engagement start date, engagement end date, total SOW value, milestone-based billing flag, deliverable descriptions, SOW status (draft, active, completed, terminated), IC classification flag, co-employment risk assessment, and vendor reference for MSP-managed SOW programs. Distinct from the contract domains SOW template — this product tracks the operational placement-level engagement instance, not the commercial agreement terms. Sourced from DocuSign CLM and Beeline VMS SOW module.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`per_diem` (
    `per_diem_id` BIGINT COMMENT 'Unique system-generated identifier for the per diem allowance arrangement record. Primary key for the placement.per_diem data product.',
    `assignment_id` BIGINT COMMENT 'Reference to the temporary or contract assignment for which this per diem arrangement is established. Links the per diem record to the parent assignment lifecycle.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account at whose work site the worker is placed, used to determine billable per diem pass-through arrangements and client-specific rate agreements.',
    `contract_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_schedule. Business justification: Per diem allowances are defined in contract rate schedules by job category, location, and GSA locality. Links per diem payments to contractually approved rates for billing validation and margin calcul',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement governing the per diem terms and client billing arrangement. Ensures per diem rates and reimbursement methods are contractually authorized.',
    `placement_assignment_id` BIGINT COMMENT 'Reference to the placement record associated with this per diem arrangement, connecting the allowance to the broader placement and job order context.',
    `profile_id` BIGINT COMMENT 'Reference to the worker/candidate receiving the per diem allowance. Used for payroll processing, tax reporting, and worker-level per diem analytics.',
    `wage_hour_determination_id` BIGINT COMMENT 'Foreign key linking to compliance.wage_hour_determination. Business justification: Per diem payments must comply with IRS accountable plan rules, prevailing wage laws, and FLSA regulations. Links per diem arrangement to wage-hour determination ensuring taxability, rate compliance, a',
    `work_location_id` BIGINT COMMENT 'Reference to the client work site location where the worker is placed. Used to validate GSA locality rates, determine travel distance eligibility, and support geographic per diem compliance analysis.',
    `approval_date` DATE COMMENT 'The date on which the per diem arrangement was formally approved by the designated approver. Required for audit trail and compliance with internal controls.',
    `approval_status` STRING COMMENT 'Current workflow lifecycle state of the per diem arrangement. Pending indicates awaiting manager or client approval; approved indicates active and payroll-eligible; rejected indicates denied; cancelled indicates voided before use; expired indicates past the effective period without renewal.. Valid values are `pending|approved|rejected|cancelled|expired`',
    `approved_by` STRING COMMENT 'Name or identifier of the internal manager, branch director, or account manager who authorized the per diem arrangement. Supports approval audit trail and compliance documentation.',
    `billable_to_client_flag` BOOLEAN COMMENT 'Indicates whether the per diem cost is passed through and billed to the client as part of the assignment billing arrangement. When true, the per diem amount is included in client invoicing via Salesforce Revenue Cloud.',
    `bullhorn_assignment_ref` STRING COMMENT 'The Bullhorn ATS/CRM assignment record identifier linked to this per diem arrangement. Supports cross-system reconciliation between Bullhorn placement data and TempWorks payroll per diem configuration.',
    `client_approved_flag` BOOLEAN COMMENT 'Indicates whether the client has formally approved the per diem arrangement as part of the MSA or SOW terms. Required for billable per diem pass-through arrangements and VMS program compliance.',
    `client_bill_rate` DECIMAL(18,2) COMMENT 'The daily per diem rate billed to the client when billable_to_client_flag is true. May differ from the worker daily_rate due to markup or administrative fee. Expressed in currency_code.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the per diem arrangement record was first created in the system. Supports audit trail, data lineage, and SOC 2 compliance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the per diem daily rate and budget amounts. Typically USD for domestic U.S. placements; may differ for international assignments.. Valid values are `^[A-Z]{3}$`',
    `daily_rate` DECIMAL(18,2) COMMENT 'The monetary amount paid or reimbursed to the worker per calendar day for this per diem type. Expressed in the currency defined by currency_code. Must not exceed applicable IRS GSA locality rate to maintain non-taxable status.',
    `distance_from_home_miles` DECIMAL(18,2) COMMENT 'The calculated distance in miles between the workers tax home and the work location. Used to validate per diem eligibility — IRS generally requires the work location to be far enough from the workers tax home to require overnight lodging.',
    `effective_date` DATE COMMENT 'The date on which the per diem allowance arrangement becomes active and eligible for payroll inclusion or expense reimbursement. Must align with or follow the assignment start date.',
    `expiration_date` DATE COMMENT 'The date on which the per diem arrangement ceases to be valid. Typically aligned with the assignment end date or extension date. Null indicates open-ended arrangement tied to assignment duration.',
    `first_payment_date` DATE COMMENT 'The date on which the first per diem payment was or is scheduled to be made to the worker. Used for payroll scheduling, cash flow forecasting, and worker communication.',
    `gsa_locality_rate` DECIMAL(18,2) COMMENT 'The IRS General Services Administration (GSA) published maximum per diem rate for the work locations locality and per diem type for the applicable fiscal year. Used as the compliance ceiling to determine taxable vs. non-taxable treatment of the allowance.',
    `gsa_location_code` STRING COMMENT 'The GSA-assigned location code or city/county identifier used to look up the applicable per diem locality rate for the work site. Enables automated rate validation against the GSA rate table.',
    `gsa_rate_year` STRING COMMENT 'The GSA fiscal year (October–September) for which the referenced GSA locality rate applies. Required for annual rate reconciliation and IRS compliance audits.',
    `last_payment_date` DATE COMMENT 'The date on which the most recent per diem payment was made to the worker. Used for payment tracking, reconciliation, and identifying gaps in per diem disbursement.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, exceptions, or operational notes related to the per diem arrangement. May include client-specific requirements, IRS exception documentation, or recruiter comments.',
    `overnight_stay_required` BOOLEAN COMMENT 'Indicates whether the assignment requires the worker to stay overnight away from their tax home, which is a prerequisite for non-taxable per diem treatment under IRS rules. Drives lodging and M&IE per diem eligibility.',
    `pay_frequency` STRING COMMENT 'The frequency at which the per diem allowance is paid to the worker. Typically aligns with the payroll cycle but may differ for expense-based reimbursements processed per occurrence.. Valid values are `weekly|biweekly|semimonthly|monthly|per_occurrence`',
    `per_diem_number` STRING COMMENT 'Human-readable, externally referenceable business identifier for the per diem arrangement, used in payroll configuration, expense reporting, and client billing communications. Sourced from TempWorks Payroll per diem configuration.. Valid values are `^PD-[0-9]{8,12}$`',
    `per_diem_type` STRING COMMENT 'Classification of the per diem allowance category as defined by IRS GSA guidelines. Travel covers transportation costs; lodging covers accommodation; meals covers food expenses; incidentals covers tips and minor expenses; meals_and_incidentals (M&IE) is the combined GSA rate category.. Valid values are `travel|lodging|meals|incidentals|meals_and_incidentals`',
    `reimbursement_method` STRING COMMENT 'The mechanism by which the per diem allowance is delivered to the worker. Payroll_included means the amount is added to the regular paycheck; separate_expense means it is processed as a standalone expense reimbursement; direct_deposit means a separate ACH payment; client_billed means the client reimburses the staffing firm directly.. Valid values are `payroll_included|separate_expense|direct_deposit|client_billed`',
    `taxable_amount` DECIMAL(18,2) COMMENT 'The portion of the daily per diem rate that exceeds the GSA locality rate and is therefore subject to income tax withholding and payroll taxes. Calculated as daily_rate minus gsa_locality_rate when taxable_flag is true; zero otherwise.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether the per diem allowance is subject to federal and state income tax withholding. True when the daily rate exceeds the applicable GSA locality rate or when the worker does not maintain a tax home away from the work location. Drives payroll tax treatment in TempWorks.',
    `tempworks_per_diem_reference` STRING COMMENT 'The source system identifier for this per diem record in TempWorks Payroll per diem configuration module. Used for data lineage, reconciliation, and integration with payroll processing.',
    `total_budget` DECIMAL(18,2) COMMENT 'The maximum total monetary amount authorized for this per diem arrangement over the full effective period of the assignment. Used for budget tracking, client billing caps, and financial forecasting. Expressed in currency_code.',
    `total_days_eligible` STRING COMMENT 'The total number of calendar or working days for which the worker is eligible to receive per diem under this arrangement, based on the effective and expiration dates and any exclusion rules (weekends, holidays, non-working days).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the per diem arrangement record was most recently modified. Used for change tracking, incremental data loads, and audit compliance.',
    `vms_req_number` STRING COMMENT 'The requisition or program identifier from the clients Vendor Management System (VMS) associated with this per diem arrangement. Required for MSP/VMS-managed programs where per diem must be tracked against the VMS requisition.',
    `weekend_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker is eligible to receive per diem on weekend days when not actively working. Relevant for lodging and incidental per diem where the worker remains at the remote location over weekends.',
    `worker_home_zip` STRING COMMENT 'The workers permanent home ZIP code used to determine tax home status and eligibility for non-taxable per diem treatment. Required for IRS compliance when the work location is away from the workers tax home.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_per_diem PRIMARY KEY(`per_diem_id`)
) COMMENT 'Master record for per diem allowance arrangements associated with a specific assignment, covering travel, lodging, and meal reimbursements for workers placed at remote or out-of-area work locations. Tracks per diem type (travel, lodging, meals, incidentals), daily rate, IRS GSA rate reference, effective date, expiration date, taxable flag, reimbursement method (payroll-included, separate expense), approval status, and total per diem budget for the assignment. Sourced from TempWorks Payroll per diem configuration and Bullhorn assignment details.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`offer` (
    `offer_id` BIGINT COMMENT 'Unique system-generated identifier for the job offer record. Primary key for the placement.offer data product.',
    `assignment_id` BIGINT COMMENT 'Foreign key linking to placement.assignment. Business justification: When a temporary/contract offer is accepted, it results in an assignment record. Linking offer to the resulting assignment enables tracking of offer-to-start conversion, offer acceptance to actual sta',
    `bgc_order_id` BIGINT COMMENT 'Foreign key linking to credentialing.bgc_order. Business justification: Offers are contingent on background check clearance. Links offer to BGC order for offer-to-hire workflow tracking, adverse action processing, and decline-reason analysis (BGC fail vs candidate decline',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which the placement offer is being made.',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: When a direct hire offer is accepted, it results in a direct_hire placement record. Linking offer to the resulting direct_hire enables tracking of offer-to-placement conversion for permanent roles, of',
    `envelope_id` BIGINT COMMENT 'Foreign key linking to contract.envelope. Business justification: Offer acceptance in staffing requires e-signature capture for legal enforceability of employment terms, bill/pay rates, and start dates. Staffing operations track envelope status to confirm offer exec',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: Offers to independent contractors require executed IC agreements to establish worker classification, scope, payment terms, and IP assignment before work begins. Compliance requirement to mitigate misc',
    `staff_profile_id` BIGINT COMMENT 'Reference to the account manager responsible for the client relationship associated with this offer.',
    `offer_staff_profile_id` BIGINT COMMENT 'Reference to the recruiter responsible for managing this offer and the candidate relationship.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) for which this offer was generated.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate to whom the job offer was extended.',
    `readiness_status_id` BIGINT COMMENT 'Foreign key linking to credentialing.readiness_status. Business justification: Offer acceptance depends on credential package completion status. Links offer to readiness evaluation for onboarding timeline forecasting and offer-expiration risk management. Enables automated offer-',
    `submittal_id` BIGINT COMMENT 'Reference to the candidate submittal record that preceded and triggered this offer, linking the recruitment pipeline to the offer stage.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Offers track which supplier submitted the candidate for supplier performance metrics (offer acceptance rate, time-to-offer). Used in VMS scorecards, supplier tier reviews, and fee attribution. Essenti',
    `wage_hour_determination_id` BIGINT COMMENT 'Foreign key linking to compliance.wage_hour_determination. Business justification: Offers must undergo wage-hour compliance validation before extension: FLSA exempt/non-exempt classification, minimum wage compliance, salary threshold verification, prevailing wage requirements. Pre-o',
    `work_location_id` BIGINT COMMENT 'Reference to the specific client work location where the offered position will be performed. Used for geographic workforce analytics and compliance (state-specific labor law, workers comp).',
    `accepted_date` DATE COMMENT 'The date on which the candidate formally accepted the offer. Null if the offer has not been accepted. Used to calculate offer-to-acceptance cycle time KPI.',
    `annual_salary` DECIMAL(18,2) COMMENT 'The annual base salary offered to the candidate for permanent or direct hire placements. Applicable for perm offer types. Used in compensation benchmarking and conversion fee calculations.',
    `bgc_required` BOOLEAN COMMENT 'Indicates whether a background check (BGC) is required as a condition of this offer. Drives Sterling Background Check initiation workflow and offer contingency tracking.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit bill rate offered to the client for the temporary or contract worker. Applicable for temp, CTH, and SOW offer types. Used in spread and gross margin calculations.',
    `bullhorn_offer_reference` STRING COMMENT 'Native offer record identifier from the Bullhorn ATS/CRM system. Used for cross-system reconciliation and audit traceability back to the source system of record.',
    `counter_offer_amount` DECIMAL(18,2) COMMENT 'The compensation amount proposed by the candidate as a counter-offer to the original offer. Applicable when offer_status is counter_offered. Used in negotiation tracking and compensation benchmarking.',
    `counter_offer_rate_type` STRING COMMENT 'The rate basis (hourly, annual, etc.) for the candidates counter-offer amount. Required to correctly interpret counter_offer_amount in negotiation analytics.. Valid values are `hourly|daily|weekly|annual|fixed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the offer record was first created in the system. Audit trail field for data lineage, SOC 2 Type II compliance, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary amounts on this offer record (bill rate, pay rate, salary, sign-on bonus). Defaults to USD for domestic U.S. operations.. Valid values are `^[A-Z]{3}$`',
    `decline_reason_code` STRING COMMENT 'Standardized reason code explaining why the candidate declined the offer (e.g., COMP_LOW, ACCEPTED_COMPETITOR, LOCATION, ROLE_MISMATCH, PERSONAL). Null if offer was not declined. Critical for competitive intelligence and offer strategy improvement. [ENUM-REF-CANDIDATE: comp_low|accepted_competitor|location|role_mismatch|personal|counter_accepted — promote to reference product]',
    `declined_date` DATE COMMENT 'The date on which the candidate formally declined the offer. Null if not declined. Used in fall-off rate monitoring and competitive compensation benchmarking.',
    `department` STRING COMMENT 'The clients organizational department or cost center to which the offered position belongs. Used for client billing allocation and workforce planning analytics.',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether a pre-employment drug screen is required as a condition of this offer. Drives Sterling drug screening workflow and offer contingency tracking.',
    `exempt_status` STRING COMMENT 'Fair Labor Standards Act (FLSA) classification of the offered position as exempt (salaried, not eligible for overtime) or non-exempt (eligible for overtime pay). Critical for payroll compliance and OT/DT calculations.. Valid values are `exempt|non_exempt`',
    `expiration_date` DATE COMMENT 'The date by which the candidate must accept or decline the offer before it automatically expires. Used to enforce offer validity windows and trigger follow-up workflows.',
    `job_title` STRING COMMENT 'The job title communicated to the candidate as part of the offer. May differ from the internal job order title. Used in candidate communications, onboarding, and EEOC job category reporting.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied over the pay rate to derive the bill rate, representing the staffing firms gross margin component. Calculated as ((bill_rate - pay_rate) / pay_rate) * 100. Stored for offer-level financial benchmarking.',
    `msp_program_flag` BOOLEAN COMMENT 'Indicates whether this offer is part of a Managed Service Provider (MSP)-managed contingent workforce program. Drives VMS submission workflows, rate card compliance checks, and MSP fee calculations.',
    `negotiation_round_count` STRING COMMENT 'The total number of negotiation rounds completed for this offer, including the initial offer and any counter-offers. Used to measure negotiation complexity and recruiter efficiency.',
    `notes` STRING COMMENT 'Free-text field for recruiter or account manager notes related to the offer, including negotiation context, special conditions, client-specific requirements, or candidate feedback not captured in structured fields.',
    `offer_date` DATE COMMENT 'The calendar date on which the formal job offer was extended to the candidate. Principal business event date used in Time-to-Fill (TTF) and offer cycle time analytics.',
    `offer_number` STRING COMMENT 'Human-readable, externally-visible business identifier for the offer (e.g., OFR-2024-00123). Used in candidate communications, recruiter workflows, and reporting.',
    `offer_status` STRING COMMENT 'Current lifecycle state of the offer. Drives offer acceptance rate KPI and time-to-fill analytics. [ENUM-REF-CANDIDATE: pending|accepted|declined|rescinded|expired|counter_offered — promote to reference product if additional statuses are needed]. Valid values are `pending|accepted|declined|rescinded|expired|counter_offered`',
    `offer_type` STRING COMMENT 'Classification of the offer by engagement model: temp (temporary assignment), contract_to_hire (Contract-to-Hire / CTH), perm (permanent/direct placement), or sow (Statement of Work / SOW-based engagement).. Valid values are `temp|contract_to_hire|perm|sow`',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit pay rate offered to the candidate for the temporary or contract assignment. Applicable for temp, CTH, and SOW offer types. Used in spread and markup percentage calculations.',
    `placement_type` STRING COMMENT 'The staffing engagement model for this offer, aligned with the downstream placement record type. Distinguishes temporary, temp-to-perm, contract-to-hire (CTH), direct hire, and SOW engagements for routing to the correct placement workflow.. Valid values are `temporary|temp_to_perm|contract_to_hire|direct_hire|sow`',
    `proposed_start_date` DATE COMMENT 'The anticipated assignment or employment start date communicated to the candidate as part of the offer. Used in Time-to-Start (TTS) analytics and workforce scheduling.',
    `rate_type` STRING COMMENT 'Specifies the unit basis for the offered pay rate and bill rate (e.g., hourly for temp workers, annual for direct hire, fixed for SOW engagements). Drives payroll and billing calculations.. Valid values are `hourly|daily|weekly|annual|fixed`',
    `rescind_reason_code` STRING COMMENT 'Standardized reason code explaining why the offer was rescinded by the firm or client (e.g., BGC_FAILED, DRUG_SCREEN_FAILED, CLIENT_CANCELLED, HEADCOUNT_FREEZE, CANDIDATE_MISREPRESENTATION). Null if not rescinded. [ENUM-REF-CANDIDATE: bgc_failed|drug_screen_failed|client_cancelled|headcount_freeze|candidate_misrepresentation|other — promote to reference product]',
    `rescinded_date` DATE COMMENT 'The date on which the staffing firm or client rescinded (withdrew) the offer after it had been extended. Null if not rescinded. Tracked for compliance and candidate experience reporting.',
    `sign_on_bonus` DECIMAL(18,2) COMMENT 'One-time sign-on bonus amount offered to the candidate as part of the compensation package. Null if no sign-on bonus is included. Relevant for compensation benchmarking and candidate attraction analytics.',
    `sourcing_channel` STRING COMMENT 'The recruitment sourcing channel through which the candidate was originally identified and submitted (e.g., job_board, referral, internal_database, social_media, campus, direct_sourcing). Used in sourcing effectiveness and cost-per-hire analytics. [ENUM-REF-CANDIDATE: job_board|referral|internal_database|social_media|campus|direct_sourcing|other — promote to reference product]',
    `to_acceptance_days` STRING COMMENT 'Number of calendar days elapsed between the offer_date and the accepted_date. Populated upon acceptance. Key KPI for Time-to-Fill (TTF) analytics and recruiter performance measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the offer record was last modified. Audit trail field used for change data capture (CDC), Silver layer incremental processing, and compliance audit trails.',
    `vms_req_number` STRING COMMENT 'The requisition number assigned by the clients Vendor Management System (VMS) such as Beeline, associated with this offer. Required for MSP/VMS-managed programs to reconcile offer records with client procurement systems.',
    `work_arrangement` STRING COMMENT 'The physical work arrangement offered to the candidate: onsite (at client location), remote (fully remote), or hybrid (combination). Relevant for candidate matching, client SLA compliance, and workforce planning.. Valid values are `onsite|remote|hybrid`',
    `worker_classification` STRING COMMENT 'Tax and employment classification of the worker under this offer: W-2 (employee), 1099 (independent contractor / IC), corp-to-corp (C2C), or EOR (Employer of Record). Drives payroll tax treatment, co-employment risk assessment, and IRS compliance.. Valid values are `w2|1099|corp_to_corp|eor`',
    CONSTRAINT pk_offer PRIMARY KEY(`offer_id`)
) COMMENT 'Transactional record capturing the formal job offer extended to a candidate for a temporary assignment, contract-to-hire, or permanent placement. Tracks offer date, offer type (temp, CTH, perm, SOW), offered bill rate, offered pay rate, offered salary, sign-on bonus, offer expiration date, offer status (pending, accepted, declined, rescinded, expired, counter-offered), decline reason code, counter-offer details, negotiation round count, and offer-to-acceptance cycle time. Serves as the bridge between the recruitment submittal process and the active assignment or direct hire record. Critical for offer acceptance rate KPI, time-to-fill analytics, and compensation benchmarking. Sourced from Bullhorn offer management workflow.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`bench_roster` (
    `bench_roster_id` BIGINT COMMENT 'Unique identifier for the bench roster record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Identifier of the most recent placement or assignment that ended, resulting in the candidate being placed on the bench.',
    `client_account_id` BIGINT COMMENT 'Identifier of the client where the candidates most recent assignment ended. Used for tracking client-specific redeployment opportunities and restrictions.',
    `profile_id` BIGINT COMMENT 'Identifier of the candidate currently on the bench and available for redeployment.',
    `readiness_status_id` BIGINT COMMENT 'Foreign key linking to credentialing.readiness_status. Business justification: Bench roster tracks redeployment-ready candidates. Links to readiness status enables rapid deployment by pre-filtering credential-ready candidates for client submittals. Reduces time-to-fill for backf',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the recruiter responsible for redeploying this bench candidate.',
    `prior_bench_roster_id` BIGINT COMMENT 'Self-referencing FK on bench_roster (prior_bench_roster_id)',
    `assignment_end_reason` STRING COMMENT 'Reason why the candidates previous assignment ended and they were placed on the bench. Assignment Completed indicates natural end of contract; Client Ended indicates client terminated early; Candidate Resigned indicates voluntary departure; Performance indicates performance-related termination; Contract Expired indicates end of contract term; Project Cancelled indicates client project cancellation; Layoff indicates workforce reduction; Other indicates miscellaneous reasons. [ENUM-REF-CANDIDATE: assignment_completed|client_ended|candidate_resigned|performance|contract_expired|project_cancelled|layoff|other — 8 candidates stripped; promote to reference product]',
    `availability_date` DATE COMMENT 'Date when the candidate will be available to start a new assignment. May be the same as bench entry date or a future date if candidate has scheduling constraints.',
    `bench_cost_risk` STRING COMMENT 'Risk level associated with the cost of keeping this candidate on the bench. High indicates significant ongoing cost (high pay rate, benefits burden); Medium indicates moderate cost impact; Low indicates minimal cost impact.. Valid values are `high|medium|low`',
    `bench_entry_date` DATE COMMENT 'Date when the candidate was placed on the bench roster, typically the day after the previous assignment ended.',
    `bench_entry_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the candidate was added to the bench roster, used for SLA tracking and bench cost calculations.',
    `bench_roster_number` STRING COMMENT 'Human-readable business identifier for the bench roster entry, used for tracking and reporting purposes.',
    `bench_status` STRING COMMENT 'Current status of the candidate on the bench roster. Available indicates ready for immediate placement; In Process indicates actively interviewing or in submittal stage; Redeployed indicates successfully placed in new assignment; Separated indicates candidate left the organization; On Hold indicates temporarily unavailable; Inactive indicates no longer seeking redeployment.. Valid values are `available|in_process|redeployed|separated|on_hold|inactive`',
    `bgc_status` STRING COMMENT 'Status of the candidates background check. Clear indicates passed and current; Pending indicates check in progress; Expired indicates check needs renewal; Flagged indicates issues requiring review.. Valid values are `clear|pending|expired|flagged`',
    `bullhorn_candidate_reference` STRING COMMENT 'External identifier for the candidate in the Bullhorn ATS system, used for system integration and data reconciliation.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the candidate for redeployment. Compliant indicates all required credentials, background checks, and certifications are current; Expiring Soon indicates items will expire within 30 days; Expired indicates one or more items have lapsed; Pending indicates initial compliance checks in progress.. Valid values are `compliant|expiring_soon|expired|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bench roster record was first created in the system. Used for audit trail and data lineage.',
    `days_on_bench` STRING COMMENT 'Number of calendar days the candidate has been on the bench since bench entry date. Key metric for redeployment efficiency and bench cost management.',
    `drug_screen_status` STRING COMMENT 'Status of the candidates drug screening. Clear indicates passed and current; Pending indicates test in progress; Expired indicates test needs renewal; Failed indicates did not pass screening.. Valid values are `clear|pending|expired|failed`',
    `ending_job_title` STRING COMMENT 'Job title from the candidates most recent assignment, used for matching to similar roles.',
    `i9_verified` BOOLEAN COMMENT 'Indicates whether the candidate has a current and verified I-9 Employment Eligibility Verification form on file. True means verified and current; False means verification needed.',
    `interviews_count` STRING COMMENT 'Number of client interviews the candidate has participated in while on the bench. Used to assess redeployment progress and candidate competitiveness.',
    `last_bill_rate` DECIMAL(18,2) COMMENT 'The bill rate from the candidates most recent assignment, used as a baseline for pricing new placements.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent recruiter outreach to the candidate regarding redeployment opportunities.',
    `last_pay_rate` DECIMAL(18,2) COMMENT 'The pay rate from the candidates most recent assignment, used as a baseline for compensation negotiations.',
    `minimum_pay_rate` DECIMAL(18,2) COMMENT 'The minimum pay rate the candidate is willing to accept for a new assignment. Used for filtering and matching to job orders.',
    `notes` STRING COMMENT 'Free-text notes regarding the candidates bench status, redeployment efforts, special considerations, or restrictions. Used by recruiters for context and coordination.',
    `outreach_attempts` STRING COMMENT 'Number of times the recruiter has contacted the candidate regarding redeployment opportunities since they were placed on the bench.',
    `preferred_location` STRING COMMENT 'The candidates preferred geographic location or city for their next assignment.',
    `preferred_state` STRING COMMENT 'The candidates preferred state or province for their next assignment, using standard postal abbreviations (e.g., CA, TX, NY).',
    `preferred_work_type` STRING COMMENT 'The candidates preferred type of work arrangement for their next placement. Temporary indicates short-term assignments; Temp-to-Perm indicates temporary with conversion option; Contract-to-Hire indicates contract with hire option; Direct Hire indicates permanent placement only; Any indicates open to all types.. Valid values are `temporary|temp_to_perm|contract_to_hire|direct_hire|any`',
    `primary_skill` STRING COMMENT 'The candidates primary marketable skill or job function that will be used for matching to new job orders (e.g., Registered Nurse, Java Developer, Warehouse Associate).',
    `priority_level` STRING COMMENT 'Priority level for redeploying this candidate. Critical indicates immediate action required (high bench cost or key talent); High indicates priority redeployment; Medium indicates standard redeployment effort; Low indicates passive redeployment.. Valid values are `critical|high|medium|low`',
    `rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for all rate fields (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `redeployment_readiness` STRING COMMENT 'Indicates whether the candidate is immediately ready for redeployment. Ready means all compliance and availability requirements are met; Pending Compliance means background checks, credentials, or certifications need renewal; Pending Availability means candidate has scheduling constraints; Not Ready means candidate is not currently seeking placement.. Valid values are `ready|pending_compliance|pending_availability|not_ready`',
    `remote_eligible` BOOLEAN COMMENT 'Indicates whether the candidate is eligible and willing to work remotely. True means candidate can work remote assignments; False means candidate requires on-site work.',
    `skill_category` STRING COMMENT 'High-level categorization of the candidates skill set (e.g., Healthcare, IT, Industrial, Administrative, Finance) used for broad matching and reporting.',
    `skill_summary` STRING COMMENT 'Brief summary of the candidates key skills, certifications, and experience relevant for redeployment matching. Used by recruiters for quick assessment.',
    `submittals_count` STRING COMMENT 'Number of times the candidate has been submitted to job orders while on the bench. Used to track redeployment activity and candidate marketability.',
    `target_redeploy_date` DATE COMMENT 'Target date by which the organization aims to redeploy this candidate into a new assignment, based on bench cost management and SLA targets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this bench roster record was last modified. Used for audit trail and change tracking.',
    `willing_to_relocate` BOOLEAN COMMENT 'Indicates whether the candidate is willing to relocate for a new assignment. True means willing to relocate; False means prefers local opportunities only.',
    `worker_classification` STRING COMMENT 'Tax and employment classification of the candidate. W-2 (Wage and Tax Statement) indicates employee status; 1099 (Independent Contractor Tax Form) indicates contractor status; IC (Independent Contractor) indicates independent contractor classification.. Valid values are `w2|1099|ic`',
    CONSTRAINT pk_bench_roster PRIMARY KEY(`bench_roster_id`)
) COMMENT 'Real-time roster of unassigned (bench) workers available for redeployment or new placement, tracking bench entry date, redeployment readiness, skill summary, and days on bench';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` (
    `dispatch_order_id` BIGINT COMMENT 'Unique identifier for the dispatch order record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Reference to the parent temporary assignment or placement record that this dispatch order fulfills.',
    `client_account_id` BIGINT COMMENT 'Reference to the client organization receiving the dispatched worker.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order or requisition (Req) that this dispatch fulfills.',
    `profile_id` BIGINT COMMENT 'Reference to the worker being dispatched to the client site.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal staffing coordinator or dispatcher who created and authorized this dispatch order.',
    `supervisor_id` BIGINT COMMENT 'Reference to the client supervisor or manager who will oversee the worker during this dispatch period.',
    `work_location_id` BIGINT COMMENT 'Reference to the specific client site or facility where the worker will report for this shift or work period.',
    `worker_schedule_id` BIGINT COMMENT 'Foreign key linking to placement.worker_schedule. Business justification: Dispatch orders authorize workers to fulfill specific scheduled shifts. Linking dispatch_order to worker_schedule enables tracking of dispatch-to-schedule fulfillment, dispatch confirmation vs. schedu',
    `replacement_dispatch_order_id` BIGINT COMMENT 'Self-referencing FK on dispatch_order (replacement_dispatch_order_id)',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the worker clocked out or completed work, captured from time and attendance system.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'The actual number of hours worked by the worker during this dispatch period, as recorded in time and attendance system.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the worker clocked in or began work, captured from time and attendance system.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly rate charged to the client for this worker during this dispatch period.',
    `cancellation_date` DATE COMMENT 'The date when this dispatch order was cancelled, if applicable.',
    `cancellation_reason` STRING COMMENT 'The reason code or description explaining why this dispatch order was cancelled.',
    `client_confirmed_timestamp` TIMESTAMP COMMENT 'The date and time when the client confirmed approval and acceptance of this dispatch.',
    `confirmation_method` STRING COMMENT 'The communication channel used to confirm this dispatch with the worker (phone, email, SMS, mobile app, VMS portal).. Valid values are `phone|email|sms|vms|mobile_app|portal`',
    `confirmation_number` STRING COMMENT 'Confirmation or authorization number provided by the client or VMS system approving this dispatch.',
    `cost_center` STRING COMMENT 'The client cost center code for financial tracking and billing allocation of this dispatch.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this dispatch order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this dispatch order.. Valid values are `USD|CAD|GBP|EUR|AUD`',
    `department` STRING COMMENT 'The client department or functional area where the worker will be assigned during this dispatch.',
    `dispatch_date` DATE COMMENT 'The date when the dispatch order was created and authorized for worker deployment.',
    `dispatch_number` STRING COMMENT 'Human-readable business identifier for the dispatch order, often used in communications with workers and clients.',
    `dispatch_status` STRING COMMENT 'Current lifecycle status of the dispatch order indicating its progression from creation through completion or cancellation. [ENUM-REF-CANDIDATE: draft|scheduled|confirmed|dispatched|in_progress|completed|cancelled|no_show — 8 candidates stripped; promote to reference product]',
    `dispatch_type` STRING COMMENT 'Classification of the dispatch order based on duration and scheduling pattern (single shift, recurring, emergency coverage, backfill). [ENUM-REF-CANDIDATE: single_shift|multi_shift|daily|weekly|on_call|emergency|backfill — 7 candidates stripped; promote to reference product]',
    `flsa_classification` STRING COMMENT 'FLSA classification determining overtime eligibility for this dispatch assignment.. Valid values are `exempt|non_exempt`',
    `is_backfill` BOOLEAN COMMENT 'Indicates whether this dispatch is filling a backfill request due to another worker falling off or ending assignment early.',
    `is_emergency_dispatch` BOOLEAN COMMENT 'Indicates whether this dispatch was created as an emergency or urgent fill request requiring expedited processing.',
    `job_title` STRING COMMENT 'The job title or role the worker will perform during this dispatch assignment.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the worker failed to report to the client site as scheduled for this dispatch.',
    `ot_bill_rate` DECIMAL(18,2) COMMENT 'The overtime hourly rate charged to the client when the worker exceeds standard hours during this dispatch.',
    `ot_pay_rate` DECIMAL(18,2) COMMENT 'The overtime hourly rate paid to the worker when they exceed standard hours during this dispatch.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly rate paid to the worker for this dispatch period.',
    `po_number` STRING COMMENT 'The client purchase order number authorizing payment for this dispatch assignment.',
    `shift_code` STRING COMMENT 'The shift identifier or code indicating the work schedule pattern (day shift, night shift, swing shift, etc.).',
    `special_instructions` STRING COMMENT 'Additional instructions or notes for the worker regarding site access, dress code, parking, safety requirements, or other dispatch-specific details.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this dispatch order record was last modified in the system.',
    `vms_req_number` STRING COMMENT 'The requisition number from the client VMS system that this dispatch order fulfills.',
    `worker_classification` STRING COMMENT 'The employment classification of the worker for this dispatch (W-2 employee, 1099 independent contractor, temporary, contract).. Valid values are `w2|1099|ic|temp|contract`',
    `worker_confirmed_timestamp` TIMESTAMP COMMENT 'The date and time when the worker confirmed their acceptance of this dispatch assignment.',
    CONSTRAINT pk_dispatch_order PRIMARY KEY(`dispatch_order_id`)
) COMMENT 'Dispatch order record authorizing the deployment of a specific worker to a client site for a defined shift or work period';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` (
    `worker_schedule_id` BIGINT COMMENT 'Unique identifier for the worker schedule record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Reference to the placement assignment this schedule belongs to. Links the schedule to the active worker assignment.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account where the worker is scheduled to work. Identifies the customer organization.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate (worker) being scheduled. Identifies the individual assigned to work this shift.',
    `shift_template_id` BIGINT COMMENT 'Foreign key linking to placement.shift_template. Business justification: Worker schedules are often created from reusable shift templates that define standard shift configurations (shift times, duration, break rules, OT eligibility). Linking worker_schedule to shift_templa',
    `supervisor_id` BIGINT COMMENT 'Reference to the client supervisor overseeing this scheduled shift. Identifies the on-site manager responsible for the worker during this shift.',
    `work_location_id` BIGINT COMMENT 'Reference to the physical work location where the scheduled shift will take place. Links to client site or facility.',
    `original_worker_schedule_id` BIGINT COMMENT 'Self-referencing FK on worker_schedule (original_worker_schedule_id)',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the worker clocked out or completed work. Used for payroll processing and client billing.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours actually worked during this shift. Calculated from actual clock-in/out times, used for payroll and invoicing.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the worker clocked in or began work. Used for timesheet generation and variance analysis.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly rate charged to the client for this scheduled shift. May vary by shift type (regular, overtime, holiday).',
    `break_duration_minutes` STRING COMMENT 'Total minutes of unpaid break time during the shift. Deducted from total hours for payroll calculation per FLSA meal break rules.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the scheduled shift was cancelled. Used for root cause analysis and fall-off tracking.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the scheduled shift was cancelled. Used for measuring advance notice and impact on workforce planning.',
    `cancelled_by` STRING COMMENT 'Identifies which party initiated the cancellation of the scheduled shift. Used for accountability and service level agreement (SLA) tracking.. Valid values are `worker|client|staffing_agency|system`',
    `confirmation_required` BOOLEAN COMMENT 'Indicates whether this schedule requires explicit confirmation from the worker or client before the shift. Used for high-priority or on-call assignments.',
    `confirmed_by_worker` BOOLEAN COMMENT 'Indicates whether the worker has confirmed their availability and commitment to work this scheduled shift.',
    `cost_center` STRING COMMENT 'The client cost center code for financial tracking and billing allocation. Used for invoice line item detail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was first created in the system. Used for audit trail and data lineage.',
    `department` STRING COMMENT 'The client department or business unit where the worker is scheduled. Used for cost allocation and reporting.',
    `dispatch_method` STRING COMMENT 'The method used to create and communicate this schedule to the worker. Tracks operational efficiency and worker engagement channels.. Valid values are `manual|automated|self_service|mobile_app`',
    `job_title` STRING COMMENT 'The job title or role the worker is performing during this scheduled shift. May vary by assignment or client need.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the worker failed to report for this scheduled shift without prior notice. Impacts worker reliability scoring and client satisfaction.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to this scheduled shift. May include dress code, parking instructions, or client-specific requirements.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether a schedule notification was successfully sent to the worker via email, SMS, or mobile app.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule notification was sent to the worker. Used for compliance with advance notice requirements.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly rate paid to the worker for this scheduled shift. Must comply with FLSA minimum wage and overtime requirements.',
    `po_number` STRING COMMENT 'Client purchase order number authorizing this scheduled work. Required for invoice processing and accounts receivable matching.',
    `rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for bill and pay rates. Typically USD for domestic US operations.. Valid values are `^[A-Z]{3}$`',
    `schedule_number` STRING COMMENT 'Business-readable unique identifier for the schedule record. Used for tracking and reference in workforce management systems.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the scheduled shift. Tracks progression from initial scheduling through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|confirmed|in_progress|completed|cancelled|no_show|modified — 7 candidates stripped; promote to reference product]',
    `scheduled_date` DATE COMMENT 'The calendar date on which the shift is scheduled to occur. Used for day-level workforce planning and reporting.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the worker is scheduled to complete the shift. Used for calculating scheduled hours and labor costs.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total number of hours scheduled for this shift. Calculated from start and end times, used for capacity planning and billing projections.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the worker is scheduled to begin the shift. Used for time and attendance tracking.',
    `source_system` STRING COMMENT 'The originating system that created this schedule record. Typically Kronos Workforce Ready, Bullhorn, or client VMS.',
    `source_system_schedule_reference` STRING COMMENT 'The unique identifier for this schedule in the source system. Used for data reconciliation and troubleshooting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was last modified. Used for change tracking and audit compliance.',
    `vms_req_number` STRING COMMENT 'The requisition number from the client Vendor Management System if this is a VMS-managed placement. Used for compliance and billing reconciliation.',
    `work_arrangement` STRING COMMENT 'The physical work arrangement for this scheduled shift. Indicates whether worker reports to client site or works remotely.. Valid values are `on_site|remote|hybrid`',
    `worker_confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the worker confirmed the scheduled shift. Used for tracking response times and commitment reliability.',
    CONSTRAINT pk_worker_schedule PRIMARY KEY(`worker_schedule_id`)
) COMMENT 'Individual worker shift schedule records capturing scheduled start/end times, shift type, work location, and assigned client for placed workers';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` (
    `schedule_exception_id` BIGINT COMMENT 'Unique identifier for the schedule exception record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Reference to the temporary or permanent assignment this exception occurred on.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account where the exception occurred.',
    `profile_id` BIGINT COMMENT 'Reference to the worker who was subject to the schedule exception.',
    `supervisor_id` BIGINT COMMENT 'Reference to the client supervisor who reported or approved the exception.',
    `work_location_id` BIGINT COMMENT 'Reference to the physical work location where the exception occurred.',
    `worker_schedule_id` BIGINT COMMENT 'Foreign key linking to placement.worker_schedule. Business justification: Schedule exceptions are deviations from planned worker schedules (no-shows, late arrivals, early departures, unscheduled absences). Linking schedule_exception to the specific worker_schedule record it',
    `original_schedule_exception_id` BIGINT COMMENT 'Self-referencing FK on schedule_exception (original_schedule_exception_id)',
    `actual_end_time` TIMESTAMP COMMENT 'The actual time the worker ended work, if applicable. Used to calculate early departure duration.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual time the worker started work, if applicable. Null for no-shows or unscheduled absences.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the exception was approved by the authorized approver.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the exception, typically a client supervisor or account manager.',
    `billing_impact_flag` BOOLEAN COMMENT 'Indicates whether this exception affects client billing, such as reduced billable hours or penalty charges.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this exception record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue impact amount.. Valid values are `^[A-Z]{3}$`',
    `disciplinary_action_flag` BOOLEAN COMMENT 'Indicates whether this exception resulted in disciplinary action against the worker per attendance policy.',
    `escalation_date` DATE COMMENT 'The date the exception was escalated to management or account team for review.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this exception has been escalated to management or account team for review due to severity or pattern.',
    `exception_date` DATE COMMENT 'The date the exception was recorded or occurred, used for reporting and tracking purposes.',
    `exception_duration_minutes` STRING COMMENT 'The duration of the exception in minutes, calculated as the difference between scheduled and actual times.',
    `exception_number` STRING COMMENT 'Human-readable business identifier for the schedule exception, often auto-generated for tracking and reference purposes.',
    `exception_status` STRING COMMENT 'Current workflow status of the exception record indicating approval and resolution state.. Valid values are `pending|approved|rejected|disputed|resolved`',
    `exception_type` STRING COMMENT 'Classification of the schedule exception indicating the nature of the deviation from the planned schedule.. Valid values are `no_show|late_arrival|early_departure|shift_swap|unscheduled_absence|schedule_change`',
    `hours_lost` DECIMAL(18,2) COMMENT 'The number of scheduled hours lost due to the exception, used for productivity and revenue impact analysis.',
    `kronos_exception_reference` STRING COMMENT 'External identifier for this exception in the Kronos Workforce Ready time and attendance system.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, resolution details, or follow-up actions related to the exception.',
    `occurrence_count` STRING COMMENT 'The sequential count of similar exceptions for this worker within a defined time period, used for attendance tracking.',
    `pattern_flag` BOOLEAN COMMENT 'Indicates whether this exception is part of a recurring pattern of similar exceptions for the same worker, used for performance management.',
    `payroll_impact_flag` BOOLEAN COMMENT 'Indicates whether this exception affects payroll processing, such as unpaid time or penalty deductions.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the schedule exception, used for analytics and pattern detection.. Valid values are `illness|personal|transportation|weather|family_emergency|no_call_no_show`',
    `reason_detail` STRING COMMENT 'Free-text detailed explanation of the reason for the exception, providing additional context beyond the reason code.',
    `replacement_required_flag` BOOLEAN COMMENT 'Indicates whether a replacement worker is required to cover the missed shift or hours.',
    `reported_by` STRING COMMENT 'Name or identifier of the person who reported the exception, typically the client supervisor or site contact.',
    `reported_timestamp` TIMESTAMP COMMENT 'The date and time when the exception was first reported into the system.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'The estimated revenue impact of the exception in monetary terms, calculated based on bill rate and hours lost.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this exception record was last modified in the system.',
    `vms_exception_reference` STRING COMMENT 'External identifier for this exception in the client Vendor Management System, used for VMS-managed programs.',
    CONSTRAINT pk_schedule_exception PRIMARY KEY(`schedule_exception_id`)
) COMMENT 'Record of a scheduling exception or deviation from the planned worker schedule — including no-shows, late arrivals, early departures, and shift swaps';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`shift_template` (
    `shift_template_id` BIGINT COMMENT 'Unique identifier for the shift template. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which this shift template is configured. Null if this is a general template.',
    `work_location_id` BIGINT COMMENT 'Reference to the specific work location where this shift template applies. Null if this is a general template.',
    `base_shift_template_id` BIGINT COMMENT 'Self-referencing FK on shift_template (base_shift_template_id)',
    `break_duration_minutes` STRING COMMENT 'Total break time allocated within the shift in minutes (e.g., 30 for lunch, 15 for rest breaks).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift template record was first created in the system.',
    `days_of_week` STRING COMMENT 'Comma-separated list of days this shift template applies to (e.g., Monday,Tuesday,Wednesday,Thursday,Friday or Saturday,Sunday).',
    `differential_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage premium applied to base pay rate for shift differential compensation (e.g., 10% for evening, 15% for night).',
    `double_time_eligible` BOOLEAN COMMENT 'Indicates whether assignments using this shift template are eligible for double-time compensation (typically for holidays or excessive hours).',
    `effective_date` DATE COMMENT 'Date from which this shift template becomes active and available for use in scheduling and assignments.',
    `expiration_date` DATE COMMENT 'Date after which this shift template is no longer valid for new assignments. Null for templates with no planned end date.',
    `flsa_classification` STRING COMMENT 'FLSA classification indicating whether positions using this shift template are exempt or non-exempt from overtime requirements.. Valid values are `exempt|non_exempt`',
    `holiday_shift` BOOLEAN COMMENT 'Indicates whether this shift template is designated for holiday work, typically requiring premium pay rates.',
    `on_call_shift` BOOLEAN COMMENT 'Indicates whether this shift template represents on-call availability rather than scheduled work hours.',
    `ot_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours after which overtime rates apply (typically 8 hours daily or 40 hours weekly per FLSA).',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether assignments using this shift template are eligible for overtime compensation under FLSA rules.',
    `paid_break_minutes` STRING COMMENT 'Portion of break time that is compensated, typically short rest breaks under FLSA guidelines.',
    `remote_eligible` BOOLEAN COMMENT 'Indicates whether this shift template can be used for remote work assignments.',
    `rotation_pattern` STRING COMMENT 'Description of the rotation schedule if this is a rotating shift (e.g., 2 weeks day, 2 weeks night, 4 on 3 off).',
    `shift_differential_eligible` BOOLEAN COMMENT 'Indicates whether this shift qualifies for shift differential pay (additional compensation for evening, night, or weekend shifts).',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the shift in hours, including break time. Used for scheduling and capacity planning.',
    `shift_end_time` TIMESTAMP COMMENT 'Standard end time for the shift in HH:mm format (24-hour clock). Represents the scheduled clock-out time.',
    `shift_start_time` TIMESTAMP COMMENT 'Standard start time for the shift in HH:mm format (24-hour clock). Represents the scheduled clock-in time.',
    `shift_template_description` STRING COMMENT 'Detailed description of the shift template including any special requirements, conditions, or notes for schedulers and recruiters.',
    `shift_template_status` STRING COMMENT 'Current lifecycle status of the shift template indicating whether it is available for use in scheduling.. Valid values are `active|inactive|draft|archived`',
    `shift_type` STRING COMMENT 'Classification of the shift template by time of day or pattern (day, evening, night, rotating, split, on-call).. Valid values are `day|evening|night|rotating|split|on_call`',
    `split_shift` BOOLEAN COMMENT 'Indicates whether this shift template represents a split shift with a significant unpaid gap between work periods.',
    `template_code` STRING COMMENT 'Unique business identifier code for the shift template used for reference and lookup across systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `template_name` STRING COMMENT 'Human-readable name of the shift template (e.g., Day Shift 8-5, Night Shift 10-6, Weekend Rotation).',
    `time_zone` STRING COMMENT 'Time zone in which the shift times are defined (e.g., America/New_York, America/Chicago). Critical for multi-location scheduling.',
    `unpaid_break_minutes` STRING COMMENT 'Portion of break time that is not compensated, typically meal breaks of 30 minutes or more.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift template record was last modified in the system.',
    `vms_shift_code` STRING COMMENT 'External shift code used in the clients VMS system for integration and rate card mapping.',
    `weekend_shift` BOOLEAN COMMENT 'Indicates whether this shift template is designated for weekend work, which may carry premium rates or differential pay.',
    `worked_hours` DECIMAL(18,2) COMMENT 'Net worked hours excluding breaks. Used for payroll calculation and billable hours determination.',
    CONSTRAINT pk_shift_template PRIMARY KEY(`shift_template_id`)
) COMMENT 'Reusable shift definition template capturing standard shift configurations — shift name, start/end times, shift duration, and break rules';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` (
    `assignment_compliance_id` BIGINT COMMENT 'Unique surrogate identifier for each assignment-compliance requirement fulfillment record',
    `assignment_id` BIGINT COMMENT 'Foreign key linking to the worker assignment record that must satisfy this compliance requirement',
    `compliance_requirement_id` BIGINT COMMENT 'Foreign key to compliance.compliance_requirement.compliance_requirement_id',
    `requirement_id` BIGINT COMMENT 'Foreign key linking to the specific compliance requirement that must be fulfilled for this assignment',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal user (recruiter, compliance specialist, operations manager) who verified completion of this requirement for this assignment. Supports audit trail and accountability.',
    `completion_date` DATE COMMENT 'The date on which this compliance requirement was successfully fulfilled for this assignment. Used to calculate re-verification due dates and track compliance history.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment-compliance requirement record was created, typically at assignment activation when requirements are evaluated and assigned',
    `expiration_date` DATE COMMENT 'The date on which this completed requirement expires for this assignment and must be re-verified. Calculated from completion_date plus the requirements re_verification_interval_days. Null if requirement does not expire.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this assignment-compliance fulfillment record, tracking status changes, completions, and re-verifications',
    `re_verification_due_date` DATE COMMENT 'The date by which this requirement must be re-verified for this assignment to maintain compliance. Typically set before expiration_date to allow processing time. Drives operational workflows and alerts.',
    `requirement_status` STRING COMMENT 'Current status of this compliance requirement for this specific assignment: pending (not yet started), in_progress (documentation being collected), completed (requirement satisfied), waived (exception granted), expired (completed but now expired and needs re-verification), failed (requirement not met), not_applicable (requirement determined not to apply to this assignment)',
    `verification_method` STRING COMMENT 'The method used to verify fulfillment of this requirement for this assignment: document_review (manual review of uploaded documents), background_check (third-party BGC vendor), drug_test (lab results), training_completion (LMS integration), credential_verification (license/certification check), client_attestation (client confirmation), system_integration (automated verification via API)',
    `verification_notes` STRING COMMENT 'Free-text notes captured by the verifying user regarding the fulfillment of this requirement for this assignment. May include document names, vendor confirmation numbers, or special circumstances.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether a waiver or exception was granted for this requirement on this assignment, allowing the assignment to proceed despite non-completion',
    `waiver_reason` STRING COMMENT 'Business justification for granting a waiver for this requirement on this assignment. Required when waiver_flag is true. Captures approval authority and business rationale.',
    CONSTRAINT pk_assignment_compliance PRIMARY KEY(`assignment_compliance_id`)
) COMMENT 'This association product represents the compliance fulfillment relationship between a worker assignment and a regulatory or client-specific compliance requirement. It captures the operational tracking of which requirements must be satisfied for each assignment, the completion status, verification methods, and re-verification schedules. Each record links one assignment to one compliance requirement with attributes that exist only in the context of this specific assignment-requirement pairing, enabling the business to enforce compliance gates, track waivers, and manage re-verification workflows.. Existence Justification: In staffing operations, each worker assignment must satisfy multiple compliance requirements (I-9 employment eligibility, background checks, drug screens, client-specific credentials, industry certifications, training mandates). Simultaneously, each compliance requirement applies to many assignments across different workers, clients, and time periods. The business actively manages the fulfillment status of each assignment-requirement pairing, tracking completion dates, verification methods, waivers, expiration dates, and re-verification schedules as operational data that belongs to neither the assignment nor the requirement alone.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` (
    `assignment_sla_measurement_id` BIGINT COMMENT 'Unique identifier for this specific SLA measurement record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Foreign key linking to the worker assignment being measured against the SLA commitment',
    `sla_id` BIGINT COMMENT 'Foreign key linking to the SLA commitment being measured',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured performance value for this SLA metric for this specific assignment during the measurement period. Explicitly identified in detection phase relationship data.',
    `breach_flag` BOOLEAN COMMENT 'Indicates whether this specific assignment breached the SLA commitment during this measurement period. Explicitly identified in detection phase relationship data.',
    `measured_by` STRING COMMENT 'The system user or automated process that performed this SLA measurement calculation for this assignment.',
    `measurement_period_end` DATE COMMENT 'The end date of the period during which this SLA metric was measured for this assignment. Explicitly identified in detection phase relationship data.',
    `measurement_period_start` DATE COMMENT 'The start date of the period during which this SLA metric was measured for this assignment. Explicitly identified in detection phase relationship data.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA measurement was calculated and recorded for this assignment.',
    `notes` STRING COMMENT 'Free-text notes explaining special circumstances, adjustments, or context for this specific assignments SLA measurement result.',
    `penalty_credit_amount` DECIMAL(18,2) COMMENT 'The monetary penalty or credit amount triggered by this specific assignments performance against this SLA during this measurement period.',
    `target_value` DECIMAL(18,2) COMMENT 'The target threshold value that this assignment was measured against for this SLA during this period. Explicitly identified in detection phase relationship data.',
    `variance_from_target` DECIMAL(18,2) COMMENT 'The calculated difference between actual value and target value, indicating degree of over-performance or under-performance for this assignment-SLA combination.',
    CONSTRAINT pk_assignment_sla_measurement PRIMARY KEY(`assignment_sla_measurement_id`)
) COMMENT 'This association product represents the measurement record between assignment and sla. It captures the actual performance measurement of a specific SLA metric against a specific assignment during a defined measurement period. Each record links one assignment to one sla with the actual measured value, target comparison, breach determination, and measurement period boundaries that exist only in the context of this specific measurement event.. Existence Justification: In staffing operations, each worker assignment is measured against multiple SLA commitments (time-to-fill, quality-of-hire, retention rate, first-day no-show rate), and each SLA metric applies to many assignments across the client portfolio. The business actively manages SLA measurement as an operational process: for each assignment, performance is measured against applicable SLAs during defined measurement periods, actual values are compared to targets, breaches are flagged, and penalties/credits are calculated. This measurement data is used for client QBRs, scorecard reporting, and contract compliance tracking.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` (
    `assignment_credential_compliance_id` BIGINT COMMENT 'Unique system-generated identifier for each assignment-credential compliance record',
    `assignment_id` BIGINT COMMENT 'Foreign key linking to the worker assignment requiring credential verification',
    `credential_id` BIGINT COMMENT 'Foreign key linking to the credential type required for this assignment',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal user (recruiter, compliance officer, or placement coordinator) who performed the credential verification for this assignment',
    `compliance_notes` STRING COMMENT 'Free-text notes regarding compliance status, verification issues, or special circumstances for this credential on this assignment',
    `compliance_status` STRING COMMENT 'Current compliance state for this credential on this assignment. Compliant = verified and current; Pending_verification = submitted but not yet verified; Expired = credential lapsed during assignment; Waived = client approved waiver; Not_required = requirement removed. Captured from detection phase relationship data.',
    `expiration_date` DATE COMMENT 'The expiration date of the credential instance as it applies to this assignment. Tracked per assignment to trigger compliance alerts. Captured from detection phase relationship data.',
    `is_client_mandatory` BOOLEAN COMMENT 'Indicates whether this specific credential is mandatory per the client contract for this assignment, which may differ from the general credential definition',
    `last_compliance_check_date` DATE COMMENT 'Most recent date on which compliance status was reviewed or re-verified for this credential on this assignment',
    `next_compliance_check_date` DATE COMMENT 'Scheduled date for next compliance review, calculated based on credential renewal cycle and assignment duration',
    `verification_date` DATE COMMENT 'The date on which this specific credential was verified as valid for this assignment. Captured from detection phase relationship data.',
    `verification_method` STRING COMMENT 'The method used to verify this credential for this assignment. Primary_source = verified directly with issuing authority; Candidate_provided = document submitted by candidate; Client_verified = client performed verification; Third_party_service = verified via background check vendor; System_integration = auto-verified via API integration. Captured from detection phase relationship data.',
    `waiver_approval_date` DATE COMMENT 'Date on which the client approved a waiver for this credential requirement on this assignment',
    `waiver_expiration_date` DATE COMMENT 'Date on which the waiver expires and full compliance must be achieved',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether a compliance waiver was granted by the client for this credential on this specific assignment. Captured from detection phase relationship data.',
    `waiver_reason` STRING COMMENT 'Business justification for granting the credential waiver for this assignment',
    CONSTRAINT pk_assignment_credential_compliance PRIMARY KEY(`assignment_credential_compliance_id`)
) COMMENT 'This association product represents the compliance verification relationship between a worker assignment and a required credential. It captures the verification status, expiration tracking, and waiver management for each credential required for a specific assignment. Each record links one assignment to one credential with attributes that exist only in the context of ensuring placement compliance and regulatory adherence.. Existence Justification: In staffing operations, each assignment requires multiple credentials (professional licenses, safety certifications, immunizations, background checks, drug screens) and each credential type applies to many assignments over time. The business actively manages assignment-credential compliance as a distinct operational process, tracking verification dates, expiration monitoring, waiver approvals, and compliance status for each assignment-credential pair. This is not derivable from transaction history—it is an operational compliance management entity.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` (
    `location_compliance_mandate_id` BIGINT COMMENT 'Unique surrogate identifier for this location-requirement mandate record. Primary key.',
    `compliance_requirement_id` BIGINT COMMENT 'Foreign key to compliance.compliance_requirement identifying the requirement enforced at this location',
    `requirement_id` BIGINT COMMENT 'Foreign key linking to the compliance requirement that applies to this work location',
    `staff_profile_id` BIGINT COMMENT 'Reference to the compliance team member responsible for auditing this requirement at this location. Enables workload distribution and accountability tracking.',
    `work_location_id` BIGINT COMMENT 'Foreign key linking to the work location where this compliance requirement is enforced',
    `compliance_status` STRING COMMENT 'Current compliance state for this requirement at this location: compliant (all workers meet requirement), non_compliant (one or more violations detected), pending_review (audit in progress), exempt (location granted exemption), waived (client waived requirement).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this location-requirement mandate record was created in the system.',
    `effective_date` DATE COMMENT 'The date on which this compliance requirement became enforceable at this specific work location. May differ from the requirements global effective_date due to site-specific rollout schedules or client contract start dates.',
    `enforcement_level` STRING COMMENT 'Site-specific enforcement rigor for this requirement: strict (blocking - prevents placement if not met), standard (warning - flags non-compliance but allows placement with override), advisory (informational only). Driven by client contract terms and risk tolerance.',
    `exemption_reason` STRING COMMENT 'Narrative explanation if this location has been granted an exemption or waiver from this requirement. Includes reference to approval authority and expiration date if applicable.',
    `last_audit_date` DATE COMMENT 'The most recent date on which compliance with this requirement was audited at this work location. Used to track audit frequency and identify locations overdue for review.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this mandate record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this mandate record.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this requirement is mandatory (true) or recommended/optional (false) at this specific work location. Allows for site-specific enforcement variations where a federal requirement may be mandatory at federal contractor sites but optional elsewhere.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next compliance audit of this requirement at this location. Calculated based on compliance_frequency from the requirement master and last_audit_date.',
    `site_specific_notes` STRING COMMENT 'Free-text field capturing location-specific variations, exceptions, or implementation guidance for this requirement at this site. Examples: Client requires notarized I-9 copies, OSHA posting must be in both English and Spanish, Background check must include county-level search.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this mandate record.',
    CONSTRAINT pk_location_compliance_mandate PRIMARY KEY(`location_compliance_mandate_id`)
) COMMENT 'This association product represents the enforcement relationship between work locations and compliance requirements. It captures which federal, state, and client-specific compliance requirements are mandatory at each work location, along with site-specific enforcement parameters, audit history, and implementation status. Each record links one work location to one compliance requirement with attributes that exist only in the context of this site-specific mandate.. Existence Justification: In staffing operations, work locations are subject to multiple compliance requirements (OSHA postings, I-9 verification, state-specific rules, client contractual mandates, federal contractor obligations), and each compliance requirement applies to many work locations across the client portfolio. The compliance team actively manages which requirements are enforced at which sites, tracks site-specific enforcement levels (strict vs. advisory), conducts location-specific audits, and maintains site-specific implementation notes (e.g., Client requires bilingual OSHA postings). This is an operational enforcement relationship, not a derivable correlation.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` (
    `location_credential_requirement_id` BIGINT COMMENT 'Unique system-generated identifier for this location-credential requirement record. Primary key.',
    `credential_id` BIGINT COMMENT 'Foreign key linking to the credential that is required at this work location',
    `work_location_id` BIGINT COMMENT 'Foreign key to placement.work_location identifying the location with this requirement',
    `client_mandated_flag` BOOLEAN COMMENT 'Indicates whether this credential requirement was mandated by the client (true) versus being a Staffing Hr internal policy requirement (false). Affects waiver authority and compliance reporting.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this location-credential requirement record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this credential requirement becomes effective for this work location. Workers placed after this date must possess this credential.',
    `end_date` DATE COMMENT 'The date on which this credential requirement is no longer enforced for this work location. Null indicates an ongoing requirement.',
    `grace_period_days` STRING COMMENT 'Number of days after credential expiration during which the worker can continue working at this location while renewal is in progress. Overrides the credential definition grace period when location-specific rules apply.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this requirement record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this requirement record.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this credential is absolutely mandatory for placement at this location (true) or preferred but not blocking (false). Mandatory credentials block placement if not held.',
    `notes` STRING COMMENT 'Free-text notes explaining location-specific nuances of this credential requirement, such as client-specific verification procedures or exemption conditions.',
    `requirement_status` STRING COMMENT 'Current lifecycle status of this location-credential requirement. Active requirements are enforced during placement eligibility checks.',
    `verification_level` STRING COMMENT 'The level of verification required for this credential at this specific location. Some high-security or healthcare locations may require primary source verification even when the credential definition allows secondary verification.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this requirement record.',
    CONSTRAINT pk_location_credential_requirement PRIMARY KEY(`location_credential_requirement_id`)
) COMMENT 'This association product represents the credential requirements mandated for a specific work location. It captures which credentials are required for workers to be placed at each location, with location-specific enforcement rules and effective dates. Each record links one work location to one credential with attributes that define the requirement parameters for that specific location-credential combination.. Existence Justification: In staffing operations, work locations require multiple credentials (state licenses, facility-specific badges, OSHA certifications, immunizations, security clearances) and each credential type applies to multiple work locations across the client portfolio. The business actively manages location-credential requirement matrices to ensure placement compliance, with location-specific enforcement rules such as mandatory vs. preferred status, verification levels, and grace periods that vary by client site.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_supervisor_id` FOREIGN KEY (`supervisor_id`) REFERENCES `staffing_hr_ecm`.`placement`.`supervisor`(`supervisor_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_primary_replacement_placement_direct_hire_id` FOREIGN KEY (`primary_replacement_placement_direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_replacement_conversion_id` FOREIGN KEY (`replacement_conversion_id`) REFERENCES `staffing_hr_ecm`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_bench_roster_id` FOREIGN KEY (`bench_roster_id`) REFERENCES `staffing_hr_ecm`.`placement`.`bench_roster`(`bench_roster_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_target_placement_assignment_id` FOREIGN KEY (`target_placement_assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_backfill_replacement_assignment_id` FOREIGN KEY (`backfill_replacement_assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_backfill_id` FOREIGN KEY (`backfill_id`) REFERENCES `staffing_hr_ecm`.`placement`.`backfill`(`backfill_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ADD CONSTRAINT `fk_placement_per_diem_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ADD CONSTRAINT `fk_placement_per_diem_placement_assignment_id` FOREIGN KEY (`placement_assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ADD CONSTRAINT `fk_placement_per_diem_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ADD CONSTRAINT `fk_placement_bench_roster_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ADD CONSTRAINT `fk_placement_bench_roster_prior_bench_roster_id` FOREIGN KEY (`prior_bench_roster_id`) REFERENCES `staffing_hr_ecm`.`placement`.`bench_roster`(`bench_roster_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_supervisor_id` FOREIGN KEY (`supervisor_id`) REFERENCES `staffing_hr_ecm`.`placement`.`supervisor`(`supervisor_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_worker_schedule_id` FOREIGN KEY (`worker_schedule_id`) REFERENCES `staffing_hr_ecm`.`placement`.`worker_schedule`(`worker_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_replacement_dispatch_order_id` FOREIGN KEY (`replacement_dispatch_order_id`) REFERENCES `staffing_hr_ecm`.`placement`.`dispatch_order`(`dispatch_order_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ADD CONSTRAINT `fk_placement_worker_schedule_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ADD CONSTRAINT `fk_placement_worker_schedule_shift_template_id` FOREIGN KEY (`shift_template_id`) REFERENCES `staffing_hr_ecm`.`placement`.`shift_template`(`shift_template_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ADD CONSTRAINT `fk_placement_worker_schedule_supervisor_id` FOREIGN KEY (`supervisor_id`) REFERENCES `staffing_hr_ecm`.`placement`.`supervisor`(`supervisor_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ADD CONSTRAINT `fk_placement_worker_schedule_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ADD CONSTRAINT `fk_placement_worker_schedule_original_worker_schedule_id` FOREIGN KEY (`original_worker_schedule_id`) REFERENCES `staffing_hr_ecm`.`placement`.`worker_schedule`(`worker_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ADD CONSTRAINT `fk_placement_schedule_exception_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ADD CONSTRAINT `fk_placement_schedule_exception_supervisor_id` FOREIGN KEY (`supervisor_id`) REFERENCES `staffing_hr_ecm`.`placement`.`supervisor`(`supervisor_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ADD CONSTRAINT `fk_placement_schedule_exception_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ADD CONSTRAINT `fk_placement_schedule_exception_worker_schedule_id` FOREIGN KEY (`worker_schedule_id`) REFERENCES `staffing_hr_ecm`.`placement`.`worker_schedule`(`worker_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ADD CONSTRAINT `fk_placement_schedule_exception_original_schedule_exception_id` FOREIGN KEY (`original_schedule_exception_id`) REFERENCES `staffing_hr_ecm`.`placement`.`schedule_exception`(`schedule_exception_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ADD CONSTRAINT `fk_placement_shift_template_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ADD CONSTRAINT `fk_placement_shift_template_base_shift_template_id` FOREIGN KEY (`base_shift_template_id`) REFERENCES `staffing_hr_ecm`.`placement`.`shift_template`(`shift_template_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ADD CONSTRAINT `fk_placement_assignment_sla_measurement_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ADD CONSTRAINT `fk_placement_assignment_credential_compliance_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ADD CONSTRAINT `fk_placement_location_compliance_mandate_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ADD CONSTRAINT `fk_placement_location_credential_requirement_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm`.`placement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `staffing_hr_ecm`.`placement` SET TAGS ('dbx_domain' = 'placement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `right_to_represent_id` SET TAGS ('dbx_business_glossary_term' = 'Right To Represent Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `supervisor_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `tier_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Classification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|ended|extended|converted|cancelled');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'temp|contract|contract_to_hire|temp_to_perm|direct_hire');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `bgc_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `bgc_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|clear|adverse|waived');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `bullhorn_placement_reference` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `conversion_fee` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `conversion_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Client Department');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|negative|positive|waived');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `end_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `end_reason` SET TAGS ('dbx_value_regex' = 'assignment_completed|client_terminated|worker_resigned|converted_to_perm|cancelled|no_show');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Assignment Extension Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `i9_verified` SET TAGS ('dbx_business_glossary_term' = 'I-9 Employment Eligibility Verification Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `is_backfill` SET TAGS ('dbx_business_glossary_term' = 'Backfill Assignment Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `is_redeployment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Eligibility Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `per_diem_eligible` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Eligibility Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `scheduled_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours Per Week');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `spread` SET TAGS ('dbx_business_glossary_term' = 'Spread (Bill Rate Minus Pay Rate)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `spread` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification (W-2 / 1099 / Corp-to-Corp / Employer of Record)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|corp_to_corp|eor');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ALTER COLUMN `workers_comp_code` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Agreement Envelope Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `bgc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Bgc Order Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Fee Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `placement_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Compliance Check Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `primary_replacement_placement_direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `readiness_status_id` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `right_to_represent_id` SET TAGS ('dbx_business_glossary_term' = 'Right To Represent Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Submittal Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Candidate Base Salary');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `base_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `bgc_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `bgc_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|passed|failed|adjudicated');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `bullhorn_placement_reference` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `conversion_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `conversion_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Client Department');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed|waived');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `eeoc_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity Commission (EEOC) Job Category');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `exempt_status` SET TAGS ('dbx_business_glossary_term' = 'FLSA Exempt Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `exempt_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `fall_off_date` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `fall_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `fee_collected` SET TAGS ('dbx_business_glossary_term' = 'Fee Collected Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `fee_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Fee Invoiced Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `fee_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `fee_payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|upon_start|split');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Placement Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `guarantee_end_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `guarantee_period_days` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period (Days)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `i9_verified` SET TAGS ('dbx_business_glossary_term' = 'I-9 Employment Eligibility Verified Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Placed Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Placement Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `placement_number` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Placement Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Placement Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `placement_status` SET TAGS ('dbx_value_regex' = 'offered|accepted|started|fell_off|replaced');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Placement Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'direct_hire|temp_to_perm|contract_to_hire');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `replacement_obligation` SET TAGS ('dbx_business_glossary_term' = 'Replacement Obligation Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Sourcing Channel');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `assignment_extension_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Extension ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Approval Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `bullhorn_extension_reference` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Extension Record ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `client_approver_email` SET TAGS ('dbx_business_glossary_term' = 'Client Approver Email Address');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `client_approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `client_approver_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `client_approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `client_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Client Approver Name');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `conversion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Executed Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Extension Duration Days');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_number` SET TAGS ('dbx_business_glossary_term' = 'Extension Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_number` SET TAGS ('dbx_value_regex' = '^EXT-[0-9]{6,12}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_reason_code` SET TAGS ('dbx_value_regex' = 'project_continuation|headcount_backfill|client_request|worker_request|sow_extension|other');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Extension Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_status` SET TAGS ('dbx_business_glossary_term' = 'Extension Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `extension_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|executed|cancelled');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `fall_off_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Risk Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `msp_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Program Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `new_end_date` SET TAGS ('dbx_business_glossary_term' = 'New Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `prior_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Prior Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `prior_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `prior_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `prior_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Prior Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `prior_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `prior_pay_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `rate_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `redeployment_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Candidate Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Rejection Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Request Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `revised_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Revised Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `revised_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `revised_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Revised Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `revised_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `revised_pay_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `spread_prior` SET TAGS ('dbx_business_glossary_term' = 'Prior Spread (Bill Rate minus Pay Rate)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `spread_prior` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `spread_revised` SET TAGS ('dbx_business_glossary_term' = 'Revised Spread (Bill Rate minus Pay Rate)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `spread_revised` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification (W-2 / 1099 / Corp-to-Corp)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|corp_to_corp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Agreement Envelope Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `branch_office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Office Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `conversion_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Branch ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `readiness_status_id` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `replacement_conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Conversion ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Submittal Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `worker_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked Prior to Conversion');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Original Assignment Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `bullhorn_conversion_reference` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Conversion External ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `client_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Client Confirmation Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|invoiced|fell_off|cancelled');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type (Temp-to-Perm / Contract-to-Hire)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `conversion_type` SET TAGS ('dbx_value_regex' = 'temp_to_perm|contract_to_hire|direct_conversion');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `converted_worker_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Converted Worker Annual Salary');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `converted_worker_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fall_off_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fall-Off Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fall_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fall-Off Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fall_off_reason` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|client_termination|role_eliminated|candidate_no_show|other');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_basis_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Basis Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_basis_type` SET TAGS ('dbx_value_regex' = 'percentage_of_salary|flat_fee|negotiated');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Approved By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Waiver Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_value_regex' = 'msa_tenure_clause|client_relationship|negotiated_waiver|minimum_hours_met|other');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `guarantee_period_days` SET TAGS ('dbx_business_glossary_term' = 'Conversion Guarantee Period (Days)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Invoice Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Converted Role Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `minimum_tenure_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tenure Hours for Fee Waiver');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Conversion Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Notice Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Payment Due Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Payment Received Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `permanent_start_date` SET TAGS ('dbx_business_glossary_term' = 'Permanent Employment Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|beeline|manual|other');
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `assignment_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status History ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Changed By User ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `quaternary_assignment_approved_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `tertiary_assignment_account_manager_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'VMS (Vendor Management System) Program ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `actual_transition_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Status Transition Hours');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Description');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `client_contact_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Notified Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `compliance_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `compliance_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `days_in_prior_status` SET TAGS ('dbx_business_glossary_term' = 'Days in Prior Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `is_backfill` SET TAGS ('dbx_business_glossary_term' = 'Is Backfill Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `is_conversion` SET TAGS ('dbx_business_glossary_term' = 'Is Conversion Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `is_extension` SET TAGS ('dbx_business_glossary_term' = 'Is Extension Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `is_fall_off` SET TAGS ('dbx_business_glossary_term' = 'Is Fall-Off Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `is_redeployment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Redeployment Eligible Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Assignment Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'temporary|contract_to_hire|temp_to_perm|direct_hire|sow');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Assignment Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Breach Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Target Hours');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|beeline_vms|sap_successfactors|tempworks|kronos|manual_entry');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `source_system_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `transition_source` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Source');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `transition_source` SET TAGS ('dbx_value_regex' = 'manual|system_automated|vms_sync|api_integration|bulk_update');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'w2_employee|1099_contractor|corp_to_corp|eor');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_id` SET TAGS ('dbx_business_glossary_term' = 'Redeployment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `bench_roster_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Roster Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Target Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Ending Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ending Client ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Coordinator ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Submittal Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `target_client_client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Target Client ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `target_placement_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `actual_redeploy_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Redeployment Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `availability_date` SET TAGS ('dbx_business_glossary_term' = 'Candidate Availability Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `bench_cost_risk` SET TAGS ('dbx_business_glossary_term' = 'Bench Cost Risk');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `bench_cost_risk` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `conversion_fee` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `conversion_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `interviews_count` SET TAGS ('dbx_business_glossary_term' = 'Interviews Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `is_backfill` SET TAGS ('dbx_business_glossary_term' = 'Is Backfill');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `last_outreach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Outcome');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'redeployed|converted|separated|extended|declined|no_show');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `outreach_attempts` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempts');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `pay_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Currency');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `pay_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `pay_rate_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `pay_rate_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `preferred_location` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work Location');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `preferred_work_state` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work State');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `preferred_work_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `preferred_work_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `preferred_work_type` SET TAGS ('dbx_value_regex' = 'temporary|contract|temp_to_perm|direct_hire|per_diem');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `primary_skill` SET TAGS ('dbx_business_glossary_term' = 'Primary Skill');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Priority Level');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_number` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_number` SET TAGS ('dbx_value_regex' = '^RDP-[0-9]{7}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_source` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Source');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_source` SET TAGS ('dbx_value_regex' = 'bullhorn_workflow|manual_entry|vms_notification|coordinator_initiated|system_auto');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_status` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_status` SET TAGS ('dbx_value_regex' = 'bench|in_process|redeployed|converted|separated');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_type` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `redeployment_type` SET TAGS ('dbx_value_regex' = 'internal_transfer|new_client|temp_to_perm|contract_extension|reactivation');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `separation_reason` SET TAGS ('dbx_business_glossary_term' = 'Separation Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `submittals_count` SET TAGS ('dbx_business_glossary_term' = 'Submittals Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `target_redeploy_date` SET TAGS ('dbx_business_glossary_term' = 'Target Redeployment Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `willing_to_relocate` SET TAGS ('dbx_business_glossary_term' = 'Willing to Relocate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'W2|1099|C2C|EOR');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `backfill_id` SET TAGS ('dbx_business_glossary_term' = 'Backfill ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Original Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `backfill_replacement_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `backfill_replacement_candidate_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `osha_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Osha Incident Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Submittal Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `backfill_number` SET TAGS ('dbx_business_glossary_term' = 'Backfill Request Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `backfill_number` SET TAGS ('dbx_value_regex' = '^BKF-[0-9]{6,10}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `backfill_status` SET TAGS ('dbx_business_glossary_term' = 'Backfill Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `backfill_status` SET TAGS ('dbx_value_regex' = 'open|filled|cancelled|on_hold|escalated');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Backfill Cancelled Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `client_supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Client Supervisor Name');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `client_supervisor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `days_to_backfill` SET TAGS ('dbx_business_glossary_term' = 'Days to Backfill');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Client Department');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `fall_off_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Reason Category');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `fall_off_reason_category` SET TAGS ('dbx_value_regex' = 'candidate_quality|client_issue|external_factor|recruiter_error|unknown');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Backfill Filled Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `is_fall_off` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `is_redeployment_candidate` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Candidate Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Backfill Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `original_assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'temporary|contract_to_hire|temp_to_perm|direct_hire');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Backfill Priority Level');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Backfill Request Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `required_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Required Fill Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|beeline|manual|other');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `source_system_backfill_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Backfill ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `trigger_detail` SET TAGS ('dbx_business_glossary_term' = 'Backfill Trigger Detail');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Backfill Trigger Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Identifier');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `client_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Placement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Rate Approved By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rate Approved Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `burden_rate` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `burden_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `conversion_fee` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `conversion_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `direct_hire_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `direct_hire_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `dt_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `dt_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `dt_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `dt_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `gsa_rate_reference` SET TAGS ('dbx_business_glossary_term' = 'IRS GSA (General Services Administration) Rate Reference');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `holiday_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Holiday Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `holiday_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `holiday_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Holiday Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `holiday_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Rate Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `job_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `per_diem_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Per Diem (Per Diem) Budget Cap');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `per_diem_category` SET TAGS ('dbx_business_glossary_term' = 'Per Diem (Per Diem) Category');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `per_diem_category` SET TAGS ('dbx_value_regex' = 'travel|lodging|meals|incidentals');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `per_diem_daily_allowance` SET TAGS ('dbx_business_glossary_term' = 'Per Diem (Per Diem) Daily Allowance');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'temporary|contract_to_hire|direct_hire|sow');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Source');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'bullhorn|beeline_vms|tempworks|manual');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'standard|overtime|double_time|holiday|per_diem|burden');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Reimbursement Method');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_value_regex' = 'actual_expense|flat_rate|gsa_rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Spread Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `spread_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `unit` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|fixed');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `vms_rate_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Rate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `work_state_code` SET TAGS ('dbx_business_glossary_term' = 'Work State Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `work_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `workers_comp_rate` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ALTER COLUMN `workers_comp_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `credential_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Requirement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `ofccp_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Ofccp Audit Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `ot_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Rule ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Client Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `vms_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Enrollment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Work Location Address Line 1');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Work Location Address Line 2');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `bgc_level` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Level');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `bgc_level` SET TAGS ('dbx_value_regex' = 'basic|standard|enhanced|federal');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Work Location City');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Work Location Closure Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Country Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `dress_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Dress Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `dress_code` SET TAGS ('dbx_value_regex' = 'business_formal|business_casual|smart_casual|casual|safety_ppe|uniform_required');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Work Location Effective Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `federal_contractor_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Contractor Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `i9_verification_method` SET TAGS ('dbx_business_glossary_term' = 'I-9 Employment Eligibility Verification Method');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `i9_verification_method` SET TAGS ('dbx_value_regex' = 'physical|remote_authorized|e_verify');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Work Location Latitude');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Work Location Name');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Work Location Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Work Location Longitude');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Work Location Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `osha_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Establishment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `parking_available` SET TAGS ('dbx_business_glossary_term' = 'Parking Available Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `per_diem_eligible` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Postal Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `public_transit_accessible` SET TAGS ('dbx_business_glossary_term' = 'Public Transit Accessible Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `remote_work_type` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `remote_work_type` SET TAGS ('dbx_value_regex' = 'fully_remote|hybrid_remote|not_remote');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Work Location Shift Pattern');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|split|flexible');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Email Address');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Work Location State or Province');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Work Location Time Zone');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `vms_site_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Site ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `worker_capacity` SET TAGS ('dbx_business_glossary_term' = 'Worker Capacity');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `workers_comp_class_code` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Classification Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ALTER COLUMN `workers_comp_class_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `supervisor_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Contact ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `nda_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `assignment_checkin_contact` SET TAGS ('dbx_business_glossary_term' = 'Assignment Check-In Contact Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `current_active_assignments` SET TAGS ('dbx_business_glossary_term' = 'Current Active Assignment Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Department');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Email Address');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor First Name');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Full Name');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `i9_verification_contact` SET TAGS ('dbx_business_glossary_term' = 'I-9 Verification Contact Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Language Preference');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Last Name');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `max_direct_reports` SET TAGS ('dbx_business_glossary_term' = 'Maximum Direct Reports');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Mobile Phone Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `msp_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Program Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `nda_on_file` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) On File Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `onboarding_contact` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Contact Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `performance_escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Performance Escalation Contact Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Phone Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|vms_portal|text');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `safety_orientation_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Orientation Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `secondary_email` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Secondary Email Address');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `secondary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `secondary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `secondary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|beeline|manual|salesforce|successfactors');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `source_system_contact_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Contact ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `sow_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Authority Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `supervisor_status` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Record Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `supervisor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `supervisor_type` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `supervisor_type` SET TAGS ('dbx_value_regex' = 'direct_manager|site_supervisor|project_lead|department_head|vms_manager');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Time Zone');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `timesheet_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Approval Authority Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `vms_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Contact Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `vms_user_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) User ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `vms_user_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ALTER COLUMN `vms_user_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `fall_off_id` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `backfill_id` SET TAGS ('dbx_business_glossary_term' = 'Backfill Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Branch ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Submittal Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `bullhorn_fall_off_reference` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Fall-Off Source System ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `client_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notified Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `days_to_fall_off` SET TAGS ('dbx_business_glossary_term' = 'Days to Fall-Off');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `fall_off_date` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `fall_off_number` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Reference Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `fall_off_status` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `fall_off_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|replacement_in_progress|closed|cancelled');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `fee_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Credit Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `fee_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `guarantee_period_days` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period Days');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `msp_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Program Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `placement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Placement Fee Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `placement_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'temporary|contract_to_hire|temp_to_perm|direct_hire|permanent');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Reason Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'candidate_quit|client_termination|no_show|performance|personal|other');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Reason Detail');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `redeployment_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Candidate Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `replacement_deadline` SET TAGS ('dbx_business_glossary_term' = 'Replacement Deadline Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `replacement_fulfilled_date` SET TAGS ('dbx_business_glossary_term' = 'Replacement Fulfilled Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `replacement_obligation` SET TAGS ('dbx_business_glossary_term' = 'Replacement Obligation Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `replacement_status` SET TAGS ('dbx_business_glossary_term' = 'Replacement Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `replacement_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|fulfilled|failed|waived');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `revenue_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `revenue_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|manual|vms_import|other');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `within_guarantee_period` SET TAGS ('dbx_business_glossary_term' = 'Within Guarantee Period Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Engagement Identifier');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `readiness_status_id` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `right_to_represent_id` SET TAGS ('dbx_business_glossary_term' = 'Right To Represent Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) SOW Identifier');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `worker_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'SOW Actual End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `bgc_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `bgc_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed|expired');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `co_employment_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Co-Employment Risk Level');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `co_employment_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `co_employment_risk_notes` SET TAGS ('dbx_business_glossary_term' = 'Co-Employment Risk Assessment Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'SOW Deliverable Description');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Client Department');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'SOW Engagement End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'SOW Engagement Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'SOW Engagement Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|terminated|on_hold');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'SOW Engagement Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'fixed_price|time_and_materials|milestone_based|retainer');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'SOW Extension Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `fall_off_date` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `fall_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `fall_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `fall_off_reason` SET TAGS ('dbx_value_regex' = 'candidate_withdrew|client_terminated|performance|scope_change|budget_cut|other');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `i9_verified` SET TAGS ('dbx_business_glossary_term' = 'I-9 Employment Eligibility Verified Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `ic_classification_flag` SET TAGS ('dbx_business_glossary_term' = 'Independent Contractor (IC) Classification Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'SOW Invoiced Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'SOW Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `milestone_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Milestone-Based Billing Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `msp_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Managed Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'SOW Placement Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'sow_ic|sow_w2|sow_vendor');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `redeployment_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Candidate Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'docusign_clm|beeline_vms|bullhorn|manual');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `sow_number` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Reference Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `sow_number` SET TAGS ('dbx_value_regex' = '^SOW-[A-Z0-9]{4,20}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `sow_title` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `total_hours_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Total Budgeted Hours');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `total_sow_value` SET TAGS ('dbx_business_glossary_term' = 'Total Statement of Work (SOW) Value');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `total_sow_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `per_diem_id` SET TAGS ('dbx_business_glossary_term' = 'Per Diem ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `contract_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `placement_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Wage Hour Determination Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Approval Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Approval Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|expired');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Approved By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `billable_to_client_flag` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Billable to Client Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `bullhorn_assignment_ref` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Assignment Reference');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `client_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Approved Per Diem Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `client_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Client Per Diem Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `client_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Daily Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `distance_from_home_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance from Home (Miles)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Effective Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Per Diem Payment Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `gsa_locality_rate` SET TAGS ('dbx_business_glossary_term' = 'GSA Locality Per Diem Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `gsa_location_code` SET TAGS ('dbx_business_glossary_term' = 'GSA Location Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `gsa_rate_year` SET TAGS ('dbx_business_glossary_term' = 'GSA Rate Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Per Diem Payment Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `overnight_stay_required` SET TAGS ('dbx_business_glossary_term' = 'Overnight Stay Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Pay Frequency');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|per_occurrence');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `per_diem_number` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `per_diem_number` SET TAGS ('dbx_value_regex' = '^PD-[0-9]{8,12}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `per_diem_type` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `per_diem_type` SET TAGS ('dbx_value_regex' = 'travel|lodging|meals|incidentals|meals_and_incidentals');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Reimbursement Method');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_value_regex' = 'payroll_included|separate_expense|direct_deposit|client_billed');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Per Diem Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Taxable Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `tempworks_per_diem_reference` SET TAGS ('dbx_business_glossary_term' = 'TempWorks Per Diem Configuration ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `total_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Per Diem Budget');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `total_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `total_days_eligible` SET TAGS ('dbx_business_glossary_term' = 'Total Per Diem Eligible Days');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `weekend_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Per Diem Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `worker_home_zip` SET TAGS ('dbx_business_glossary_term' = 'Worker Home ZIP Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `worker_home_zip` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `worker_home_zip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ALTER COLUMN `worker_home_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `bgc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Bgc Order Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'Esignature Envelope Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `offer_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `readiness_status_id` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Submittal ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Wage Hour Determination Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Offered Annual Salary');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `annual_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `bgc_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Offered Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `bullhorn_offer_reference` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Offer ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `counter_offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Counter-Offer Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `counter_offer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `counter_offer_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `counter_offer_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Counter-Offer Rate Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `counter_offer_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|annual|fixed');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `declined_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Declined Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Client Department');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `exempt_status` SET TAGS ('dbx_business_glossary_term' = 'FLSA Exempt Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `exempt_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Offered Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `msp_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Program Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `negotiation_round_count` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Offer Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `offer_number` SET TAGS ('dbx_business_glossary_term' = 'Offer Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|rescinded|expired|counter_offered');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'temp|contract_to_hire|perm|sow');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Offered Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'temporary|temp_to_perm|contract_to_hire|direct_hire|sow');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|annual|fixed');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `rescind_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rescind Reason Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `rescinded_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Rescinded Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `sign_on_bonus` SET TAGS ('dbx_business_glossary_term' = 'Sign-On Bonus Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `sign_on_bonus` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `sign_on_bonus` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `to_acceptance_days` SET TAGS ('dbx_business_glossary_term' = 'Offer-to-Acceptance Cycle Time (Days)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|corp_to_corp|eor');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` SET TAGS ('dbx_subdomain' = 'worker_engagement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bench_roster_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Roster ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Ending Placement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ending Client ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `readiness_status_id` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `prior_bench_roster_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `assignment_end_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `availability_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bench_cost_risk` SET TAGS ('dbx_business_glossary_term' = 'Bench Cost Risk');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bench_cost_risk` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bench_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Bench Entry Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bench_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bench Entry Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bench_roster_number` SET TAGS ('dbx_business_glossary_term' = 'Bench Roster Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bench_status` SET TAGS ('dbx_business_glossary_term' = 'Bench Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bench_status` SET TAGS ('dbx_value_regex' = 'available|in_process|redeployed|separated|on_hold|inactive');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bgc_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bgc_status` SET TAGS ('dbx_value_regex' = 'clear|pending|expired|flagged');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `bullhorn_candidate_reference` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|expiring_soon|expired|pending');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `days_on_bench` SET TAGS ('dbx_business_glossary_term' = 'Days on Bench');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_value_regex' = 'clear|pending|expired|failed');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `ending_job_title` SET TAGS ('dbx_business_glossary_term' = 'Ending Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `i9_verified` SET TAGS ('dbx_business_glossary_term' = 'I-9 (Employment Eligibility Verification) Verified');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `interviews_count` SET TAGS ('dbx_business_glossary_term' = 'Interviews Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `last_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Last Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `last_outreach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `last_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Last Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `minimum_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Bench Roster Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `outreach_attempts` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempts');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `preferred_location` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work Location');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `preferred_state` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work State');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `preferred_work_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `preferred_work_type` SET TAGS ('dbx_value_regex' = 'temporary|temp_to_perm|contract_to_hire|direct_hire|any');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `primary_skill` SET TAGS ('dbx_business_glossary_term' = 'Primary Skill');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Priority Level');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `redeployment_readiness` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Readiness');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `redeployment_readiness` SET TAGS ('dbx_value_regex' = 'ready|pending_compliance|pending_availability|not_ready');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `skill_summary` SET TAGS ('dbx_business_glossary_term' = 'Skill Summary');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `submittals_count` SET TAGS ('dbx_business_glossary_term' = 'Submittals Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `target_redeploy_date` SET TAGS ('dbx_business_glossary_term' = 'Target Redeployment Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `willing_to_relocate` SET TAGS ('dbx_business_glossary_term' = 'Willing to Relocate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|ic');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `dispatch_order_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `supervisor_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `worker_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `replacement_dispatch_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `client_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Client Confirmed Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Method');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_value_regex' = 'phone|email|sms|vms|mobile_app|portal');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|AUD');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Order Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Order Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Order Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `is_backfill` SET TAGS ('dbx_business_glossary_term' = 'Backfill Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `is_emergency_dispatch` SET TAGS ('dbx_business_glossary_term' = 'Emergency Dispatch Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|ic|temp|contract');
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ALTER COLUMN `worker_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Worker Confirmed Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `worker_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Schedule ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `shift_template_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `supervisor_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `original_worker_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Party');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_value_regex' = 'worker|client|staffing_agency|system');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `confirmation_required` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `confirmed_by_worker` SET TAGS ('dbx_business_glossary_term' = 'Confirmed By Worker Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `dispatch_method` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Method');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `dispatch_method` SET TAGS ('dbx_value_regex' = 'manual|automated|self_service|mobile_app');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `source_system_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Schedule ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ALTER COLUMN `worker_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Worker Confirmation Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `schedule_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Exception ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `supervisor_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `worker_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `original_schedule_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `billing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `disciplinary_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `exception_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `exception_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Exception Duration Minutes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|disputed|resolved');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'no_show|late_arrival|early_departure|shift_swap|unscheduled_absence|schedule_change');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `hours_lost` SET TAGS ('dbx_business_glossary_term' = 'Hours Lost');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `kronos_exception_reference` SET TAGS ('dbx_business_glossary_term' = 'Kronos Exception ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `occurrence_count` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Count');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `pattern_flag` SET TAGS ('dbx_business_glossary_term' = 'Pattern Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `payroll_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Impact Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'illness|personal|transportation|weather|family_emergency|no_call_no_show');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Reason Detail');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `replacement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Required Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ALTER COLUMN `vms_exception_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Exception ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_template_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Template ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `base_shift_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Days of Week');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `differential_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Differential Rate Percentage');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `double_time_eligible` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Eligible');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `holiday_shift` SET TAGS ('dbx_business_glossary_term' = 'Holiday Shift');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `on_call_shift` SET TAGS ('dbx_business_glossary_term' = 'On-Call Shift');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `ot_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Threshold Hours');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Eligible');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `paid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Minutes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Eligible');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_differential_eligible` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Eligible');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Hours');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_template_description` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Description');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_template_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_template_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|split|on_call');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `split_shift` SET TAGS ('dbx_business_glossary_term' = 'Split Shift');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Name');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `unpaid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Unpaid Break Minutes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `vms_shift_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Shift Code');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `weekend_shift` SET TAGS ('dbx_business_glossary_term' = 'Weekend Shift');
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ALTER COLUMN `worked_hours` SET TAGS ('dbx_business_glossary_term' = 'Worked Hours');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` SET TAGS ('dbx_subdomain' = 'regulatory_adherence');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` SET TAGS ('dbx_association_edges' = 'placement.assignment,compliance.compliance_requirement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `assignment_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Compliance Fulfillment ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Compliance - Assignment Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `compliance_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Compliance - Compliance Requirement Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Verifying User ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Completion Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `re_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Re-verification Due Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Fulfillment Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Indicator');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` SET TAGS ('dbx_subdomain' = 'regulatory_adherence');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` SET TAGS ('dbx_association_edges' = 'placement.assignment,contract.sla');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `assignment_sla_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment SLA Measurement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Sla Measurement - Assignment Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Sla Measurement - Sla Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Value');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `measured_by` SET TAGS ('dbx_business_glossary_term' = 'Measured By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `penalty_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty or Credit Amount');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ALTER COLUMN `variance_from_target` SET TAGS ('dbx_business_glossary_term' = 'Variance from Target');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` SET TAGS ('dbx_subdomain' = 'regulatory_adherence');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` SET TAGS ('dbx_association_edges' = 'placement.assignment,credentialing.credential');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `assignment_credential_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Credential Compliance ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Credential Compliance - Assignment Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Credential Compliance - Credential Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `is_client_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Client Mandatory');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `last_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Check Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `next_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Check Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` SET TAGS ('dbx_subdomain' = 'regulatory_adherence');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` SET TAGS ('dbx_association_edges' = 'placement.work_location,compliance.compliance_requirement');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `location_compliance_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Location Compliance Mandate ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `compliance_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Location Compliance Mandate - Compliance Requirement Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Auditor ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Compliance Mandate - Work Location Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Effective Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Level');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `site_specific_notes` SET TAGS ('dbx_business_glossary_term' = 'Site Specific Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_adherence');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` SET TAGS ('dbx_association_edges' = 'placement.work_location,credentialing.credential');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `location_credential_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Location Credential Requirement ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Location Credential Requirement - Credential Id');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `client_mandated_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Mandated Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Created Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement End Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Location-Specific Grace Period');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Requirement Last Modified By');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Last Modified Date');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Requirement Flag');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `verification_level` SET TAGS ('dbx_business_glossary_term' = 'Verification Level Required');
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Requirement Created By');
