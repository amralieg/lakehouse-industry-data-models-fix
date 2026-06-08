-- Schema for Domain: contract | Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm`.`contract` COMMENT 'Owns all commercial agreement and contract lifecycle data. Covers Master Service Agreements (MSA) terms, Statements of Work (SOW) execution, rate schedule amendments, non-disclosure agreements (NDA), non-compete clauses, service level agreements (SLA), contract amendments, renewal and expiration tracking, and e-signature workflows via DocuSign CLM. SSOT for the legal and commercial terms governing all client and vendor contractual commitments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`msa` (
    `msa_id` BIGINT COMMENT 'Primary key for msa',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that this MSA governs. Links to the client account hierarchy.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: MSAs are managed by internal account managers/contract administrators. Staffing firms track MSA ownership for renewal alerts, compliance monitoring, and client relationship management. contract_owner_',
    `envelope_id` BIGINT COMMENT 'Unique envelope identifier from DocuSign CLM system for the executed MSA document package.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: MSAs are executed by specific legal entities. Required for financial consolidation, intercompany elimination, tax jurisdiction determination, and regulatory reporting. Staffing firms operate multiple ',
    `amendment_count` STRING COMMENT 'Total number of formal amendments executed against this MSA since original execution.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the MSA automatically renews at the end of each term unless terminated.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether background checks are mandatory for all candidates placed under this MSA.',
    `client_signatory_name` STRING COMMENT 'Name of the authorized client representative who signed the MSA on behalf of the client organization.',
    `client_signatory_title` STRING COMMENT 'Job title of the client signatory (e.g., Chief Procurement Officer, VP Human Resources).',
    `confidentiality_term_years` STRING COMMENT 'Number of years that confidentiality obligations survive after MSA termination.',
    `conversion_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of the candidates annual salary owed to the staffing firm if the client converts a temporary placement to permanent hire.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MSA record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Primary method specified in the MSA for resolving disputes between parties.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `drug_screen_required_flag` BOOLEAN COMMENT 'Indicates whether drug screening is mandatory for all candidates placed under this MSA.',
    `effective_date` DATE COMMENT 'Date when the MSA becomes legally binding and enforceable. Start of the contract term.',
    `errors_omissions_minimum_usd` DECIMAL(18,2) COMMENT 'Minimum required errors and omissions (professional liability) insurance coverage amount in USD that the staffing firm must maintain.',
    `everify_required_flag` BOOLEAN COMMENT 'Indicates whether E-Verify employment eligibility verification is required for all placements under this MSA.',
    `executed_date` DATE COMMENT 'Date when all parties signed the MSA and it became fully executed. May differ from effective date.',
    `expiration_date` DATE COMMENT 'Date when the MSA term ends. Nullable for evergreen agreements with no fixed end date.',
    `general_liability_minimum_usd` DECIMAL(18,2) COMMENT 'Minimum required general liability insurance coverage amount in USD that the staffing firm must maintain.',
    `governing_law_jurisdiction` STRING COMMENT 'State or country whose laws govern the interpretation and enforcement of the MSA (e.g., State of Delaware, England and Wales).',
    `indemnification_scope` STRING COMMENT 'Description of the scope and limitations of indemnification obligations between parties, including covered claims and exclusions.',
    `initial_term_months` STRING COMMENT 'Duration of the initial contract term in months before any renewal periods.',
    `invoice_delivery_method` STRING COMMENT 'Preferred method for delivering invoices to the client as specified in the MSA.. Valid values are `email|portal|edi|mail`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to this MSA. Nullable if no amendments have been executed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MSA record was last updated in the system.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum aggregate liability amount that either party can be held liable for under the MSA, excluding certain carve-outs.',
    `liability_cap_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the liability cap amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `msa_number` STRING COMMENT 'Externally-known unique business identifier for the MSA. Used in all client communications and legal references.. Valid values are `^MSA-[A-Z0-9]{6,12}$`',
    `msa_status` STRING COMMENT 'Current lifecycle status of the MSA. Tracks the agreement from draft through execution to termination. [ENUM-REF-CANDIDATE: draft|under_review|pending_signature|executed|active|suspended|expired|terminated|cancelled — 9 candidates stripped; promote to reference product]',
    `nda_attached_flag` BOOLEAN COMMENT 'Indicates whether a separate NDA document is attached to or incorporated into this MSA.',
    `non_solicitation_flag` BOOLEAN COMMENT 'Indicates whether the MSA includes a non-solicitation clause prohibiting direct hire of placed candidates.',
    `non_solicitation_period_months` STRING COMMENT 'Duration in months during which the client is prohibited from directly hiring placed candidates without paying a conversion fee.',
    `payment_terms_net_days` STRING COMMENT 'Standard payment terms in days (e.g., Net 30, Net 45) for invoices issued under this MSA.',
    `renewal_term_months` STRING COMMENT 'Duration of each automatic renewal period in months, if auto-renewal is enabled.',
    `sla_attached_flag` BOOLEAN COMMENT 'Indicates whether a formal SLA document with performance metrics and penalties is attached to this MSA.',
    `termination_date` DATE COMMENT 'Actual date when the MSA was terminated by either party or mutual agreement. Nullable if still active.',
    `termination_notice_days` STRING COMMENT 'Number of days advance written notice required by either party to terminate the MSA.',
    `termination_reason` STRING COMMENT 'Business reason or cause for MSA termination (e.g., breach of contract, mutual agreement, client request, business closure).',
    `title` STRING COMMENT 'Descriptive title of the MSA, typically including client name and agreement type.',
    `vendor_signatory_name` STRING COMMENT 'Name of the authorized staffing firm representative who signed the MSA on behalf of the vendor organization.',
    `vendor_signatory_title` STRING COMMENT 'Job title of the vendor signatory (e.g., President, VP Sales, Regional Director).',
    `workers_comp_minimum_usd` DECIMAL(18,2) COMMENT 'Minimum required workers compensation insurance coverage amount in USD that the staffing firm must maintain.',
    CONSTRAINT pk_msa PRIMARY KEY(`msa_id`)
) COMMENT 'Master Service Agreement — the primary commercial contract governing the overall client-staffing firm relationship. Stores MSA header data including effective dates, governing law, jurisdiction, auto-renewal terms, termination notice periods, liability caps, indemnification clauses, insurance requirements (GL, WC, E&O minimums), and MSA status lifecycle (draft, under_review, executed, expired, terminated). Links to client account hierarchy. SSOT for all client MSA terms managed via DocuSign CLM. Parent contract for SOWs, rate schedules, SLAs, and amendments.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`sow` (
    `sow_id` BIGINT COMMENT 'Unique identifier for the Statement of Work. Primary key.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: SOWs require internal approval by operations managers or VPs before execution. Staffing firms track approver identity for audit trails, delegation workflows, and compliance reporting. approved_by is d',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for whom this SOW is executed.',
    `envelope_id` BIGINT COMMENT 'Unique identifier of the DocuSign envelope used to execute this SOW, enabling traceability to the e-signature workflow.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: SOWs must specify the legal entity providing services for revenue recognition (ASC 606), tax compliance, and P&L attribution. Critical for multi-entity staffing operations where different entities ser',
    `msa_id` BIGINT COMMENT 'Reference to the parent Master Service Agreement under which this SOW is executed. Every SOW is governed by an MSA.',
    `acceptance_criteria` STRING COMMENT 'Conditions and standards that must be met for the client to accept deliverables and authorize payment.',
    `amendment_count` STRING COMMENT 'Number of formal amendments or modifications that have been executed against this SOW since original signing.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this SOW automatically renews unless either party provides notice of termination. True: auto-renews. False: requires explicit renewal action.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether background checks are required for all workers assigned to this SOW. True: BGC required. False: BGC not required.',
    `client_signatory_name` STRING COMMENT 'Name of the client representative who signed the SOW on behalf of the client organization.',
    `client_signatory_title` STRING COMMENT 'Job title or role of the client representative who signed the SOW.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOW record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial amounts in this SOW (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `deliverables_summary` STRING COMMENT 'High-level summary of key deliverables, milestones, or outputs expected from this SOW engagement.',
    `drug_screen_required_flag` BOOLEAN COMMENT 'Indicates whether drug screening is required for all workers assigned to this SOW. True: drug screen required. False: drug screen not required.',
    `end_date` DATE COMMENT 'Scheduled or actual end date when work under this SOW is completed or the contract term expires. Nullable for open-ended SOWs.',
    `estimated_duration_days` STRING COMMENT 'Estimated total duration of the SOW engagement in calendar days, from start to completion.',
    `estimated_fte_count` DECIMAL(18,2) COMMENT 'Estimated number of full-time equivalent resources required to deliver this SOW. May be fractional (e.g., 2.5 FTEs).',
    `estimated_headcount` STRING COMMENT 'Estimated number of individual workers or consultants to be assigned to this SOW, regardless of full-time or part-time status.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law that applies to this SOW (e.g., State of California, USA).',
    `insurance_requirements` STRING COMMENT 'Description of insurance coverage requirements (e.g., general liability, professional liability, workers compensation) that the staffing firm must maintain for this SOW.',
    `invoice_frequency` STRING COMMENT 'Frequency at which invoices are issued for this SOW. Weekly: every 7 days. Biweekly: every 14 days. Monthly: once per calendar month. Milestone: upon completion of defined milestones. Upon completion: single invoice at project end. Custom: non-standard schedule.. Valid values are `weekly|biweekly|monthly|milestone|upon_completion|custom`',
    `nda_required_flag` BOOLEAN COMMENT 'Indicates whether workers assigned to this SOW must sign a Non-Disclosure Agreement. True: NDA required. False: NDA not required.',
    `net_payment_days` STRING COMMENT 'Number of days from invoice date within which payment is due (e.g., Net 30, Net 45).',
    `non_compete_clause` STRING COMMENT 'Description of any non-compete restrictions applicable to workers or the staffing firm during and after the SOW engagement.',
    `notes` STRING COMMENT 'Free-form internal notes, comments, or special instructions related to this SOW engagement.',
    `payment_terms` STRING COMMENT 'Description of payment schedule and terms, including invoicing frequency, net payment days, and milestone-based payment triggers.',
    `pricing_model` STRING COMMENT 'Financial structure of the SOW. Time and materials: hourly/daily rates. Fixed fee: predetermined total price. Cost plus: actual costs plus markup. Retainer: recurring periodic fee. Milestone-based: payment tied to deliverable completion. Hybrid: combination of models.. Valid values are `time_and_materials|fixed_fee|cost_plus|retainer|milestone_based|hybrid`',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SOW is eligible for renewal or extension upon expiration. True: renewal allowed. False: one-time engagement only.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal or termination notice must be provided, as specified in the SOW terms.',
    `scope_description` STRING COMMENT 'Detailed narrative description of the work scope, deliverables, services, and responsibilities covered by this SOW.',
    `signed_date` DATE COMMENT 'Date when the SOW was fully executed (signed by all parties) and became legally binding.',
    `sla_terms` STRING COMMENT 'Summary of service level commitments, performance metrics, response times, and quality standards defined in this SOW.',
    `sow_number` STRING COMMENT 'Externally-known unique business identifier for the SOW, typically formatted as SOW-XXXXXX. Used in client communications, invoicing, and contract references.. Valid values are `^SOW-[A-Z0-9]{6,20}$`',
    `sow_status` STRING COMMENT 'Current lifecycle status of the SOW. Draft: being prepared. Submitted: sent to client for review. Under review: client evaluation in progress. Approved: signed and ready to execute. Active: work in progress. On hold: temporarily paused. Completed: deliverables finished. Closed: administratively closed. Cancelled: terminated before completion. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|on_hold|completed|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `sow_type` STRING COMMENT 'Classification of the SOW engagement model. Project-based: fixed deliverables and timeline. Staff augmentation: temporary workforce placement. RPO: Recruitment Process Outsourcing. MSP: Managed Service Provider program. Consulting: advisory services. Managed services: ongoing operational support.. Valid values are `project_based|staff_augmentation|rpo|msp|consulting|managed_services`',
    `start_date` DATE COMMENT 'Effective start date when work under this SOW is authorized to begin.',
    `termination_clause` STRING COMMENT 'Description of conditions, notice periods, and penalties under which either party may terminate the SOW prior to completion.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for either party to terminate the SOW without cause.',
    `title` STRING COMMENT 'Descriptive title or name of the SOW engagement, summarizing the project or service scope.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the SOW over its entire duration, in USD. For time-and-materials SOWs, this represents the not-to-exceed cap or estimated value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOW record was last modified in the system.',
    CONSTRAINT pk_sow PRIMARY KEY(`sow_id`)
) COMMENT 'Statement of Work — a child contract under an MSA that defines a specific engagement scope, deliverables, milestones, project timelines, fixed-fee or time-and-materials pricing, and acceptance criteria. Tracks SOW status (draft, submitted, approved, active, closed), SOW type (project-based, staff augmentation, RPO, MSP), and links to the governing MSA. Managed via DocuSign CLM.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`nda` (
    `nda_id` BIGINT COMMENT 'Unique identifier for the non-disclosure agreement record. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account party to this NDA. Links to the client master data.',
    `envelope_id` BIGINT COMMENT 'Unique envelope identifier from DocuSign CLM system tracking the e-signature workflow for this NDA. Used for audit trail and document retrieval.',
    `msa_id` BIGINT COMMENT 'Reference to the parent MSA if this NDA is ancillary to or incorporated into a broader master service agreement. Nullable for standalone NDAs.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate party to this NDA. Nullable if NDA is with client or vendor only.',
    `sow_id` BIGINT COMMENT 'Reference to a specific SOW if this NDA was executed in connection with a particular project or engagement. Nullable for general NDAs.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor party to this NDA. Nullable if NDA is with client or candidate only.',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether the NDA automatically renews for successive terms unless terminated by either party. True if auto-renewal clause is present.',
    `carve_outs` STRING COMMENT 'Exceptions to confidentiality obligations. Standard carve-outs include information that is publicly available, independently developed, already known, or required to be disclosed by law.',
    `confidentiality_duration_months` STRING COMMENT 'Duration in months that confidentiality obligations remain in effect from the effective date. Common values are 12, 24, 36, or 60 months. Nullable for perpetual NDAs.',
    `confidentiality_scope` STRING COMMENT 'Description of the types of information covered by the NDA. May include business plans, financial data, candidate information, client requirements, proprietary processes, trade secrets, or other confidential materials.',
    `counterparty_title` STRING COMMENT 'Job title or role of the counterparty representative who signed the NDA. Used to verify signing authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NDA record was first created in the system. Audit field for data lineage and compliance tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any monetary amounts specified in the NDA, such as liquidated damages. Example: USD, GBP, EUR.. Valid values are `^[A-Z]{3}$`',
    `document_url` STRING COMMENT 'URL or file path to the executed NDA document stored in DocuSign CLM or document management system. Used for retrieval and audit purposes.',
    `effective_date` DATE COMMENT 'Date when the NDA becomes legally binding and confidentiality obligations commence. Typically the date of last signature or a future date specified in the agreement.',
    `execution_date` DATE COMMENT 'Date when the NDA was fully executed by all parties. Typically the date of the last signature. May differ from effective date if agreement specifies a future effective date.',
    `expiration_date` DATE COMMENT 'Date when the NDA confidentiality obligations expire. Nullable for perpetual NDAs. After this date, parties may no longer be bound by confidentiality terms unless survival clauses apply.',
    `governing_law` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the NDA. Typically the state or country where the disclosing party is headquartered.',
    `jurisdiction` STRING COMMENT 'Court jurisdiction or venue where disputes arising from the NDA must be resolved. May differ from governing law jurisdiction.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Pre-determined monetary amount payable for breach of the NDA. Nullable if liquidated damages are not specified or if actual damages apply.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this NDA record. Audit field for accountability and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NDA record was last updated. Audit field for change tracking and data quality monitoring.',
    `nda_number` STRING COMMENT 'Business identifier for the NDA. Externally-known unique document number assigned by DocuSign CLM or internal contract management system.',
    `nda_status` STRING COMMENT 'Current lifecycle status of the NDA. Tracks progression from draft through execution to expiration or termination. [ENUM-REF-CANDIDATE: draft|pending_signature|executed|active|expired|terminated|superseded — 7 candidates stripped; promote to reference product]',
    `nda_type` STRING COMMENT 'Classification of the NDA based on directionality of confidentiality obligations. Mutual means both parties protect each others information; one-way means only one party discloses confidential information.. Valid values are `mutual|one_way_client|one_way_candidate|one_way_vendor|multilateral`',
    `non_compete_clause` BOOLEAN COMMENT 'Indicates whether the NDA includes a non-compete provision restricting the receiving party from competing with the disclosing party during or after the NDA term.',
    `non_solicitation_clause` BOOLEAN COMMENT 'Indicates whether the NDA includes a non-solicitation provision prohibiting the receiving party from soliciting employees, candidates, or clients of the disclosing party.',
    `notes` STRING COMMENT 'Free-form notes or comments about the NDA. May include special terms, negotiation history, renewal reminders, or other contextual information.',
    `permitted_use` STRING COMMENT 'Specific purposes for which the receiving party may use the confidential information. Typically limited to evaluation of business relationship, recruitment activities, or specific project scope.',
    `renewal_notice_days` STRING COMMENT 'Number of days before expiration that a party must provide notice to prevent auto-renewal or to initiate renewal. Nullable if not applicable.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the NDA requires explicit renewal action before expiration. True if renewal is needed; false for auto-renewing or perpetual NDAs.',
    `return_destruction_required` BOOLEAN COMMENT 'Indicates whether the receiving party must return or destroy confidential information upon termination or expiration of the NDA. True if return/destruction is mandatory.',
    `signed_by_counterparty` STRING COMMENT 'Name of the authorized representative from the counterparty (client, candidate, or vendor) who signed the NDA.',
    `signed_by_staffing_hr` STRING COMMENT 'Name of the authorized representative from Staffing Hr who signed the NDA on behalf of the company.',
    `survival_period_months` STRING COMMENT 'Number of months that confidentiality obligations survive after termination or expiration of the NDA. Ensures continued protection of disclosed information beyond the agreement term.',
    `termination_date` DATE COMMENT 'Actual date when the NDA was terminated by either party before the natural expiration date. Nullable if NDA has not been terminated early.',
    `termination_reason` STRING COMMENT 'Explanation for early termination of the NDA. May include mutual agreement, breach, business relationship ended, or other cause.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this NDA record. Audit field for accountability and compliance.',
    CONSTRAINT pk_nda PRIMARY KEY(`nda_id`)
) COMMENT 'Non-Disclosure Agreement — standalone or ancillary confidentiality agreement executed with clients, candidates, or vendors. Captures NDA type (mutual, one-way), parties involved, confidentiality scope, duration, carve-outs, and execution status. Tracks expiration and renewal obligations. Managed via DocuSign CLM.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`non_compete` (
    `non_compete_id` BIGINT COMMENT 'Unique identifier for the non-compete and non-solicitation agreement record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Reference to the originating placement or assignment record that triggered this non-compete agreement, if applicable. Null for internal employees or direct hires not tied to a specific placement.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that the non-compete is designed to protect. Identifies the client whose relationship and workforce the agreement restricts the subject from soliciting or competing for.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Non-competes often signed by specific client contacts (hiring managers, department heads) who are restricted parties. Required for enforceability tracking, breach prevention when contacts change roles',
    `envelope_id` BIGINT COMMENT 'Unique envelope identifier from DocuSign CLM system if the agreement was executed electronically via DocuSign. Used for audit trail and document retrieval.',
    `msa_id` BIGINT COMMENT 'Reference to the parent Master Service Agreement (MSA) under which this non-compete clause is governed, if the restriction is embedded within a broader commercial agreement.',
    `profile_id` BIGINT COMMENT 'Identifier of the individual or entity subject to the non-compete restriction. May reference candidate, employee, or contractor depending on subject_party_type.',
    `agreement_number` STRING COMMENT 'Business-facing unique identifier or reference number for the non-compete agreement, often used in legal documentation and contract management systems.',
    `agreement_type` STRING COMMENT 'Classification of the restrictive covenant type: non-compete only, non-solicitation only, combined non-compete and non-solicitation, or confidentiality agreement with non-compete provisions.. Valid values are `non_compete|non_solicitation|combined|confidentiality_with_non_compete`',
    `breach_date` DATE COMMENT 'Date when the breach or violation of the non-compete agreement was first identified or reported. Null if no breach has been reported.',
    `breach_description` STRING COMMENT 'Detailed description of the alleged breach or violation: specific prohibited activity engaged in, clients or candidates solicited, competitive employment taken, or other violation details.',
    `breach_reported` BOOLEAN COMMENT 'Indicates whether a breach or violation of the non-compete agreement has been reported or suspected, triggering potential legal action or investigation.',
    `candidate_solicitation_prohibited` BOOLEAN COMMENT 'Indicates whether the agreement prohibits the subject from recruiting, soliciting, or poaching candidates from the staffing firms talent pool or client assignments.',
    `client_solicitation_prohibited` BOOLEAN COMMENT 'Indicates whether the agreement explicitly prohibits the subject from soliciting or doing business with the protected client(s) during the restriction period.',
    `competitive_employment_prohibited` BOOLEAN COMMENT 'Indicates whether the agreement restricts the subject from working for a direct competitor in the staffing and recruitment industry during the restriction period.',
    `consideration_amount` DECIMAL(18,2) COMMENT 'Monetary value of consideration provided to the subject for signing the non-compete, if applicable. Null if consideration is non-monetary (e.g., continued employment, training).',
    `consideration_provided` STRING COMMENT 'Description of the consideration (compensation, benefit, or value) provided to the subject in exchange for agreeing to the non-compete. Required for enforceability in many jurisdictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the non-compete agreement record was first created in the system. Audit trail for record creation.',
    `effective_end_date` DATE COMMENT 'Date when the non-compete restriction expires and the subject is no longer bound by the agreement. Calculated as effective_start_date plus restriction_duration_months, or manually set if waived or released early.',
    `effective_start_date` DATE COMMENT 'Date when the non-compete restriction becomes effective. Typically the date of agreement execution or the start date of the placement/employment.',
    `enforceability_status` STRING COMMENT 'Current legal enforceability status of the non-compete agreement: enforceable under governing law, unenforceable (e.g., due to state law changes), under legal review, challenged in court, or waived by the company.. Valid values are `enforceable|unenforceable|under_review|challenged|waived`',
    `execution_date` DATE COMMENT 'Date when the non-compete agreement was fully executed (signed by all parties). Null if still pending or declined.',
    `execution_status` STRING COMMENT 'Current lifecycle status of the agreement document: draft, pending signature, fully executed, declined by subject, expired, or terminated early.. Valid values are `draft|pending_signature|executed|declined|expired|terminated`',
    `geographic_radius_miles` DECIMAL(18,2) COMMENT 'Radius in miles from a specified location (e.g., client site, staffing office) within which the restriction applies. Null if geographic_restriction_type is not radius.',
    `geographic_restriction_type` STRING COMMENT 'Type of geographic limitation applied to the non-compete: radius (distance from a location), territory (named regions), state-level, national, or no geographic restriction.. Valid values are `radius|territory|state|national|none`',
    `geographic_territory` STRING COMMENT 'Named geographic territory or list of states/regions where the non-compete restriction is enforceable. Free-text field for flexibility in defining complex territories.',
    `governing_law_jurisdiction` STRING COMMENT 'The state or jurisdiction whose laws govern the enforceability and interpretation of the non-compete agreement. Critical because non-compete enforceability varies significantly by state.',
    `legal_action_taken` BOOLEAN COMMENT 'Indicates whether the company has initiated legal action (cease and desist, injunction, lawsuit) to enforce the non-compete agreement following a breach.',
    `legal_case_number` STRING COMMENT 'Court case number or legal matter reference if litigation has been initiated to enforce the non-compete agreement. Null if no legal action taken.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Pre-determined monetary penalty specified in the agreement for breach of the non-compete, if applicable. Null if no liquidated damages clause exists.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the non-compete agreement record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, negotiation history, or internal comments related to the non-compete agreement.',
    `restricted_activity_scope` STRING COMMENT 'Detailed description of the activities prohibited under the agreement: client solicitation, candidate poaching, competitive employment in the same industry, disclosure of confidential information, or other specific restrictions.',
    `restriction_duration_months` STRING COMMENT 'Duration of the non-compete restriction period in months from the effective start date or termination of employment/assignment. Common values are 6, 12, 18, or 24 months.',
    `signature_method` STRING COMMENT 'Method by which the agreement was executed: electronic signature (e.g., DocuSign), wet signature (physical), verbal agreement, or implied consent.. Valid values are `electronic|wet_signature|verbal|implied`',
    `subject_party_type` STRING COMMENT 'Classification of the individual or entity bound by the non-compete: placed worker (W-2 temp), direct hire candidate, internal employee, independent contractor (IC), or vendor representative.. Valid values are `placed_worker|direct_hire_candidate|internal_employee|independent_contractor|vendor_representative`',
    `trigger_event` STRING COMMENT 'The business event that activates the non-compete restriction period: placement start, assignment end, employment termination, contract execution, or other specified event.. Valid values are `placement_start|assignment_end|employment_termination|contract_execution|other`',
    `waiver_date` DATE COMMENT 'Date when the waiver or release from the non-compete restriction was granted. Null if no waiver has been issued.',
    `waiver_granted` BOOLEAN COMMENT 'Indicates whether the company has granted a waiver or release from the non-compete restriction, allowing the subject to engage in otherwise prohibited activities.',
    `waiver_reason` STRING COMMENT 'Business justification or reason for granting the waiver: business relationship preservation, goodwill gesture, legal settlement, or other documented reason.',
    CONSTRAINT pk_non_compete PRIMARY KEY(`non_compete_id`)
) COMMENT 'Non-Compete and Non-Solicitation Agreement — contractual restriction placed on placed workers (W-2 temps, contractors), direct-hire candidates, or departing internal employees. Stores restricted activity scope (client solicitation, candidate poaching, competitive employment), geographic restriction radius or territory, duration in months, enforceability jurisdiction and governing law, and linkage to the originating placement, assignment, or employment record. Tracks execution status, expiration date, and any waiver or release granted. Critical for protecting client relationships and preventing revenue leakage in staffing where placed workers and recruiters frequently move between competing firms.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`sla` (
    `sla_id` BIGINT COMMENT 'Unique identifier for the service level agreement record. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for whom this SLA commitment is defined.',
    `msa_id` BIGINT COMMENT 'Reference to the parent contract (MSA or SOW) that governs this SLA commitment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SLA performance metrics are tracked by cost center for operational P&L analysis, service delivery cost attribution, and penalty/credit impact on cost center performance. Supports accountability for SL',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: SLAs are created by operations managers or contract administrators during MSA/SOW setup. Staffing firms track creator for audit trails, template usage analysis, and process compliance. created_by is d',
    `amendment_date` DATE COMMENT 'The date of the most recent amendment or revision to this SLA commitment.',
    `amendment_number` STRING COMMENT 'Sequential number tracking amendments or revisions to this SLA commitment. Zero indicates the original version.',
    `amendment_reason` STRING COMMENT 'Business justification or explanation for the most recent amendment to this SLA commitment.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this SLA commitment.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA commitment was formally approved by authorized stakeholders.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether this SLA automatically renews at the end of its term or requires explicit renegotiation.',
    `breach_threshold` DECIMAL(18,2) COMMENT 'The performance level at which an SLA breach is triggered, potentially different from the target (e.g., target 15 days, breach at 20 days).',
    `calculation_method` STRING COMMENT 'Detailed explanation of the formula or logic used to calculate the SLA metric from source data, including any exclusions or adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA record was first created in the system.',
    `effective_date` DATE COMMENT 'The date when this SLA commitment becomes binding and enforceable.',
    `escalation_contact` STRING COMMENT 'Name or role of the person or team to be notified when an SLA breach occurs and escalation is required.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether an SLA breach requires formal escalation to client management or executive leadership.',
    `expiration_date` DATE COMMENT 'The date when this SLA commitment expires or is no longer enforceable. Null if ongoing or tied to parent contract term.',
    `geography_scope` STRING COMMENT 'Geographic regions, states, or locations to which this SLA applies (e.g., USA - West Coast, EMEA, Chicago Metro).',
    `job_category_scope` STRING COMMENT 'Specific job categories, skill levels, or role types to which this SLA applies (e.g., Healthcare - RN, IT - Software Engineer, Light Industrial).',
    `measurement_end_date` DATE COMMENT 'The date when SLA measurement and tracking ends for this commitment. Null if ongoing.',
    `measurement_frequency` STRING COMMENT 'How often the SLA metric is measured and reported (e.g., weekly, monthly, quarterly, per placement, per requisition). [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annually|per_placement|per_requisition — 8 candidates stripped; promote to reference product]',
    `measurement_source_system` STRING COMMENT 'The operational system or platform from which SLA metric data is sourced (e.g., Bullhorn ATS, Beeline VMS, Power BI Analytics).',
    `measurement_start_date` DATE COMMENT 'The date when SLA measurement and tracking begins for this commitment.',
    `metric_description` STRING COMMENT 'Detailed definition of how the SLA metric is calculated, including numerator, denominator, exclusions, and any special conditions.',
    `metric_name` STRING COMMENT 'The specific performance metric being measured under this SLA. Common metrics include TTF (Time to Fill), TTS (Time to Start), QoS (Quality of Submission), fill rate, NPS (Net Promoter Score), submittal-to-interview ratio, and first-day no-show rate. [ENUM-REF-CANDIDATE: TTF|TTS|QoS|fill_rate|NPS|submittal_to_interview_ratio|first_day_no_show_rate|time_to_start|quality_of_submission|net_promoter_score — 10 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this SLA record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this SLA commitment.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The fixed monetary amount of the penalty or credit applied per breach occurrence or measurement period.',
    `penalty_cap_amount` DECIMAL(18,2) COMMENT 'The maximum cumulative penalty or credit amount that can be applied within a given measurement period or contract term.',
    `penalty_percentage` DECIMAL(18,2) COMMENT 'The percentage-based penalty or credit applied to the invoice or contract value when the SLA is breached.',
    `penalty_type` STRING COMMENT 'The type of financial or service remedy applied when the SLA is breached (e.g., credit, rebate, discount, penalty fee, service credit, none).. Valid values are `credit|rebate|discount|penalty_fee|service_credit|none`',
    `reporting_format` STRING COMMENT 'The format in which SLA performance results are delivered to the client (e.g., dashboard, PDF report, Excel spreadsheet, email summary, API feed).. Valid values are `dashboard|pdf_report|excel_spreadsheet|email_summary|api_feed`',
    `reporting_recipient` STRING COMMENT 'Name, role, or email address of the client stakeholder who receives SLA performance reports.',
    `reporting_required_flag` BOOLEAN COMMENT 'Indicates whether periodic SLA performance reporting is contractually required (e.g., for QBRs or monthly business reviews).',
    `scope_filter` STRING COMMENT 'Business rules defining which placements, requisitions, or transactions are included in the SLA measurement (e.g., IT roles only, permanent placements only, exclude rush orders).',
    `sla_name` STRING COMMENT 'Business-friendly name or title of the SLA commitment (e.g., Time to Fill - IT Roles, Quality of Submission - Healthcare).',
    `sla_number` STRING COMMENT 'Externally-known unique identifier or reference number for this SLA commitment, often used in client communications and QBRs.',
    `sla_status` STRING COMMENT 'Current lifecycle status of the SLA commitment (e.g., active, suspended, expired, terminated, draft, pending approval).. Valid values are `active|suspended|expired|terminated|draft|pending_approval`',
    `target_operator` STRING COMMENT 'The comparison operator defining how actual performance is evaluated against the target (e.g., less_than for TTF, greater_than_or_equal for fill rate).. Valid values are `less_than|less_than_or_equal|greater_than|greater_than_or_equal|equal|between`',
    `target_value` DECIMAL(18,2) COMMENT 'The contractually committed target threshold or goal for this SLA metric (e.g., 15 days for TTF, 85% for fill rate, 8.0 for NPS).',
    `unit_of_measure` STRING COMMENT 'The unit in which the SLA metric is expressed (e.g., days, hours, percentage, ratio, score, count).. Valid values are `days|hours|percentage|ratio|score|count`',
    CONSTRAINT pk_sla PRIMARY KEY(`sla_id`)
) COMMENT 'Service Level Agreement record defining measurable performance commitments within an MSA or SOW, along with periodic measurement results tracking actual performance against those targets. Stores SLA metric name (TTF, TTS, QoS, fill rate, NPS, submittal-to-interview ratio, first-day no-show rate), target threshold, measurement frequency (weekly, monthly, quarterly), penalty/credit terms, and governing contract reference. Captures measurement results per period: actual metric value, variance from target, breach flag, penalty/credit amount triggered, measurement period dates, and measurement source system. SSOT for all contractual SLA obligations, compliance tracking, and performance measurement. Enables SLA compliance reporting, penalty/credit calculation, client QBR (Quarterly Business Review) preparation, and trend analysis across measurement periods.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` (
    `contract_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the contract rate schedule record. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for whom this rate schedule is established.',
    `client_rate_card_id` BIGINT COMMENT 'Foreign key linking to client.rate_card. Business justification: Contract rate schedules reference client-approved rate cards for alignment verification and markup validation. Required for rate card compliance verification, contract-to-rate-card reconciliation, and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate schedules often map to cost centers for margin analysis, P&L reporting by service line, and operational cost tracking. Enables gross margin analysis by cost center and supports service line profi',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Rate schedules often location-specific due to geographic wage differentials, local labor markets, and cost-of-living adjustments. Required for location-based billing, cost center allocation, and site-',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement under which this rate schedule is defined.',
    `sow_id` BIGINT COMMENT 'Reference to the Statement of Work that this rate schedule supports. Nullable if rate schedule applies at MSA level.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Rate schedules can be associated with vendor agreements (vendor markup caps, fee schedules). Currently contract_rate_schedule has msa_id and sow_id but no vendor_agreement_id. Vendor agreements have m',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program under which this rate schedule is managed, if applicable.',
    `amendment_number` STRING COMMENT 'Sequential amendment number if this rate schedule is part of a contract amendment or revision.',
    `amendment_reason` STRING COMMENT 'Business reason or justification for the rate schedule amendment, such as market adjustment, client request, or regulatory change.',
    `approval_status` STRING COMMENT 'Current approval status of the rate schedule in the contract lifecycle workflow.. Valid values are `draft|pending_approval|approved|rejected|superseded|expired`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this rate schedule for use.',
    `approved_date` DATE COMMENT 'The date on which this rate schedule was formally approved.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate charged to the client for services rendered under this rate schedule.',
    `burden_rate` DECIMAL(18,2) COMMENT 'The additional cost per hour or unit to cover employer taxes, benefits, workers compensation, and other statutory obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all rates and amounts are denominated (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `double_time_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the standard bill rate for double-time hours, typically 2.0x or as contractually agreed.',
    `effective_end_date` DATE COMMENT 'The date on which this rate schedule expires or is superseded. Nullable for open-ended schedules.',
    `effective_start_date` DATE COMMENT 'The date from which this rate schedule becomes active and applicable to placements and billing.',
    `geographic_scope` STRING COMMENT 'Geographic region, state, or location to which this rate schedule applies, if geographically differentiated.',
    `gross_margin_percentage` DECIMAL(18,2) COMMENT 'The gross margin as a percentage of the bill rate, calculated as (bill rate - pay rate) / bill rate * 100.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this rate schedule is currently active and available for use in placements and billing.',
    `job_category` STRING COMMENT 'The job category or classification to which this rate schedule applies, such as Administrative, IT, Healthcare, Engineering, etc.',
    `labor_classification` STRING COMMENT 'The labor classification or job title covered by this rate schedule, aligned with client job requisition taxonomy.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to the pay rate to derive the bill rate, expressed as a percentage.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or special terms related to this rate schedule, such as volume discounts or conditional clauses.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the standard bill rate for overtime hours, typically 1.5x or as contractually agreed.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate paid to the worker or contractor for services rendered under this rate schedule.',
    `per_diem_allowance` DECIMAL(18,2) COMMENT 'Daily allowance provided to workers for meals, lodging, or incidental expenses when working on assignment, if applicable.',
    `rate_card_version` STRING COMMENT 'Version identifier for the rate card, used to track amendments and revisions over time.',
    `rate_schedule_name` STRING COMMENT 'Descriptive name for the rate schedule, often indicating the job category, skill level, or labor classification it covers.',
    `rate_schedule_number` STRING COMMENT 'Business identifier for the rate schedule, typically referenced in contract documents and invoices.',
    `rate_schedule_type` STRING COMMENT 'Classification of the rate schedule structure, such as standard, custom, blended, tiered, or project-based.. Valid values are `standard|custom|blended|tiered|project_based`',
    `rate_unit` STRING COMMENT 'The unit of measure for the rate, such as hourly, daily, weekly, monthly, or per unit of work delivered.. Valid values are `hourly|daily|weekly|monthly|per_unit`',
    `skill_level` STRING COMMENT 'The skill or experience level for which this rate applies, such as entry, intermediate, senior, expert, or executive.. Valid values are `entry|intermediate|senior|expert|executive`',
    `spread` DECIMAL(18,2) COMMENT 'The difference between the bill rate and pay rate, representing gross margin before burden costs.',
    CONSTRAINT pk_contract_rate_schedule PRIMARY KEY(`contract_rate_schedule_id`)
) COMMENT 'Contractual rate schedule defining agreed bill rates, pay rates, markup percentages, spread, burden rates, OT/DT multipliers, and per diem allowances for specific job categories, skill levels, or labor classifications under an MSA or SOW. Tracks effective date ranges, rate card version, and approval status. SSOT for all contractually agreed pricing terms.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key.',
    `msa_id` BIGINT COMMENT 'Reference to the parent contract (MSA, SOW, rate schedule, or vendor agreement) being amended. Links to the contract product.',
    `contract_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_schedule. Business justification: Rate schedules are frequently amended. Currently amendment has requires_rate_schedule_update boolean flag but no direct FK to the rate schedule being amended. Adding contract_rate_schedule_id allows t',
    `envelope_id` BIGINT COMMENT 'Unique identifier for the DocuSign envelope containing the amendment document and signature workflow. Used to retrieve execution audit trail from DocuSign CLM.',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: IC agreements can have amendments. Currently amendment table doesnt reference ic_agreement. IC agreements have amendment_count and last_amendment_date fields indicating amendments exist. This complet',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: SLAs can be amended. Currently amendment has requires_sla_update boolean flag but no direct sla_id FK. Adding sla_id allows tracking which specific SLA was amended, not just whether an SLA update is r',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Amendments can modify SOWs in addition to MSAs. Currently amendment only references contract_msa_id. Adding nullable sow_id allows amendments to target specific SOWs. No columns to remove since amendm',
    `superseded_by_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that supersedes or replaces this amendment. Used to track amendment version chains. Null if this is the current active amendment.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Vendor agreements can have amendments. Currently amendment only references contract_msa_id. Vendor agreements have amendment_count and last_amendment_date fields indicating amendments exist. Adding ve',
    `amendment_description` STRING COMMENT 'Detailed narrative description of the changes being made, including business rationale and impact. May include before/after values for modified terms.',
    `amendment_number` STRING COMMENT 'Business identifier for the amendment, typically formatted as contract number plus amendment sequence (e.g., MSA-2024-001-A01). Externally visible and used in legal documentation.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment in the approval and execution workflow. Tracks progression from draft through legal review, approvals, signatures, and final execution. [ENUM-REF-CANDIDATE: draft|pending_legal_review|pending_finance_approval|pending_client_signature|pending_vendor_signature|executed|rejected|superseded|cancelled — 9 candidates stripped; promote to reference product]',
    `amendment_type` STRING COMMENT 'Classification of the amendment by the nature of the change being made to the parent contract. Determines approval workflow and legal review requirements. [ENUM-REF-CANDIDATE: rate_change|scope_change|term_extension|party_addition|party_removal|insurance_requirement_change|sla_modification|billing_terms_change|termination_clause_change|other — 10 candidates stripped; promote to reference product]',
    `cancellation_reason` STRING COMMENT 'Explanation of why the amendment was cancelled before execution. Null if not cancelled.',
    `change_summary` STRING COMMENT 'Structured summary of specific contract terms being modified, added, or removed. Includes section references and explicit before/after values for key terms (e.g., Section 3.2 Bill Rate: $85/hr → $92/hr).',
    `client_signatory_name` STRING COMMENT 'Full name of the client representative authorized to sign the amendment on behalf of the client organization.',
    `client_signatory_title` STRING COMMENT 'Job title or role of the client signatory (e.g., VP of Human Resources, Procurement Director).',
    `client_signature_date` DATE COMMENT 'Date when the client signatory executed the amendment via DocuSign or other signature method.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the contract management system. Audit trail field.',
    `document_url` STRING COMMENT 'URL or file path to the executed amendment document stored in the document management system or DocuSign CLM.',
    `effective_date` DATE COMMENT 'Date when the amendment terms become legally binding and operationally effective. May be retroactive, current, or future-dated.',
    `execution_date` DATE COMMENT 'Date when the amendment became fully executed with all required signatures obtained. Typically the date of the last signature.',
    `expiration_date` DATE COMMENT 'Date when the amendment terms expire or are superseded. Null if the amendment has no expiration and remains in effect until the parent contract ends.',
    `finance_approval_date` DATE COMMENT 'Date when finance approval was granted for the amendment.',
    `finance_approval_notes` STRING COMMENT 'Comments from finance regarding budget impact, revenue implications, or cost considerations related to the amendment.',
    `finance_approver` STRING COMMENT 'Name or identifier of the finance manager who approved the amendment for financial impact and budget alignment.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated annual financial impact of the amendment in USD. Positive for revenue increases, negative for cost increases or revenue decreases. Used for finance approval thresholds.',
    `initiated_by` STRING COMMENT 'Name or identifier of the person or role who initiated the amendment request (e.g., Account Manager, Client, Legal Counsel).',
    `initiated_date` DATE COMMENT 'Date when the amendment request was formally initiated and entered into the contract management system.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this amendment is currently active and in effect. False if superseded, expired, cancelled, or rejected.',
    `legal_review_date` DATE COMMENT 'Date when legal review was completed and the amendment was approved by legal counsel.',
    `legal_review_notes` STRING COMMENT 'Comments and recommendations from legal counsel regarding the amendment, including any risk factors or required modifications.',
    `legal_reviewer` STRING COMMENT 'Name or identifier of the legal counsel who reviewed and approved the amendment for legal compliance and risk.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was last modified in the contract management system. Audit trail field.',
    `notification_sent_date` DATE COMMENT 'Date when notification of the executed amendment was sent to all affected stakeholders (account managers, operations, billing, compliance).',
    `prior_terms_expiration_date` DATE COMMENT 'Date when the prior contract terms being replaced by this amendment cease to be effective. Typically matches the amendment effective date but may differ for transition periods.',
    `rejection_reason` STRING COMMENT 'Explanation of why the amendment was rejected during legal review, finance approval, or client/vendor signature process. Null if not rejected.',
    `requires_rate_schedule_update` BOOLEAN COMMENT 'Indicates whether this amendment requires updates to associated rate schedules in the billing system. True if rate changes are included.',
    `requires_sla_update` BOOLEAN COMMENT 'Indicates whether this amendment modifies SLA terms and requires updates to SLA measurement and tracking systems. True if SLA changes are included.',
    `sequence_number` STRING COMMENT 'Sequential order of this amendment within the parent contract lifecycle (1, 2, 3, etc.). Used to reconstruct full contract version history.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the purpose of the amendment (e.g., Q2 2024 Rate Increase, Scope Expansion - IT Staffing Services).',
    `vendor_signatory_name` STRING COMMENT 'Full name of the staffing firm representative authorized to sign the amendment on behalf of the vendor organization.',
    `vendor_signatory_title` STRING COMMENT 'Job title or role of the vendor signatory (e.g., VP of Operations, General Counsel).',
    `vendor_signature_date` DATE COMMENT 'Date when the vendor signatory executed the amendment via DocuSign or other signature method.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Contract Amendment — a formal, versioned modification to an existing MSA, SOW, rate schedule, or vendor agreement. Captures amendment sequence number, amendment type (rate change, scope change, term extension, party addition/removal, insurance requirement change), detailed description of changes with before/after values, effective date, expiration of prior terms, approval chain with legal and finance sign-off, and execution status via DocuSign CLM. Maintains a complete amendment audit trail for any parent contract document, enabling full contract version history reconstruction. Critical for staffing firms managing hundreds of active client and vendor contracts with frequent rate and scope changes.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`renewal` (
    `renewal_id` BIGINT COMMENT 'Unique identifier for the contract renewal record. Primary key for the renewal entity.',
    `msa_id` BIGINT COMMENT 'Reference to the parent contract (MSA, SOW, or vendor agreement) that this renewal record tracks. Links to the master contract entity.',
    `contract_rate_schedule_id` BIGINT COMMENT 'Reference to the new or updated rate schedule that applies to the renewed contract term. Links to the rate schedule entity for bill rates and pay rates.',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: IC agreements have renewal/expiration tracking. Currently renewal table doesnt reference ic_agreement. IC agreements have expiration_date and renewal tracking needs. This completes renewal tracking f',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Managed program renewals require advance planning for scope adjustments and fee renegotiation. Required for program extension planning, scope-of-work renegotiation, and managed service contract lifecy',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOWs have renewal cycles and expiration tracking. Currently renewal only has contract_msa_id. SOWs are time-bound engagements that require renewal tracking. Adding sow_id allows tracking SOW-specific ',
    `staff_profile_id` BIGINT COMMENT 'Reference to the employee or user responsible for managing this renewal. Typically an account manager, contract administrator, or procurement specialist.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Vendor agreements have renewal cycles. Currently renewal only tracks contract_msa_id. Vendor agreements have auto_renewal_flag, renewal_term_months, and expiration tracking that require renewal record',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: VMS program renewals are critical business events requiring advance planning and rate renegotiation. Essential for program continuation planning, supplier tier adjustments, and VMS platform contract l',
    `acknowledgment_date` DATE COMMENT 'Date when the renewal owner formally acknowledged the renewal alert and committed to action. Null if not yet acknowledged.',
    `acknowledgment_status` STRING COMMENT 'Status of stakeholder acknowledgment of the renewal alert. Tracks whether the renewal owner has acknowledged the alert and taken required action.. Valid values are `pending|acknowledged|action_taken|escalated`',
    `alert_lead_time_days` STRING COMMENT 'Number of days prior to the renewal trigger date that alerts should be sent. Configurable per contract type and priority level.',
    `alert_sent_date` DATE COMMENT 'Date when the first renewal alert notification was sent. Used to track compliance with internal notification lead-time requirements.',
    `alert_sent_flag` BOOLEAN COMMENT 'Indicates whether proactive renewal alert notifications have been sent to stakeholders. True if alerts sent; False if not yet sent.',
    `auto_renewal_enabled_flag` BOOLEAN COMMENT 'Indicates whether the contract has an auto-renewal clause that will execute unless explicitly opted out. True if auto-renewal is active; False if manual renewal required.',
    `compliance_filing_deadline_date` DATE COMMENT 'Date by which regulatory compliance filings (EEOC, OFCCP, OSHA) related to this contract must be submitted. Tracks critical compliance dates tied to contract renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewal record was first created in the system. Audit field for data lineage and compliance tracking.',
    `effective_date` DATE COMMENT 'Date when the renewed contract terms become effective. Typically aligns with the expiration date of the prior term.',
    `expiration_date` DATE COMMENT 'Date when the renewed contract term ends. Defines the end of the renewal period and may trigger subsequent renewal cycles.',
    `insurance_certificate_renewal_date` DATE COMMENT 'Date when insurance certificates (Workers Comp, General Liability, Professional Liability) must be renewed to maintain contract compliance. Critical for risk management.',
    `negotiation_end_date` DATE COMMENT 'Date when renewal negotiations concluded. Marks the completion of discussions and agreement on renewed terms.',
    `negotiation_start_date` DATE COMMENT 'Date when renewal negotiation discussions formally began. Tracks the start of the renegotiation process for rate schedules, terms, or service levels.',
    `negotiation_status` STRING COMMENT 'Current state of renewal negotiation activities. Tracks whether negotiations are active, paused, successfully completed, or failed.. Valid values are `not_started|in_progress|on_hold|completed|failed`',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special considerations, negotiation outcomes, or stakeholder feedback related to the renewal process.',
    `notice_deadline_date` DATE COMMENT 'Final date by which notice of intent to renew or not renew must be provided per contract terms. Critical for compliance with contractual notification requirements.',
    `notice_period_days` STRING COMMENT 'Number of days prior to renewal effective date that notice must be provided. Typically 30, 60, or 90 days per Master Service Agreement (MSA) terms.',
    `opt_out_deadline_date` DATE COMMENT 'Final date by which a party can opt out of an auto-renewal without penalty. Missing this deadline results in automatic contract extension.',
    `opt_out_party` STRING COMMENT 'Identifies which party initiated the opt-out. Client indicates the client opted out; vendor indicates a vendor/supplier opted out; staffing_hr indicates internal decision; mutual indicates both parties agreed.. Valid values are `client|vendor|staffing_hr|mutual`',
    `opt_out_received_date` DATE COMMENT 'Date when opt-out notice was formally received. Null if no opt-out was received. Used to verify compliance with opt-out deadline requirements.',
    `opt_out_received_flag` BOOLEAN COMMENT 'Indicates whether an opt-out notice was received from either party prior to the opt-out deadline. True if opt-out received; False if no opt-out.',
    `outcome` STRING COMMENT 'Final result of the renewal process. Renewed indicates continuation under existing terms; renegotiated indicates modified terms; lapsed indicates contract expired without renewal; terminated indicates active cancellation; extended indicates temporary continuation.. Valid values are `renewed|renegotiated|lapsed|terminated|extended`',
    `outcome_date` DATE COMMENT 'Date when the final renewal outcome was determined and recorded. Marks the conclusion of the renewal decision process.',
    `priority` STRING COMMENT 'Business priority level assigned to this renewal. Critical renewals require immediate attention; high priority renewals are strategically important; medium and low priority follow standard workflows.. Valid values are `critical|high|medium|low`',
    `rate_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change in rates from the prior term to the renewed term. Positive values indicate rate increases; negative values indicate decreases. Expressed as a percentage (e.g., 3.50 for 3.5% increase).',
    `rate_schedule_review_date` DATE COMMENT 'Scheduled date for formal review of bill rates and pay rates as part of the renewal process. Ensures rates remain competitive and aligned with market conditions.',
    `renewal_number` STRING COMMENT 'Business-facing identifier for the renewal event. Format typically follows contract number with renewal sequence suffix (e.g., MSA-2024-001-R2).',
    `renewal_status` STRING COMMENT 'Current lifecycle state of the renewal process. Tracks progression from pending through negotiation to final outcome (renewed, renegotiated, lapsed, or terminated). [ENUM-REF-CANDIDATE: pending|in_negotiation|approved|renewed|renegotiated|lapsed|terminated|opted_out — 8 candidates stripped; promote to reference product]',
    `renewal_type` STRING COMMENT 'Classification of the renewal mechanism. Auto-renewal executes automatically unless opted out; manual renewal requires explicit action; evergreen continues indefinitely; one-time is non-renewable; conditional depends on performance or other criteria.. Valid values are `auto_renewal|manual_renewal|evergreen|one_time|conditional`',
    `resolution_action_taken` STRING COMMENT 'Free-text description of the action taken to resolve the renewal. Documents decisions made, approvals obtained, and next steps executed.',
    `sla_review_required_flag` BOOLEAN COMMENT 'Indicates whether Service Level Agreement (SLA) terms must be reviewed and potentially renegotiated as part of the renewal. True if SLA review required; False if existing SLA continues unchanged.',
    `term_length_months` STRING COMMENT 'Duration of the renewal term expressed in months. Common values include 12 (annual), 24 (biennial), 36 (triennial), or custom durations per contract terms.',
    `trigger_date` DATE COMMENT 'Date when the renewal process is initiated or triggered. For auto-renewals, this is when the system begins the renewal workflow. For manual renewals, this is when stakeholders must begin review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewal record was last modified. Audit field for tracking changes to renewal status, dates, or outcomes.',
    CONSTRAINT pk_renewal PRIMARY KEY(`renewal_id`)
) COMMENT 'Contract renewal, expiry, and critical date lifecycle record tracking upcoming renewal events, expiration milestones, and proactive date management for MSAs, SOWs, and vendor agreements. Stores renewal type (auto-renewal, manual renewal, evergreen, one-time), renewal trigger date, notice deadline, opt-out deadline, renewal term length, renewed rate schedule reference, negotiation status, and outcome (renewed, renegotiated, lapsed, terminated). Tracks all critical contract dates requiring proactive action — including auto-renewal opt-out deadlines, insurance certificate renewal dates, rate schedule review dates, and compliance filing deadlines — with alert type, trigger date, lead-time days, assigned owner, acknowledgment status, and resolution action taken. Enables proactive renewal pipeline management, prevents costly contract lapses or unwanted auto-renewals, and drives critical date alerting across the entire contract portfolio.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`envelope` (
    `envelope_id` BIGINT COMMENT 'Primary key for envelope',
    `parent_envelope_id` BIGINT COMMENT 'Reference to the parent envelope ID if this envelope is part of a bulk send or template-based distribution.',
    `template_id` BIGINT COMMENT 'Identifier of the DocuSign template used to create this envelope. Null if created from scratch.',
    `authentication_method` STRING COMMENT 'Primary authentication method required for recipient access. KBA (Knowledge-Based Authentication) for identity verification.. Valid values are `email|sms|phone|id_verification|kba|access_code`',
    `brand_code` STRING COMMENT 'Identifier for the DocuSign brand configuration applied to this envelope. Controls visual appearance and branding.',
    `certificate_of_completion_url` STRING COMMENT 'URL to the certificate of completion document that provides the full audit trail and signed document package.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when all required signatures were obtained and the envelope was finalized. Marks legal execution completion.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the envelope record was first created in the system. Marks the beginning of the envelope lifecycle.',
    `custom_field_1` STRING COMMENT 'Configurable custom field for organization-specific metadata. Usage varies by implementation.',
    `custom_field_2` STRING COMMENT 'Configurable custom field for organization-specific metadata. Usage varies by implementation.',
    `custom_field_3` STRING COMMENT 'Configurable custom field for organization-specific metadata. Usage varies by implementation.',
    `declined_reason` STRING COMMENT 'Explanation provided by the recipient for declining to sign. Captured for audit and contract negotiation tracking.',
    `declined_timestamp` TIMESTAMP COMMENT 'Date and time when a recipient declined to sign the envelope. Indicates rejection of the contract terms.',
    `delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the envelope was successfully delivered to all recipients. Confirms receipt before signing.',
    `document_type` STRING COMMENT 'Type of contract document being executed. MSA (Master Service Agreement), SOW (Statement of Work), NDA (Non-Disclosure Agreement), IC Agreement (Independent Contractor Agreement). [ENUM-REF-CANDIDATE: msa|sow|nda|non_compete|amendment|ic_agreement|rate_schedule|other — 8 candidates stripped; promote to reference product]',
    `envelope_status` STRING COMMENT 'Current status of the envelope in the signature workflow. Tracks progression from draft through completion or termination. [ENUM-REF-CANDIDATE: draft|sent|delivered|signed|completed|declined|voided|expired — 8 candidates stripped; promote to reference product]',
    `expiration_enabled` BOOLEAN COMMENT 'Indicates whether the envelope has an expiration date. True if the envelope will expire if not completed by the expiration timestamp.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the envelope expires if not completed. Enforces time-bound signature requirements.',
    `external_reference_code` STRING COMMENT 'Native envelope identifier from DocuSign CLM system. Used for API integration and cross-system reconciliation.',
    `is_bulk_send` BOOLEAN COMMENT 'Indicates whether this envelope was sent as part of a bulk send operation. True for mass distribution scenarios.',
    `is_signature_required` BOOLEAN COMMENT 'Indicates whether at least one signature is required for envelope completion. False for information-only envelopes.',
    `is_wet_sign_enabled` BOOLEAN COMMENT 'Indicates whether wet (physical) signature is enabled as an option for this envelope. True if physical signing is allowed.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code for the envelope content and notifications. Supports multilingual operations.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the envelope record was last updated. Tracks any changes to envelope metadata or status.',
    `message_body` STRING COMMENT 'Custom message included by the sender to provide instructions or context to recipients.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether email notifications are enabled for envelope events. True if recipients receive status notifications.',
    `purge_timestamp` TIMESTAMP COMMENT 'Date and time when the envelope and associated documents will be purged from the system per retention policy.',
    `recipient_count` STRING COMMENT 'Total number of recipients (signers, carbon copy, certified delivery) included in the envelope.',
    `reminder_enabled` BOOLEAN COMMENT 'Indicates whether automatic reminders are enabled for pending signers. True if reminders will be sent.',
    `reminder_frequency_days` STRING COMMENT 'Number of days between automatic reminder notifications sent to pending signers.',
    `sender_email` STRING COMMENT 'Email address of the individual who sent the envelope. Used for audit trail and sender identification.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_ip_address` STRING COMMENT 'IP address from which the envelope was sent. Captured for security audit and fraud prevention.',
    `sender_name` STRING COMMENT 'Full name of the individual who initiated and sent the envelope for signature.',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the envelope was sent to recipients for signature. Marks the start of the active signature workflow.',
    `signer_count` STRING COMMENT 'Number of recipients who are required to sign the document for completion.',
    `signing_order_enforced` BOOLEAN COMMENT 'Indicates whether recipients must sign in a specific sequential order. True if routing order is enforced.',
    `subject_line` STRING COMMENT 'Subject line or title of the envelope as displayed to recipients. Provides context for the signature request.',
    `time_zone` STRING COMMENT 'Time zone used for displaying timestamps to recipients. Ensures consistent time interpretation across geographies.',
    `uri` STRING COMMENT 'Uniform Resource Identifier for accessing the envelope in the DocuSign system. Used for API operations and deep linking.',
    `voided_reason` STRING COMMENT 'Explanation provided by the sender for voiding the envelope. Captured for audit and process improvement.',
    `voided_timestamp` TIMESTAMP COMMENT 'Date and time when the envelope was voided by the sender. Indicates cancellation before completion.',
    CONSTRAINT pk_envelope PRIMARY KEY(`envelope_id`)
) COMMENT 'DocuSign CLM e-signature envelope record representing a single signature workflow execution with full signatory audit trail. Captures envelope ID (DocuSign native), document type, sent timestamp, completed timestamp, voided/declined status, and IP address capture for audit. Includes per-recipient signatory detail: signer name, title, organization, signing order, authentication method (email, SMS, ID verification, knowledge-based), signing authority level (e.g., VP and above, C-suite only), delegation scope (full authority, limited to SOW under $X), active/inactive signer status, individual sign/decline timestamp, and recipient status. Person/contact identity is resolved via the client or candidate domain contact master — this product stores signing-role attributes and execution events only. SSOT for all electronic execution events and signatory audit trails across MSAs, SOWs, NDAs, amendments, IC agreements, and non-competes.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`template` (
    `template_id` BIGINT COMMENT 'Primary key for template',
    `replacement_template_id` BIGINT COMMENT 'Identifier of the template that supersedes this one when deprecated. Null if this is the current active version.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the compliance team member who reviewed and approved this template for regulatory compliance.',
    `template_legal_reviewer_user_staff_profile_id` BIGINT COMMENT 'Identifier of the legal team member who reviewed and approved this template for use.',
    `template_staff_profile_id` BIGINT COMMENT 'Identifier of the user (typically legal or contracts manager) who owns and maintains this template.',
    `applicable_client_segments` STRING COMMENT 'Comma-separated list of client segments this template is appropriate for (e.g., Enterprise,Mid-Market,SMB,Government). Supports segment-specific contract terms.',
    `applicable_industries` STRING COMMENT 'Comma-separated list of industries or sectors this template is designed for (e.g., Healthcare,Technology,Finance). Enables industry-specific clause selection.',
    `approval_status` STRING COMMENT 'Approval workflow status indicating which governance reviews have been completed (legal, compliance, executive).. Valid values are `Pending|Legal Approved|Compliance Approved|Executive Approved|Rejected`',
    `approved_date` DATE COMMENT 'Date when the template received final approval and became available for use in contract generation.',
    `configurable_parameters` STRING COMMENT 'JSON or comma-separated list of parameters that can be customized during contract generation (e.g., payment_terms,notice_period,liability_cap,indemnification_limit).',
    `contract_type` STRING COMMENT 'Type of contract this template generates: Master Service Agreement (MSA), Statement of Work (SOW), Non-Disclosure Agreement (NDA), Non-Compete Agreement, Amendment, or Independent Contractor (IC) Agreement.. Valid values are `MSA|SOW|NDA|Non-Compete|Amendment|IC Agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this template record was first created in the system.',
    `default_jurisdiction` STRING COMMENT 'Default legal jurisdiction or governing law for contracts generated from this template (e.g., State of Delaware, State of California, Federal).',
    `default_liability_cap_amount` DECIMAL(18,2) COMMENT 'Default maximum liability amount specified in the templates limitation of liability clause. Can be overridden during contract generation.',
    `default_liability_cap_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the default liability cap amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `default_notice_period_days` STRING COMMENT 'Default number of days required for contract termination notice as specified in the template. Can be overridden during contract generation.',
    `default_payment_terms` STRING COMMENT 'Default payment terms embedded in the template (e.g., Net 30, Net 45, 50% upfront, 50% on completion). Can be overridden during contract generation.',
    `deprecated_date` DATE COMMENT 'Date when the template was marked as deprecated and replaced by a newer version. Null if the template is still active.',
    `docusign_template_reference` STRING COMMENT 'External identifier linking this template to the corresponding template in DocuSign CLM for e-signature workflow integration.',
    `e_signature_enabled` BOOLEAN COMMENT 'Indicates whether contracts generated from this template support electronic signature workflows via DocuSign or other e-signature platforms.',
    `effective_end_date` DATE COMMENT 'Date after which this template version is no longer available for new contract generation. Null indicates the template is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this template version becomes active and available for new contract generation.',
    `includes_coe_risk_clause` BOOLEAN COMMENT 'Indicates whether the template includes language addressing co-employment risk mitigation and liability allocation between staffing firm and client.',
    `includes_data_privacy_clause` BOOLEAN COMMENT 'Indicates whether the template includes data privacy and protection clauses compliant with GDPR, CCPA, or other applicable regulations.',
    `includes_eeoc_compliance_clause` BOOLEAN COMMENT 'Indicates whether the template includes EEOC compliance language ensuring non-discrimination in employment practices.',
    `includes_flsa_compliance_clause` BOOLEAN COMMENT 'Indicates whether the template includes FLSA compliance language covering wage and hour requirements.',
    `includes_indemnification_clause` BOOLEAN COMMENT 'Indicates whether the template includes a standard indemnification clause protecting the company from third-party claims.',
    `includes_ip_ownership_clause` BOOLEAN COMMENT 'Indicates whether the template includes a clause defining intellectual property ownership and work-for-hire provisions.',
    `includes_non_solicitation_clause` BOOLEAN COMMENT 'Indicates whether the template includes a non-solicitation clause preventing clients from directly hiring placed candidates.',
    `includes_ofccp_compliance_clause` BOOLEAN COMMENT 'Indicates whether the template includes OFCCP compliance language for federal contractor obligations.',
    `includes_workers_comp_clause` BOOLEAN COMMENT 'Indicates whether the template includes workers compensation insurance requirements and liability allocation.',
    `internal_notes` STRING COMMENT 'Internal notes for legal and contracts teams regarding template usage, known issues, or special handling requirements. Not visible to end users.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this template record was last updated. Tracks all changes including status updates, clause modifications, and configuration changes.',
    `last_used_date` DATE COMMENT 'Most recent date a contract was generated from this template. Used to identify unused or obsolete templates.',
    `optional_clause_menu` STRING COMMENT 'Comma-separated list of clause IDs or clause type codes that are available for selection during contract generation but not mandatory (e.g., NON_SOL,DATA_PRIV,WORKERS_COMP).',
    `required_clause_set` STRING COMMENT 'Comma-separated list of clause IDs or clause type codes that are mandatory in every contract generated from this template (e.g., INDEM_STD,LIM_LIAB,IP_OWN,EEOC_COMP).',
    `template_code` STRING COMMENT 'Unique alphanumeric code identifying the template for system integration and reference (e.g., MSA_TECH_V3, SOW_HC_STD).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `template_description` STRING COMMENT 'Detailed description of the templates purpose, intended use cases, and any special considerations for contract generation.',
    `template_name` STRING COMMENT 'Business-friendly name of the contract template (e.g., Standard MSA - Technology Sector, SOW Template - Healthcare Staffing).',
    `template_status` STRING COMMENT 'Current lifecycle status of the template. Only Active templates can be used for new contract generation.. Valid values are `Draft|Under Review|Approved|Active|Deprecated|Archived`',
    `usage_count` STRING COMMENT 'Total number of contracts generated from this template. Used for template effectiveness analysis and retirement decisions.',
    `version` STRING COMMENT 'Version number of the template following semantic versioning (e.g., 1.0, 2.1.3). Tracks template evolution and ensures correct version usage.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_template PRIMARY KEY(`template_id`)
) COMMENT 'Contract template and clause library master record defining the standard structure, default clauses, configurable parameters, and complete reusable clause inventory for each contract type (MSA, SOW, NDA, non-compete, amendment, IC agreement, vendor agreement). Stores template name, version, applicable contract type, default jurisdiction, required clause set, optional clause menu, and approval status. Includes the full clause library: standard and custom clause text for all clause types (indemnification, limitation of liability, IP ownership, co-employment, EEOC, OFCCP, FLSA, workers comp, governing law, data privacy, non-solicitation), clause version, jurisdiction applicability, mandatory vs. optional flag, regulatory source reference, and clause approval status. Used by DocuSign CLM to generate new contract drafts consistently while enabling clause-level compliance tracking, template governance, and regulatory clause audit. SSOT for all contract generation configuration and reusable clause management.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique identifier for the contractual obligation record. Primary key.',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement under which this obligation arises.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contract obligations (insurance renewals, compliance filings, audit requirements) often have cost center ownership for budget tracking and expense allocation. Enables cost center managers to track and',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: IC agreements have contractual obligations (W-9 submission, insurance requirements, deliverable milestones). Currently obligation table doesnt reference ic_agreement. This allows tracking IC agreemen',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Contractual obligations often location-specific: site access requirements, safety compliance, local permits, workers comp filings. Essential for site-level compliance tracking, audit preparation, and ',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Managed programs have contractual obligations: headcount reporting, SLA compliance, on-site coordinator presence, program manager deliverables. Essential for program management, client deliverable tra',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Contract obligations (insurance renewals, compliance filings, reporting) are assigned to internal staff when responsible_party_type=internal. Staffing firms track assignee for task management, escal',
    `sow_id` BIGINT COMMENT 'Reference to the Statement of Work that defines this obligation, if applicable.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Vendor agreements have contractual obligations (insurance requirements, compliance filings, reporting requirements). Currently obligation has contract_msa_id and sow_id but no vendor_agreement_id. Thi',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: VMS programs have program-specific contractual obligations: supplier performance reviews, quarterly business reviews, submission compliance, timesheet approval cycles. Required for program governance ',
    `amendment_reference` STRING COMMENT 'Reference to the contract amendment document that modified or waived this obligation.',
    `audit_ready_flag` BOOLEAN COMMENT 'Indicates whether all documentation and evidence for this obligation is complete and audit-ready.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) reflecting the quality and timeliness of obligation fulfillment, used for contractual compliance scoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the obligation record was first created in the system.',
    `days_until_due` STRING COMMENT 'Calculated number of days remaining until the obligation due date. Negative values indicate overdue obligations.',
    `due_date` DATE COMMENT 'The date by which the obligation must be fulfilled. For recurring obligations, this is the next occurrence due date.',
    `escalation_date` DATE COMMENT 'Date when the obligation was escalated to a higher management level due to non-fulfillment.',
    `escalation_level` STRING COMMENT 'Current escalation tier for overdue or at-risk obligations, following the defined escalation path.. Valid values are `none|level_1|level_2|level_3|executive`',
    `escalation_owner_name` STRING COMMENT 'Name of the individual or role to whom the obligation is escalated when overdue.',
    `evidence_document_reference` STRING COMMENT 'Reference identifier or URI to the document or artifact that serves as proof of obligation fulfillment.',
    `evidence_submission_date` DATE COMMENT 'Date when supporting evidence or documentation was submitted to demonstrate fulfillment.',
    `evidence_verified_flag` BOOLEAN COMMENT 'Indicates whether the submitted evidence has been reviewed and verified as satisfactory.',
    `fulfillment_date` DATE COMMENT 'The actual date on which the obligation was completed and evidence provided.',
    `last_notification_date` DATE COMMENT 'Date of the most recent notification or reminder sent to the responsible party.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the obligation record.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or internal comments related to the obligation.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a reminder or notification has been sent to the responsible party regarding the upcoming or overdue obligation.',
    `obligation_category` STRING COMMENT 'High-level grouping of the obligation for reporting and tracking purposes.. Valid values are `compliance|insurance|reporting|audit|deliverable|legal`',
    `obligation_description` STRING COMMENT 'Detailed narrative describing the specific commitment, deliverable, or compliance requirement that must be fulfilled.',
    `obligation_number` STRING COMMENT 'Business-readable unique identifier for the obligation, typically formatted as OBL-NNNNNN.. Valid values are `^OBL-[0-9]{6,10}$`',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the obligation indicating progress toward fulfillment.. Valid values are `pending|in_progress|fulfilled|overdue|waived|cancelled`',
    `obligation_type` STRING COMMENT 'Classification of the contractual obligation. Types include periodic reporting, insurance certificate renewal, background check requirement, OFCCP/AAP compliance filing, audit right exercise, indemnification trigger, workers compensation certificate, professional liability proof, WOTC documentation, and other compliance or deliverable commitments. [ENUM-REF-CANDIDATE: periodic_reporting|insurance_certificate_renewal|background_check_requirement|ofccp_aap_compliance_filing|audit_right_exercise|indemnification_trigger|workers_comp_certificate|professional_liability_proof|wotc_documentation|sla_performance_report|nda_renewal|non_compete_acknowledgment|credential_verification|drug_screen_requirement|everify_compliance|tax_document_submission|payroll_report_submission — promote to reference product]. Valid values are `periodic_reporting|insurance_certificate_renewal|background_check_requirement|ofccp_aap_compliance_filing|audit_right_exercise|indemnification_trigger`',
    `original_due_date` DATE COMMENT 'The initially scheduled due date before any extensions or amendments.',
    `overdue_flag` BOOLEAN COMMENT 'Indicates whether the obligation is past its due date and remains unfulfilled.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or liquidated damages amount incurred due to non-fulfillment or late fulfillment of the obligation.',
    `penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to the obligation based on risk, contractual importance, and regulatory impact.. Valid values are `low|medium|high|critical`',
    `recurrence_type` STRING COMMENT 'Indicates whether the obligation is a one-time event or recurring on a schedule.. Valid values are `one_time|daily|weekly|monthly|quarterly|annually`',
    `responsible_department` STRING COMMENT 'Internal department or business unit accountable for ensuring the obligation is met.',
    `responsible_party_type` STRING COMMENT 'Indicates whether the obligation is the responsibility of an internal department, external counterparty, or joint responsibility.. Valid values are `internal|external|joint`',
    `risk_rating` STRING COMMENT 'Assessment of the risk exposure if the obligation is not fulfilled on time.. Valid values are `low|medium|high|severe`',
    `title` STRING COMMENT 'Short descriptive title of the obligation for quick identification.',
    `updated_by_name` STRING COMMENT 'Name of the user or system process that last modified the obligation record.',
    `verification_date` DATE COMMENT 'Date when the evidence was verified and the obligation marked as fulfilled.',
    `verified_by_name` STRING COMMENT 'Name of the individual who verified the evidence and confirmed obligation fulfillment.',
    `waiver_date` DATE COMMENT 'Date on which the obligation waiver was granted.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the obligation has been formally waived by the counterparty or through contract amendment.',
    `waiver_reason` STRING COMMENT 'Business justification or explanation for waiving the obligation.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Contractual obligation record tracking specific commitments, deliverables, or compliance requirements arising from an MSA, SOW, SLA, or vendor agreement. Captures obligation type (periodic reporting, insurance certificate renewal, background check requirement, OFCCP/AAP compliance filing, audit right exercise, indemnification trigger, workers compensation certificate, professional liability proof, WOTC documentation), due date or recurring schedule, responsible party (internal department or external counterparty), fulfillment status, evidence of completion with document reference, and escalation path for overdue items. Enables proactive obligation management, audit readiness, and contractual compliance scoring across the entire contract portfolio.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` (
    `vendor_agreement_id` BIGINT COMMENT 'Unique identifier for the vendor agreement record. Primary key.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Vendor agreements are managed by supplier relationship managers or procurement staff. Staffing firms track ownership for renewal management, performance reviews, and rate negotiations. contract_owner_',
    `envelope_id` BIGINT COMMENT 'Unique identifier for the DocuSign envelope containing the executed vendor agreement, used for e-signature tracking and document retrieval.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Vendor agreements are executed by specific legal entities. Required for AP processing, 1099 reporting, tax withholding, and intercompany payables when vendors serve multiple entities. Essential for MS',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Vendor agreements often part of managed programs with program-specific terms and tier classifications. Essential for supplier tier management, program-specific performance tracking, and managed progra',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or subcontractor party that is the counterparty to this agreement. Links to the vendor domain for vendor identity and profile data.',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program under which this vendor agreement is managed, if applicable. Links to the client VMS program for MSP/VMS-managed supplier relationships.',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier or contract number for this vendor agreement, used for reference in communications and invoicing.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the vendor agreement. Draft indicates agreement is being prepared; pending approval indicates awaiting internal or vendor signature; active indicates agreement is in force; suspended indicates temporarily inactive; expired indicates agreement term has ended; terminated indicates agreement was ended early; renewed indicates agreement has been extended. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_title` STRING COMMENT 'Descriptive title or name of the vendor agreement, summarizing the scope or purpose of the commercial relationship.',
    `agreement_type` STRING COMMENT 'Classification of the vendor agreement type. Subvendor staffing agreement covers third-party staffing suppliers; IC firm agreement covers independent contractor firms; EOR agreement covers Employer of Record relationships; PEO agreement covers Professional Employer Organization relationships; RPO subcontract covers Recruitment Process Outsourcing subcontracts; service provider agreement covers other service providers.. Valid values are `subvendor_staffing_agreement|ic_firm_agreement|eor_agreement|peo_agreement|rpo_subcontract|service_provider_agreement`',
    `amendment_count` STRING COMMENT 'Total number of amendments or modifications made to the vendor agreement since its original execution.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the vendor agreement automatically renews at the end of each term unless either party provides termination notice. True if auto-renewal is enabled; False if manual renewal is required.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor is required to conduct background checks on all workers placed under this agreement. True if background checks are mandatory; False if not required.',
    `background_check_standard` STRING COMMENT 'Description of the background check standard or level required for workers placed under this agreement, such as criminal history, employment verification, education verification, or credit check requirements.',
    `confidentiality_term_years` STRING COMMENT 'Duration in years for which confidentiality obligations survive the termination or expiration of the vendor agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor agreement record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Method specified in the vendor agreement for resolving disputes between the parties. Litigation indicates court proceedings; arbitration indicates binding arbitration; mediation indicates facilitated negotiation; negotiation indicates direct party-to-party resolution.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `diversity_certification_status` STRING COMMENT 'Diversity certification status of the vendor. MBE indicates Minority Business Enterprise; WBE indicates Women Business Enterprise; SDVOB indicates Service-Disabled Veteran-Owned Business; DBE indicates Disadvantaged Business Enterprise; VBE indicates Veteran Business Enterprise; LGBTBE indicates LGBT Business Enterprise; none indicates no diversity certification; multiple indicates vendor holds multiple certifications. [ENUM-REF-CANDIDATE: mbe|wbe|sdvob|dbe|vbe|lgbtbe|none|multiple — 8 candidates stripped; promote to reference product]',
    `drug_screen_panel_type` STRING COMMENT 'Type of drug screening panel required for workers placed under this agreement. 5-panel is standard; 10-panel is expanded; DOT 5-panel is Department of Transportation compliant; custom indicates client-specific panel.. Valid values are `5_panel|10_panel|dot_5_panel|custom`',
    `drug_screen_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor is required to conduct drug screening on all workers placed under this agreement. True if drug screening is mandatory; False if not required.',
    `effective_date` DATE COMMENT 'Date on which the vendor agreement becomes legally binding and enforceable. Marks the start of the agreement term.',
    `errors_omissions_minimum_usd` DECIMAL(18,2) COMMENT 'Minimum required errors and omissions (professional liability) insurance coverage amount in US dollars that the vendor must maintain.',
    `everify_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor is required to use E-Verify for employment eligibility verification of all workers placed under this agreement. True if E-Verify is mandatory; False if not required.',
    `executed_date` DATE COMMENT 'Date on which the vendor agreement was fully executed by all parties, with all required signatures obtained.',
    `expiration_date` DATE COMMENT 'Date on which the vendor agreement term ends, unless renewed or extended. Nullable for open-ended or evergreen agreements.',
    `fee_schedule_type` STRING COMMENT 'Type of fee structure governing vendor compensation. Flat fee indicates fixed amount per placement or period; percentage of bill rate indicates fee calculated as percentage of worker bill rate; tiered indicates fee varies by volume or worker level; cost plus indicates cost reimbursement plus fixed margin; negotiated indicates custom fee arrangement.. Valid values are `flat_fee|percentage_of_bill_rate|tiered|cost_plus|negotiated`',
    `general_liability_minimum_usd` DECIMAL(18,2) COMMENT 'Minimum required general liability insurance coverage amount in US dollars that the vendor must maintain as a condition of the agreement.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the vendor agreement, typically specified as a state or country.',
    `indemnification_scope` STRING COMMENT 'Description of the indemnification obligations and scope defined in the vendor agreement, specifying which party indemnifies the other for various liabilities, claims, or damages.',
    `initial_term_months` STRING COMMENT 'Duration of the initial agreement term in months, from effective date to first expiration or renewal point.',
    `internal_signatory_name` STRING COMMENT 'Full name of the authorized representative who signed the vendor agreement on behalf of Staffing Hr.',
    `internal_signatory_title` STRING COMMENT 'Job title or role of the authorized representative who signed the vendor agreement on behalf of Staffing Hr.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the vendor agreement, if any amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor agreement record was last updated or modified in the system.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount specified in the vendor agreement, capping the financial exposure of either party for damages or claims arising from the agreement.',
    `liability_cap_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the liability cap amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `markup_cap_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable markup percentage that the vendor may apply to pay rates when billing the client. Used to control vendor margin and ensure competitive pricing within VMS programs.',
    `non_solicitation_flag` BOOLEAN COMMENT 'Indicates whether the vendor agreement includes a non-solicitation clause prohibiting either party from soliciting the other partys employees or contractors. True if non-solicitation clause is present; False if not.',
    `non_solicitation_period_months` STRING COMMENT 'Duration in months for which the non-solicitation clause remains in effect after termination or expiration of the vendor agreement.',
    `payment_terms_net_days` STRING COMMENT 'Number of days from invoice date within which payment is due to the vendor. Common values include net-30, net-45, or net-60.',
    `renewal_term_months` STRING COMMENT 'Duration of each renewal term in months, applicable if the agreement is renewed or auto-renews.',
    `termination_date` DATE COMMENT 'Date on which the vendor agreement was terminated, if applicable. Nullable if the agreement has not been terminated.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the vendor agreement without cause, as specified in the contract terms.',
    `termination_reason` STRING COMMENT 'Reason or cause for termination of the vendor agreement, if terminated early. Examples include breach of contract, poor performance, mutual agreement, or business closure.',
    `tier_classification` STRING COMMENT 'Tier or classification level of the vendor within the supply chain hierarchy. Tier 1 represents preferred or strategic vendors; Tier 2 represents standard approved vendors; Tier 3 represents conditional or limited-use vendors.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|conditional`',
    `vendor_signatory_name` STRING COMMENT 'Full name of the authorized representative who signed the vendor agreement on behalf of the vendor organization.',
    `vendor_signatory_title` STRING COMMENT 'Job title or role of the authorized representative who signed the vendor agreement on behalf of the vendor organization.',
    `workers_comp_minimum_usd` DECIMAL(18,2) COMMENT 'Minimum required workers compensation insurance coverage amount in US dollars that the vendor must maintain to cover placed workers.',
    CONSTRAINT pk_vendor_agreement PRIMARY KEY(`vendor_agreement_id`)
) COMMENT 'Vendor/subcontractor agreement governing the commercial relationship with third-party staffing suppliers, subvendors, independent contractor firms, and service providers within MSP/VMS-managed programs. Captures agreement type (subvendor staffing agreement, IC firm agreement, EOR/Employer of Record agreement, PEO agreement, RPO subcontract), tier classification (Tier 1/2/3), markup caps and fee schedules, payment terms (net-30/45/60), insurance requirements (GL, WC, E&O minimums), diversity certification status (MBE, WBE, SDVOB), and compliance obligations (E-Verify, background check standards, drug screening requirements). Distinct from client-facing MSAs — this is the supply-side commercial contract governing the staffing supply chain. Note: vendor identity and profile data is owned by the vendor domain; this product owns the commercial agreement terms only.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` (
    `ic_agreement_id` BIGINT COMMENT 'Unique identifier for the independent contractor agreement record. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for whom the independent contractor is performing services.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: IC agreements are managed by recruiters or contractor coordinators who handle onboarding, compliance, and renewals. Staffing firms track ownership for workload management, compliance audits, and perfo',
    `profile_id` BIGINT COMMENT 'Reference to the independent contractors candidate profile in the system.',
    `envelope_id` BIGINT COMMENT 'Unique identifier for the DocuSign envelope containing the electronically signed independent contractor agreement. Used for e-signature audit trail and document retrieval.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: IC agreements must specify the contracting legal entity for 1099 reporting, tax withholding, liability determination, and worker classification compliance. Critical for independent contractor tax repo',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the IC agreement, used in communications and documentation.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the IC agreement (draft, pending signature, active, suspended, completed, terminated, or expired). [ENUM-REF-CANDIDATE: draft|pending_signature|active|suspended|completed|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_title` STRING COMMENT 'Descriptive title or name of the independent contractor agreement.',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or modifications made to the original independent contractor agreement.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether the independent contractor is required to pass a background check as a condition of engagement.',
    `client_signatory_name` STRING COMMENT 'Name of the authorized representative from the client organization who signed the independent contractor agreement.',
    `client_signatory_title` STRING COMMENT 'Job title or position of the client signatory who executed the independent contractor agreement.',
    `confidentiality_term_years` STRING COMMENT 'Number of years the independent contractor is bound by confidentiality obligations regarding client proprietary information, measured from agreement end date.',
    `contract_type` STRING COMMENT 'Classification of the independent contractor engagement structure (project-based, retainer, time and materials, fixed price, milestone-based, or ongoing).. Valid values are `project_based|retainer|time_and_materials|fixed_price|milestone_based|ongoing`',
    `contractor_signatory_name` STRING COMMENT 'Name of the independent contractor or their authorized representative who signed the agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this independent contractor agreement record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Agreed-upon method for resolving disputes arising from the independent contractor agreement (litigation, binding arbitration, mediation, negotiation, or escalation process).. Valid values are `litigation|arbitration|mediation|negotiation|escalation`',
    `drug_screen_required_flag` BOOLEAN COMMENT 'Indicates whether the independent contractor is required to pass a drug screening test as a condition of engagement.',
    `effective_date` DATE COMMENT 'Date when the independent contractor agreement becomes legally binding and services may commence.',
    `executed_date` DATE COMMENT 'Date when all parties signed the independent contractor agreement, making it legally binding.',
    `expense_reimbursement_flag` BOOLEAN COMMENT 'Indicates whether the independent contractor is eligible for reimbursement of approved business expenses incurred during service delivery.',
    `expiration_date` DATE COMMENT 'Date when the independent contractor agreement ends or is scheduled to expire. Nullable for open-ended agreements.',
    `form_1099_reporting_flag` BOOLEAN COMMENT 'Indicates whether payments to this independent contractor are subject to IRS Form 1099-NEC reporting requirements. Critical for tax compliance.',
    `general_liability_minimum_usd` DECIMAL(18,2) COMMENT 'Minimum required general liability insurance coverage amount in USD that the independent contractor must maintain. Null if insurance is not required.',
    `governing_law_jurisdiction` STRING COMMENT 'State, province, or country whose laws govern the interpretation and enforcement of this independent contractor agreement.',
    `indemnification_scope` STRING COMMENT 'Defines which party or parties are required to indemnify the other for claims, damages, or losses arising from the agreement (mutual, client only, contractor only, limited scope, or none).. Valid values are `mutual|client_only|contractor_only|limited|none`',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the independent contractor is required to maintain specific insurance coverage (e.g., general liability, professional liability, errors and omissions) as a condition of the agreement.',
    `invoice_frequency` STRING COMMENT 'Frequency at which the independent contractor is expected to submit invoices for services rendered.. Valid values are `weekly|biweekly|monthly|upon_completion|milestone|as_needed`',
    `ip_assignment_clause` STRING COMMENT 'Terms governing ownership and assignment of intellectual property created by the independent contractor during the engagement (work-for-hire, full assignment to client, shared ownership, contractor retains rights, or custom negotiated terms).. Valid values are `work_for_hire|full_assignment|shared_ownership|contractor_retains|negotiated`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the independent contractor agreement. Null if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this independent contractor agreement record was last updated or modified in the system.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum financial liability amount that the independent contractor may be held responsible for under the agreement terms.',
    `non_compete_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a non-compete clause restricting the contractor from competing with the client during or after the engagement.',
    `non_compete_period_months` STRING COMMENT 'Duration in months that the non-compete restriction remains in effect after agreement termination. Null if non_compete_flag is false.',
    `non_solicitation_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a non-solicitation clause restricting the contractor from soliciting client employees or customers.',
    `non_solicitation_period_months` STRING COMMENT 'Duration in months that the non-solicitation restriction remains in effect after agreement termination. Null if non_solicitation_flag is false.',
    `payment_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment rate and all financial terms in this agreement.. Valid values are `^[A-Z]{3}$`',
    `payment_rate` DECIMAL(18,2) COMMENT 'Agreed-upon rate of compensation for the independent contractor. Interpretation depends on payment_structure (e.g., hourly rate, project fee, monthly retainer).',
    `payment_structure` STRING COMMENT 'Method by which the independent contractor is compensated (hourly, daily, weekly, monthly, per project, per deliverable, milestone-based, or commission). [ENUM-REF-CANDIDATE: hourly|daily|weekly|monthly|per_project|per_deliverable|milestone|commission — 8 candidates stripped; promote to reference product]',
    `payment_terms_net_days` STRING COMMENT 'Number of days from invoice date within which payment is due to the independent contractor (e.g., Net 30, Net 15).',
    `professional_liability_minimum_usd` DECIMAL(18,2) COMMENT 'Minimum required professional liability or errors and omissions insurance coverage amount in USD that the independent contractor must maintain. Null if not required.',
    `scope_of_services` STRING COMMENT 'Detailed description of the services, deliverables, and work to be performed by the independent contractor under this agreement.',
    `termination_date` DATE COMMENT 'Actual date when the independent contractor agreement was terminated or ended. Null if agreement is still active or has not been terminated early.',
    `termination_for_cause_allowed_flag` BOOLEAN COMMENT 'Indicates whether the agreement permits immediate termination for cause (e.g., breach of contract, misconduct, failure to perform).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the independent contractor agreement without cause.',
    `termination_reason` STRING COMMENT 'Explanation or reason code for early termination of the independent contractor agreement (e.g., project completion, breach of contract, mutual agreement, budget constraints). Null if not terminated.',
    `w9_on_file_flag` BOOLEAN COMMENT 'Indicates whether a completed IRS Form W-9 (Request for Taxpayer Identification Number and Certification) has been received and is on file for this independent contractor.',
    `worker_classification_basis` STRING COMMENT 'Legal and regulatory basis for classifying the worker as an independent contractor (e.g., IRS 20-factor test, ABC test, economic realities test, common law test). Critical for co-employment risk management and IRS compliance.',
    CONSTRAINT pk_ic_agreement PRIMARY KEY(`ic_agreement_id`)
) COMMENT 'Independent Contractor (1099/IC) agreement record governing the engagement of independent contractors. Captures IC classification basis (IRS worker classification rules, ABC test, economic realities test), contract type (project-based, retainer), scope of services, payment terms, IP assignment, non-solicitation terms, and IRS Form 1099 reporting flag. Critical for co-employment risk management and IRS compliance.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`contract_document` (
    `contract_document_id` BIGINT COMMENT 'Unique identifier for the contract document record. Primary key.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Amendments are tracked in the amendment table, but the physical document files for amendments should be tracked in the document table. Currently document has no amendment_id FK. This allows linking am',
    `msa_id` BIGINT COMMENT 'Reference to the parent Master Service Agreement under which this document is executed or associated.',
    `envelope_id` BIGINT COMMENT 'Unique envelope identifier from DocuSign CLM system tracking the e-signature workflow for this document.',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: IC agreements have associated documents (executed agreements, W-9 forms, insurance certificates). Currently document table doesnt reference ic_agreement. This completes document tracking for all cont',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Contract documents are owned by the staff member responsible for the parent contract (MSA/SOW/amendment). Staffing firms track ownership for access control, retention policy enforcement, and audit tra',
    `parent_document_contract_document_id` BIGINT COMMENT 'Reference to the contract document ID that this document amends or supersedes. Nullable for original documents.',
    `primary_superseded_by_document_contract_document_id` BIGINT COMMENT 'Reference to the contract document ID that supersedes or replaces this document. Nullable if this is the current active version.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Contract documents can be associated with SOWs. Currently document has contract_msa_id but no sow_id. SOWs generate their own document artifacts (scope documents, deliverables, acceptance criteria) th',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Vendor agreements have associated documents (executed agreements, amendments, insurance certificates). Currently document only references contract_msa_id. Adding vendor_agreement_id allows tracking ve',
    `amendment_flag` BOOLEAN COMMENT 'Boolean indicator whether this document is an amendment to an existing contract (True) or an original contract document (False).',
    `audit_trail_available_flag` BOOLEAN COMMENT 'Boolean indicator whether a complete audit trail of document creation, modification, and signature events is available (True) or not (False).',
    `checksum_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the document file content to ensure integrity and detect tampering.',
    `client_signatory_email` STRING COMMENT 'Email address of the client signatory used for e-signature delivery and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `client_signatory_name` STRING COMMENT 'Full name of the client representative who signed or is designated to sign this contract document.',
    `client_signatory_title` STRING COMMENT 'Job title or role of the client signatory (e.g., Chief Procurement Officer, VP of Human Resources).',
    `confidentiality_classification` STRING COMMENT 'Data classification level of the contract document content (Public, Internal, Confidential, Restricted) per organizational information security policy.. Valid values are `Public|Internal|Confidential|Restricted`',
    `created_date` DATE COMMENT 'Date when the contract document record was first created in the system.',
    `document_name` STRING COMMENT 'Human-readable name or title of the contract document file (e.g., MSA Amendment 3 - Rate Schedule Update).',
    `document_status` STRING COMMENT 'Current lifecycle status of the contract document. Draft = in preparation, Pending Signature = awaiting signatory execution, Fully Executed = all parties signed, Superseded = replaced by newer version, Voided = cancelled before execution.. Valid values are `Draft|Pending Signature|Fully Executed|Superseded|Voided`',
    `document_type` STRING COMMENT 'Classification of the contract document type. MSA = Master Service Agreement, SOW = Statement of Work, NDA = Non-Disclosure Agreement, Amendment = Contract Amendment, Rate Schedule = Rate Card or Pricing Schedule, Non-Compete = Non-Compete Clause Agreement.. Valid values are `MSA|SOW|NDA|Amendment|Rate Schedule|Non-Compete`',
    `effective_date` DATE COMMENT 'Date on which the contract document becomes legally binding and enforceable.',
    `esignature_completed_flag` BOOLEAN COMMENT 'Boolean indicator whether all required e-signatures have been collected via DocuSign CLM (True) or signatures are still pending (False).',
    `execution_date` DATE COMMENT 'Date on which all required parties signed and executed the contract document, making it fully executed.',
    `expiration_date` DATE COMMENT 'Date on which the contract document terms expire or terminate. Nullable for perpetual or open-ended agreements.',
    `file_format` STRING COMMENT 'Digital file format of the stored contract document (e.g., PDF, DOCX, DOC, TXT, HTML).. Valid values are `PDF|DOCX|DOC|TXT|HTML`',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the document file in kilobytes (KB).',
    `last_modified_date` DATE COMMENT 'Date when the contract document record or file was last updated or modified.',
    `legal_review_completed_date` DATE COMMENT 'Date when legal department review and approval of this contract document was completed. Nullable if not yet reviewed or review not required.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this document requires legal department review and approval before execution (True) or not (False).',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, or special instructions related to this contract document.',
    `page_count` STRING COMMENT 'Total number of pages in the contract document file.',
    `retention_expiry_date` DATE COMMENT 'Date after which the contract document may be purged or archived per the applicable retention policy.',
    `retention_policy_code` STRING COMMENT 'Code identifying the data retention policy classification governing how long this document must be retained per FCRA, GDPR, CCPA, and internal compliance requirements.',
    `signatory_count` STRING COMMENT 'Total number of signatories required to fully execute this contract document.',
    `storage_location` STRING COMMENT 'Reference path or URI to the physical storage location of the document file in the DocuSign CLM vault or enterprise document repository.',
    `vendor_signatory_email` STRING COMMENT 'Email address of the vendor signatory used for e-signature delivery and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_signatory_name` STRING COMMENT 'Full name of the staffing vendor (Staffing Hr) representative who signed or is designated to sign this contract document.',
    `vendor_signatory_title` STRING COMMENT 'Job title or role of the vendor signatory (e.g., Vice President of Sales, Regional Director).',
    `version_number` STRING COMMENT 'Version identifier for the document, tracking revisions and amendments (e.g., 1.0, 2.1, Rev A).',
    CONSTRAINT pk_contract_document PRIMARY KEY(`contract_document_id`)
) COMMENT 'Physical or digital contract document record representing a specific executed or draft document file associated with any contract type (MSA, SOW, NDA, amendment, IC agreement). Stores document name, file format, version number, storage location (DocuSign CLM vault reference), document status (draft, pending signature, fully executed, superseded), and retention policy classification per FCRA, GDPR, and CCPA requirements.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` (
    `contract_approval_workflow_id` BIGINT COMMENT 'Unique identifier for the contract approval workflow record. Primary key.',
    `amendment_id` BIGINT COMMENT 'Reference to the contract amendment being approved through this workflow, if applicable.',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement being approved through this workflow.',
    `sow_id` BIGINT COMMENT 'Reference to the Statement of Work being approved through this workflow, if applicable.',
    `envelope_id` BIGINT COMMENT 'Unique identifier of the DocuSign envelope that will be used for contract execution after approval is complete.',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: IC agreements require approval workflows. Currently approval_workflow supports MSA, SOW, and amendment but not IC agreements. Adding this FK completes approval workflow support for all major contract ',
    `nda_id` BIGINT COMMENT 'Foreign key linking to contract.nda. Business justification: NDAs require approval workflows. Currently approval_workflow supports MSA, SOW, amendment, but not NDA. NDAs are standalone contracts that require legal review and approval. Adding nda_id completes ap',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who initiated the approval workflow, typically a contract manager or sales representative.',
    `quaternary_contract_escalated_to_user_staff_profile_id` BIGINT COMMENT 'Reference to the executive or senior manager to whom the workflow has been escalated.',
    `quinary_contract_final_approver_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who made the final approval decision, typically the last stage approver or escalation authority.',
    `tertiary_contract_delegated_to_user_staff_profile_id` BIGINT COMMENT 'Reference to the user to whom approval authority has been delegated, if delegation has occurred.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Vendor agreements require approval workflows just like MSAs and SOWs. Currently approval_workflow has contract_msa_id, contract_sow_id, contract_amendment_id but no vendor_agreement_id. This completes',
    `approval_comments` STRING COMMENT 'General comments or notes provided by approvers throughout the workflow, capturing conditions, concerns, or recommendations.',
    `approval_threshold_tier` STRING COMMENT 'Approval authority tier required based on contract value or risk level. Higher tiers require more senior approvers.. Valid values are `tier_1|tier_2|tier_3|tier_4|executive`',
    `completed_stages_count` STRING COMMENT 'Number of approval stages that have been completed with an approved decision.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether a dedicated compliance review stage is required for this contract due to regulatory or policy requirements.',
    `contract_value_usd` DECIMAL(18,2) COMMENT 'Total estimated value of the contract being approved, in US Dollars. Used for approval routing and escalation thresholds.',
    `current_approver_role` STRING COMMENT 'Role of the person or group currently responsible for approval at this stage, such as Legal Counsel, Controller, Operations VP, or Executive Sponsor.',
    `current_stage_name` STRING COMMENT 'Name of the current approval stage, such as Legal Review, Finance Approval, Operations VP Approval, or Executive Sponsor Approval.',
    `current_stage_sequence` STRING COMMENT 'Sequential number of the current approval stage in the workflow. Starts at 1 and increments with each stage.',
    `delegation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the current approver is permitted to delegate their approval authority to another user.',
    `delegation_reason` STRING COMMENT 'Reason for delegating approval authority, such as out of office, workload management, or escalation.',
    `escalated_timestamp` TIMESTAMP COMMENT 'Date and time when the workflow was escalated to a higher authority.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this workflow has been escalated to a higher authority due to SLA breach or complexity.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the workflow, such as SLA breach, high contract value, or complex terms requiring executive review.',
    `final_decision` STRING COMMENT 'Final decision outcome of the approval workflow after all stages are completed or workflow is terminated.. Valid values are `approved|rejected|returned_for_revision|cancelled`',
    `final_decision_timestamp` TIMESTAMP COMMENT 'Date and time when the final approval decision was recorded and the workflow was completed or terminated.',
    `finance_review_required_flag` BOOLEAN COMMENT 'Indicates whether finance or controller review is required for this contract due to pricing, payment terms, or revenue recognition implications.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the approval workflow was initiated and submitted for review.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether legal counsel review is required for this contract due to complex terms, liability, or jurisdiction issues.',
    `out_of_office_routing_applied_flag` BOOLEAN COMMENT 'Indicates whether automatic out-of-office routing rules were applied to reassign the approval to an alternate approver.',
    `parallel_approval_flag` BOOLEAN COMMENT 'Indicates whether this workflow supports parallel approval paths where multiple approvers can review simultaneously.',
    `rejection_reason` STRING COMMENT 'Detailed reason provided by the approver for rejecting the contract, such as unfavorable terms, compliance concerns, or budget constraints.',
    `revision_request_comments` STRING COMMENT 'Comments provided by the approver when returning the contract for revision, specifying required changes.',
    `risk_level` STRING COMMENT 'Assessed risk level of the contract based on terms, liability exposure, compliance requirements, and client profile.. Valid values are `low|medium|high|critical`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the approval workflow exceeded the defined SLA turnaround time at any stage.',
    `sla_turnaround_hours` STRING COMMENT 'Number of business hours allowed for approval turnaround at the current stage, as defined by the SLA.',
    `stage_assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the current approval stage was assigned to the current approver.',
    `stage_due_timestamp` TIMESTAMP COMMENT 'Date and time by which the current approval stage must be completed to meet Service Level Agreement (SLA) requirements.',
    `total_elapsed_hours` DECIMAL(18,2) COMMENT 'Total number of business hours elapsed from workflow initiation to final decision, used for SLA performance measurement.',
    `total_stages_count` STRING COMMENT 'Total number of approval stages defined for this workflow type. Used to calculate workflow progress.',
    `workflow_number` STRING COMMENT 'Human-readable unique identifier for the approval workflow instance, formatted as WF-YYYYMMDD.. Valid values are `^WF-[0-9]{8}$`',
    `workflow_status` STRING COMMENT 'Current overall status of the approval workflow. Reflects the aggregate state across all approval stages. [ENUM-REF-CANDIDATE: initiated|in_progress|approved|rejected|returned_for_revision|escalated|cancelled|expired — 8 candidates stripped; promote to reference product]',
    `workflow_type` STRING COMMENT 'Type of contract approval workflow being executed. Determines the approval chain and routing rules.. Valid values are `new_msa_approval|sow_approval|amendment_approval|rate_change_approval|vendor_agreement_approval|nda_approval`',
    CONSTRAINT pk_contract_approval_workflow PRIMARY KEY(`contract_approval_workflow_id`)
) COMMENT 'Contract approval workflow record tracking the internal review and approval chain required before a contract document can be sent for execution via DocuSign CLM. Captures workflow type (new MSA approval, SOW approval, amendment approval, rate change approval, vendor agreement approval), sequential approval stages with approver roles (legal counsel, finance/controller, operations VP, executive sponsor), per-stage decision (approved, rejected, returned for revision, escalated), approver comments, decision timestamps, and SLA for approval turnaround. Supports delegation rules, out-of-office routing, and parallel approval paths. Critical for staffing firms where rate changes and new MSAs require multi-department sign-off before client commitment.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` (
    `sla_breach_event_id` BIGINT COMMENT 'Unique identifier for the SLA breach or near-miss event. Primary key. Role: EVENT_LOG.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account affected by the SLA breach event.',
    `msa_id` BIGINT COMMENT 'Reference to the parent contract (MSA or SOW) under which the SLA is governed.',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: SLA breaches often location-specific: site fill rates, local time-to-fill performance, location-level quality metrics. Required for site-level performance analysis, resource allocation decisions, and ',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Managed programs track SLA breaches for client QBR reporting and remediation planning. Required for program health monitoring, client escalation management, and managed service performance tracking.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: SLA breach remediation is assigned to internal operations staff or account managers. Staffing firms track assignee for task management, escalation workflows, and performance reviews. remediation_owner',
    `sla_id` BIGINT COMMENT 'Reference to the SLA commitment that was breached or nearly breached. Links to the contract.sla product.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SLA breaches can be scoped to specific SOWs. Currently sla_breach_event has contract_msa_id and client_account_id but no sow_id. Since SLAs can be defined at SOW level, breach events should also be li',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: SLA breaches tracked at VMS program level for supplier performance monitoring and penalty calculation. Essential for program-level performance dashboards, supplier tier adjustments, and VMS platform r',
    `escalated_sla_breach_event_id` BIGINT COMMENT 'Self-referencing FK on sla_breach_event (escalated_sla_breach_event_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured value at the time of the breach or near-miss event (e.g., 22 days for Time to Fill, 88% for Fill Rate).',
    `breach_event_number` STRING COMMENT 'Business-facing unique identifier for the breach event, used for tracking and reporting purposes.',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach event: open (newly detected), under_investigation (root cause analysis in progress), remediation_in_progress (corrective actions being taken), resolved (issue fixed), closed (event archived).. Valid values are `open|under_investigation|remediation_in_progress|resolved|closed`',
    `breach_timestamp` TIMESTAMP COMMENT 'The exact date and time when the SLA breach or near-miss event occurred. Principal business event timestamp.',
    `breach_type` STRING COMMENT 'Classification of the event: breach (SLA commitment was violated), near_miss (came close to violation but did not breach), or warning (trending toward breach).. Valid values are `breach|near_miss|warning`',
    `client_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the client was formally notified of the SLA breach (True) or not (False).',
    `client_notification_timestamp` TIMESTAMP COMMENT 'The date and time when the client was notified of the SLA breach event.',
    `client_response` STRING COMMENT 'Summary of the clients response or feedback regarding the breach event and remediation actions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this breach event record was first created in the system. Audit trail field.',
    `detection_timestamp` TIMESTAMP COMMENT 'The date and time when the breach or near-miss was detected by monitoring systems or personnel.',
    `escalation_recipient_name` STRING COMMENT 'Name of the individual or role to whom the breach event was escalated (e.g., Account Manager, VP of Operations, Client Contact).',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the breach event requires escalation to senior management or client stakeholders (True) or not (False).',
    `escalation_timestamp` TIMESTAMP COMMENT 'The date and time when the breach event was escalated to higher authority or client notification.',
    `impact_description` STRING COMMENT 'Description of the business impact of the breach, including effects on client satisfaction, revenue, operations, and reputation.',
    `measurement_period_end_date` DATE COMMENT 'The end date of the measurement period during which the breach occurred.',
    `measurement_period_start_date` DATE COMMENT 'The start date of the measurement period during which the breach occurred.',
    `metric_name` STRING COMMENT 'The name of the SLA metric that was breached (e.g., Time to Fill, Time to Start, Quality of Submission, Fill Rate).',
    `modified_by` STRING COMMENT 'The user ID or name of the individual who last modified this breach event record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this breach event record was last modified. Audit trail field.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or context related to the breach event, investigation, or remediation.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty amount assessed due to the SLA breach, if applicable.',
    `penalty_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `penalty_triggered_flag` BOOLEAN COMMENT 'Indicates whether the breach triggered a contractual penalty or financial consequence (True) or not (False).',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this breach is a recurrence of a previously identified issue (True) or a new occurrence (False).',
    `remediation_action_plan` STRING COMMENT 'Detailed description of the corrective actions planned or taken to address the breach and prevent recurrence.',
    `remediation_completed_date` DATE COMMENT 'The actual date when all remediation actions were completed and verified.',
    `remediation_due_date` DATE COMMENT 'The target date by which remediation actions must be completed.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause of the breach: process_failure (internal process breakdown), resource_shortage (insufficient staffing or capacity), system_outage (technology failure), vendor_delay (third-party delay), client_delay (client-side delay), data_quality_issue (inaccurate or incomplete data).. Valid values are `process_failure|resource_shortage|system_outage|vendor_delay|client_delay|data_quality_issue`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause identified during investigation, including contributing factors and context.',
    `severity_level` STRING COMMENT 'The severity classification of the breach event based on business impact: critical (major client impact), high (significant impact), medium (moderate impact), low (minor impact).. Valid values are `critical|high|medium|low`',
    `source_system` STRING COMMENT 'The system or application that detected and reported the SLA breach event (e.g., Bullhorn ATS, Beeline VMS, Power BI Analytics Platform).',
    `target_value` DECIMAL(18,2) COMMENT 'The SLA target value that was expected to be met (e.g., 15 days for Time to Fill, 95% for Fill Rate).',
    `unit_of_measure` STRING COMMENT 'The unit in which the metric is measured (e.g., days, hours, percentage, count, USD).',
    `variance` DECIMAL(18,2) COMMENT 'The difference between the actual value and the target value, indicating the magnitude of the breach or near-miss.',
    `created_by` STRING COMMENT 'The user ID or name of the individual who created this breach event record.',
    CONSTRAINT pk_sla_breach_event PRIMARY KEY(`sla_breach_event_id`)
) COMMENT 'Transactional record of an SLA breach or near-miss event. Captures the breached SLA commitment, breach date, severity, root cause, and remediation actions';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` (
    `msa_credential_requirement_id` BIGINT COMMENT 'Unique identifier for this MSA credential requirement record. Primary key.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to the Master Service Agreement that mandates this credential requirement',
    `credential_id` BIGINT COMMENT 'Foreign key linking to the credential type required by this MSA',
    `acceptable_expiry_window_days` STRING COMMENT 'Number of days before credential expiration that the client will still accept the credential for new placements under this MSA. Client-specific tolerance for near-expiry credentials.',
    `client_specific_notes` STRING COMMENT 'Free-text field capturing client-specific nuances, exceptions, or clarifications about how this credential requirement should be interpreted and enforced for this MSA.',
    `effective_date` DATE COMMENT 'Date when this credential requirement becomes effective for placements under this MSA. May differ from MSA effective date if requirements are added via amendment.',
    `expiration_date` DATE COMMENT 'Date when this credential requirement is no longer enforced for this MSA. Nullable for requirements that remain in effect for the life of the MSA.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this credential is mandatory for all placements under this MSA (true) or optional/preferred (false). Drives candidate eligibility and compliance workflows.',
    `max_credential_age_days` STRING COMMENT 'Maximum age in days that a credential verification can be for this MSA. Some clients require recent verification even if the credential itself has not expired (e.g., background checks must be within 12 months).',
    `renewal_lead_time_days` STRING COMMENT 'Number of days before credential expiration that the staffing firm must initiate renewal process to maintain compliance with this MSA. Client-specific lead time requirement.',
    `requirement_status` STRING COMMENT 'Current lifecycle status of this credential requirement within the MSA. Tracks whether the requirement is actively enforced, temporarily suspended, or superseded by an amendment.',
    `verification_level` STRING COMMENT 'The level of verification rigor required by this MSA for this credential type. May override the default verification_method from the credential definition based on client-specific requirements.',
    `waiver_allowed_flag` BOOLEAN COMMENT 'Indicates whether the client allows case-by-case waivers for this credential requirement under this MSA. If true, placements may proceed with documented waiver approval.',
    CONSTRAINT pk_msa_credential_requirement PRIMARY KEY(`msa_credential_requirement_id`)
) COMMENT 'This association product represents the contractual credentialing requirements between credential and msa. It captures the specific credential compliance standards mandated by each Master Service Agreement. Each record links one credential type to one MSA with attributes that define how that credential must be verified, maintained, and enforced for placements under that contract.. Existence Justification: In staffing operations, each MSA specifies multiple credential requirements (licenses, certifications, background checks, drug screens, immunizations) that candidates must hold to be eligible for placement under that contract. Conversely, each credential type (e.g., RN license, OSHA 10, Hep B immunization) is required by multiple MSAs across different clients with varying enforcement rules. The business actively manages these requirements as MSA Credential Requirements or Contract Credentialing Standards with client-specific parameters for verification depth, expiry tolerances, and renewal lead times.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` (
    `sow_credential_requirement_id` BIGINT COMMENT 'Unique system-generated identifier for each SOW credential requirement record. Primary key.',
    `credential_id` BIGINT COMMENT 'Foreign key linking to the credential definition that is required for this SOW',
    `sow_id` BIGINT COMMENT 'Foreign key linking to the Statement of Work that requires this credential',
    `acceptable_expiry_window_days` STRING COMMENT 'Number of days before the SOW end date that the credential is allowed to expire. For example, if set to 30, the credential must remain valid until at least 30 days before the SOW ends. Ensures credentials dont expire mid-engagement unless acceptable to the client.',
    `applies_to_assignment_start` BOOLEAN COMMENT 'Indicates whether this credential must be held and verified before a worker can start their assignment on this SOW (true), or whether it can be obtained during the engagement (false). Critical for compliance and client onboarding requirements.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this SOW credential requirement record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this credential requirement becomes effective for this SOW. Allows for phased credential requirements or mid-engagement changes to credentialing rules based on SOW amendments or regulatory changes.',
    `end_date` DATE COMMENT 'The date on which this credential requirement ceases to apply to this SOW. Null if the requirement applies for the entire SOW duration. Used when credential requirements change mid-engagement or are time-bound.',
    `grace_period_days` STRING COMMENT 'Number of days after credential expiration during which the worker may continue working on this SOW while renewal is in progress. SOW-specific override of the credential master grace_period_days, negotiated based on client risk tolerance and regulatory requirements.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this credential is absolutely required for placement on this SOW (true) or is preferred/recommended but not blocking (false). Overrides the credential master is_placement_mandatory flag at the SOW level.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this requirement record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this SOW credential requirement record.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or exceptions related to this credential requirement for this SOW. May include client-specific verification procedures, acceptable alternative credentials, or waiver approval authority.',
    `requirement_source` STRING COMMENT 'Identifies the origin of this credential requirement. Client mandate: specified by client in SOW. Regulatory requirement: mandated by law or regulation. Industry standard: best practice for this industry vertical. Internal policy: staffing firms own requirement. MSA requirement: inherited from parent Master Service Agreement.',
    `verification_level` STRING COMMENT 'Specifies the depth of verification required for this credential on this SOW. Primary source: direct verification from issuing authority. Secondary source: verification from third-party database. Self attestation: candidate declaration accepted. Client verified: client performs their own verification. Waived: verification not required for this engagement. May be more or less stringent than the credential master verification_method based on client requirements.',
    `waiver_allowed` BOOLEAN COMMENT 'Indicates whether the client or staffing firm is permitted to grant a waiver for this credential requirement on this SOW under exceptional circumstances. When true, a formal waiver approval process may be invoked. When false, the credential is non-negotiable.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this requirement record.',
    CONSTRAINT pk_sow_credential_requirement PRIMARY KEY(`sow_credential_requirement_id`)
) COMMENT 'This association product represents the credential requirements specified for a Statement of Work. It captures the project-specific credentialing rules that govern which credentials are mandatory, how they must be verified, and what exceptions or grace periods apply for workers assigned to this SOW. Each record links one credential to one SOW with attributes that define the enforcement rules, verification depth, timing requirements, and waiver policies specific to that engagement.. Existence Justification: In staffing operations, a single SOW typically requires multiple credentials (e.g., RN license, BLS certification, TB test, background check) to ensure workers meet client and regulatory requirements, and each credential definition applies to many different SOWs across various clients and engagements. The business actively manages SOW-specific credential requirements during contract negotiation and SOW setup, defining which credentials are mandatory, how strictly they must be verified, what grace periods apply, and whether waivers are permitted—rules that vary by client risk tolerance, industry vertical, and regulatory context.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Unique identifier for this SOW-to-cost-center allocation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center receiving a portion of the SOW allocation',
    `last_updated_by_user_staff_profile_id` BIGINT COMMENT 'User identifier of the person who last modified this allocation record. Used for audit and accountability.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to the Statement of Work being allocated across cost centers',
    `staff_profile_id` BIGINT COMMENT 'User identifier of the person who created this allocation record. Used for audit and accountability.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual costs incurred by this cost center for this SOW as of the current date. Updated periodically from payroll, expenses, and overhead allocation processes. Used for budget variance analysis and profitability tracking.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this allocation. Active: currently in effect. Inactive: temporarily suspended. Pending: planned but not yet effective. Closed: allocation period ended.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budgeted financial amount allocated to this cost center for this SOW, in the SOWs currency. Derived from sow.total_contract_value multiplied by allocation_percentage, or set independently for cost-plus arrangements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this cost center allocation ceased or will cease to be active for this SOW. Null for currently active allocations. Supports historical tracking of allocation changes over the SOW lifecycle.',
    `effective_start_date` DATE COMMENT 'Date when this cost center allocation became or will become active for this SOW. Supports time-based allocation changes (e.g., SOW shifts from one branch to another mid-engagement).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified. Used for change tracking and reconciliation.',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage of the SOW allocated to this cost center. Used to distribute revenue, costs, and headcount across organizational units. Sum of all allocation_percentage values for a given sow_id should equal 100.',
    `reason` STRING COMMENT 'Business justification or reason for this cost center allocation. Examples: Primary delivery location, Shared services overhead, Multi-site engagement, Regional support. Used for audit and reporting transparency.',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'This association product represents the financial allocation between a Statement of Work and a Cost Center. It captures how SOW delivery and costs are distributed across multiple organizational cost centers, enabling multi-location delivery tracking, shared services allocation, and accurate P&L attribution. Each record links one SOW to one cost center with allocation percentages, budget amounts, and actual costs that exist only in the context of this relationship.. Existence Justification: In staffing operations, a single Statement of Work frequently spans multiple cost centers when delivery involves multiple branches, regions, or shared service units. Conversely, a cost center typically serves multiple active SOWs concurrently as part of normal operations. The business actively manages these allocations by tracking allocation percentages, budgeted amounts, and actual costs for each SOW-cost-center pairing to enable accurate P&L reporting and profitability analysis by organizational unit.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` (
    `vendor_cost_center_allocation_id` BIGINT COMMENT 'Unique identifier for this vendor-cost center allocation record. Primary key.',
    `authorized_by_staff_profile_id` BIGINT COMMENT 'Reference to the employee who authorized this vendor-cost center allocation. Typically a procurement manager, MSP program manager, or cost center budget owner. Used for audit trail and approval workflows.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center that is authorized to use the vendor agreement',
    `last_modified_by_user_staff_profile_id` BIGINT COMMENT 'User identifier of the person who last modified this allocation record. Used for audit trail.',
    `staff_profile_id` BIGINT COMMENT 'User identifier of the person who created this allocation record. Used for audit trail.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to the vendor agreement that is allocated to the cost center',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the cost centers contingent workforce spend that should be allocated to this vendor agreement. Used for preferred vendor programs and spend distribution strategies. Nullable if allocation is managed by spend limits rather than percentages.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this allocation. Active = cost center can engage workers through this vendor. Suspended = temporarily blocked (e.g., performance issues, compliance hold). Expired = effective_end_date has passed. Pending = scheduled for future activation.',
    `authorization_date` DATE COMMENT 'Date when this allocation was formally authorized. Used for audit trail and compliance documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was first created in the system. Used for audit trail.',
    `effective_end_date` DATE COMMENT 'Date when this vendor-cost center allocation expires or is terminated. Nullable for open-ended allocations. Used to manage vendor rotation, program changes, and cost center reorganizations.',
    `effective_start_date` DATE COMMENT 'Date when this vendor-cost center allocation becomes active and the cost center is authorized to engage workers through this vendor agreement. Enables time-bound allocation strategies and phased vendor rollouts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form notes about this allocation. Used to document special conditions, restrictions, or business context (e.g., Approved for IT roles only, Temporary allocation during Q4 surge).',
    `priority_rank` STRING COMMENT 'Priority ranking of this vendor for the cost center when multiple vendors are allocated. Lower numbers indicate higher priority. Used in VMS auto-distribution logic and preferred vendor workflows. Nullable if no priority is defined.',
    `spend_limit_amount` DECIMAL(18,2) COMMENT 'Maximum spend amount authorized for this vendor-cost center combination within the effective date range. Used to control vendor exposure and enforce budget constraints at the cost center level. Nullable if no hard cap is defined.',
    `spend_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the spend limit amount (e.g., USD, CAD, GBP). Required when spend_limit_amount is populated.',
    CONSTRAINT pk_vendor_cost_center_allocation PRIMARY KEY(`vendor_cost_center_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between vendor agreements and cost centers within MSP/VMS-managed staffing programs. It captures the business rules governing which vendors are authorized to supply workers to which cost centers, including spend limits, allocation percentages, and effective date ranges. Each record links one vendor agreement to one cost center with attributes that exist only in the context of this allocation relationship. This enables multi-cost-center vendor agreements and multi-vendor cost center sourcing strategies.. Existence Justification: In MSP/VMS-managed staffing programs, vendor agreements are routinely allocated to multiple cost centers (e.g., IT, Finance, Operations branches), and each cost center sources workers from multiple approved vendors. The business actively manages these allocations with spend limits, allocation percentages, priority rankings, and effective date ranges. This is an operational relationship that procurement and MSP program managers create, monitor, and adjust based on vendor performance, budget constraints, and sourcing strategy.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ADD CONSTRAINT `fk_contract_msa_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ADD CONSTRAINT `fk_contract_non_compete_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ADD CONSTRAINT `fk_contract_non_compete_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_superseded_by_amendment_id` FOREIGN KEY (`superseded_by_amendment_id`) REFERENCES `staffing_hr_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ADD CONSTRAINT `fk_contract_envelope_parent_envelope_id` FOREIGN KEY (`parent_envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ADD CONSTRAINT `fk_contract_envelope_template_id` FOREIGN KEY (`template_id`) REFERENCES `staffing_hr_ecm`.`contract`.`template`(`template_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_replacement_template_id` FOREIGN KEY (`replacement_template_id`) REFERENCES `staffing_hr_ecm`.`contract`.`template`(`template_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ADD CONSTRAINT `fk_contract_ic_agreement_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `staffing_hr_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_parent_document_contract_document_id` FOREIGN KEY (`parent_document_contract_document_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_document`(`contract_document_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_primary_superseded_by_document_contract_document_id` FOREIGN KEY (`primary_superseded_by_document_contract_document_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_document`(`contract_document_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `staffing_hr_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm`.`contract`.`nda`(`nda_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_escalated_sla_breach_event_id` FOREIGN KEY (`escalated_sla_breach_event_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ADD CONSTRAINT `fk_contract_msa_credential_requirement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ADD CONSTRAINT `fk_contract_sow_credential_requirement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ADD CONSTRAINT `fk_contract_allocation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ADD CONSTRAINT `fk_contract_vendor_cost_center_allocation_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `staffing_hr_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Msa Identifier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `confidentiality_term_years` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Obligation Term (Years)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `conversion_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `drug_screen_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'MSA Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `errors_omissions_minimum_usd` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Minimum (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `everify_required_flag` SET TAGS ('dbx_business_glossary_term' = 'E-Verify Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'MSA Executed Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'MSA Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `general_liability_minimum_usd` SET TAGS ('dbx_business_glossary_term' = 'General Liability (GL) Insurance Minimum (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `indemnification_scope` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Scope');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `initial_term_months` SET TAGS ('dbx_business_glossary_term' = 'Initial Term Duration (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|portal|edi|mail');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Currency Code');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `msa_number` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `msa_number` SET TAGS ('dbx_value_regex' = '^MSA-[A-Z0-9]{6,12}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `msa_status` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `nda_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Attached Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `non_solicitation_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Solicitation Clause Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `non_solicitation_period_months` SET TAGS ('dbx_business_glossary_term' = 'Non-Solicitation Period (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `payment_terms_net_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Net Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Duration (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `sla_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Attached Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'MSA Termination Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'MSA Termination Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `vendor_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ALTER COLUMN `workers_comp_minimum_usd` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (WC) Insurance Minimum (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `deliverables_summary` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Summary');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `drug_screen_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `estimated_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Days)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `estimated_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Full-Time Equivalent (FTE) Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `estimated_headcount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Headcount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoice Frequency');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|milestone|upon_completion|custom');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `nda_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `net_payment_days` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `non_compete_clause` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'time_and_materials|fixed_fee|cost_plus|retainer|milestone_based|hybrid');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `sow_number` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `sow_number` SET TAGS ('dbx_value_regex' = '^SOW-[A-Z0-9]{6,20}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `sow_status` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `sow_type` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `sow_type` SET TAGS ('dbx_value_regex' = 'project_based|staff_augmentation|rpo|msp|consulting|managed_services');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `nda_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Profile ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Related Statement of Work (SOW) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `carve_outs` SET TAGS ('dbx_business_glossary_term' = 'NDA Carve-Outs and Exceptions');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `confidentiality_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Duration (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `confidentiality_scope` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Scope');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `counterparty_title` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'NDA Document URL');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'NDA Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'NDA Execution Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'NDA Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `nda_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `nda_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `nda_type` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `nda_type` SET TAGS ('dbx_value_regex' = 'mutual|one_way_client|one_way_candidate|one_way_vendor|multilateral');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `non_compete_clause` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Clause Included Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `non_solicitation_clause` SET TAGS ('dbx_business_glossary_term' = 'Non-Solicitation Clause Included Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'NDA Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `permitted_use` SET TAGS ('dbx_business_glossary_term' = 'Permitted Use of Confidential Information');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `return_destruction_required` SET TAGS ('dbx_business_glossary_term' = 'Return or Destruction Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `signed_by_counterparty` SET TAGS ('dbx_business_glossary_term' = 'Signed By Counterparty Representative');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `signed_by_counterparty` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `signed_by_counterparty` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `signed_by_staffing_hr` SET TAGS ('dbx_business_glossary_term' = 'Signed By Staffing HR Representative');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `signed_by_staffing_hr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `signed_by_staffing_hr` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `survival_period_months` SET TAGS ('dbx_business_glossary_term' = 'Survival Period (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'NDA Termination Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `non_compete_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Agreement ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Party ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'non_compete|non_solicitation|combined|confidentiality_with_non_compete');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `breach_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `breach_reported` SET TAGS ('dbx_business_glossary_term' = 'Breach Reported Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `candidate_solicitation_prohibited` SET TAGS ('dbx_business_glossary_term' = 'Candidate Solicitation Prohibited Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `client_solicitation_prohibited` SET TAGS ('dbx_business_glossary_term' = 'Client Solicitation Prohibited Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `competitive_employment_prohibited` SET TAGS ('dbx_business_glossary_term' = 'Competitive Employment Prohibited Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `consideration_provided` SET TAGS ('dbx_business_glossary_term' = 'Consideration Provided');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `enforceability_status` SET TAGS ('dbx_business_glossary_term' = 'Enforceability Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `enforceability_status` SET TAGS ('dbx_value_regex' = 'enforceable|unenforceable|under_review|challenged|waived');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'draft|pending_signature|executed|declined|expired|terminated');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `geographic_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Geographic Radius in Miles');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `geographic_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `geographic_restriction_type` SET TAGS ('dbx_value_regex' = 'radius|territory|state|national|none');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `geographic_territory` SET TAGS ('dbx_business_glossary_term' = 'Geographic Territory');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `legal_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Taken Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `legal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `restricted_activity_scope` SET TAGS ('dbx_business_glossary_term' = 'Restricted Activity Scope');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `restriction_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Restriction Duration in Months');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|wet_signature|verbal|implied');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `subject_party_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Party Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `subject_party_type` SET TAGS ('dbx_value_regex' = 'placed_worker|direct_hire_candidate|internal_employee|independent_contractor|vendor_representative');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `trigger_event` SET TAGS ('dbx_value_regex' = 'placement_start|assignment_end|employment_termination|contract_execution|other');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `breach_threshold` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `job_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Job Category Scope');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `measurement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `measurement_source_system` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `measurement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `metric_description` SET TAGS ('dbx_business_glossary_term' = 'Metric Description');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `penalty_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Cap Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Penalty Percentage');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'credit|rebate|discount|penalty_fee|service_credit|none');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `reporting_format` SET TAGS ('dbx_business_glossary_term' = 'Reporting Format');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `reporting_format` SET TAGS ('dbx_value_regex' = 'dashboard|pdf_report|excel_spreadsheet|email_summary|api_feed');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `reporting_recipient` SET TAGS ('dbx_business_glossary_term' = 'Reporting Recipient');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `scope_filter` SET TAGS ('dbx_business_glossary_term' = 'Scope Filter');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `sla_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|terminated|draft|pending_approval');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `target_operator` SET TAGS ('dbx_business_glossary_term' = 'Target Operator');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `target_operator` SET TAGS ('dbx_value_regex' = 'less_than|less_than_or_equal|greater_than|greater_than_or_equal|equal|between');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'days|hours|percentage|ratio|score|count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `contract_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Schedule ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `client_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|superseded|expired');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `burden_rate` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `double_time_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Multiplier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `job_category` SET TAGS ('dbx_business_glossary_term' = 'Job Category');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `labor_classification` SET TAGS ('dbx_business_glossary_term' = 'Labor Classification');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Multiplier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `per_diem_allowance` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Allowance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `rate_card_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Version');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `rate_schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `rate_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `rate_schedule_type` SET TAGS ('dbx_value_regex' = 'standard|custom|blended|tiered|project_based');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|per_unit');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|senior|expert|executive');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ALTER COLUMN `spread` SET TAGS ('dbx_business_glossary_term' = 'Spread (Bill Rate minus Pay Rate)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Contract Identifier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `contract_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope Identifier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `superseded_by_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Cancellation Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `client_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Client Signature Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document URL');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `finance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Finance Approval Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `finance_approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Finance Approval Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `finance_approver` SET TAGS ('dbx_business_glossary_term' = 'Finance Approver');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Initiated By');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Initiated Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `legal_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `legal_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `prior_terms_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Terms Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Rejection Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `requires_rate_schedule_update` SET TAGS ('dbx_business_glossary_term' = 'Requires Rate Schedule Update Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `requires_sla_update` SET TAGS ('dbx_business_glossary_term' = 'Requires Service Level Agreement (SLA) Update Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Amendment Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `vendor_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`amendment` ALTER COLUMN `vendor_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signature Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `contract_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Rate Schedule ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Owner ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|action_taken|escalated');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `alert_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Alert Lead Time (Days)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `alert_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Alert Sent Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `alert_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Sent Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `auto_renewal_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `compliance_filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Filing Deadline Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `insurance_certificate_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Renewal Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `negotiation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|completed|failed');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `notice_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Deadline Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `opt_out_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Deadline Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `opt_out_party` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Party');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `opt_out_party` SET TAGS ('dbx_value_regex' = 'client|vendor|staffing_hr|mutual');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `opt_out_received_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Received Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `opt_out_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Received Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'renewed|renegotiated|lapsed|terminated|extended');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Renewal Priority');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `rate_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `rate_schedule_review_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Review Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto_renewal|manual_renewal|evergreen|one_time|conditional');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `resolution_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Taken');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `sla_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Review Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `term_length_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Length (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Trigger Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'Envelope Identifier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `parent_envelope_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Template ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Authentication Method');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|id_verification|kba|access_code');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Brand ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `certificate_of_completion_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Completion URL');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Completed Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `custom_field_1` SET TAGS ('dbx_business_glossary_term' = 'Custom Field 1');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `custom_field_2` SET TAGS ('dbx_business_glossary_term' = 'Custom Field 2');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `custom_field_3` SET TAGS ('dbx_business_glossary_term' = 'Custom Field 3');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `declined_reason` SET TAGS ('dbx_business_glossary_term' = 'Envelope Declined Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `declined_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Declined Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Delivered Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `envelope_status` SET TAGS ('dbx_business_glossary_term' = 'Envelope Lifecycle Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `expiration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Expiration Enabled Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Expiration Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `is_bulk_send` SET TAGS ('dbx_business_glossary_term' = 'Bulk Send Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `is_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `is_wet_sign_enabled` SET TAGS ('dbx_business_glossary_term' = 'Wet Signature Enabled Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Envelope Language Code');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `message_body` SET TAGS ('dbx_business_glossary_term' = 'Envelope Message Body');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `purge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Purge Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `recipient_count` SET TAGS ('dbx_business_glossary_term' = 'Total Recipient Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `reminder_enabled` SET TAGS ('dbx_business_glossary_term' = 'Reminder Enabled Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `reminder_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Frequency in Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Envelope Sender Email Address');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sender_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Sender IP Address');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sender_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sender_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Envelope Sender Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Sent Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `signer_count` SET TAGS ('dbx_business_glossary_term' = 'Required Signer Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `signing_order_enforced` SET TAGS ('dbx_business_glossary_term' = 'Signing Order Enforced Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Envelope Subject Line');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Envelope Time Zone');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `uri` SET TAGS ('dbx_business_glossary_term' = 'Envelope URI');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `voided_reason` SET TAGS ('dbx_business_glossary_term' = 'Envelope Voided Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`envelope` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Envelope Voided Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Identifier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `replacement_template_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Template ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewer User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_legal_reviewer_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `applicable_client_segments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Client Segments');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `applicable_industries` SET TAGS ('dbx_business_glossary_term' = 'Applicable Industries');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Legal Approved|Compliance Approved|Executive Approved|Rejected');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `configurable_parameters` SET TAGS ('dbx_business_glossary_term' = 'Configurable Parameters');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'MSA|SOW|NDA|Non-Compete|Amendment|IC Agreement');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `default_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Default Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `default_liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Default Liability Cap Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `default_liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `default_liability_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Default Liability Cap Currency');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `default_liability_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `default_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Default Notice Period Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `default_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `deprecated_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `docusign_template_reference` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Template ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `e_signature_enabled` SET TAGS ('dbx_business_glossary_term' = 'E-Signature Enabled');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_coe_risk_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Co-Employment (COE) Risk Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_data_privacy_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Data Privacy Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_eeoc_compliance_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Equal Employment Opportunity Commission (EEOC) Compliance Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_flsa_compliance_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Fair Labor Standards Act (FLSA) Compliance Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_indemnification_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Indemnification Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_ip_ownership_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Intellectual Property (IP) Ownership Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_non_solicitation_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Non-Solicitation Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_ofccp_compliance_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Office of Federal Contract Compliance Programs (OFCCP) Compliance Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `includes_workers_comp_clause` SET TAGS ('dbx_business_glossary_term' = 'Includes Workers Compensation (Workers Comp) Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `optional_clause_menu` SET TAGS ('dbx_business_glossary_term' = 'Optional Clause Menu');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `required_clause_set` SET TAGS ('dbx_business_glossary_term' = 'Required Clause Set');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Active|Deprecated|Archived');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `amendment_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reference');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `audit_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Ready Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `days_until_due` SET TAGS ('dbx_business_glossary_term' = 'Days Until Due');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|level_1|level_2|level_3|executive');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `escalation_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Owner Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `evidence_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submission Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `evidence_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Verified Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `last_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Notification Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_business_glossary_term' = 'Obligation Category');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_value_regex' = 'compliance|insurance|reporting|audit|deliverable|legal');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_value_regex' = '^OBL-[0-9]{6,10}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|fulfilled|overdue|waived|cancelled');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'periodic_reporting|insurance_certificate_renewal|background_check_requirement|ofccp_aap_compliance_filing|audit_right_exercise|indemnification_trigger');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `original_due_date` SET TAGS ('dbx_business_glossary_term' = 'Original Due Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `recurrence_type` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `recurrence_type` SET TAGS ('dbx_value_regex' = 'one_time|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|severe');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `updated_by_name` SET TAGS ('dbx_business_glossary_term' = 'Updated By Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `agreement_title` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'subvendor_staffing_agreement|ic_firm_agreement|eor_agreement|peo_agreement|rpo_subcontract|service_provider_agreement');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `background_check_standard` SET TAGS ('dbx_business_glossary_term' = 'Background Check Standard');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `confidentiality_term_years` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Term (Years)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `diversity_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `drug_screen_panel_type` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Panel Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `drug_screen_panel_type` SET TAGS ('dbx_value_regex' = '5_panel|10_panel|dot_5_panel|custom');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `drug_screen_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `errors_omissions_minimum_usd` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions Insurance Minimum (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `everify_required_flag` SET TAGS ('dbx_business_glossary_term' = 'E-Verify Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Executed Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `fee_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `fee_schedule_type` SET TAGS ('dbx_value_regex' = 'flat_fee|percentage_of_bill_rate|tiered|cost_plus|negotiated');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `general_liability_minimum_usd` SET TAGS ('dbx_business_glossary_term' = 'General Liability Insurance Minimum (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `indemnification_scope` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Scope');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `initial_term_months` SET TAGS ('dbx_business_glossary_term' = 'Initial Agreement Term (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `internal_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `internal_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Internal Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Currency');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `markup_cap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Cap Percentage');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `markup_cap_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `non_solicitation_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Solicitation Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `non_solicitation_period_months` SET TAGS ('dbx_business_glossary_term' = 'Non-Solicitation Period (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `payment_terms_net_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Net Days)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Classification');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|conditional');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `vendor_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `workers_comp_minimum_usd` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Insurance Minimum (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Independent Contractor (IC) Agreement ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Profile ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Independent Contractor (IC) Agreement Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `agreement_title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `confidentiality_term_years` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Term Years');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'project_based|retainer|time_and_materials|fixed_price|milestone_based|ongoing');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `contractor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `contractor_signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `contractor_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation|escalation');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `drug_screen_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Executed Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `expense_reimbursement_flag` SET TAGS ('dbx_business_glossary_term' = 'Expense Reimbursement Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `form_1099_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Form 1099 Reporting Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `general_liability_minimum_usd` SET TAGS ('dbx_business_glossary_term' = 'General Liability Minimum United States Dollars (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `indemnification_scope` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Scope');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `indemnification_scope` SET TAGS ('dbx_value_regex' = 'mutual|client_only|contractor_only|limited|none');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoice Frequency');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|upon_completion|milestone|as_needed');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `ip_assignment_clause` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Assignment Clause');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `ip_assignment_clause` SET TAGS ('dbx_value_regex' = 'work_for_hire|full_assignment|shared_ownership|contractor_retains|negotiated');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `non_compete_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `non_compete_period_months` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Period Months');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `non_solicitation_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Solicitation Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `non_solicitation_period_months` SET TAGS ('dbx_business_glossary_term' = 'Non-Solicitation Period Months');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `payment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `payment_rate` SET TAGS ('dbx_business_glossary_term' = 'Payment Rate');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `payment_structure` SET TAGS ('dbx_business_glossary_term' = 'Payment Structure');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `payment_terms_net_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Net Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `professional_liability_minimum_usd` SET TAGS ('dbx_business_glossary_term' = 'Professional Liability Minimum United States Dollars (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `termination_for_cause_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Allowed Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `w9_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'W-9 (Wage and Tax Statement) on File Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ALTER COLUMN `worker_classification_basis` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification Basis');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` SET TAGS ('dbx_subdomain' = 'agreement_governance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `contract_document_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Document ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Document Owner Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `parent_document_contract_document_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Document ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `primary_superseded_by_document_contract_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `audit_trail_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Available Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `client_signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Email');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `client_signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `client_signatory_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `client_signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending Signature|Fully Executed|Superseded|Voided');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'MSA|SOW|NDA|Amendment|Rate Schedule|Non-Compete');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `esignature_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'E-Signature Completed Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|DOC|TXT|HTML');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (KB)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `legal_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Code');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `signatory_count` SET TAGS ('dbx_business_glossary_term' = 'Signatory Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `vendor_signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Email');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `vendor_signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `vendor_signatory_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `vendor_signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `vendor_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Title');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `contract_approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Workflow ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Statement of Work (SOW) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `nda_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `quaternary_contract_escalated_to_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `quinary_contract_final_approver_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Final Approver User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `tertiary_contract_delegated_to_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated To User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `approval_threshold_tier` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Tier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `approval_threshold_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|executive');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `completed_stages_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Stages Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `contract_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Contract Value United States Dollars (USD)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `contract_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `current_approver_role` SET TAGS ('dbx_business_glossary_term' = 'Current Approver Role');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `current_stage_name` SET TAGS ('dbx_business_glossary_term' = 'Current Stage Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `current_stage_sequence` SET TAGS ('dbx_business_glossary_term' = 'Current Stage Sequence');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `delegation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegation Allowed Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `delegation_reason` SET TAGS ('dbx_business_glossary_term' = 'Delegation Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `escalated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `final_decision` SET TAGS ('dbx_business_glossary_term' = 'Final Decision');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `final_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|returned_for_revision|cancelled');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `final_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Final Decision Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `finance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Finance Review Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Initiated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `out_of_office_routing_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Office Routing Applied Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `parallel_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Parallel Approval Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `revision_request_comments` SET TAGS ('dbx_business_glossary_term' = 'Revision Request Comments');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `sla_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Turnaround Hours');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `stage_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Assigned Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `stage_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Due Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `total_elapsed_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Elapsed Hours');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `total_stages_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stages Count');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_number` SET TAGS ('dbx_business_glossary_term' = 'Workflow Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_number` SET TAGS ('dbx_value_regex' = '^WF-[0-9]{8}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Workflow Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_type` SET TAGS ('dbx_value_regex' = 'new_msa_approval|sow_approval|amendment_approval|rate_change_approval|vendor_agreement_approval|nda_approval');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Event ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `escalated_sla_breach_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `breach_event_number` SET TAGS ('dbx_business_glossary_term' = 'Breach Event Number');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|remediation_in_progress|resolved|closed');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'breach|near_miss|warning');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `client_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Sent Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `client_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `client_response` SET TAGS ('dbx_business_glossary_term' = 'Client Response');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `escalation_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Recipient Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `escalation_recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `escalation_recipient_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `impact_description` SET TAGS ('dbx_business_glossary_term' = 'Impact Description');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `penalty_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Triggered Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `remediation_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Plan');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `remediation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completed Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process_failure|resource_shortage|system_outage|vendor_delay|client_delay|data_quality_issue');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` SET TAGS ('dbx_subdomain' = 'compliance_requirements');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` SET TAGS ('dbx_association_edges' = 'credentialing.credential,contract.msa');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `msa_credential_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'MSA Credential Requirement ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Msa Credential Requirement - Contract Msa Id');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Msa Credential Requirement - Credential Id');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `acceptable_expiry_window_days` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Expiry Window Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `client_specific_notes` SET TAGS ('dbx_business_glossary_term' = 'Client Specific Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `max_credential_age_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Credential Age Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `renewal_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Lead Time Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `verification_level` SET TAGS ('dbx_business_glossary_term' = 'Verification Level');
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ALTER COLUMN `waiver_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed Flag');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` SET TAGS ('dbx_subdomain' = 'compliance_requirements');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` SET TAGS ('dbx_association_edges' = 'credentialing.credential,contract.sow');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `sow_credential_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'SOW Credential Requirement ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Credential Requirement - Credential Id');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Credential Requirement - Sow Id');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `acceptable_expiry_window_days` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Expiry Window Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `applies_to_assignment_start` SET TAGS ('dbx_business_glossary_term' = 'Applies to Assignment Start');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `requirement_source` SET TAGS ('dbx_business_glossary_term' = 'Requirement Source');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `verification_level` SET TAGS ('dbx_business_glossary_term' = 'Verification Level');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `waiver_allowed` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed');
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` SET TAGS ('dbx_subdomain' = 'financial_allocation');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` SET TAGS ('dbx_association_edges' = 'contract.sow,finance.cost_center');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Cost Center Id');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `last_updated_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updater User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `last_updated_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `last_updated_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Sow Id');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Record Creator User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost to Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reason');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` SET TAGS ('dbx_subdomain' = 'financial_allocation');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` SET TAGS ('dbx_association_edges' = 'contract.vendor_agreement,finance.cost_center');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `vendor_cost_center_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Cost Center Allocation ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `authorized_by_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Staff Profile ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Cost Center Allocation - Cost Center Id');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Cost Center Allocation - Vendor Agreement Id');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `spend_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Amount');
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ALTER COLUMN `spend_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Currency');
